package org.sbang.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.sbang.domain.UserVO;
import org.sbang.persistence.AlarmDAO;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebSocketAlarmHandler extends TextWebSocketHandler {

	@Inject
	private AlarmDAO alarmDAO;

	private List<WebSocketSession> connectedUsers;

	public WebSocketAlarmHandler() {
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
		Integer target = Integer.parseInt(message.getPayload());
		for (WebSocketSession websocketSession : connectedUsers) {
			map = websocketSession.getAttributes();
			UserVO login = (UserVO) (map.get("login"));
			CharSequence text = null;
			if (login.getUserNo() == target) {
				if (alarmDAO.countReceiveAlarm(target) != 0)
					text = String.valueOf(alarmDAO.countReceiveAlarm(target));
				else
					text = "";
				websocketSession.sendMessage(new TextMessage(text));
			}
		}
		// 현재 수신자에게 몇개의 메세지가 와있는지 디비에서 검색함.
	}

	// 클라이언트에서 연결을 종료할 경우 발생하는 이벤트
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		connectedUsers.remove(session);
	}

}
