package org.sbang.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.QnAVO;
import org.sbang.domain.SearchCriteria;
import org.springframework.stereotype.Repository;

@Repository
public class QnADAOImpl implements QnADAO {
	
	@Inject
	private SqlSession session;

	private static String namespace = "org.sbang.mapper.QnAMapper";

	@Override
	public void create(QnAVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
		
	}

	@Override
	public QnAVO read(Integer qnANo) throws Exception {
		return session.selectOne(namespace + ".read", qnANo);
	}

	@Override
	public void update(QnAVO vo) throws Exception {
		session.update(namespace + ".update", vo);
		
	}

	@Override
	public void delete(Integer qnANo) throws Exception {
		session.delete(namespace + ".delete", qnANo);
		
	}

	@Override
	public List<QnAVO> list(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public int listCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".listCount", cri);
	}

	@Override
	public void addReply(QnAVO vo) throws Exception {
		session.update(namespace + ".addReply", vo);
	}
}
