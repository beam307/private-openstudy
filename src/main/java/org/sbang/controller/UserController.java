package org.sbang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.sbang.domain.AlarmVO;
import org.sbang.domain.Criteria;
import org.sbang.domain.NoteVO;
import org.sbang.domain.UserStudyVO;
import org.sbang.domain.UserVO;
import org.sbang.mail.TempKey;
import org.sbang.service.AlarmService;
import org.sbang.service.NoteService;
import org.sbang.service.UserService;
import org.sbang.sms.Coolsms;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService userService;
	
	@Inject
	private AlarmService alarmService;
	
	@Inject
	private NoteService noteService;

	@Inject
	private BCryptPasswordEncoder pwdEncoder;

	@RequestMapping(value = "/regUser", method = RequestMethod.GET)
	public String registerGet() throws Exception { // 회원가입

		return "/user/userJoin";
	}

	@RequestMapping(value = "/regUser", method = RequestMethod.POST)
	public String registerPost(UserVO vo, RedirectAttributes rttr) throws Exception { // 회원가입

		userService.create(vo);
		rttr.addFlashAttribute("msg", "regSuccess");
		rttr.addFlashAttribute("userEmail", vo.getUserEmail());
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value = "/sendSMS", method = RequestMethod.POST)
	public String sendSMS(@RequestParam String userPhoneNumber) throws Exception { // 휴대폰 문자보내기
		
		String api_key = "NCSQBDPMUOMDA9HP";
        String api_secret = "1NKOJINSQP8QZPAOPIF6MLYZHEWRCGGO";
        Coolsms coolsms = new Coolsms(api_key, api_secret);
        String key = new TempKey().getNumKey(6);
        userService.insertAuthCode(userPhoneNumber, key);
        /*
         * Parameters
         * 관련정보 : http://www.coolsms.co.kr/SDK_Java_API_Reference_ko#toc-0
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
            System.out.println(result.get("result_message"));  // 결과 메시지
            System.out.println(result.get("success_count")); // 메시지아이디
            System.out.println(result.get("error_count"));  // 여러개 보낼시 오류난 메시지 수
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
	public String phoneDuplicate(@RequestParam String userPhoneNumber) throws Exception { // 휴대폰중복체크
		if(userService.phoneDuplicate(userPhoneNumber) > 0) // 휴대폰이 중복된 경우
			return "fail";
		else // 휴대폰 중복이 안된 경우
			return "success";
	}
	
	@ResponseBody
	@RequestMapping(value = "/authCodeCheck", method = RequestMethod.POST)
	public String authCodeCheck(@RequestParam String phoneCheck, @RequestParam String authCode, @RequestParam String userPhoneNumber, HttpSession session) throws Exception { // 인증번호 체크
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

		UserVO vo = (UserVO) session.getAttribute("login");
		model.addAttribute("UserVO", userService.read(vo.getUserNo()));
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
	public String userInfo(@RequestParam Integer userNo, Model model) throws Exception {

		model.addAttribute(userService.read(userNo)); 
		model.addAttribute("applyStudyCnt", userService.applyStudyCnt(userNo)); // 신청스터디(승인완료) 갯수
		model.addAttribute("applyStudyList", userService.applyStudyList(userNo)); // 신청스터디(승인완료) 리스트
		model.addAttribute("endStudyList", userService.endStudyList(userNo)); // 스터디 완료리스트

		return "/user/userInfo";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deletePost(RedirectAttributes rttr, HttpSession session) throws Exception { // 회원탈퇴

		UserVO vo = (UserVO) session.getAttribute("login");
		userService.delete(vo);
		session.invalidate();

		rttr.addFlashAttribute("msg", "delete");

		return "redirect:/";
	}

	@RequestMapping(value = "/changePwd", method = RequestMethod.POST)
	public String changePost(UserVO vo, HttpServletRequest request, HttpSession session, @RequestParam String userNewPwd) throws Exception { // 비밀번호 변경

		vo.setUserNo(((UserVO) session.getAttribute("login")).getUserNo());
		vo.setUserEmail(((UserVO) session.getAttribute("login")).getUserEmail());
		if (pwdEncoder.matches(vo.getUserPwd(), userService.getPwd(vo))) {
			vo.setUserPwd(pwdEncoder.encode(userNewPwd)); // 비밀번호 암호화
			userService.changePwd(vo);
			request.setAttribute("msg", "changePwd");
		} else
			request.setAttribute("msg", "changeFail");

		return "/user/changePwdPost";
	}

	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	public String findIdGet(@RequestParam String userPhoneNumber, @RequestParam String toEmail, RedirectAttributes rttr) throws Exception { // 아이디 찾기
		if (userService.findIdCheck(userPhoneNumber) > 0) {
			rttr.addFlashAttribute("findUser", "findIdSuccess");
			rttr.addFlashAttribute("userPhoneNumber", userPhoneNumber);
			rttr.addFlashAttribute("toEmail", toEmail);
		}
		else
			rttr.addFlashAttribute("findUser", "findIdFail");

		return "redirect:/login/loginGet";
	}
	
	@ResponseBody
	@RequestMapping(value = "/findIdSendEmail", method = RequestMethod.POST)
	public void findIdSendEmail(@RequestParam String userPhoneNumber, @RequestParam String toEmail) throws Exception { // 인증번호 체크
		userService.findId(userPhoneNumber, toEmail);
	}

	@RequestMapping(value = "/findPwd", method = RequestMethod.POST)
	public String sendPwd(UserVO vo, RedirectAttributes rttr) throws Exception { // 패스워드 찾기
		if (userService.findPwdCheck(vo) > 0) {
			rttr.addFlashAttribute("findUser", "findPwdSuccess");
			rttr.addFlashAttribute("userVO", vo);
		} else
			rttr.addFlashAttribute("findUser", "findPwdFail");

		return "redirect:/login/loginGet";
	}
	
	@ResponseBody
	@RequestMapping(value = "/findPwdSendPwd", method = RequestMethod.POST)
	public void findPwdSendPwd(@RequestBody UserVO userVO) throws Exception { // 패스워드 찾기 이메일 보내기
		userService.findPwd(userVO);
	}

	@RequestMapping(value = "/studyManage", method = RequestMethod.GET)
	public String studyManage(@ModelAttribute("cri") Criteria cri, Model model, HttpSession session) throws Exception {

		UserVO userVO = (UserVO) session.getAttribute("login");
		int userNo = userVO.getUserNo();
		
		model.addAttribute("favList", userService.favStudyManage(userNo)); // 스터디 즐겨찾기리스트
		model.addAttribute("regList", userService.regStudyManage(userNo)); // 스터디 등록리스트
		model.addAttribute("appList", userService.applyStudyManage(userNo)); // 스터디 신청리스트
		model.addAttribute("endList", userService.endStudyManage(userNo)); // 스터디 완료리스트
		model.addAttribute("endListMem", userService.memberEndStudyManage(userNo)); // 스터디 완료리스트(스터디원기준)

		return "/user/studyManage";
	}

	@ResponseBody
	@RequestMapping(value = "/checkEmail", method = RequestMethod.POST)
	public Integer checkEmail(@RequestParam String userEmail, Integer result) throws Exception { // 이메일 중복확인(ajax)
		
		result = userService.emailCheck(userEmail); // 있으면 1 , 없으면 0

		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/checkNick", method = RequestMethod.POST)
	public Integer checkMail(@RequestParam String userNick, Integer result) throws Exception { // 닉네임 중복확인(ajax)

		result = userService.nickCheck(userNick);

		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/favoriteStudy", method = RequestMethod.POST)
	public String favoriteStudy(HttpSession session, UserVO userVO, @RequestParam Integer studyNo, @RequestParam Integer studyWriter) throws Exception { // 스터디 즐겨찾기(ajax)

		userVO = (UserVO) session.getAttribute("login");
		int userNo = userVO.getUserNo();

		int result; // 0 = 값변경 X / 1 = 값변경 O

		if (userService.checkFavorStudy(userNo, studyNo) > 0) { // 이미 즐겨 찾기 한 경우
			result = 0;
			userService.deleteFavorStudy(userNo, studyNo);
			
		} else { // 즐겨 찾기 안한 경우
			result = 1;
			userService.favorStudy(userNo, studyNo);
			if(userNo!=studyWriter) {
				AlarmVO alarm=new AlarmVO();
				alarm.setAlarmSender(userNo);
				alarm.setAlarmTargetStudy(studyNo);
				alarm.setAlarmTarget(studyWriter);
				alarm.setAlarmFlag(3);
				alarmService.create(alarm);
			}
		}
		return String.valueOf(result);
	}

	@ResponseBody
	@RequestMapping(value = "/applyStudy", method = RequestMethod.POST)
	public String applyStudy(HttpSession session, UserVO userVO, @RequestParam Integer studyNo, @RequestParam Integer studyWriter) throws Exception { // 스터디 신청(ajax)
		userVO = (UserVO) session.getAttribute("login");
		Integer userNo = userVO.getUserNo();
		userVO = userService.read(userNo);
		
		
		if (userVO.getUserName() != null && userVO.getUserNick() != null && userVO.getUserBirth() != null && userVO.getUserPhoneNumber() != null) {
			if (userService.checkApplyStudy(userNo, studyNo) == 0) {
				userService.applyStudy(userNo, studyNo);
				AlarmVO alarm=new AlarmVO();
				alarm.setAlarmSender(userNo);
				alarm.setAlarmTargetStudy(studyNo);
				alarm.setAlarmTarget(studyWriter);
				alarm.setAlarmFlag(1);
				alarmService.create(alarm);
			}
			return "success";
		}
		else
			return "fail";
	}

	@ResponseBody
	@RequestMapping(value = "/cancelStudy", method = RequestMethod.POST)
	public void cancelStudy(HttpSession session, UserVO userVO, @RequestParam Integer studyNo, @RequestParam Integer studyWriter) throws Exception { // 스터디 취소(ajax)
		userVO = (UserVO) session.getAttribute("login");
		int userNo = userVO.getUserNo();
		if (userService.checkApplyStudy(userNo, studyNo) > 0) {
			userService.cancelStudy(userNo, studyNo);
			AlarmVO alarm=new AlarmVO();
			alarm.setAlarmSender(userNo);
			alarm.setAlarmTargetStudy(studyNo);
			alarm.setAlarmTarget(studyWriter);
			alarm.setAlarmFlag(2);
			alarmService.create(alarm);
		}
			
	}
	
	@ResponseBody
	@RequestMapping(value = "/endStudy", method = RequestMethod.POST)
	public ResponseEntity<List<Integer>> endStudy(@RequestParam Integer studyNo, HttpSession session) throws Exception { // 스터디 완료
		ResponseEntity<List<Integer>> entity = null;
		UserVO userVO = (UserVO) session.getAttribute("login");
		Integer studyWriter=userVO.getUserNo();
		try {
			if(userService.studyEndCheck(studyNo) > 0) { // 스터디완료가능
				List<Integer> studyCurMemList=userService.approveMemList(studyNo);
				for(int i=0; i<studyCurMemList.size(); i++) {
					AlarmVO alarm=new AlarmVO();
					alarm.setAlarmSender(studyWriter);
					alarm.setAlarmTargetStudy(studyNo);
					alarm.setAlarmTarget(studyCurMemList.get(i));
					alarm.setAlarmFlag(7);
					alarmService.create(alarm);
				}
				userService.studyEnd(studyNo);
				entity = new ResponseEntity<>(studyCurMemList, HttpStatus.OK);
			}else {
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
		}catch(Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "/applyMemList", method = RequestMethod.POST)
	public List<UserVO> applyMemList(@RequestParam Integer studyNo) throws Exception { // 신청자리스트(ajax)

		List<UserVO> applyList = userService.applyMember(studyNo);

		return applyList;
	}
	
	@ResponseBody
	@RequestMapping(value = "/studyMemList", method = RequestMethod.POST)
	public List<UserVO> studyMemList(@RequestParam Integer studyNo) throws Exception { // 스터디 멤버리스트(ajax)

		List<UserVO> studyMemList = userService.studyMemList(studyNo);

		return studyMemList;
	}

	@ResponseBody
	@RequestMapping(value = "/applyApprove", method = RequestMethod.POST)
	public UserVO applyResult(@RequestParam Integer studyNo, @RequestParam Integer userNo, @RequestParam Integer studyWriter, UserVO userVO) throws Exception { // 신청 승인(ajax)

		userService.applyApprove(studyNo, userNo); // 신청승인
		userVO = userService.read(userNo); // 유저정보 넘기기
		
		AlarmVO alarm=new AlarmVO();
		alarm.setAlarmSender(studyWriter);
		alarm.setAlarmTargetStudy(studyNo);
		alarm.setAlarmTarget(userNo);
		alarm.setAlarmFlag(5);
		alarmService.create(alarm);

		return userVO;
	}

	@ResponseBody
	@RequestMapping(value = "/applyDeny", method = RequestMethod.POST)
	public void applyDeny(@RequestParam Integer studyNo, @RequestParam Integer userNo, @RequestParam Integer studyWriter, @RequestParam String denyMsg) throws Exception { // 신청 거부(ajax)

		userService.applyDeny(studyNo, userNo, denyMsg); // 신청 거부
		NoteVO note=new NoteVO();
		note.setNoteTarget(userNo);
		note.setNoteSender(studyWriter);
		note.setNoteText(denyMsg);
		noteService.addNote(note);
		AlarmVO alarm=new AlarmVO();
		alarm.setAlarmSender(studyWriter);
		alarm.setAlarmTargetStudy(studyNo);
		alarm.setAlarmTarget(userNo);
		alarm.setAlarmFlag(6);
		alarmService.create(alarm);
	}

	@ResponseBody
	@RequestMapping(value = "/approveCheck", method = RequestMethod.POST)
	public Map<String, Object> approveCheck(@RequestParam Integer studyNo, HttpSession session, UserVO userVO, UserStudyVO userStudyVO) throws Exception { // 승인여부체크(ajax)
		userVO = (UserVO) session.getAttribute("login");
		int userNo = userVO.getUserNo();

		Map<String, Object> map = new HashMap<String, Object>();
		userStudyVO = userService.approveCheck(studyNo, userNo); // 스터디 승인 여부
		userVO = userService.studyLeaderInfo(studyNo); // 스터디장 정보
		map.put("userStudyVO", userStudyVO);
		if (userStudyVO.getUserApprove() == 2) // 스터디장이 승인 할 경우 정보 넘기기(보안상)
			map.put("userVO", userVO);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/applyDenyCancel", method = RequestMethod.POST)
	public void applyDenyCancel(@RequestParam Integer studyNo, HttpSession session, UserVO userVO) throws Exception { // 승인 여부 확인
		userVO = (UserVO) session.getAttribute("login");
		int userNo = userVO.getUserNo();

		userService.cancelStudy(userNo, studyNo);
	}
	
	@RequestMapping(value = "/agreeUser", method = RequestMethod.GET)
	public String agreeGet() throws Exception { // 약관동의
		return "/user/userAgree";
	}

	@RequestMapping(value = "/agreeUser", method = RequestMethod.POST)
	public String agreePost() throws Exception { // 약관동의
		return "/user/userJoin";
	}

}