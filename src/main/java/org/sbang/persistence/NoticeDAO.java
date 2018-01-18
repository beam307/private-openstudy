package org.sbang.persistence;

import java.util.List;

import org.sbang.domain.NoticeVO;
import org.sbang.domain.SearchCriteria;

public interface NoticeDAO {
	
	public void create(NoticeVO vo) throws Exception;
	
	public NoticeVO read(Integer noticeNo) throws Exception;
	
	public void update(NoticeVO vo) throws Exception;
	
	public void delete(Integer noticeNo) throws Exception;
	
	public List<NoticeVO> list(SearchCriteria cri) throws Exception;
	
	public int listCount(SearchCriteria cri) throws Exception;
}
