package org.sbang.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.sbang.domain.NoteVO;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserStudyVO;
import org.sbang.domain.UserVO;
import org.sbang.mail.TempKey;
import org.sbang.service.NoteService;
import org.sbang.service.UserService;
import org.sbang.sms.Coolsms;
import org.sbang.util.AlarmUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService userService;

	@Inject
	private NoteService noteService;

	@Inject
	private AlarmUtils alarmUtils;

	@Inject
	private BCryptPasswordEncoder pwdEncoder;

	@RequestMapping(value = "/regUser", method = RequestMethod.GET)
	public void regUserGet() throws Exception { // 회원가입
	}

	@RequestMapping(value = "/regUser", method = RequestMethod.POST)
	public String regUserPost(UserVO userVO, RedirectAttributes rttr) throws Exception { // 회원가입

		userService.create(userVO);
		rttr.addFlashAttribute("msg", "regSuccess");
		rttr.addFlashAttribute("userEmail", userVO.getUserEmail());
		return "redirect:/";
	}

	@ResponseBody
	@RequestMapping(value = "/sendSMS", method = RequestMethod.POST)
	public String sendSMS(String userPhoneNumber) throws Exception { // 휴대폰 문자보내기

		String api_key = "NCSQBDPMUOMDA9HP";
		String api_secret = "1NKOJINSQP8QZPAOPIF6MLYZHEWRCGGO";
		Coolsms coolsms = new Coolsms(api_key, api_secret);
		String key = new TempKey().getNumKey(6); // 인증키 생성
		userService.insertAuthCode(userPhoneNumber, key); // 테이블에 폰번호와 인증키넣기
		/*
		 * Parameters 관련정보 : http://www.coolsms.co.kr/SDK_Java_API_Reference_ko#toc-0
		 */
		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", userPhoneNumber); // 수신번호
		set.put("from", "01062313396"); // 발신번호
		set.put("text", "안녕하세요 오픈스터디입니다. 인증번호는 [" + key + "] 입니다."); // 문자내용
		set.put("type", "sms"); // 문자 타입

		JSONObject result = coolsms.send(set); // 보내기&전송결과받기
		if ((boolean) result.get("status") == true) {
			// 메시지 보내기 성공 및 전송결과 출력
			System.out.println("성공");
			System.out.println(result.get("group_id")); // 그룹아이디
			System.out.println(result.get("result_code")); // 결과코드
			System.out.println(result.get("result_message")); // 결과 메시지
			System.out.println(result.get("success_count")); // 메시지아이디
			System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수
			return "success";
		} else {
			// 메시지 보내기 실패
			System.out.println("실패");
			System.out.println(result.get("code")); // REST API 에러코드
			System.out.println(result.get("message")); // 에러메시지
			return "fail";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/phoneDuplicate", method = RequestMethod.POST)
	public String phoneDuplicate(String userPhoneNumber) throws Exception { // 휴대폰중복체크
		if (userService.phoneDuplicate(userPhoneNumber) != 0) // 휴대폰이 중복된 경우
			return "fail";
		else // 휴대폰 중복이 안된 경우
			return "success";
	}

	@ResponseBody
	@RequestMapping(value = "/authCodeCheck", method = RequestMethod.POST) // 인증번호 체크
	public String authCodeCheck(String phoneCheck, String authCode, String userPhoneNumber, HttpSession session) throws Exception {
		UserVO userVO = (UserVO) session.getAttribute("login");
		userVO.setUserPhoneNumber(userPhoneNumber); // userPhoneNumber = 콤마 있는 전화번호

		if (authCode.equals(userService.authCodeCheck(phoneCheck))) { // phoneCheck = 콤마 없는 전화번호
			userService.phoneNumberOK(userVO);
			return "success";
		} else
			return "fail";
	}

	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPageGet(HttpSession session, Model model) throws Exception { // 마이페이지 창

		UserVO userVO = (UserVO) session.getAttribute("login");
		model.addAttribute("UserVO", userService.read(userVO.getUserNo()));
		return "/user/myPage";

	}

	@RequestMapping(value = "/myPage", method = RequestMethod.POST)
	public String myPagePost(UserVO userVO, RedirectAttributes rttr, HttpSession session) throws Exception { // 프로필정보수정

		UserVO tempVO = (UserVO) session.getAttribute("login");
		userVO.setUserNo(tempVO.getUserNo());
		userService.modify(userVO);
		userVO = userService.snsLogin(userVO); // 세션 재구성
		session.setAttribute("login", userVO);
		rttr.addFlashAttribute("msg", "regSuccess");

		return "/user/myPagePost";
	}

	@RequestMapping(value = "/additionalInfo", method = RequestMethod.POST)
	public String additionalInfoPost(UserVO userVO, RedirectAttributes rttr, HttpSession session) throws Exception { // 부가정보수정

		UserVO tempVO = (UserVO) session.getAttribute("login");
		userVO.setUserNo(tempVO.getUserNo());
		userService.additionalInfo(userVO);
		rttr.addFlashAttribute("msg", "regSuccess");

		return "/user/additionalInfoPost";
	}

	@RequestMapping(value = "/userInfo", method = RequestMethod.GET)
	public String userInfo(Integer userNo, Model model) throws Exception { // 유저정보페이지

		model.addAttribute(userService.read(userNo)); // 유저정보
		model.addAttribute("applyStudyCnt", userService.applyStudyCnt(userNo)); // 신청스터디(승인완료) 갯수
		model.addAttribute("applyStudyList", userService.applyStudyList(userNo)); // 신청스터디(승인완료) 리스트
		model.addAttribute("endStudyList", userService.endStudyList(userNo)); // 스터디 완료리스트

		return "/user/userInfo";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deletePost(RedirectAttributes rttr, HttpSession session) throws Exception { // 회원탈퇴

		UserVO vo = (UserVO) session.getAttribute("login"); // 로그인 유저정보
		userService.delete(vo);
		session.invalidate(); // 세션초기화

		rttr.addFlashAttribute("msg", "delete");

		return "redirect:/";
	}

	@RequestMapping(value = "/changePwd", method = RequestMethod.POST)
	public String changePost(UserVO userVO, HttpServletRequest request, HttpSession session, String userNewPwd) throws Exception { // 비밀번호 변경

		userVO.setUserNo(((UserVO) session.getAttribute("login")).getUserNo());
		userVO.setUserEmail(((UserVO) session.getAttribute("login")).getUserEmail());

		if (pwdEncoder.matches(userVO.getUserPwd(), userService.getPwd(userVO))) { // 비밀번호 비교
			userVO.setUserPwd(pwdEncoder.encode(userNewPwd)); // 비밀번호 암호화
			userService.changePwd(userVO);
			request.setAttribute("msg", "changePwd");
		} else
			request.setAttribute("msg", "changeFail");

		return "/user/changePwdPost";
	}

	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	public String findIdGet(String userPhoneNumber, String toEmail, RedirectAttributes rttr) throws Exception { // 아이디 찾기
		if (userService.findIdCheck(userPhoneNumber) != 0) {
			rttr.addFlashAttribute("findUser", "findIdSuccess");
			rttr.addFlashAttribute("userPhoneNumber", userPhoneNumber);
			rttr.addFlashAttribute("toEmail", toEmail);
		} else
			rttr.addFlashAttribute("findUser", "findIdFail");

		return "redirect:/login";
	}
	
	@ResponseBody
	@RequestMapping(value = "/findIdSendEmail", method = RequestMethod.POST)
	public void findIdSendEmail(String userPhoneNumber, String toEmail) throws Exception { // 인증번호 체크
		userService.findId(userPhoneNumber, toEmail);
	}

	@RequestMapping(value = "/findPwd", method = RequestMethod.POST)
	public String sendPwd(UserVO userVO, RedirectAttributes rttr) throws Exception { // 패스워드 찾기
		if (userService.findPwdCheck(userVO) != 0) { // 패스워드 찾기 성공하면
			rttr.addFlashAttribute("findUser", "findPwdSuccess");
			rttr.addFlashAttribute("userVO", userVO);
		} else // 패스워드 찾기 실패하면
			rttr.addFlashAttribute("findUser", "findPwdFail");

		return "redirect:/login";
	}
	
	@ResponseBody
	@RequestMapping(value = "/findPwdSendPwd", method = RequestMethod.POST)
	public void findPwdSendPwd(@RequestBody UserVO userVO) throws Exception { // 패스워드 찾기 이메일 보내기
		userService.findPwd(userVO);
	}

	@RequestMapping(value = "/studyManage", method = RequestMethod.GET)
	public void studyManage() throws Exception { // 스터디관리창
	}

	@ResponseBody
	@RequestMapping(value = "/favList", method = RequestMethod.POST)
	public List<StudyVO> favList(Integer userNo) throws Exception { // 북마크 리스트

		return userService.favStudyManage(userNo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/regList", method = RequestMethod.POST)
	public List<StudyVO> regList(Integer userNo) throws Exception { // 모집 리스트
	
		return userService.regStudyManage(userNo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/appList", method = RequestMethod.POST)
	public List<StudyVO> appList(Integer userNo) throws Exception { // 신청 리스트
	
		return userService.applyStudyManage(userNo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/endList", method = RequestMethod.POST)
	public List<StudyVO> endList(Integer userNo) throws Exception { // 완료 리스트
		
		List<StudyVO> list = new ArrayList<>(userService.endStudyManage(userNo)); // 스터디장일 경우
		list.addAll(userService.memberEndStudyManage(userNo)); // 스터디원일 경우
		
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "/checkEmail", method = RequestMethod.POST)
	public Integer checkEmail(String userEmail, Integer result) throws Exception { // 이메일 중복확인(ajax)
		
		return userService.emailCheck(userEmail); // 있으면 1 , 없으면 0
	}

	@ResponseBody
	@RequestMapping(value = "/checkNick", method = RequestMethod.POST)
	public Integer checkMail(String userNick, Integer result) throws Exception { // 닉네임 중복확인(ajax)

		return userService.nickCheck(userNick); // 있으면 1 , 없으면 0
	}

	@ResponseBody
	@RequestMapping(value = "/applyMemList", method = RequestMethod.POST)
	public List<UserVO> applyMemList(Integer studyNo) throws Exception { // 신청자리스트(ajax)

		return userService.applyMember(studyNo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/studyMemList", method = RequestMethod.POST)
	public List<UserVO> studyMemList(Integer studyNo) throws Exception { // 스터디 멤버리스트(ajax)

		return userService.studyMemList(studyNo);
	}

	@ResponseBody
	@RequestMapping(value = "/applyApprove", method = RequestMethod.POST)
	public UserVO applyResult(Integer studyNo, Integer userNo, Integer studyWriter, UserVO userVO) throws Exception { // 신청 승인(ajax)

		userService.applyApprove(studyNo, userNo); // 신청승인
		alarmUtils.createAlarm(studyNo, userNo, studyWriter, 5); // 알람생성

		return userService.read(userNo); // 유저정보 넘기기
	}

	@ResponseBody
	@RequestMapping(value = "/applyDeny", method = RequestMethod.POST)
	public void applyDeny(Integer studyNo, Integer userNo, Integer studyWriter, String denyMsg) throws Exception { // 신청 거부(ajax)

		userService.applyDeny(studyNo, userNo, denyMsg); // 신청 거부
		
		NoteVO note = new NoteVO();
		note.setNoteTarget(userNo);
		note.setNoteSender(studyWriter);
		note.setNoteText(denyMsg);
		noteService.addNote(note); // 거부 쪽지 보내기
		
		alarmUtils.createAlarm(studyNo, userNo, studyWriter, 6); // 알람생성
	}

	@ResponseBody
	@RequestMapping(value = "/approveCheck", method = RequestMethod.POST)
	public Map<String, Object> approveCheck(Integer studyNo, HttpSession session) throws Exception { // 승인여부체크(ajax)
		Map<String, Object> map = new HashMap<>();
		UserVO userVO = (UserVO) session.getAttribute("login"); // 로그인 유저정보
		UserStudyVO userStudyVO = userService.approveCheck(studyNo, userVO.getUserNo()); // 스터디 승인 여부
		
		userVO = userService.studyLeaderInfo(studyNo); // 스터디장 정보 (userVO 객체재사용)
		map.put("userStudyVO", userStudyVO);
		if (userStudyVO.getUserApprove() == 2) // 스터디장이 승인 할 경우 정보 넘기기(보안상)
			map.put("userVO", userVO);

		return map;
	}
	
	@RequestMapping(value = "/userAgree", method = RequestMethod.GET)
	public String userAgree() throws Exception { // 약관동의
		return "/user/userAgree";
	}
}