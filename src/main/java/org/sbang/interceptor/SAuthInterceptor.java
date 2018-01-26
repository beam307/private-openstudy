package org.sbang.interceptor;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sbang.domain.UserVO;
import org.sbang.service.UserService;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SAuthInterceptor extends HandlerInterceptorAdapter {

	@Inject
	UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession();
		if (session.getAttribute("login") == null) { // login세션이 없으면
			saveDest(request); // URI값 가져오기
			response.sendRedirect("/login");
			session.setAttribute("temp", "temp");
			return false;
		}else {
			UserVO userVO = (UserVO) session.getAttribute("login");
			Integer userNo = userVO.getUserNo();
			userVO = userService.read(userNo);
			if(!(userVO.getUserName() != null && userVO.getUserNick() != null && userVO.getUserBirth() != null && userVO.getUserPhoneNumber() != null)) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('기본 프로필 정보가 부족합니다'); location.href = '/user/myPage'</script>"); // 실패알림 후 마이페이지가기
				out.close();
				return false;
			}
		}
		
		return true;
	}

	private void saveDest(HttpServletRequest req) {
		String uri = req.getRequestURI(); // URI로부터 URL 반환
		String query = req.getQueryString(); // URI 반환(질의 문자열 포함)

		if (query == null || query.equals("null"))
			query = "";
		else
			query = "?" + query;

		if (req.getMethod().equals("GET"))
			req.getSession().setAttribute("dest", uri + query);
	}

}