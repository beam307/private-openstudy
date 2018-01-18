package org.sbang.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.NoticeVO;
import org.sbang.domain.SearchCriteria;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Inject
	private SqlSession session;

	private static String namespace = "org.sbang.mapper.NoticeMapper";

	@Override
	public void create(NoticeVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public NoticeVO read(Integer noticeNo) throws Exception {
		return session.selectOne(namespace + ".read", noticeNo);
	}

	@Override
	public void update(NoticeVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(Integer noticeNo) throws Exception {
		session.delete(namespace + ".delete", noticeNo);
	}

	@Override
	public List<NoticeVO> list(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".list",cri);
	}
	
	@Override
	public int listCount(SearchCriteria cri) throws Exception{
		return session.selectOne(namespace + ".listCount",cri);
	}

}
