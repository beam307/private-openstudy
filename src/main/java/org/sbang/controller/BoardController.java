package org.sbang.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.sbang.domain.NoticeVO;
import org.sbang.domain.PageMaker;
import org.sbang.domain.QnAVO;
import org.sbang.domain.SearchCriteria;
import org.sbang.service.NoticeService;
import org.sbang.service.QnAService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Inject
	private NoticeService notiService;
	
	@Inject
	private QnAService qnaService;
	
	@RequestMapping(value = "/noticeReg", method = RequestMethod.GET)
	public void registGET(NoticeVO notice, Model model) throws Exception {

	}
	
	@RequestMapping(value = "/noticeReg", method = RequestMethod.POST)
	public String registPOST(NoticeVO notice, Model model)  throws Exception {
		notiService.addNotice(notice);
		 
		return "redirect:/board/noticeList";
	}
	
	
	@RequestMapping(value = "/noticeList", method = RequestMethod.GET)
	public void list(@ModelAttribute("cri") SearchCriteria cri, HttpSession session, Model model) throws Exception {
		cri.setPerPageNum(15);
		model.addAttribute("list", notiService.listNotice(cri)); // 전체 리스트
		
		PageMaker pageMaker = new PageMaker(); // 페이지 메이커 생성
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(notiService.listNoticeCount(cri));
		model.addAttribute("pageMaker", pageMaker);
		
/*		UserVO vo = (UserVO) session.getAttribute("login");
		if(vo!=null) 
			model.addAttribute("userNo", vo.getUserNo());*/
	}	
	
	
	@RequestMapping(value = "/noticeRemove", method = RequestMethod.GET)
	public String remove(@RequestParam("noticeNo") int noticeNo, Model model) throws Exception {
		notiService.removeNotice(noticeNo);
		
		return "redirect:/board/noticeList";
	}

	
	@RequestMapping(value = "/noticeMod", method = RequestMethod.GET)
	public void modifyGET(int noticeNo, Model model) throws Exception {
		model.addAttribute(notiService.readNotice(noticeNo));
	}
	
	@RequestMapping(value = "/noticeMod", method = RequestMethod.POST)
	public String modifyPOST(NoticeVO notice, Model model)  throws Exception {
		notiService.modifyNotice(notice);
		 
		return "redirect:/board/noticeList";
	}

	
	
	
	@RequestMapping(value = "/qnAReg", method = RequestMethod.GET)
	public void registGET2(QnAVO qnA, Model model) throws Exception {

	}
	
	@RequestMapping(value = "/qnAReg", method = RequestMethod.POST)
	public String registPOST2(QnAVO qnA, Model model, RedirectAttributes rttr)  throws Exception {
		qnaService.addQnA(qnA);
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/board/qnAList";
	}
	
	@RequestMapping(value = "/qnAMasterReg", method = RequestMethod.GET)
	public void registGET3(int qnANo, Model model ) throws Exception {
		model.addAttribute(qnaService.readQnA(qnANo));
	}
	
	@RequestMapping(value = "/qnAMasterReg", method = RequestMethod.POST)
	public String registPOST3(QnAVO qnA, Model model, RedirectAttributes rttr)  throws Exception {
		qnaService.addReply(qnA);
		rttr.addFlashAttribute("msg", "SUCCESS");
		 
		return "redirect:/board/qnAList";
	}
	
	
	@RequestMapping(value = "/qnAList", method = RequestMethod.GET)
	public void listGET2(@ModelAttribute("cri") SearchCriteria cri, HttpSession session, Model model) throws Exception {
		cri.setPerPageNum(15);
		model.addAttribute("list", qnaService.listQnA(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(qnaService.listQnACount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}	
	
	
	@RequestMapping(value = "/qnARemove", method = RequestMethod.GET)
	public String removeGET2(@RequestParam("qnANo") int qnANo, Model model) throws Exception {
		qnaService.removeQnA(qnANo);
		
		return "redirect:/board/qnAList";
	}

	
	@RequestMapping(value = "/qnAMod", method = RequestMethod.GET)
	public void modifyGET2(int qnANo, Model model) throws Exception {
		model.addAttribute(qnaService.readQnA(qnANo));
	}
	
	@RequestMapping(value = "/qnAMod", method = RequestMethod.POST)
	public String modifyPOST2(QnAVO qnA, Model model)  throws Exception {
		qnaService.modifyQnA(qnA);
		 
		return "redirect:/board/qnAList";
	}
	
}

