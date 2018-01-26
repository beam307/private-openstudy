package org.sbang.service;

import java.util.List;

import javax.inject.Inject;

import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserVO;
import org.sbang.persistence.AdminDAO;
import org.springframework.stereotype.Repository;

@Repository
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDAO adminDAO;
	
	@Override
	public void userDelete(Integer userNo) throws Exception { // 회원 탈퇴
		adminDAO.userDelete(userNo);
	}

	@Override
	public void userDeleteCancel(Integer userNo) throws Exception { // 회원 탈퇴 취소
		adminDAO.userDeleteCancel(userNo);
	}

	@Override
	public void studyDelete(Integer studyNo) throws Exception { // 스터디 삭제
		adminDAO.studyDelete(studyNo);
	}
	
	@Override
	public void studyDeleteCancel(Integer studyNo) throws Exception { // 스터디 삭제 취소
		adminDAO.studyDeleteCancel(studyNo);
	}

	@Override
	public void todyCntUpdate() throws Exception { // 오늘 방문자 + 1
		adminDAO.todyCntUpdate();
	}

	@Override
	public List<UserVO> userList(SearchCriteria cri) throws Exception { // 회원 리스트
		return adminDAO.userList(cri);
	}

	@Override
	public Integer userCount(SearchCriteria cri) throws Exception { // 회원 수
		return adminDAO.userCount(cri);
	}

	@Override
	public List<StudyVO> studyList(SearchCriteria cri) throws Exception { // 스터디 리스트
		return adminDAO.studyList(cri);
	}

	@Override
	public Integer studyCount(SearchCriteria cri) throws Exception { // 스터디 수
		return adminDAO.studyCount(cri);
	}

	@Override
	public Integer totalUserVisit() throws Exception { // 전체 방문자 수
		return adminDAO.totalUserVisit();
	}

	@Override
	public Integer totalUserReg() throws Exception { // 전체 가입자 수
		return adminDAO.totalUserReg();
	}

	@Override
	public Integer totalStudyReg() throws Exception { // 전체 스터디 등록 수
		return adminDAO.totalStudyReg();
	}

	@Override
	public Integer totalStudyApply() throws Exception { // 전체 스터디 신청 수
		return adminDAO.totalStudyApply();
	}

	@Override
	public Integer totalStudyEnd() throws Exception { // 전체 스터디 완료 수
		return adminDAO.totalStudyEnd();
	}

	@Override
	public List<Integer> weekVisit() throws Exception { // 주간 방문자 수
		return adminDAO.weekVisit();
	}

	@Override
	public List<Integer> weekUserReg() throws Exception { // 주간 회원가입 수
		return adminDAO.weekUserReg();
	}

	@Override
	public List<Integer> weekStudyReg() throws Exception { // 주간 스터디 신청 수
		return adminDAO.weekStudyReg();
	}

	@Override
	public List<Integer> weekStudyApply() throws Exception { // 주간 스터디 완료 수
		return adminDAO.weekStudyApply();
	}

	@Override
	public List<Integer> weekStudyEnd() throws Exception { // 주간 스터디 완료 수
		return adminDAO.weekStudyEnd();
	}

	@Override
	public void userHalt(Integer userNo, Integer haltTime) throws Exception { // 유저 정지
		adminDAO.userHalt(userNo, haltTime);
	}

	@Override
	public String userHaltCheck(Integer userNo) throws Exception { // 유저 정지 체크
		return adminDAO.userHaltCheck(userNo);
	}

	@Override
	public String getAdminPwd() throws Exception {
		return adminDAO.getAdminPwd();
	}

	@Override
	public void changeAdminPwd(String adminPwd) throws Exception {
		adminDAO.changeAdminPwd(adminPwd);
	}

}