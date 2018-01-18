package org.sbang.persistence;

import java.util.List;

import org.sbang.domain.Criteria;
import org.sbang.domain.ReplyVO;

public interface ReplyDAO {
	public List<ReplyVO> list(Integer studyNo) throws Exception;

	public void create(ReplyVO vo) throws Exception;

	public void update(ReplyVO vo) throws Exception;

	public void delete(Integer replyNo) throws Exception;

	public void deleteWithStudyNo(Integer studyNo) throws Exception;
	
	public List<ReplyVO> listPage(Integer studyNo, Criteria cri) throws Exception;

	public int count(Integer studyNo) throws Exception;
	
	public void updateReplyCnt(Integer studyNo, int amount) throws Exception;
}
