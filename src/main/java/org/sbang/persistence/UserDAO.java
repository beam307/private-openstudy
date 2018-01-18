package org.sbang.persistence;

import java.util.Date;
import java.util.List;

import org.sbang.DTO.LoginDTO;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserStudyVO;
import org.sbang.domain.UserVO;

public interface UserDAO {

	public void create(UserVO vo) throws Exception;

	public UserVO login(LoginDTO dto) throws Exception;

	public Integer userLeaveCheck(String userEmail) throws Exception;

	public void returnKakaoUser(UserVO userVO) throws Exception;

	public void returnNaverUser(UserVO userVO) throws Exception;

	public void keepLogin(String userEmail, String sessionId, Date next) throws Exception;

	public UserVO checkUserWithSessionKey(String value) throws Exception;

	public String getPwd(LoginDTO dto) throws Exception;

	public String getPwd(UserVO vo) throws Exception;

	public String findId(String userPhoneNumber) throws Exception;

	public Integer findIdCheck(String userPhoneNumber) throws Exception;

	public void findPwd(UserVO vo, String tempPwd) throws Exception;

	public Integer findPwdCheck(UserVO vo) throws Exception;

	public UserVO read(Integer userNo) throws Exception;// myPage정보

	public void changePwd(UserVO vo) throws Exception;

	public void modify(UserVO vo) throws Exception;
	
	public void phoneNumberOK(UserVO vo) throws Exception;

	public void additionalInfo(UserVO vo) throws Exception;

	public void modifyImg(Integer userNo, String userProfileImgPath) throws Exception;

	public void delete(UserVO userVO) throws Exception;

	public void deleteAllStudy(Integer userNo) throws Exception;

	public void userCertification(String userEmail) throws Exception;

	public void insertNaver(UserVO vo) throws Exception;

	public UserVO selectNaver(UserVO vo) throws Exception;

	public void insertKakao(UserVO vo) throws Exception;

	public UserVO selectKakao(UserVO vo) throws Exception;

	public UserVO snsLogin(UserVO vo) throws Exception;

	public Integer emailCheck(String userEmail) throws Exception;

	public Integer nickCheck(String userNick) throws Exception;

	public List<StudyVO> favStudyManage(Integer userNo) throws Exception;

	public List<StudyVO> regStudyManage(Integer userNo) throws Exception;

	public List<StudyVO> applyStudyManage(Integer userNo) throws Exception;

	public List<StudyVO> endStudyManage(Integer userNo) throws Exception;

	public List<StudyVO> memberEndStudyManage(Integer userNo) throws Exception;

	public Integer checkFavorStudy(Integer userNo, Integer studyNo) throws Exception;

	public void favorStudy(Integer userNo, Integer studyNo) throws Exception;

	public void deleteFavorStudy(Integer userNo, Integer studyNo) throws Exception;

	public Integer checkApplyStudy(Integer userNo, Integer studyNo) throws Exception;

	public void applyStudy(Integer userNo, Integer studyNo) throws Exception;

	public void cancelStudy(Integer userNo, Integer studyNo) throws Exception;

	public void CurMemCnt(Integer studyNo) throws Exception;

	public List<UserVO> applyMember(Integer studyNo) throws Exception;

	public void applyApprove(Integer studyNo, Integer userNo) throws Exception;

	public void applyDeny(Integer studyNo, Integer userNo, String denyMsg) throws Exception;

	public UserStudyVO approveCheck(Integer studyNo, Integer userNo) throws Exception;

	public UserVO studyLeaderInfo(Integer studyNo) throws Exception;

	public List<StudyVO> exStudyList(Integer userNo) throws Exception;

	public List<StudyVO> exStudyEndList(Integer userNo) throws Exception;

	public Integer findUserNoByNick(String userNick) throws Exception;
	
	public List<Integer> approveMemList(Integer studyNo) throws Exception;

	public void studyEnd(Integer studyNo) throws Exception;

	public void studyEndImg(Integer studyNo) throws Exception;

	public void studyEndWeek(Integer studyNo) throws Exception;

	public void studyEndApply(Integer studyNo) throws Exception;

	public void studyEndDelete(Integer studyNo) throws Exception;

	public Integer studyRegCnt(Integer userNo) throws Exception;

	public Integer applyStudyCnt(Integer userNo) throws Exception;

	public List<StudyVO> applyStudyList(Integer userNo) throws Exception;

	public List<StudyVO> endStudyList(Integer userNo) throws Exception;

	public List<UserVO> studyMemList(Integer studyNo) throws Exception;

	public Integer studyEndCheck(Integer studyNo) throws Exception;

	public Integer phoneDuplicate(String userPhoneNumber) throws Exception;

	public void insertAuthCode(String userPhoneNumber, String authCode) throws Exception;

	public void deleteAuthCode(String userPhoneNumber) throws Exception;
	
	public String authCodeCheck(String userPhoneNumber) throws Exception;
}