package org.sbang.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.WeekVO;
import org.springframework.stereotype.Repository;

@Repository
public class WeekDAOImpl implements WeekDAO{
	
	@Inject
	private SqlSession session;

	private static String namespace = "org.sbang.mapper.WeekMapper";

	@Override
	public List<WeekVO> list(Integer studyNo) throws Exception {
		return session.selectList(namespace + ".list", studyNo);
	}

	@Override
	public List<WeekVO> listEnd(Integer studyNo) throws Exception {
		return session.selectList(namespace + ".listEnd", studyNo);
	}

	@Override
	public void create(WeekVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public void replace(WeekVO vo,Integer studyNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("studyNo", studyNo);
		paramMap.put("weekVO", vo);
		session.insert(namespace + ".replace", paramMap);
	}

	@Override
	public void delete(Integer weekNo) throws Exception {
		session.delete(namespace + ".delete", weekNo);
	}

}
