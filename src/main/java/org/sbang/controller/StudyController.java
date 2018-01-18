package org.sbang.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.sbang.domain.PageMaker;
import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserVO;
import org.sbang.domain.WeekVO;
import org.sbang.service.StudyService;
import org.sbang.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/study/*")
public class StudyController {

	@Inject
	private StudyService studyService;
	
	@Inject
	private UserService userService;
	
	@RequestMapping(value = "/studyReg", method = RequestMethod.GET) // 스터디 등록 - get
	public void registGET(StudyVO study, Model model, HttpSession session) throws Exception {
		UserVO userVO = (UserVO) session.getAttribute("login");
		model.addAttribute("studyRegCnt", userService.studyRegCnt(userVO.getUserNo()));
		model.addAttribute("list", userService.exStudyList(userVO.getUserNo()));
		model.addAttribute("listEnd", userService.exStudyEndList(userVO.getUserNo()));
	}

	@RequestMapping(value = "/studyReg", method = RequestMethod.POST) // 스터디 등록 - post
	public String registPOST(StudyVO study, RedirectAttributes rttr, HttpSession session) throws Exception {
		UserVO userVO = (UserVO) session.getAttribute("login");
		study.setStudyWriter(userVO.getUserNo());
		studyService.regist(study);
		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/study/studyList";
	}
	
	@RequestMapping("/exStudyList/{studyNo}") // 이전 스터디등록 리스트 가져오기(ajax)
	@ResponseBody
	public StudyVO getList(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.read(studyNo);
	}
	
	@RequestMapping("/exStudyEndList/{studyNo}") // 이전 스터디등록 리스트 가져오기(ajax)
	@ResponseBody
	public StudyVO getListEnd(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.readEnd(studyNo);
	}
	
	@RequestMapping(value = "/studyList", method = RequestMethod.GET)  // 스터디 리스트
	public void studyList(@ModelAttribute("cri") SearchCriteria cri, Model model, HttpServletRequest request) throws Exception {
		model.addAttribute("list", studyService.listSearchCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(studyService.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
		
		String upCategory = request.getParameter("upCategory");
		String upRegion = request.getParameter("upRegion");
		
		if(upCategory != null)
			model.addAttribute("upCategory", upCategory);
		if(upRegion != null)
			model.addAttribute("upRegion", upRegion);

	}

	@RequestMapping(value = "/studyView", method = RequestMethod.GET)  // 스터디 보기
	public void read(@RequestParam Integer studyNo, @ModelAttribute("cri") SearchCriteria cri, Model model, HttpSession session, UserVO userVO, StudyVO studyVO) throws Exception {
		
		studyVO = studyService.read(studyNo);
		userVO = (UserVO) session.getAttribute("login");
		
		if(userVO != null){
			int userNo = userVO.getUserNo();
			int favCheck = userService.checkFavorStudy(userNo, studyNo);
			int applyCheck = userService.checkApplyStudy(userNo, studyNo);
			model.addAttribute("favCheck" , favCheck); // 즐겨찾기 확인 여부
			model.addAttribute("applyCheck" , applyCheck); // 신청스터디 확인 여부
		}
		
		if(studyVO == null)
			throw new UrlNotFoundException();
		
		model.addAttribute(studyVO); // studyVO 전체
		model.addAttribute("userVO", studyService.userInfoByStudyWriter(studyVO.getStudyWriter())); // 글쓴이 닉네임 가져오기
		model.addAttribute("weekList", studyService.getWeek(studyNo)); // 주 일정 가져오기

	}
	
	@RequestMapping(value = "/studyEndView", method = RequestMethod.GET)  // 스터디 완료 보기
	public void studyEndView(@RequestParam Integer studyNo, Model model, HttpSession session, UserVO userVO, StudyVO studyVO) throws Exception {
		
		studyVO = studyService.readEnd(studyNo);
		userVO = (UserVO) session.getAttribute("login");
		
		if(studyVO == null)
			throw new UrlNotFoundException();
		
		model.addAttribute(studyVO); // studyVO 전체
		model.addAttribute("userVO", studyService.userInfoByStudyWriter(studyVO.getStudyWriter())); // 글쓴이 닉네임 가져오기
		model.addAttribute("weekList", studyService.getWeekEnd(studyNo)); // 주 일정 가져오기

	}

	@RequestMapping(value = "/studyRemove", method = RequestMethod.POST) // 스터디 삭제
	public String remove(@RequestParam("studyNo") int studyNo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		studyService.remove(studyNo);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("lineUp", cri.getLineUp());
		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/study/studyList";
	}

	@RequestMapping("/getImg/{studyNo}") // 이미지 가져오기(ajax)
	@ResponseBody
	public List<String> getImg(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.getImg(studyNo);
	}
	
	@RequestMapping("/getImgEnd/{studyNo}") // 이미지 가져오기(ajax)
	@ResponseBody
	public List<String> getImgEnd(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.getImgEnd(studyNo);
	}
	
	@RequestMapping("/getWeek/{studyNo}") // 이전 스터디등록 리스트 가져오기 - 주단위 일정(ajax)
	@ResponseBody
	public List<WeekVO> getWeek(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.getWeek(studyNo);
	}
	
	@RequestMapping("/getWeekEnd/{studyNo}") // 이전 스터디등록 리스트 가져오기 - 주단위 일정(ajax)
	@ResponseBody
	public List<WeekVO> getWeekEnd(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.getWeekEnd(studyNo);
	}

	@RequestMapping(value = "/studyModify", method = RequestMethod.GET)  // 스터디 수정 - get
	public void modifyGET(@RequestParam("studyNo") int studyNo, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		model.addAttribute(studyService.read(studyNo));
		model.addAttribute("weekList", studyService.getWeek(studyNo));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(studyService.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/studyModify", method = RequestMethod.POST)  // 스터디 수정 - post
	public String modifyPOST(StudyVO study, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("lineUp", cri.getLineUp());
		studyService.modify(study);
		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/study/studyList";
	}
	
	@ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "잘못된 접근입니다.")
	public class UrlNotFoundException extends RuntimeException { } // 404 에러 처리

}
