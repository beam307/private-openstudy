package org.sbang.service;

import java.util.List;

import org.sbang.domain.NoticeVO;
import org.sbang.domain.SearchCriteria;

public interface NoticeService {
	
	public void addNotice(NoticeVO vo) throws Exception;
	
	public NoticeVO readNotice(Integer noticeNo) throws Exception;
	
	public void modifyNotice(NoticeVO vo) throws Exception;
	
	public void removeNotice(Integer noticeNo) throws Exception;
	
	public List<NoticeVO> listNotice(SearchCriteria cri) throws Exception;
	
	public int listNoticeCount(SearchCriteria cri) throws Exception;
}
