package org.sbang.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.sbang.domain.PageMaker;
import org.sbang.domain.SearchCriteria;
import org.sbang.service.AdminService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Inject
	private AdminService adminService;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model) throws Exception {
		model.addAttribute("totalUserVisit", adminService.totalUserVisit()); // 전체 방문자 수
		model.addAttribute("totalUserReg", adminService.totalUserReg()); // 전체 가입자 수
		model.addAttribute("totalStudyReg", adminService.totalStudyReg()); // 스터디 등록 수
		model.addAttribute("totalStudyApply", adminService.totalStudyApply()); // 스터디 신청 수
		model.addAttribute("totalStudyEnd", adminService.totalStudyEnd()); // 스터디 완료 수
		
		return "/admin/index";
	}
	
	@ResponseBody
	@RequestMapping(value = "/weekUserVisit", method = RequestMethod.POST)
	public List<Integer> weekVisit() throws Exception { // 주간 방문자 수
		return adminService.weekVisit();
	}
	
	@ResponseBody
	@RequestMapping(value = "/weekUserReg", method = RequestMethod.POST)
	public List<Integer> weekUserReg() throws Exception { // 주간 가입자 수
		return adminService.weekUserReg();
	}

	@ResponseBody
	@RequestMapping(value = "/weekStudyReg", method = RequestMethod.POST)
	public List<Integer> studyRegCnt() throws Exception { // 주간 스터디 신청 수
		return adminService.weekStudyReg();
	}

	@ResponseBody
	@RequestMapping(value = "/weekStudyApply", method = RequestMethod.POST)
	public List<Integer> studyApplyCnt() throws Exception { // 주간 스터디 신청 수
		return adminService.weekStudyApply();
	}
	
	@ResponseBody
	@RequestMapping(value = "/weekStudyEnd", method = RequestMethod.POST)
	public List<Integer> studyEndCnt() throws Exception { // 주간 스터디 완료 수
		return adminService.weekStudyEnd();
	}
	
	
	@RequestMapping(value = "/study", method = RequestMethod.GET)
	public void study(@ModelAttribute("cri") SearchCriteria cri, HttpSession session, Model model) throws Exception {
		cri.setPerPageNum(15);
		model.addAttribute("studyList", adminService.studyList(cri));

		PageMaker pageMaker = new PageMaker(); // 페이지 메이커 생성
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(adminService.studyCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public void user(@ModelAttribute("cri") SearchCriteria cri, HttpSession session, Model model) throws Exception {
		cri.setPerPageNum(15);
		model.addAttribute("userList", adminService.userList(cri));

		PageMaker pageMaker = new PageMaker(); // 페이지 메이커 생성
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(adminService.userCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}

	@ResponseBody
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public void userDelete(@RequestParam Integer userNo) throws Exception { // 유저 탈퇴
		adminService.userDelete(userNo);
	}

	@ResponseBody
	@RequestMapping(value = "/userDeleteCancel", method = RequestMethod.POST)
	public void userDeleteCancel(@RequestParam Integer userNo) throws Exception { // 유저 탈퇴철회
		adminService.userDeleteCancel(userNo);
	}

	@ResponseBody
	@RequestMapping(value = "/studyDelete", method = RequestMethod.POST)
	public void studyDelete(@RequestParam Integer studyNo) throws Exception { // 스터디 삭제
		adminService.studyDelete(studyNo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/studyDeleteCancel", method = RequestMethod.POST)
	public void studyDeleteCancel(@RequestParam Integer studyNo) throws Exception { // 스터디 삭제 취소
		adminService.studyDeleteCancel(studyNo);
	}

	@ResponseBody
	@RequestMapping(value = "/userHalt", method = RequestMethod.POST)
	public void userHalt(@RequestParam Integer userNo, @RequestParam Integer haltTime) throws Exception { // 유저 정지
		adminService.userHalt(userNo, haltTime);
	}

}
