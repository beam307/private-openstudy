package org.sbang.service;

import java.util.List;

import org.sbang.domain.Criteria;
import org.sbang.domain.ReplyVO;

public interface ReplyService {

	public void addReply(ReplyVO vo) throws Exception;

	public List<ReplyVO> listReply(Integer studyNo) throws Exception;

	public void modifyReply(ReplyVO vo) throws Exception;

	public void removeReply(Integer replyNo,Integer studyNo) throws Exception;

	public List<ReplyVO> listReplyPage(Integer studyNo, Criteria cri) throws Exception;

	public int count(Integer studyNo) throws Exception;
}
