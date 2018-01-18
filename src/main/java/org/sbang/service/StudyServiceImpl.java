package org.sbang.service;

import java.util.List;

import javax.inject.Inject;

import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserVO;
import org.sbang.domain.WeekVO;
import org.sbang.persistence.StudyDAO;
import org.sbang.persistence.WeekDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class StudyServiceImpl implements StudyService {

	@Inject
	private StudyDAO studyDAO;

	@Inject
	private WeekDAO weekDAO;

	@Transactional
	@Override
	public void regist(StudyVO study) throws Exception { // 스터디등록
		studyDAO.create(study);
		String[] files = study.getFiles();
		WeekVO[] weekArr = study.getWeekVO();
		
		if (weekArr == null)
			return;
		
		for (WeekVO weekVO : weekArr)
			weekDAO.create(weekVO);

		if (files == null)
			return;

		for (String imagePath : files)
			studyDAO.addImg(imagePath);

		
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public StudyVO read(Integer studyNo) throws Exception { // 스터디 상세보기
		studyDAO.updateViewCnt(studyNo);
		return studyDAO.read(studyNo);
	}

	@Override
	public StudyVO readEnd(Integer studyNo) throws Exception { // 완료 스터디 상세보기
		return studyDAO.readEnd(studyNo);
	}

	@Override
	public List<WeekVO> getWeek(Integer studyNo) throws Exception { // 스터디 일정 불러오기
		return weekDAO.list(studyNo);
	}
	
	@Override
	public List<WeekVO> getWeekEnd(Integer studyNo) throws Exception { // 완료 스터디 일정 불러오기
		return weekDAO.listEnd(studyNo);
	}

	@Override
	public List<String> getImg(Integer studyNo) throws Exception { // 스터디 이미지 불러오기
		return studyDAO.getImg(studyNo);
	}
	
	@Override
	public List<String> getImgEnd(Integer studyNo) throws Exception { // 완료 스터디 이미지 불러오기
		return studyDAO.getImgEnd(studyNo);
	}

	@Transactional
	@Override
	public void modify(StudyVO study) throws Exception { // 스터디 수정
		studyDAO.update(study);
		Integer studyNo = study.getStudyNo();
		studyDAO.deleteImg(studyNo);

		String[] files = study.getFiles();

		if (files == null)
			return;

		for (String fileName : files)
			studyDAO.replaceImg(fileName, studyNo);

		weekDAO.delete(studyNo);
		WeekVO[] weekArr = study.getWeekVO();

		if (weekArr == null)
			return;

		for (WeekVO weekVO : weekArr)
			weekDAO.replace(weekVO, studyNo);

	}

	@Transactional
	@Override
	public void remove(Integer studyNo) throws Exception { // 스터디 삭제
		studyDAO.delete(studyNo);
		studyDAO.cancelAllStudy(studyNo);
		studyDAO.deleteWish(studyNo);
	}

	@Override
	public List<StudyVO> listSearchCriteria(SearchCriteria cri) throws Exception { // 스터디리스트
		return studyDAO.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception { // 스터디 리스트수
		return studyDAO.listSearchCount(cri);
	}

	@Override
	public UserVO userInfoByStudyWriter(Integer studyWriter) throws Exception { // 유저번호로 닉네임 가져오기
		return studyDAO.userInfoByStudyWriter(studyWriter);
	}

	@Override
	public List<StudyVO> listSearchRand() throws Exception { // 랜덤으로 스터디 6개 출력  
		return studyDAO.listSearchRand();
	}

}
