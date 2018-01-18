package org.sbang.service;

import java.util.List;

import org.sbang.domain.MessageVO;

public interface MessageService {
	
	public void readState(Integer msgRoom) throws Exception;
	
	public void userReadState(Integer msgRoom) throws Exception;
	
	public List<MessageVO> msgList(Integer msgTo, Integer msgFrom) throws Exception;
	
	public List<MessageVO> senderList(Integer msgTo) throws Exception;
}
