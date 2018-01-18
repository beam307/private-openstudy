package org.sbang.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sbang.domain.PageMaker;
import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserVO;
import org.sbang.service.AdminService;
import org.sbang.service.ItemsService;
import org.sbang.service.StudyService;
import org.sbang.service.UserService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

@Controller
public class HomeController {

	@Inject
	private StudyService studyService;

	@Inject
	private UserService userService;

	@Inject
	private AdminService adminService;
	
	@Inject
	private ItemsService itemsService;
	
	@Inject
	private BCryptPasswordEncoder pwdEncoder;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Date totalCnt, Model model, StudyVO studyVO, HttpSession session, SearchCriteria cri, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		if (session.isNew())
			adminService.todyCntUpdate();
		

		cri.setPerPageNum(6);
		model.addAttribute("list", studyService.listSearchCriteria(cri));
		
		cri.setLineUp("f");
		model.addAttribute("listLine", studyService.listSearchCriteria(cri));
		
		UserVO userVO = (UserVO)session.getAttribute("login");
		if(userVO != null){ // 로그인 되었을 때
			Integer userNo = userVO.getUserNo();
			userVO = userService.read(userNo); // 유저정보 읽어오기
			cri.setPerPageNum(3); // 썸네일 3개까지만 출력
			
			cri.setLineUp(null); // 북마크 순 취소
			if(!(userVO.getUserFavUpRegion() == null || userVO.getUserFavUpRegion().equals("n") )){
				cri.setUpRegion(itemsService.readUpRegionNo(userVO.getUserFavUpRegion())); // upRegion 세팅
				cri.setDownRegion(itemsService.readDownRegionNo(userVO.getUserFavDownRegion())); // downRegion 세팅
				model.addAttribute("userFavRegion", studyService.listSearchCriteria(cri)); // 관심지역 리스트 넘기기
			} 
			
			cri.setUpRegion(null); // 관심지역 취소
			cri.setDownRegion(null); // 관심지역 취소
			String userFavCategory = userVO.getUserFavCategory();
			if(userFavCategory != null){
				String[] userFavCategoryArr = userFavCategory.split(",");
				cri.setCategory(itemsService.readCategoryNo(userFavCategoryArr[0])); // 관심카테고리 중 첫번 째 것으로 카테고리 번호 받아오기
				model.addAttribute("userFavCategory", studyService.listSearchCriteria(cri)); // 관심카테고리 리스트 넘기기	
			} 
			
		} else { // 로그인 안 되었을 때
			model.addAttribute("listRand", studyService.listSearchRand()); // 랜덤으로 스터디 6개 출력  
		}
		
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		session.removeAttribute("adminPwd");
		if (loginCookie != null) { // 자동로그인 쿠키
			UserVO vo = userService.checkLoginBefore(loginCookie.getValue());
			if (vo != null)
				session.setAttribute("login", vo);
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(studyService.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);

		return "index";
	}
	
	@RequestMapping(value = "/studyReg", method = RequestMethod.GET)
	public String studyReg(Model model) {

		return "study/studyReg";
	}

	@RequestMapping(value = "/studyList", method = RequestMethod.GET)
	public String list(Model model) {

		return "redirect:study/studyList";
	}

	@RequestMapping(value = "/studyModify", method = RequestMethod.GET)
	public String studyModify(Model model) {

		return "study/studyModify";
	}

	@RequestMapping(value = "/studyView", method = RequestMethod.GET)
	public String studyView(Model model) {

		return "study/studyView";
	}

	@RequestMapping(value = "/adminPwd", method = RequestMethod.GET)
	public String adminPwdGet() throws Exception {
		return "admin/adminPwd";
	}

	@RequestMapping(value = "/adminPwdPost", method = RequestMethod.POST)
	public void adminPwdPost(String adminPwd, HttpServletResponse response, HttpSession session) throws Exception {
		if(session.getAttribute("login") != null){ // 로그인 안한 경우
			if ( pwdEncoder.matches(adminPwd, adminService.getAdminPwd())) { // 2차 비밀번호가 일치 할 경우
				if(((UserVO)session.getAttribute("login")).getUserAuth() == 1) { // 관리자아이디로 로그인 한경우
					session.setAttribute("adminPwd", "adminPwd");
					response.sendRedirect("/admin/index");
				}
				else
					response.sendRedirect("/");
			} else
				response.sendRedirect("/adminPwd");
		}
		else
			response.sendRedirect("/");
	}
	
	@RequestMapping(value = "/changeAdminPwd", method = RequestMethod.GET)
	public String changeAdminPwdGET() throws Exception {
		return "admin/changeAdminPwd";
	}
	@RequestMapping(value = "/changeAdminPwdPost", method = RequestMethod.POST)
	public String changeAdminPwdPOST(String adminPwd, String adminNewPwd, HttpServletRequest request, HttpSession session) throws Exception {
		if( pwdEncoder.matches(adminPwd, adminService.getAdminPwd())){
			adminService.changeAdminPwd(pwdEncoder.encode(adminNewPwd));
			request.setAttribute("msg", "changePwd");
		}else
			request.setAttribute("msg", "changeFail");
		// pwdEncoder.matches(adminPwd, adminService.getAdminPwd())
		return "admin/changeAdminPwdPost";
	}
}
