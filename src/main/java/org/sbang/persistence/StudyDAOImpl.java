package org.sbang.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.Criteria;
import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserVO;
import org.springframework.stereotype.Repository;

@Repository
public class StudyDAOImpl implements StudyDAO {
	@Inject
	private SqlSession session;

	private static String namespace = "org.sbang.mapper.StudyMapper";

	@Override
	public void create(StudyVO vo) throws Exception { // 스터디만들기
		session.insert(namespace + ".create", vo);
	}

	@Override
	public StudyVO read(Integer studyNo) throws Exception { // 스터디 상세보기
		return session.selectOne(namespace + ".read", studyNo);
	}

	@Override
	public StudyVO readEnd(Integer studyNo) throws Exception { // 완료 스터디 상세보기
		return session.selectOne(namespace + ".readEnd", studyNo);
	}

	@Override
	public void update(StudyVO vo) throws Exception { // 스터디 수정
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(Integer studyNo) throws Exception { // 스터디삭제
		session.update(namespace + ".delete", studyNo);
	}
	
	@Override
	public void deleteWish(Integer studyNo) throws Exception { // 북마크삭제
		session.delete(namespace + ".deleteWish", studyNo);
	}

	@Override
	public void addImg(String imagePath) throws Exception {
		session.insert(namespace + ".addImg", imagePath);
	}

	@Override
	public void deleteImg(Integer studyNo) throws Exception {
		session.delete(namespace + ".deleteImg", studyNo);
	}

	@Override
	public List<String> getImg(Integer studyNo) throws Exception {
		return session.selectList(namespace + ".getImg", studyNo);
	}
	
	@Override
	public List<String> getImgEnd(Integer studyNo) throws Exception {
		return session.selectList(namespace + ".getImgEnd", studyNo);
	}

	@Override
	public List<StudyVO> listPage(int page) throws Exception {
		if (page <= 0)
			page = 1;

		page = (page - 1) * 10;

		return session.selectList(namespace + ".listPage", page);
	}

	@Override
	public List<StudyVO> listCriteria(Criteria cri) throws Exception {
		return session.selectList(namespace + ".listCriteria", cri);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {
		return session.selectOne(namespace + ".countPaging", cri);
	}

	@Override
	public void replaceImg(String imagePath, Integer studyNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("studyNo", studyNo);
		paramMap.put("imagePath", imagePath);
		session.insert(namespace + ".replaceImg", paramMap);
	}

	@Override
	public List<StudyVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".listSearchCount", cri);
	}

	@Override
	public void updateViewCnt(Integer studyNo) throws Exception {
		session.update(namespace + ".updateViewCnt", studyNo);
	}

	@Override
	public void updateReplyCnt(Integer studyNo, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("studyNo", studyNo);
		paramMap.put("amount", amount);
		session.update(namespace + ".updateReplyCnt", paramMap);
	}

	@Override
	public void updateFavCnt(Integer studyNo, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("studyNo", studyNo);
		paramMap.put("amount", amount);
		session.update(namespace + ".updateFavCnt", paramMap);
	}

	@Override
	public void cancelAllStudy(Integer studyNo) throws Exception { // 스터디 신청한 사람 전체 취소
		session.update(namespace + ".cancelAllStudy", studyNo);
	}

	@Override
	public UserVO userInfoByStudyWriter(Integer studyWriter) throws Exception { // 글쓴이번호로 글쓴이 정보 가져오기
		return session.selectOne(namespace + ".userInfoByStudyWriter", studyWriter);
	}

	@Override
	public List<StudyVO> listSearchRand() throws Exception { // 랜덤으로 스터디 6개 출력  
		return session.selectList(namespace + ".listSearchRand");
	}

}
