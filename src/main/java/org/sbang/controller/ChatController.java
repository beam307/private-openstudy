package org.sbang.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.sbang.domain.MessageVO;
import org.sbang.domain.UserVO;
import org.sbang.service.MessageService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/chat")
public class ChatController {
	
	@Inject
	private MessageService msgService;
	
	@RequestMapping(value= "/", method = RequestMethod.GET)
	public void chat (MessageVO msg, Model model, HttpSession session){
		
	}
	
	@RequestMapping(value= "/chatView/{msgFrom}", method = RequestMethod.GET)//채팅 뷰
	public ResponseEntity<List<MessageVO>> chatView (@PathVariable Integer msgFrom, MessageVO msg, Model model, HttpSession session) throws Exception {
		ResponseEntity<List<MessageVO>> entity = null;
		UserVO userVO = (UserVO) session.getAttribute("login");
		Integer msgTo=userVO.getUserNo();
		try {
			entity = new ResponseEntity<>(msgService.msgList(msgTo,msgFrom), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value= "/senderList", method = RequestMethod.GET)//채팅 뷰
	public ResponseEntity<List<MessageVO>> senderList (MessageVO msg, Model model, HttpSession session) throws Exception {
		ResponseEntity<List<MessageVO>> entity = null;
		UserVO userVO = (UserVO) session.getAttribute("login");
		Integer msgTo=userVO.getUserNo();
		try {
			entity = new ResponseEntity<>(msgService.senderList(msgTo), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/{msgRoom}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> openState(@PathVariable("msgRoom") Integer msgRoom, HttpSession session) {
		ResponseEntity<String> entity = null;
		try {
			UserVO userVO = (UserVO) session.getAttribute("login");
			if(userVO.getUserNo()==1) {
				msgService.readState(msgRoom); // admin에서 채팅방 readDate update
			}else {
				msgService.userReadState(msgRoom); //user입장에서 채팅방 읽기 readDate update
			}
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
