package org.sbang.service;

import java.util.List;

import org.sbang.domain.QnAVO;
import org.sbang.domain.SearchCriteria;

public interface QnAService {
	
	public void addQnA(QnAVO vo) throws Exception;
	
	public QnAVO readQnA(Integer qnANo) throws Exception;
	
	public void modifyQnA(QnAVO vo) throws Exception;
	
	public void removeQnA(Integer qnANo) throws Exception;
	
	public List<QnAVO> listQnA(SearchCriteria cri) throws Exception;
	
	public int listQnACount(SearchCriteria cri) throws Exception;
	
	public void addReply(QnAVO vo) throws Exception;
}
