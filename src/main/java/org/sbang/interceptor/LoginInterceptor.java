package org.sbang.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sbang.domain.UserVO;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
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
		UserVO vo = (UserVO) userVO;
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if (modelMap.get("loginFail") != null) { // 아이디,비밀번호가  일치하지 않을 경우
			out.println("<script>alert('아이디와 비밀번호가 일치하지 않습니다.'); location.href = '/login/loginGet'</script>"); // 실패알림 후 로그인창 가기
			out.close();
			return;
		}
		
		if (modelMap.get("userLeaveCheck") != null) {
			out.println("<script>alert('해당 고객님은 탈퇴 유저입니다.'); location.href = '/login/loginGet'; </script>"); // 탈퇴알림 후 로그인창 가기
			out.close();
			return;
		}
		
		if (modelMap.get("emailCertification") != null) {
			out.println("<script>alert('이메일 인증을 받지 않은 고객입니다. 이메일 인증을 받으십시요.'); location.href = '/login/loginGet'; </script>"); // 인증알림 후 로그인창 가기
			out.close();
			return;
		}
		
		if (modelMap.get("userHaltCheck") != null) { // 정지 유저 일 경우
			out.println("<script>alert('고객님은 [" + modelMap.get("userHaltCheck") + "] 까지 정지기간 입니다.'); location.href = '/login/loginGet'</script>"); // 정지알림 후 로그인창 가기
			out.close();
			return;
		}
		
		if (userVO != null) { // 로그인 성공시(객체가 있을 경우)
			session.setAttribute(LOGIN, userVO); // userVO 세션저장
			if (request.getParameter("useCookie") != null) {
				Cookie loginCookie = new Cookie("loginCookie", session.getId()); // loginCookie 쿠키에 세션id 저장
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(loginCookie);
			}

			Cookie idCookie = new Cookie("rememberID", vo.getUserEmail());

			if (request.getParameter("rememberEmail") != null) {
				idCookie.setMaxAge(60 * 60 * 24 * 7);
				idCookie.setPath("/");
				response.addCookie(idCookie);
			} else {
				idCookie.setMaxAge(0);
				idCookie.setPath("/");
				response.addCookie(idCookie);
			}

			String dest = (String) session.getAttribute("dest"); // URI 세션 저장
			
			if(session.getAttribute("snsHalt") != null) {
				dest = "/";
				session.removeAttribute("snsHalt");
			}
			
			if (dest.equals("http://localhost/login/loginPost"))
				dest = "/";
			response.sendRedirect(dest != null ? (String) dest : "/");
		} else
			response.sendRedirect("/login/loginGet");

	}

}
