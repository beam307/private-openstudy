package org.sbang.service;

import java.util.List;

import javax.inject.Inject;

import org.sbang.domain.Criteria;
import org.sbang.domain.ReplyVO;
import org.sbang.persistence.ReplyDAO;
import org.sbang.persistence.StudyDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDAO;
	
	@Inject
	private StudyDAO studyDAO;

	@Transactional
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		replyDAO.create(vo);
		studyDAO.updateReplyCnt(vo.getStudyNo(), 1);
		
	}

	@Override
	public List<ReplyVO> listReply(Integer studyNo) throws Exception {
		return replyDAO.list(studyNo);
	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		replyDAO.update(vo);
	}

	@Transactional
	@Override
	public void removeReply(Integer replyNo,Integer studyNo) throws Exception {
		replyDAO.delete(replyNo);
		studyDAO.updateReplyCnt(studyNo, -1);
	}

	@Override
	public List<ReplyVO> listReplyPage(Integer studyNo, Criteria cri) throws Exception {
		return replyDAO.listPage(studyNo, cri);
	}

	@Override
	public int count(Integer studyNo) throws Exception {
		return replyDAO.count(studyNo);
	}
}
