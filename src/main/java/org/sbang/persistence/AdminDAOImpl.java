package org.sbang.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.domain.UserVO;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "org.sbang.mapper.adminMapper";

	@Override
	public void userDelete(Integer userNo) throws Exception { // 회원 탈퇴
		session.update(namespace + ".userDelete", userNo);
	}
	
	@Override
	public void userDeleteCancel(Integer userNo) throws Exception { // 회원 탈퇴 취소
		session.update(namespace + ".userDeleteCancel", userNo);
	}

	@Override
	public void studyDelete(Integer studyNo) throws Exception { // 스터디삭제
		session.update(namespace + ".studyDelete", studyNo);
	}
	
	@Override
	public void studyDeleteCancel(Integer studyNo) throws Exception { // 스터디 삭제 취소
		session.update(namespace + ".studyDeleteCancel", studyNo);
	}

	@Override
	public void todyCntUpdate() throws Exception { // 오늘 방문자 + 1
		session.update(namespace + ".todyCntUpdate");
	}

	@Override
	public List<UserVO> userList(SearchCriteria cri) throws Exception { // 회원 리스트
		return session.selectList(namespace + ".userList", cri);
	}

	@Override
	public Integer userCount(SearchCriteria cri) throws Exception { // 회원 수
		return session.selectOne(namespace + ".userCount", cri);
	}

	@Override
	public List<StudyVO> studyList(SearchCriteria cri) throws Exception { // 스터디 리스트
		return session.selectList(namespace + ".studyList", cri);
	}

	@Override
	public Integer studyCount(SearchCriteria cri) throws Exception { // 스터디 수
		return session.selectOne(namespace + ".studyCount", cri);
	}

	@Override
	public Integer totalUserVisit() throws Exception { // 전체 방문 수
		return session.selectOne(namespace + ".totalUserVisit");
	}

	@Override
	public Integer totalUserReg() throws Exception { // 전체 가입자수
		return session.selectOne(namespace + ".totalUserReg");
	}

	@Override
	public Integer totalStudyReg() throws Exception { // 전체 스터디 등록 수
		return session.selectOne(namespace + ".totalStudyReg");
	}

	@Override
	public Integer totalStudyApply() throws Exception { // 전체 스터디 신청 수
		return session.selectOne(namespace + ".totalStudyApply");
	}

	@Override
	public Integer totalStudyEnd() throws Exception { // 전체 스터디 완료 수
		return session.selectOne(namespace + ".totalStudyEnd");
	}

	@Override
	public List<Integer> weekVisit() throws Exception { // 주간 방문자 수
		return session.selectList(namespace + ".weekVisit");
	}

	@Override
	public List<Integer> weekUserReg() throws Exception { // 주간 회원가입 수
		return session.selectList(namespace + ".weekUserReg");
	}

	@Override
	public List<Integer> weekStudyReg() throws Exception { // 주간 스터디 등록 수
		return session.selectList(namespace + ".weekStudyReg");
	}

	@Override
	public List<Integer> weekStudyApply() throws Exception { // 주간 스터디 신청 수
		return session.selectList(namespace + ".weekStudyApply");
	}

	@Override
	public List<Integer> weekStudyEnd() throws Exception { // 주간 스터디 완료 수
		return session.selectList(namespace + ".weekStudyEnd");
	}

	@Override
	public void userHalt(Integer userNo, Integer haltTime) throws Exception { // 유저 정지
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("haltTime", haltTime);

		session.update(namespace + ".userHalt", map);
	}

	@Override
	public String userHaltCheck(Integer userNo) throws Exception { // 유저 정지 체크
		return session.selectOne(namespace + ".userHaltCheck", userNo);
	}

	@Override
	public String getAdminPwd() throws Exception {
		return session.selectOne(namespace + ".getAdminPwd");
	}

	@Override
	public void changeAdminPwd(String adminPwd) throws Exception {
		session.update(namespace + ".changeAdminPwd", adminPwd);
	}

}
