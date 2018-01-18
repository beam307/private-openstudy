package org.sbang.service;

import java.util.List;

import javax.inject.Inject;

import org.sbang.domain.NoticeVO;
import org.sbang.domain.SearchCriteria;
import org.sbang.persistence.NoticeDAO;
import org.springframework.stereotype.Service;

@Service
public class NoticeServiceImpl implements NoticeService{

	@Inject
	private NoticeDAO dao;
	
	
	@Override
	public void addNotice(NoticeVO vo) throws Exception {
		dao.create(vo);
	}

	@Override
	public NoticeVO readNotice(Integer noticeNo) throws Exception {
		return dao.read(noticeNo);
	}

	@Override
	public void modifyNotice(NoticeVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void removeNotice(Integer noticeNo) throws Exception {
		dao.delete(noticeNo);
	}

	@Override
	public List<NoticeVO> listNotice(SearchCriteria cri) throws Exception {
		return dao.list(cri);
	}
	
	@Override
	public int listNoticeCount(SearchCriteria cri) throws Exception{
		return dao.listCount(cri);
	}

}
