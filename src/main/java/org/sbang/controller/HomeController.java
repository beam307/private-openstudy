package org.sbang.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String home(HttpSession session, HttpServletRequest request) throws Exception {
		
		if (session.isNew()) // 방문자수 업데이트
			adminService.todyCntUpdate();
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		session.removeAttribute("adminPwd");
		if (loginCookie != null) { // 자동로그인 쿠키
			UserVO vo = userService.checkLoginBefore(loginCookie.getValue());
			if (vo != null)
				session.setAttribute("login", vo);
		}

		return "index";
	}
	
	@ResponseBody
	@RequestMapping(value = "/recentList", method = RequestMethod.POST)
	public List<StudyVO> recentList(SearchCriteria cri) throws Exception { // 최신순 리스트
		cri.setPerPageNum(6);
		return studyService.listSearchCriteria(cri);
	}
	
	@ResponseBody
	@RequestMapping(value = "/bestList", method = RequestMethod.POST)
	public List<StudyVO> bestList(SearchCriteria cri) throws Exception { // 베스트순 리스트
		cri.setLineUp("f");
		cri.setPerPageNum(6);
		return studyService.listSearchCriteria(cri);
	}
	
	@ResponseBody
	@RequestMapping(value = "/favAllList", method = RequestMethod.POST)
	public List<StudyVO> favAllList(HttpSession session) throws Exception { // 관심카테고리순 리스트
		Integer userNo = ((UserVO) session.getAttribute("login")).getUserNo();
		UserVO userVO = userService.read(userNo);

		if (userNo != null) { // 로그인 했을 경우
			if (userVO.getUserFavCategory() != null) { // 카테고리 선택했을 경우
				String[] favCategoryArr = userVO.getUserFavCategory().split(","); // 카테고리 배열
				return itemsService.favStudyList(favCategoryArr, userVO.getUserFavUpRegion()); // 추천스터디 리스트
			} else // 카테고리 선택 안할시
				return null;
		} else // 로그인 안할 시
			return null;
	}
	
	@ResponseBody
	@RequestMapping(value = "/randomList", method = RequestMethod.POST)
	public List<StudyVO> randomList() throws Exception { // 랜덤 리스트
		return studyService.listSearchRand();
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
