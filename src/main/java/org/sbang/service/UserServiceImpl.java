package org.sbang.service;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.sbang.DTO.LoginDTO;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserStudyVO;
import org.sbang.domain.UserVO;
import org.sbang.mail.MailHandler;
import org.sbang.mail.TempKey;
import org.sbang.persistence.StudyDAO;
import org.sbang.persistence.UserDAO;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private JavaMailSender mailSender;

	@Inject
	private BCryptPasswordEncoder pwdEncoder;

	@Inject
	private UserDAO userDAO;

	@Inject
	private StudyDAO studyDAO;

	@Override
	public void create(UserVO vo) throws Exception { // 회원가입
		vo.setUserPwd(pwdEncoder.encode(vo.getUserPwd())); // 비밀번호 암호화
		userDAO.create(vo); // 회원가입
	}

	@Override
	public UserVO login(LoginDTO dto) throws Exception { // 로그인
		return userDAO.login(dto);
	}

	@Override
	public void keepLogin(String userEmail, String sessionId, Date next) throws Exception { // 자동로그인
		userDAO.keepLogin(userEmail, sessionId, next);
	}

	@Override
	public UserVO checkLoginBefore(String value) throws Exception { // 자동 로그인
		return userDAO.checkUserWithSessionKey(value);
	}

	@Override
	public String getPwd(LoginDTO dto) throws Exception { // 비밀번호 가져오기
		return userDAO.getPwd(dto);
	}

	@Override
	public String getPwd(UserVO vo) throws Exception { // 비밀번호 가져오기
		return userDAO.getPwd(vo);
	}

	@Override
	public void findId(String userPhoneNumber, String toEmail) throws Exception { // 아이디찾기
		String userEmail = userDAO.findId(userPhoneNumber);
		
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[오픈스터디 홈페이지 아이디 찾기]");
		sendMail.setText(new StringBuffer().append("고객님의 이메일 주소는 [").append(userEmail).append("] 입니다.").toString());
		sendMail.setFrom("openstudy.mail@gmail.com", "오픈스터디관리자");
		sendMail.setTo(toEmail);
		sendMail.send();
	}

	@Override
	public Integer findIdCheck(String userPhoneNumber) throws Exception { // 아이디찾기 정보 확인
		return userDAO.findIdCheck(userPhoneNumber);
	}

	@Override
	public void findPwd(UserVO vo) throws Exception { // 비밀번호 찾기
		String tempKey = new TempKey().getKey(10, false); // 인증키 생성
		String tempPwd = pwdEncoder.encode(tempKey); // 비밀번호 암호화

		userDAO.findPwd(vo, tempPwd); // 임시 비밀번호로 변경

		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[오픈스터디 홈페이지 임시비밀번호 발급 ]");
		sendMail.setText(new StringBuffer().append("임시 비밀번호는 [").append(tempKey).append("]입니다.").toString());
		sendMail.setFrom("openstudy.mail@gmail.com", "오픈스터디 관리자");
		sendMail.setTo(vo.getUserEmail());
		sendMail.send();
	}

	@Override
	public Integer findPwdCheck(UserVO vo) throws Exception { // 비밀번호 찾기 정보 확인
		return userDAO.findPwdCheck(vo);
	}

	@Override
	public UserVO read(Integer userNo) throws Exception { // 마이페이지 유저정보 가져오기
		return userDAO.read(userNo);
	}

	@Override
	public void changePwd(UserVO vo) throws Exception { // 비밀번호 변경
		userDAO.changePwd(vo);
	}

	@Override
	public void modify(UserVO vo) throws Exception { // 프로필 정보 수정
		userDAO.modify(vo);
	}

	@Override
	public void phoneNumberOK(UserVO vo) throws Exception { // 휴대폰인증 성공시 폰번호 저장 및 인증여부 변환
		userDAO.phoneNumberOK(vo);
	}

	@Override
	public void additionalInfo(UserVO vo) throws Exception { // 부가 정보 수정
		userDAO.additionalInfo(vo);
	}

	@Override
	public void modifyImg(Integer userNo, String userProfileImgPath) throws Exception {// 프로필 이미지 수정
		userDAO.modifyImg(userNo, userProfileImgPath);
	}

	@Transactional
	@Override
	public void delete(UserVO userVO) throws Exception { // 회원 탈퇴
		userDAO.delete(userVO); // 회원 삭제
		userDAO.deleteAllStudy(userVO.getUserNo()); // 회원이 등록한 글 삭제
	}

	@Override
	public Integer userLeaveCheck(String userEmail) throws Exception { // 탈퇴 여부 확인
		return userDAO.userLeaveCheck(userEmail);
	}
	
	@Override
	public void returnKakaoUser(UserVO userVO) throws Exception{ // 카카오유저 돌아옴
		userDAO.returnKakaoUser(userVO);
	}
	
	@Override
	public void returnNaverUser(UserVO userVO) throws Exception{ // 네이버유저 돌아옴
		userDAO.returnNaverUser(userVO);
	}

	@Override
	public void insertNaver(UserVO vo) throws Exception { // 네이버 로그인 정보 추가
		userDAO.insertNaver(vo);
	}

	@Override
	public UserVO selectNaver(UserVO vo) throws Exception { // 네이버 로그인 정보 확인
		return userDAO.selectNaver(vo);
	}

	@Override
	public void insertKakao(UserVO vo) throws Exception { // 카카오 로그인 정보 추가
		userDAO.insertKakao(vo);
	}

	@Override
	public UserVO selectKakao(UserVO vo) throws Exception { // 카카오 로그인 정보 확인
		return userDAO.selectKakao(vo);
	}

	@Override
	public UserVO snsLogin(UserVO vo) throws Exception { // 외부 로그인
		return userDAO.snsLogin(vo);
	}

	@Override
	public Integer emailCheck(String userEmail) throws Exception { // 이메일 중복 확인
		return userDAO.emailCheck(userEmail);
	}

	@Override
	public Integer nickCheck(String userNick) throws Exception { // 닉네임 중복 확인
		return userDAO.nickCheck(userNick);
	}

	@Override
	public List<StudyVO> favStudyManage(Integer userNo) throws Exception { // 스터디관리(즐겨찾기) 리스트
		return userDAO.favStudyManage(userNo);
	}

	@Override
	public List<StudyVO> regStudyManage(Integer userNo) throws Exception { // 스터디관리(모집) 리스트
		return userDAO.regStudyManage(userNo);
	}

	@Override
	public List<StudyVO> applyStudyManage(Integer userNo) throws Exception { // 스터디관리(신청) 리스트
		return userDAO.applyStudyManage(userNo);
	}

	@Override
	public List<StudyVO> endStudyManage(Integer userNo) throws Exception { // 스터디관리(완료) 리스트
		return userDAO.endStudyManage(userNo);
	}

	@Override
	public List<StudyVO> memberEndStudyManage(Integer userNo) throws Exception { // 스터디관리(완료)스터디원기준 리스트
		return userDAO.memberEndStudyManage(userNo);
	}

	@Override
	public Integer checkFavorStudy(Integer userNo, Integer studyNo) throws Exception { // 즐겨찾기 스터디 신청 여부
		return userDAO.checkFavorStudy(userNo, studyNo);
	}

	@Transactional
	@Override
	public void favorStudy(Integer userNo, Integer studyNo) throws Exception { // 즐겨찾기 스터디 추가
		userDAO.favorStudy(userNo, studyNo);
		studyDAO.updateFavCnt(studyNo, 1);
	}

	@Transactional
	@Override
	public void deleteFavorStudy(Integer userNo, Integer studyNo) throws Exception { // 즐겨찾기 스터디 삭제
		userDAO.deleteFavorStudy(userNo, studyNo);
		studyDAO.updateFavCnt(studyNo, -1);
	}

	@Transactional
	@Override
	public void studyEnd(Integer studyNo) throws Exception { // 스터디 완료
		userDAO.studyEnd(studyNo); // studyEnd 테이블에 추가
		userDAO.studyEndImg(studyNo); // endImage 테이블에 추가
		userDAO.studyEndWeek(studyNo); // endWeek 테이블에 추가
		userDAO.studyEndApply(studyNo); // endApplyUser 테이블에 추가
		userDAO.studyEndDelete(studyNo); // study 테이블에서 삭제
	}

	@Override
	public Integer checkApplyStudy(Integer userNo, Integer studyNo) throws Exception { // 스터디 신청 유무 체크
		return userDAO.checkApplyStudy(userNo, studyNo);
	}

	@Override
	public void applyStudy(Integer userNo, Integer studyNo) throws Exception { // 스터디 신청
		userDAO.applyStudy(userNo, studyNo); // 스터디 신청
	}

	@Transactional
	@Override
	public void cancelStudy(Integer userNo, Integer studyNo) throws Exception { // 스터디 신청 취소
		userDAO.cancelStudy(userNo, studyNo); // 스터디 신청 취소
		userDAO.CurMemCnt(studyNo); // 스터디 멤버 업데이트
	}

	@Override
	public List<UserVO> applyMember(Integer studyNo) throws Exception { // 스터디 신청 멤버
		return userDAO.applyMember(studyNo);
	}

	@Transactional
	@Override
	public void applyApprove(Integer studyNo, Integer userNo) throws Exception { // 스터디 신청 승인
		userDAO.applyApprove(studyNo, userNo);
		userDAO.CurMemCnt(studyNo);
	}

	@Override
	public void applyDeny(Integer studyNo, Integer userNo, String denyMsg) throws Exception { // 스터디 신청 거부
		userDAO.applyDeny(studyNo, userNo, denyMsg);
	}

	@Override
	public UserStudyVO approveCheck(Integer studyNo, Integer userNo) throws Exception { // 스터디 승인 여부 확인
		return userDAO.approveCheck(studyNo, userNo);
	}

	@Override
	public UserVO studyLeaderInfo(Integer studyNo) throws Exception { // 스터디장 정보 가져오기
		return userDAO.studyLeaderInfo(studyNo);
	}

	@Override
	public List<StudyVO> exStudyList(Integer userNo) throws Exception { // 기존 등록했던 스터디 리스트
		return userDAO.exStudyList(userNo);
	}
	
	@Override
	public List<StudyVO> exStudyEndList(Integer userNo) throws Exception { // 기존 등록했던 스터디 리스트
		return userDAO.exStudyEndList(userNo);
	}

	@Override
	public Integer findUserNoByNick(String userNick) throws Exception { // 유저번호로 닉네임 가져오기
		return userDAO.findUserNoByNick(userNick);
	}
	
	@Override
	public List<Integer> approveMemList(Integer studyNo) throws Exception{ // 스터디 참여자 리스트
		return userDAO.approveMemList(studyNo);
	}

	@Override
	public Integer studyRegCnt(Integer userNo) throws Exception { // 스터디등록 갯수
		return userDAO.studyRegCnt(userNo);
	}

	@Override
	public Integer applyStudyCnt(Integer userNo) throws Exception { // 신청스터디(승인완료) 갯수
		return userDAO.applyStudyCnt(userNo);
	}

	@Override
	public List<StudyVO> applyStudyList(Integer userNo) throws Exception { // 신청스터디(승인완료) 리스트
		return userDAO.applyStudyList(userNo);
	}

	@Override
	public List<StudyVO> endStudyList(Integer userNo) throws Exception { // 완료스터디(승인완료) 리스트
		return userDAO.endStudyList(userNo);
	}

	@Override
	public List<UserVO> studyMemList(Integer studyNo) throws Exception { // 스터디 멤버리스트(완료후)
		return userDAO.studyMemList(studyNo);
	}

	@Override
	public Integer studyEndCheck(Integer studyNo) throws Exception { // 스터디시작날짜 이후 완료 하기
		return userDAO.studyEndCheck(studyNo);
	}

	@Override
	public Integer phoneDuplicate(String userPhoneNumber) throws Exception { // 휴대폰중복 체크
		return userDAO.phoneDuplicate(userPhoneNumber);
	}
	
	@Transactional
	@Override
	public void insertAuthCode(String userPhoneNumber, String authCode) throws Exception { // 테이블에 인증번호 넣기
		userDAO.deleteAuthCode(userPhoneNumber);
		userDAO.insertAuthCode(userPhoneNumber, authCode);
	}

	@Override
	public String authCodeCheck(String userPhoneNumber) throws Exception { // 인증번호 체크
		return userDAO.authCodeCheck(userPhoneNumber);
	}
	
}