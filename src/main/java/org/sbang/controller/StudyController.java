package org.sbang.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.sbang.domain.PageMaker;
import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserVO;
import org.sbang.domain.WeekVO;
import org.sbang.service.StudyService;
import org.sbang.service.UserService;
import org.sbang.util.AlarmUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/study/*")
public class StudyController {

	@Inject
	private StudyService studyService;
	
	@Inject
	private UserService userService;
	
	@Inject
	private AlarmUtils alarmUtils;
	
	@RequestMapping(value = "/studyReg", method = RequestMethod.GET) // 스터디 등록 - get
	public void studyRegGET(Model model, HttpSession session) throws Exception {
		UserVO userVO = (UserVO) session.getAttribute("login");
		model.addAttribute("studyRegCnt", userService.studyRegCnt(userVO.getUserNo()));
		model.addAttribute("list", userService.exStudyList(userVO.getUserNo()));
		model.addAttribute("listEnd", userService.exStudyEndList(userVO.getUserNo()));
	}

	@RequestMapping(value = "/studyReg", method = RequestMethod.POST) // 스터디 등록 - post
	public String studyRegPOST(StudyVO study, HttpSession session) throws Exception {
		UserVO userVO = (UserVO) session.getAttribute("login");
		study.setStudyWriter(userVO.getUserNo());
		studyService.regist(study);

		return "redirect:/study/studyList";
	}
	
	@RequestMapping("/exStudyList/{studyNo}") // 이전 스터디등록 리스트 가져오기(ajax)
	@ResponseBody
	public StudyVO exStudyList(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.read(studyNo);
	}
	
	@RequestMapping("/exStudyEndList/{studyNo}") // 이전 스터디등록 리스트 가져오기(ajax)
	@ResponseBody
	public StudyVO exStudyEndList(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.readEnd(studyNo);
	}
	
	@RequestMapping(value = "/studyList", method = RequestMethod.GET)  // 스터디 리스트
	public void studyList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		
		model.addAttribute("list", studyService.listSearchCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(studyService.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
		
	}

	@RequestMapping(value = "/studyView", method = RequestMethod.GET)  // 스터디 보기
	public void studyView(Integer studyNo, @ModelAttribute("cri") SearchCriteria cri, Model model, HttpSession session) throws Exception {
		
		StudyVO studyVO = studyService.read(studyNo);
		UserVO userVO = (UserVO) session.getAttribute("login");
		
		if(userVO != null){
			Integer userNo = userVO.getUserNo();
			model.addAttribute("favCheck" , userService.checkFavorStudy(userNo, studyNo)); // 즐겨찾기 확인 여부
			model.addAttribute("applyCheck" , userService.checkApplyStudy(userNo, studyNo)); // 신청스터디 확인 여부
		}
		
		if(studyVO == null)
			throw new UrlNotFoundException();
		
		model.addAttribute(studyVO); // studyVO 전체
		model.addAttribute("userVO", studyService.userInfoByStudyWriter(studyVO.getStudyWriter())); // 글쓴이 닉네임 가져오기
		model.addAttribute("weekList", studyService.getWeek(studyNo)); // 주 일정 가져오기

	}
	
	@RequestMapping(value = "/studyEndView", method = RequestMethod.GET)  // 스터디 완료 보기
	public void studyEndView(Integer studyNo, Model model, HttpSession session) throws Exception {
		
		StudyVO studyVO = studyService.readEnd(studyNo);
		
		if(studyVO == null)
			throw new UrlNotFoundException();
		
		model.addAttribute(studyVO); // studyVO 전체
		model.addAttribute("userVO", studyService.userInfoByStudyWriter(studyVO.getStudyWriter())); // 글쓴이 닉네임 가져오기
		model.addAttribute("weekList", studyService.getWeekEnd(studyNo)); // 주 일정 가져오기

	}

	@RequestMapping(value = "/studyRemove", method = RequestMethod.POST) // 스터디 삭제
	public String remove(Integer studyNo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		studyService.remove(studyNo);
		redirectAddAttr(cri, rttr);

		return "redirect:/study/studyList";
	}

	@RequestMapping("/getImg/{studyNo}") // 이미지 가져오기(ajax)
	@ResponseBody
	public List<String> getImg(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.getImg(studyNo);
	}
	
	@RequestMapping("/getImgEnd/{studyNo}") // 이미지 가져오기(ajax)
	@ResponseBody
	public List<String> getImgEnd(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.getImgEnd(studyNo);
	}
	
	@RequestMapping("/getWeek/{studyNo}") // 이전 스터디등록 리스트 가져오기 - 주단위 일정(ajax)
	@ResponseBody
	public List<WeekVO> getWeek(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.getWeek(studyNo);
	}
	
	@RequestMapping("/getWeekEnd/{studyNo}") // 이전 스터디등록 리스트 가져오기 - 주단위 일정(ajax)
	@ResponseBody
	public List<WeekVO> getWeekEnd(@PathVariable("studyNo") Integer studyNo) throws Exception {
		return studyService.getWeekEnd(studyNo);
	}

	@RequestMapping(value = "/studyModify", method = RequestMethod.GET)  // 스터디 수정 - get
	public void studyModifyGET(Integer studyNo, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		model.addAttribute(studyService.read(studyNo));
		model.addAttribute("weekList", studyService.getWeek(studyNo));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(studyService.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/studyModify", method = RequestMethod.POST)  // 스터디 수정 - post
	public String studyModifyPOST(StudyVO study, SearchCriteria cri,HttpSession session, RedirectAttributes rttr) throws Exception {
		System.out.println("controller:"+study.toString());
		UserVO userVO = (UserVO) session.getAttribute("login");
		if(userVO.getUserNo()==study.getStudyWriter())
			studyService.modify(study);
		redirectAddAttr(cri, rttr);
		return "redirect:/study/studyList";
	}

	@ResponseBody
	@RequestMapping(value = "/favoriteStudy", method = RequestMethod.POST)// 스터디 즐겨찾기(ajax)
	public String favoriteStudy(HttpSession session, Integer studyNo, Integer studyWriter) throws Exception { 

		UserVO userVO = (UserVO) session.getAttribute("login"); // 로그인 정보
		Integer userNo = userVO.getUserNo();

		Integer result; // 0 = 값변경 X / 1 = 값변경 O

		if (userService.checkFavorStudy(userNo, studyNo) != 0) { // 이미 즐겨 찾기 한 경우
			result = 0;
			userService.deleteFavorStudy(userNo, studyNo);
			
		} else { // 즐겨 찾기 안한 경우
			result = 1;
			userService.favorStudy(userNo, studyNo);
			if(userNo != studyWriter) {
				alarmUtils.createAlarm(studyNo, studyWriter, userNo, 3);
			}
		}
		return String.valueOf(result);
	}

	@ResponseBody
	@RequestMapping(value = "/applyStudy", method = RequestMethod.POST)// 스터디 신청(ajax)
	public String applyStudy(HttpSession session, UserVO userVO, @RequestParam Integer studyNo, @RequestParam Integer studyWriter) throws Exception { 
		userVO = (UserVO) session.getAttribute("login");
		Integer userNo = userVO.getUserNo();
		userVO = userService.read(userNo);
		
		
		if (userVO.getUserName() != null && userVO.getUserNick() != null && userVO.getUserBirth() != null && userVO.getUserPhoneNumber() != null) {
			if (userService.checkApplyStudy(userNo, studyNo) == 0) {
				userService.applyStudy(userNo, studyNo);
				alarmUtils.createAlarm(studyNo, studyWriter, userNo, 1);
			}
			return "success";
		}
		else
			return "fail";
	}

	@ResponseBody
	@RequestMapping(value = "/cancelStudy", method = RequestMethod.POST)// 스터디 취소(ajax)
	public void cancelStudy(HttpSession session, UserVO userVO, @RequestParam Integer studyNo, @RequestParam Integer studyWriter) throws Exception { 
		userVO = (UserVO) session.getAttribute("login");
		int userNo = userVO.getUserNo();
		if (userService.checkApplyStudy(userNo, studyNo) > 0) {
			userService.cancelStudy(userNo, studyNo);
			alarmUtils.createAlarm(studyNo, studyWriter, userNo, 2);
		}
			
	}
	
	@ResponseBody
	@RequestMapping(value = "/endStudy", method = RequestMethod.POST)// 스터디 완료
	public ResponseEntity<Object> endStudy(@RequestParam Integer studyNo, HttpSession session) throws Exception { 
		ResponseEntity<Object> entity = null;
		UserVO userVO = (UserVO) session.getAttribute("login");
		Integer studyWriter=userVO.getUserNo();
		try {
			if(userService.studyEndCheck(studyNo) > 0) { // 스터디완료가능
				List<Integer> studyCurMemList=userService.approveMemList(studyNo);
				for(int i=0; i<studyCurMemList.size(); i++) {
					alarmUtils.createAlarm(studyNo, studyWriter, studyCurMemList.get(i), 7);
				}
				userService.studyEnd(studyNo);
				entity = new ResponseEntity<>(studyCurMemList, HttpStatus.OK);
			}else {
				entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);//날짜 불충족시 500에러발생
			}
		}catch(Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	private void redirectAddAttr(SearchCriteria cri, RedirectAttributes rttr) {
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("lineUp", cri.getLineUp());
	}

	@ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "잘못된 접근입니다.")
	public class UrlNotFoundException extends RuntimeException {}


}
