package org.sbang.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.sbang.domain.UserVO;
import org.sbang.persistence.MessageDAO;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class WebSocketChatAlarmHandler extends TextWebSocketHandler {

	private List<WebSocketSession> connectedUsers;

	@Inject
	private MessageDAO msgDAO;

	public WebSocketChatAlarmHandler() {
		connectedUsers = new ArrayList<WebSocketSession>();
	}
	
	// 클라이언트에서 접속을 하여 성공할 경우 발생하는 이벤트
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		connectedUsers.add(session);
	}
	
	// 클라이언트에서 send를 이용해서 메시지 발송을 한 경우 이벤트 핸들링
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Map<String, Object> map = null;
		Integer msgTo = Integer.parseInt(message.getPayload());
		for (WebSocketSession websocketSession : connectedUsers) {
			map = websocketSession.getAttributes();
			UserVO login = (UserVO) (map.get("login"));
			if (msgTo.equals(login.getUserNo())) {
				Gson gson = new Gson();
				String listJson = null;
				if (msgTo.equals(1)) {
					listJson = gson.toJson(msgDAO.countReceiveChat(msgTo));
					websocketSession.sendMessage(new TextMessage(listJson));
				} else {
					String text = String.valueOf(msgDAO.countReceiveChatUser(msgTo));
					websocketSession.sendMessage(new TextMessage(text));
				}
			}

		}
	}

	// 클라이언트에서 연결을 종료할 경우 발생하는 이벤트
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		connectedUsers.remove(session);
	}

}
