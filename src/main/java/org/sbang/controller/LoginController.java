package org.sbang.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sbang.DTO.LoginDTO;
import org.sbang.domain.UserVO;
import org.sbang.kakao.KakaoLogin;
import org.sbang.naver.JsonParser;
import org.sbang.naver.NaverLoginBO;
import org.sbang.service.AdminService;
import org.sbang.service.UserService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping("/login")
public class LoginController {

	private NaverLoginBO naverLoginBO;

	@Inject
	private BCryptPasswordEncoder pwdEncoder;

	@Inject
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@Inject
	private UserService userService;
	
	@Inject
	private AdminService adminService;
	
	@RequestMapping(value = "/loginGet", method = RequestMethod.GET)
	public String loginGet(HttpServletRequest request) throws Exception { // 로그인창
		HttpSession session = request.getSession();
		if (request.getRequestURI() != null && request.getHeader("referer") != null) { // 바로 로그인 URI 접근시 null값 방지
			if (session.getAttribute("temp") != null) // auth인터셉터 거칠때는 이전 페이지 저장 X
				session.removeAttribute("temp");
			else if (!(request.getRequestURI().equals("/login/loginGet") && request.getHeader("referer").equals("http://localhost/login/loginGet"))) // 로그인창 여러번 할때는 저장하지 않음
				session.setAttribute("dest", request.getHeader("referer")); // 이전 페이지 정보 저장
		}

		return "/user/login";
	}

	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public void loginPost(LoginDTO dto, Model model, HttpSession session) throws Exception { // 로그인
		UserVO vo = null;
		
		if(userService.userLeaveCheck(dto.getUserEmail()) > 0) // 탈퇴유저 확인
			model.addAttribute("userLeaveCheck", true);
		
		if (pwdEncoder.matches(dto.getUserPwd(), userService.getPwd(dto))) // DB 비밀번호와 로그인 비밀번호 비교
			vo = userService.login(dto); // vo에 userNo, userEmail, userNick, userProfileImgPath 저장
		else {
			model.addAttribute("loginFail", true);
			return;
		}
		
		String temp;
		if((temp = adminService.userHaltCheck(vo.getUserNo())) != null) // 정지 유저인 경우
			model.addAttribute("userHaltCheck", temp); // model을 인터셉터로 넘기기
		model.addAttribute("userVO", vo); // model에 {userVO : vo} 저장
		if (dto.isUseCookie()) {
			int amount = 60 * 60 * 24 * 7;
			Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
			userService.keepLogin(vo.getUserEmail(), session.getId(), sessionLimit); // 세션ID,세션시간,저장
		}

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception { // 로그아웃
		Object obj = session.getAttribute("login");

		if (obj != null) {
			UserVO vo = (UserVO) obj;
			session.removeAttribute("login"); // 세션 제거
			session.invalidate();

			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");

			if (loginCookie != null) { // 쿠키 제거
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				userService.keepLogin(vo.getUserEmail(), session.getId(), new Date());
			}
		}
		return "/login/logout";
	}

	@RequestMapping(value = "/naverLogin", method = RequestMethod.GET)
	public ModelAndView naverLogin(HttpSession session) { // 네이버 로그인
		/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		return new ModelAndView("login/naverLogin", "url", naverAuthUrl);
	}

	@RequestMapping(value = "/callback", method = RequestMethod.GET)
	public void callback(@RequestParam String code, @RequestParam String state, HttpSession session, Model model, UserVO userVO) throws Exception { // 네이버 로그인 콜백
		/* 네아로 인증이 성공적으로 완료되면 code 파라미터가 전달되며 이를 통해 access token을 발급 */
		JsonParser json = new JsonParser();

		OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
		String apiResult = naverLoginBO.getUserProfile(oauthToken);
		userVO = json.changeJson(apiResult); // userVO {userEmail, userNick, userGender, userNaver} 저장
		boolean SNSFlag = false;
		if (userService.selectNaver(userVO) == null) {// 처음 로그인 하는 사용자
			String userNick = userVO.getUserNick();
			if (userService.nickCheck(userNick) >0) {
				String ran =null;
				 do{
					ran=String.valueOf((int)(Math.random()*10000));
					
					while(ran.length()!=4) 
						ran=String.valueOf((int)(Math.random()*10000));
					
				}while (userService.nickCheck(userNick+"#"+ran) > 0);
				 userVO.setUserNick(userNick+"#"+ran);
			}
			userService.insertNaver(userVO);//처음 로그인시
			
			SNSFlag = true;// 처음 SNS로그인하는 사용자는 myPage로
			
		}
		userVO = userService.snsLogin(userVO); // user 재설정(userNo, userEmail, userNick, userProfileImgPath} 담기
		model.addAttribute("userVO", userVO); // model에 {userVO : userVO} 저장 // 이전 페이지 정보 저장을 위해서 필요
		model.addAttribute("SNSFlag", SNSFlag);
		
		String temp;
		if((temp = adminService.userHaltCheck(userVO.getUserNo())) != null) {// 정지 유저인 경우
			model.addAttribute("userHaltCheck", temp); // model을 인터셉터로 넘기기
			session.setAttribute("snsHalt", true);
		}
	}

	@RequestMapping(value = "/kakaoLogin", method = { RequestMethod.GET, RequestMethod.POST })
	public void kakaoLogin(@RequestParam("code") String code, UserVO userVO, HttpSession session, Model model) throws Exception { // 카카오 로그인
		JsonNode jsonToken = KakaoLogin.getAccessToken(code);
		JsonNode userInfo = KakaoLogin.getKakaoUserInfo(jsonToken.get("access_token").toString());
		userVO = KakaoLogin.changeData(userInfo); // userVO {userEmail, userNick, userName, userKakao}저장

		
		boolean SNSFlag = false;
		if (userService.selectKakao(userVO) == null) {// 처음 로그인 하는 사용자
			String userNick = userVO.getUserNick();
			if (userService.nickCheck(userNick) > 0) {
				String ran =null;
				 do{
					ran=String.valueOf((int)(Math.random()*10000));
					while(ran.length()!=4) 
						ran=String.valueOf((int)(Math.random()*10000));
				}while (userService.nickCheck(userNick+"#"+ran) > 0);
				 userVO.setUserNick(userNick+"#"+ran);
			}
			userService.insertKakao(userVO);// 처음가입시
			
			SNSFlag = true;// 처음 SNS로그인하는 사용자는 myPage로
		}

		userVO = userService.snsLogin(userVO); // user 재설정(userNo, userEmail, userNick, userKakao, userNaver, userProfileImgPath} 담기
		model.addAttribute("userVO", userVO); // model에 {userVO : userVO} 저장 // 이전 페이지 정보 저장을 위해서 필요
		model.addAttribute("SNSFlag", SNSFlag);
		
		String temp;
		if((temp = adminService.userHaltCheck(userVO.getUserNo())) != null) { // 정지 유저인 경우
			model.addAttribute("userHaltCheck", temp); // model을 인터셉터로 넘기기
			session.setAttribute("snsHalt", true);
		}
	}

}