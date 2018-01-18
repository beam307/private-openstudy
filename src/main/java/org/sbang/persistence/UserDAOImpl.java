package org.sbang.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.DTO.LoginDTO;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserStudyVO;
import org.sbang.domain.UserVO;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "org.sbang.mapper.UserMapper";

	@Override
	public void create(UserVO vo) throws Exception { // 회원가입
		session.insert(namespace + ".create", vo);
	}

	@Override
	public UserVO login(LoginDTO dto) throws Exception { // 로그인
		return session.selectOne(namespace + ".login", dto);
	}

	@Override
	public Integer userLeaveCheck(String userEmail) throws Exception { // 탈퇴 여부 확인
		return session.selectOne(namespace + ".userLeaveCheck", userEmail);
	}

	@Override
	public void returnKakaoUser(UserVO userVO) throws Exception {// 카카오 계정 돌아옴
		session.update(namespace + ".returnKakaoUser", userVO);
	}

	@Override
	public void returnNaverUser(UserVO userVO) throws Exception {// 카카오 계정 돌아옴
		session.update(namespace + ".returnNaverUser", userVO);
	}

	@Override
	public void keepLogin(String userEmail, String sessionId, Date next) throws Exception { // 자동로그인
		Map<String, Object> map = new HashMap<>();

		map.put("userEmail", userEmail);
		map.put("sessionId", sessionId);
		map.put("next", next);

		session.update(namespace + ".keepLogin", map);
	}

	@Override
	public UserVO checkUserWithSessionKey(String value) throws Exception { // 자동 로그인
		return session.selectOne(namespace + ".checkUserWithSessionKey", value);
	}

	@Override
	public String getPwd(LoginDTO dto) throws Exception { // 비밀번호 가져오기
		return session.selectOne(namespace + ".getPwd", dto);
	}

	@Override
	public String getPwd(UserVO vo) throws Exception { // 비밀번호 가져오기
		return session.selectOne(namespace + ".getPwd", vo);
	}

	@Override
	public String findId(String userPhoneNumber) throws Exception { // 아이디 찾기
		return session.selectOne(namespace + ".findId", userPhoneNumber);
	}

	@Override
	public Integer findIdCheck(String userPhoneNumber) throws Exception { // 아이디찾기 정보확인
		return session.selectOne(namespace + ".findIdCheck", userPhoneNumber);
	}

	@Override
	public void findPwd(UserVO vo, String tempPwd) throws Exception { // 비밀번호 찾기
		Map<String, Object> map = new HashMap<>();

		map.put("UserVO", vo);
		map.put("tempPwd", tempPwd);

		session.update(namespace + ".findPwd", map);
	}

	@Override
	public Integer findPwdCheck(UserVO vo) throws Exception { // 비밀번호찾기 정보확인
		return session.selectOne(namespace + ".findPwdCheck", vo);
	}

	@Override
	public UserVO read(Integer userNo) throws Exception { // 마이페이지 유저정보 가져오기
		return session.selectOne(namespace + ".read", userNo);
	}

	@Override
	public void changePwd(UserVO vo) throws Exception { // 비밀번호 변경
		session.selectOne(namespace + ".changePwd", vo);
	}

	@Override
	public void modify(UserVO vo) throws Exception { // 프로필 정보 수정
		session.update(namespace + ".modify", vo);
	}

	@Override
	public void phoneNumberOK(UserVO vo) throws Exception { // 휴대폰인증 성공시 폰번호 저장 및 인증여부 변환
		session.update(namespace + ".phoneNumberOK", vo);
	}

	@Override
	public void additionalInfo(UserVO vo) throws Exception {
		session.update(namespace + ".additionalInfo", vo);
	}

	@Override
	public void modifyImg(Integer userNo, String userProfileImgPath) throws Exception {// 프로필 이미지 수정
		Map<String, Object> map = new HashMap<>();

		map.put("userNo", userNo);
		map.put("userProfileImgPath", userProfileImgPath);
		session.update(namespace + ".modifyImg", map);
	}

	@Override
	public void delete(UserVO userVO) throws Exception { // 회원 탈퇴
		session.update(namespace + ".delete", userVO);
	}

	@Override
	public void deleteAllStudy(Integer userNo) throws Exception { // 회원탈퇴시 등록한 글 삭제
		session.delete(namespace + ".deleteAllStudy", userNo);
	}

	@Override
	public void userCertification(String userEmail) throws Exception { // 이메일인증 후 인증상태 변경
		session.update(namespace + ".userCertification", userEmail);
	}

	@Override
	public void insertNaver(UserVO vo) throws Exception { // 네이버 로그인 정보 추가
		session.update(namespace + ".insertNaver", vo);
	}

	@Override
	public UserVO selectNaver(UserVO vo) throws Exception { // 네이버 로그인 정보 확인
		return session.selectOne(namespace + ".selectNaver", vo);
	}

	@Override
	public void insertKakao(UserVO vo) throws Exception { // 카카오 로그인 정보 추가
		session.update(namespace + ".insertKakao", vo);
	}

	@Override
	public UserVO selectKakao(UserVO vo) throws Exception { // 카카오 로그인 정보 확인
		return session.selectOne(namespace + ".selectKakao", vo);
	}

	@Override
	public UserVO snsLogin(UserVO vo) throws Exception { // 외부 로그인
		return session.selectOne(namespace + ".snsLogin", vo);
	}

	@Override
	public Integer emailCheck(String userEmail) throws Exception { // 이메일 중복 확인
		return session.selectOne(namespace + ".emailCheck", userEmail);
	}

	@Override
	public Integer nickCheck(String userNick) throws Exception { // 닉네임 중복 확인
		return session.selectOne(namespace + ".nickCheck", userNick);
	}

	@Override
	public List<StudyVO> favStudyManage(Integer userNo) throws Exception { // 스터디관리(즐겨찾기) 리스트
		return session.selectList(namespace + ".favStudyManage", userNo);
	}

	@Override
	public List<StudyVO> regStudyManage(Integer userNo) throws Exception { // 스터디관리(모집) 리스트
		return session.selectList(namespace + ".regStudyManage", userNo);
	}

	@Override
	public List<StudyVO> applyStudyManage(Integer userNo) throws Exception { // 스터디관리(신청) 리스트
		return session.selectList(namespace + ".applyStudyManage", userNo);
	}

	@Override
	public List<StudyVO> endStudyManage(Integer userNo) throws Exception { // 스터디관리(완료) 리스트
		return session.selectList(namespace + ".endStudyManage", userNo);
	}

	@Override
	public List<StudyVO> memberEndStudyManage(Integer userNo) throws Exception { // 스터디관리(완료)스터디원기준 리스트
		return session.selectList(namespace + ".memberEndStudyManage", userNo);
	}

	@Override
	public Integer checkFavorStudy(Integer userNo, Integer studyNo) throws Exception { // 즐겨찾기 스터디 확인 여부
		Map<String, Integer> map = new HashMap<>();
		map.put("studyNo", studyNo);
		map.put("userNo", userNo);
		return session.selectOne(namespace + ".checkFavorStudy", map);
	}

	@Override
	public void favorStudy(Integer userNo, Integer studyNo) throws Exception { // 즐겨찾기 스터디 추가
		Map<String, Integer> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("studyNo", studyNo);
		session.insert(namespace + ".favorStudy", map);
	}

	@Override
	public void deleteFavorStudy(Integer userNo, Integer studyNo) throws Exception { // 즐겨찾기 스터디 삭제
		Map<String, Integer> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("studyNo", studyNo);
		session.delete(namespace + ".deleteFavorStudy", map);
	}

	@Override
	public Integer checkApplyStudy(Integer userNo, Integer studyNo) throws Exception { // 스터디 신청 여부 체크
		Map<String, Integer> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("studyNo", studyNo);
		return session.selectOne(namespace + ".checkApplyStudy", map);
	}

	@Override
	public void applyStudy(Integer userNo, Integer studyNo) throws Exception { // 스터디 신청
		Map<String, Integer> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("studyNo", studyNo);
		session.insert(namespace + ".applyStudy", map);
	}

	@Override
	public void cancelStudy(Integer userNo, Integer studyNo) throws Exception { // 스터디 신청 취소
		Map<String, Integer> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("studyNo", studyNo);
		session.delete(namespace + ".cancelStudy", map);
	}

	@Override
	public void CurMemCnt(Integer studyNo) throws Exception { // 스터디 신청 멤버수 업데이트
		session.insert(namespace + ".CurMemCnt", studyNo);
	}

	@Override
	public List<UserVO> applyMember(Integer studyNo) throws Exception { // 스터디 신청자 목록
		return session.selectList(namespace + ".applyMember", studyNo);
	}

	@Override
	public void applyApprove(Integer studyNo, Integer userNo) throws Exception { // 스터디 신청 승인
		Map<String, Integer> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("studyNo", studyNo);
		session.update(namespace + ".applyApprove", map);
	}

	@Override
	public void applyDeny(Integer studyNo, Integer userNo, String denyMsg) throws Exception { // 스터디 신청 거부
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("studyNo", studyNo);
		map.put("denyMsg", denyMsg);
		session.update(namespace + ".applyDeny", map);
	}

	@Override
	public UserStudyVO approveCheck(Integer studyNo, Integer userNo) throws Exception { // 스터디 승인 여부 확인
		Map<String, Integer> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("studyNo", studyNo);
		return session.selectOne(namespace + ".approveCheck", map);
	}

	@Override
	public UserVO studyLeaderInfo(Integer studyNo) throws Exception { // 스터디 장 정보 가져오기
		return session.selectOne(namespace + ".studyLeaderInfo", studyNo);
	}

	@Override
	public List<StudyVO> exStudyList(Integer userNo) throws Exception {
		return session.selectList(namespace + ".exStudyList", userNo);
	}

	@Override
	public List<StudyVO> exStudyEndList(Integer userNo) throws Exception {
		return session.selectList(namespace + ".exStudyEndList", userNo);
	}

	@Override
	public Integer findUserNoByNick(String userNick) throws Exception {
		return session.selectOne(namespace + ".findUserNoByNick", userNick);
	}
	
	@Override
	public List<Integer> approveMemList(Integer studyNo) throws Exception{ // 스터디 참여자 리스트
		return session.selectList(namespace + ".approveMemList", studyNo);
	}

	@Override
	public void studyEnd(Integer studyNo) throws Exception { // (스터디완료)studyEnd에 추가
		session.insert(namespace + ".studyEnd", studyNo);
	}

	@Override
	public void studyEndImg(Integer studyNo) throws Exception { // (스터디완료)endImage에 추가
		session.insert(namespace + ".studyEndImg", studyNo);
	}

	@Override
	public void studyEndWeek(Integer studyNo) throws Exception { // (스터디완료)endWeek에 추가
		session.insert(namespace + ".studyEndWeek", studyNo);
	}

	@Override
	public void studyEndApply(Integer studyNo) throws Exception { // (스터디완료)endApplyUser에 추가
		session.insert(namespace + ".studyEndApply", studyNo);
	}

	@Override
	public void studyEndDelete(Integer studyNo) throws Exception { // (스터디완료)study에서 삭제
		session.delete(namespace + ".studyEndDelete", studyNo);
	}

	@Override
	public Integer studyRegCnt(Integer userNo) throws Exception { // 스터디 신청 갯수
		return session.selectOne(namespace + ".studyRegCnt", userNo);
	}

	@Override
	public Integer applyStudyCnt(Integer userNo) throws Exception { // 신청스터디(승인완료) 갯수
		return session.selectOne(namespace + ".applyStudyCnt", userNo);
	}

	@Override
	public List<StudyVO> applyStudyList(Integer userNo) throws Exception { // 신청스터디(승인완료) 리스트
		return session.selectList(namespace + ".applyStudyList", userNo);
	}

	@Override
	public List<StudyVO> endStudyList(Integer userNo) throws Exception { // 완료스터디(승인완료) 리스트
		return session.selectList(namespace + ".endStudyList", userNo);
	}

	@Override
	public List<UserVO> studyMemList(Integer studyNo) throws Exception { // 스터디 멤버 리스트(완료후)
		return session.selectList(namespace + ".studyMemList", studyNo);
	}

	@Override
	public Integer studyEndCheck(Integer studyNo) throws Exception { // 스터디시작날짜 이후로 완료 하기
		return session.selectOne(namespace + ".studyEndCheck", studyNo);
	}

	@Override
	public Integer phoneDuplicate(String userPhoneNumber) throws Exception { // 휴대폰중복 체크
		return session.selectOne(namespace + ".phoneDuplicate", userPhoneNumber);
	}

	@Override
	public void insertAuthCode(String userPhoneNumber, String authCode) throws Exception { // 테이블에 인증번호랑 번호 넣기
		Map<String, Object> map = new HashMap<>();
		map.put("userPhoneNumber", userPhoneNumber);
		map.put("authCode", authCode);
		session.insert(namespace + ".insertAuthCode", map);
	}

	@Override
	public void deleteAuthCode(String userPhoneNumber) throws Exception { // 테이블에 인증번호 삭제하기
		session.insert(namespace + ".deleteAuthCode", userPhoneNumber);
	}

	@Override
	public String authCodeCheck(String userPhoneNumber) throws Exception { // 인증번호 체크
		return session.selectOne(namespace + ".authCodeCheck", userPhoneNumber);
	}

}