package org.sbang.persistence;

import java.util.List;

import org.sbang.domain.QnAVO;
import org.sbang.domain.SearchCriteria;

public interface QnADAO {
	  
	public void create(QnAVO vo) throws Exception;
	
	public QnAVO read(Integer qnANo) throws Exception;
	
	public void update(QnAVO vo) throws Exception;
	
	public void delete(Integer qnANo) throws Exception;
	
	public List<QnAVO> list(SearchCriteria cri) throws Exception;
	
	public int listCount(SearchCriteria cri) throws Exception;
	
	public void addReply(QnAVO vo) throws Exception;
}
