package org.sbang.service;

import java.util.List;

import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserVO;
import org.sbang.domain.WeekVO;

public interface StudyService {

	public void regist(StudyVO study) throws Exception;

	public StudyVO read(Integer studyNo) throws Exception;

	public StudyVO readEnd(Integer studyNo) throws Exception;

	public void modify(StudyVO study) throws Exception;

	public void remove(Integer studyNo) throws Exception;

	public List<String> getImg(Integer studyNo) throws Exception;

	public List<String> getImgEnd(Integer studyNo) throws Exception;

	public List<WeekVO> getWeek(Integer studyNo) throws Exception;

	public List<WeekVO> getWeekEnd(Integer studyNo) throws Exception;

	public List<StudyVO> listSearchCriteria(SearchCriteria cri) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public UserVO userInfoByStudyWriter(Integer studyWriter) throws Exception;
	
	public List<StudyVO> listSearchRand() throws Exception;

}
