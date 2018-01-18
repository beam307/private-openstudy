package org.sbang.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.Criteria;
import org.sbang.domain.ReplyVO;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "org.sbang.mapper.ReplyMapper";

	@Override
	public List<ReplyVO> list(Integer studyNo) throws Exception {
		return session.selectList(namespace + ".list", studyNo);
	}

	@Override
	public void create(ReplyVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public void update(ReplyVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(Integer replyNo) throws Exception {
		session.delete(namespace + ".delete", replyNo);
	}

	@Override
	public List<ReplyVO> listPage(Integer studyNo, Criteria cri) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();

		paramMap.put("studyNo", studyNo);
		paramMap.put("cri", cri);

		return session.selectList(namespace + ".listPage", paramMap);
	}

	@Override
	public int count(Integer studyNo) throws Exception {
		return session.selectOne(namespace + ".count", studyNo);
	}

	@Override
	public void deleteWithStudyNo(Integer studyNo) throws Exception {
		session.delete(namespace + ".deleteWithStudyNo", studyNo);
	}

	@Override
	public void updateReplyCnt(Integer studyNo, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("studyNo", studyNo);
		paramMap.put("amount", amount);
		session.update(namespace + ".updateReplyCnt", paramMap);
	}
}
