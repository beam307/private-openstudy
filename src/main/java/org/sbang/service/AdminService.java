package org.sbang.service;

import java.util.List;

import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserVO;

public interface AdminService {
	public void userDelete(Integer userNo) throws Exception;

	public void userDeleteCancel(Integer userNo) throws Exception;

	public void studyDelete(Integer studyNo) throws Exception;

	public void studyDeleteCancel(Integer studyNo) throws Exception;

	public void todyCntUpdate() throws Exception;

	public List<UserVO> userList(SearchCriteria cri) throws Exception;

	public Integer userCount(SearchCriteria cri) throws Exception;

	public List<StudyVO> studyList(SearchCriteria cri) throws Exception;

	public Integer studyCount(SearchCriteria cri) throws Exception;

	public Integer totalVisit() throws Exception;

	public Integer totalUserReg() throws Exception;

	public Integer totalStudyReg() throws Exception;

	public Integer totalStudyApply() throws Exception;

	public Integer totalStudyEnd() throws Exception;

	public List<Integer> weekVisit() throws Exception;

	public List<Integer> weekUserReg() throws Exception;

	public List<Integer> weekStudyReg() throws Exception;

	public List<Integer> weekStudyApply() throws Exception;

	public List<Integer> weekStudyEnd() throws Exception;

	public void userHalt(Integer userNo, Integer haltTime) throws Exception;

	public String userHaltCheck(Integer userNo) throws Exception;
	
	public String getAdminPwd() throws Exception;
	
	public void changeAdminPwd(String adminPwd) throws Exception;
}