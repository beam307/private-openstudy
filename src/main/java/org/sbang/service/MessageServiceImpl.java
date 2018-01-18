package org.sbang.service;

import java.util.List;

import javax.inject.Inject;

import org.sbang.domain.MessageVO;
import org.sbang.persistence.MessageDAO;
import org.springframework.stereotype.Service;

@Service
public class MessageServiceImpl implements MessageService {
	
	@Inject
	private MessageDAO msgDAO;
	
	@Override
	public void readState(Integer msgRoom) throws Exception{
		msgDAO.readState(msgRoom);
	}
	
	@Override
	public void userReadState(Integer msgRoom) throws Exception{
		msgDAO.userReadState(msgRoom);
	}
	
	@Override
	public List<MessageVO> msgList(Integer msgTo, Integer msgFrom) throws Exception{
		return msgDAO.msgList(msgTo, msgFrom);
	}
	
	@Override
	public List<MessageVO> senderList(Integer msgTo) throws Exception{
		return msgDAO.senderList(msgTo);
	}
}
