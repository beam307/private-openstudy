package org.sbang.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.MessageVO;
import org.springframework.stereotype.Repository;

@Repository
public class MessageDAOImpl implements MessageDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace="org.sbang.mapper.MessageMapper";
	
	@Override
	public void create(MessageVO vo) throws Exception{
		session.insert(namespace+".create", vo);
	}
	
	@Override
	public void delete(Integer msgNo) throws Exception{
		session.delete(namespace+".delete", msgNo);
	}
	
	@Override
	public void readState(Integer msgRoom) throws Exception{
		session.update(namespace+".readState",msgRoom);
	}
	
	@Override
	public void userReadState(Integer msgRoom) throws Exception{
		session.update(namespace+".userReadState",msgRoom);
	}
	
	@Override
	public List<MessageVO> msgList(Integer msgTo, Integer msgFrom) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();

		paramMap.put("msgTo", msgTo);
		paramMap.put("msgFrom", msgFrom);
		return session.selectList(namespace+".msgList", paramMap);
	}
	
	@Override
	public List<MessageVO> senderList(Integer msgTo) throws Exception{
		return session.selectList(namespace+".senderList", msgTo);
	}
	
	@Override
	public List<Integer> countReceiveChat(Integer msgTo) throws Exception{
		return session.selectList(namespace+".countReceiveChat", msgTo);
	}
	
	@Override
	public Integer countReceiveChatUser(Integer msgTo) throws Exception{
		return session.selectOne(namespace+".countReceiveChatUser", msgTo);
	}
}
