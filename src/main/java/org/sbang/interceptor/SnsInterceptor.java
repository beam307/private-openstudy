package org.sbang.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SnsInterceptor extends HandlerInterceptorAdapter {
	private static final String LOGIN = "login";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		if (session.getAttribute(LOGIN) != null) // 기존 로그인정보 삭제
			session.removeAttribute(LOGIN);

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();

		ModelMap modelMap = modelAndView.getModelMap();
		Object userVO = modelMap.get("userVO"); // userVO 모델속성 가져옴
		if (modelMap.get("userHaltCheck") != null) { // 정지 유저 일 경우
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('고객님은 [" + modelMap.get("userHaltCheck") + "] 까지 정지기간 입니다.'); location.replace('/login/loginGet');</script>"); // 정지 알림 후
			out.close();
		} else {
			if (userVO != null) { // 로그인 성공시(객체가 있을 경우)
				session.setAttribute(LOGIN, userVO); // userVO 세션저장

				String dest = (String) session.getAttribute("dest"); // URI 세션 저장
				boolean SNSFlag = (boolean) modelMap.get("SNSFlag");
				if (SNSFlag)
					dest = "/user/myPage";
				if(session.getAttribute("snsHalt") != null) {
					dest = "/";
					session.removeAttribute("snsHalt");
				}
				response.sendRedirect(dest != null ? dest : "/");
			} else
				response.sendRedirect("/login/loginGet");
		}
	}
}
