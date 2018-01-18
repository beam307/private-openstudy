package org.sbang.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.sbang.domain.MessageVO;
import org.sbang.domain.UserVO;
import org.sbang.persistence.MessageDAO;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class WebSocketChatHandler extends TextWebSocketHandler {

	private List<WebSocketSession> connectedUsers;

	@Inject
	private MessageDAO msgDAO;

	public WebSocketChatHandler() {
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
		MessageVO messageVO = MessageVO.convertMessage(message.getPayload());
		msgDAO.create(messageVO);

		for (WebSocketSession websocketSession : connectedUsers) {
			map = websocketSession.getAttributes();
			UserVO login = (UserVO) map.get("login");
			if (login.getUserNo().equals(messageVO.getMsgTo())) {
				Gson gson = new Gson();
				String msgJson = gson.toJson(messageVO);
				websocketSession.sendMessage(new TextMessage(msgJson));
			}
		}
	}

	// 클라이언트에서 연결을 종료할 경우 발생하는 이벤트
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		connectedUsers.remove(session);
	}

}
