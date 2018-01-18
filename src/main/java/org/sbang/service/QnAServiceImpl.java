package org.sbang.service;

import java.util.List;

import javax.inject.Inject;

import org.sbang.domain.QnAVO;
import org.sbang.domain.SearchCriteria;
import org.sbang.persistence.QnADAO;
import org.springframework.stereotype.Service;

@Service
public class QnAServiceImpl implements QnAService{

	@Inject
	private QnADAO dao;

	@Override
	public void addQnA(QnAVO vo) throws Exception {
		dao.create(vo);
		
	}

	@Override
	public QnAVO readQnA(Integer qnANo) throws Exception {
		return dao.read(qnANo);
	}

	@Override
	public void modifyQnA(QnAVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void removeQnA(Integer qnANo) throws Exception {
		dao.delete(qnANo);
	}

	@Override
	public List<QnAVO> listQnA(SearchCriteria cri) throws Exception {
		return dao.list(cri);
	}

	@Override
	public int listQnACount(SearchCriteria cri) throws Exception {
		return dao.listCount(cri);
	}

	@Override
	public void addReply(QnAVO vo) throws Exception {
		dao.addReply(vo);
	}

}