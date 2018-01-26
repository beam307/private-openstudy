package org.sbang.controller;

import javax.inject.Inject;

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

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Inject
	private NoticeService notiService;
	
	@Inject
	private QnAService qnaService;
	
	@RequestMapping(value = "/noticeReg", method = RequestMethod.GET)
	public void noticeRegGET() throws Exception {}
	
	@RequestMapping(value = "/noticeReg", method = RequestMethod.POST)
	public String noticeRegPOST(NoticeVO notice)  throws Exception {
		notiService.addNotice(notice);
		return "redirect:/board/noticeList";
	}
	
	
	@RequestMapping(value = "/noticeList", method = RequestMethod.GET)
	public void noticeList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		cri.setPerPageNum(15);
		model.addAttribute("list", notiService.listNotice(cri)); // 전체 리스트
		
		PageMaker pageMaker = new PageMaker(); // 페이지 메이커 생성
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(notiService.listNoticeCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}	
	
	
	@RequestMapping(value = "/noticeRemove", method = RequestMethod.GET)
	public String noticeRemove(Integer noticeNo) throws Exception {
		notiService.removeNotice(noticeNo);
		
		return "redirect:/board/noticeList";
	}

	
	@RequestMapping(value = "/noticeMod", method = RequestMethod.GET)
	public void noticeModGET(Integer noticeNo, Model model) throws Exception {
		model.addAttribute(notiService.readNotice(noticeNo));
	}
	
	@RequestMapping(value = "/noticeMod", method = RequestMethod.POST)
	public String noticeModPOST(NoticeVO notice)  throws Exception {
		notiService.modifyNotice(notice);
		 
		return "redirect:/board/noticeList";
	}

	
	
	
	@RequestMapping(value = "/qnAReg", method = RequestMethod.GET)
	public void qnARegGET() throws Exception {}
	
	@RequestMapping(value = "/qnAReg", method = RequestMethod.POST)
	public String qnARegPOST(QnAVO qnA)  throws Exception {
		
		qnaService.addQnA(qnA);
		
		return "redirect:/board/qnAList";
	}
	
	@RequestMapping(value = "/qnAList", method = RequestMethod.GET)
	public void listGET2(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		
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

