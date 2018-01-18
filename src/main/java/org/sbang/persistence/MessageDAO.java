package org.sbang.persistence;

import java.util.List;

import org.sbang.domain.MessageVO;

public interface MessageDAO {
	
	public void create(MessageVO vo) throws Exception;
	
	public void delete(Integer msgNo) throws Exception;
	
	public void readState(Integer msgRoom) throws Exception;
	
	public void userReadState(Integer msgRoom) throws Exception;
	
	public List<MessageVO> msgList(Integer msgTo, Integer msgFrom) throws Exception;
	
	public List<MessageVO> senderList(Integer msgTo) throws Exception;
	
	public List<Integer> countReceiveChat(Integer msgTo) throws Exception;
	
	public Integer countReceiveChatUser(Integer msgTo) throws Exception;
	
}
