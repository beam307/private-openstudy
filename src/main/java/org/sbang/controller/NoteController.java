package org.sbang.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.sbang.domain.NoteVO;
import org.sbang.domain.PageMaker;
import org.sbang.domain.SearchCriteria;
import org.sbang.domain.UserVO;
import org.sbang.service.NoteService;
import org.sbang.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/note/*")
public class NoteController {

	@Inject
	private NoteService noteService;

	@Inject
	private UserService userService;

	@RequestMapping(value = "/noteReg", method = RequestMethod.GET) // 쪽지 보내기페이지GET
	public void registGET(NoteVO noteVO, Model model, HttpSession session, Integer noteTarget) throws Exception {
		UserVO userVO = (UserVO) session.getAttribute("login"); // 보내는이 저장
		model.addAttribute(userVO);
		if (noteTarget != null) {
			UserVO noteTargetVO = userService.read(noteTarget);
			String noteTargetNick = noteTargetVO.getUserNick();
			model.addAttribute("noteTargetNick", noteTargetNick);
		}
	}

	@RequestMapping(value = "/noteReg", method = RequestMethod.POST) // 쪽지 보내기페이지POST
	public ResponseEntity<String> registPOST(@RequestBody NoteVO vo, HttpSession session) throws Exception {
		ResponseEntity<String> entity = null;
		try {
			UserVO userVO = (UserVO) session.getAttribute("login"); // 보내는이 저장
			Integer noteSender = userVO.getUserNo();
			Integer noteTarget = userService.findUserNoByNick(vo.getNoteTargetNick());
			if (noteTarget != null) {
				vo.setNoteTarget(noteTarget);
				vo.setNoteSender(noteSender);
				if (noteService.chkCutOff(vo.getNoteSender(), vo.getNoteTarget()) != 0) // 차단목록 포함여부확인
					entity = new ResponseEntity<String>("CUTOFF", HttpStatus.OK);
				else {
					noteService.addNote(vo);
					entity = new ResponseEntity<String>(String.valueOf(noteTarget), HttpStatus.OK);
				}
			} else
				entity = new ResponseEntity<String>("NOTFIND", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}

		return entity;
	}

	@RequestMapping(value = "/noteList", method = RequestMethod.GET)
	public void noteList(@ModelAttribute("cri") SearchCriteria cri, Model model, HttpSession session) throws Exception {
		cri.setPerPageNum(12);
		UserVO userVO = (UserVO) session.getAttribute("login"); // 받는이 저장
		Integer target = userVO.getUserNo();
		model.addAttribute(userVO);
		model.addAttribute("list", noteService.noteList(cri, target));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(noteService.noteListCount(target));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/noteListSender", method = RequestMethod.GET)
	public void noteListSender(@ModelAttribute("cri") SearchCriteria cri, Model model, HttpSession session) throws Exception {
		cri.setPerPageNum(12);
		UserVO userVO = (UserVO) session.getAttribute("login"); // 보낸이 저장
		Integer sender = userVO.getUserNo();
		model.addAttribute("list", noteService.noteListSender(cri, sender));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(noteService.noteListSenderCount(sender));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/noteListToMe", method = RequestMethod.GET)
	public void noteListToMe(@ModelAttribute("cri") SearchCriteria cri, Model model, HttpSession session) throws Exception {
		cri.setPerPageNum(12);
		UserVO userVO = (UserVO) session.getAttribute("login"); // 받는이 저장
		Integer target = userVO.getUserNo();
		model.addAttribute("list", noteService.noteListToMe(cri, target));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(noteService.noteListToMeCount(target));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/noteRead", method = RequestMethod.POST)
	public ResponseEntity<String> noteRead(Integer noteNo) throws Exception {
		ResponseEntity<String> entity = null;
		try {
			noteService.openState(noteNo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}

		return entity;
	}

	@RequestMapping(value = "/noteRemove", method = RequestMethod.POST)
	public String noteRemove(String[] noteArr, String noteFlag, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		String redirect = "";
		Integer[] noteNoArr = new Integer[noteArr.length];
		for (int i = 0; i < noteArr.length; i++) {
			noteNoArr[i] = Integer.parseInt(noteArr[i]);
		}
		if (noteFlag.equals("sender"))
			redirect = "redirect:/note/noteListSender";
		else if (noteFlag.equals("toMe"))
			redirect = "redirect:/note/noteListToMe";
		else
			redirect = "redirect:/note/noteList";
		noteService.removeNote(noteNoArr);
		return redirect;
	}

	@RequestMapping(value = "/noteCutOff", method = RequestMethod.POST)
	public ResponseEntity<String> noteCutOff(Integer noteSender, HttpSession session) throws Exception {
		ResponseEntity<String> entity = null;

		UserVO userVO = (UserVO) session.getAttribute("login"); // 받는이 저장
		Integer userNo = userVO.getUserNo();
		try {
			if (noteService.chkCutOff(noteSender, userNo) != 0) {
				entity = new ResponseEntity<String>("CUTOFF", HttpStatus.OK);
			} else {
				noteService.addCutOff(noteSender, userNo);
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/cutOffList", method = RequestMethod.GET)
	public void cutOffList(@ModelAttribute("cri") SearchCriteria cri, Model model, HttpSession session) throws Exception {
		cri.setPerPageNum(12);
		UserVO userVO = (UserVO) session.getAttribute("login"); // 보낸이 저장
		Integer sender = userVO.getUserNo();
		model.addAttribute("list", noteService.cutOffList(sender));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(noteService.cutOffListCount(sender));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/cutOffDelete", method = RequestMethod.POST)
	public String cutOffDelete(String[] cutOffArr, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		Integer[] cutOffNoArr = new Integer[cutOffArr.length];
		for (int i = 0; i < cutOffArr.length; i++) {
			cutOffNoArr[i] = Integer.parseInt(cutOffArr[i]);
		}
		noteService.cutOffDelete(cutOffNoArr);
		return "redirect:/note/cutOffList";
	}

}
