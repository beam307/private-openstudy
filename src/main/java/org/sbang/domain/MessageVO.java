package org.sbang.domain;

import java.util.Date;

import com.google.gson.Gson;

import lombok.Data;

@Data
public class MessageVO {
	private Integer msgNo;
	private Integer msgFrom;
	private Integer msgTo;
	private Integer msgRoom;
	
	private String msgToNick;
	private String msgFromNick;
	private String userProfileImgPath;
	private String msgText;
	private String userNick;
	
	private Boolean msgUserReadState;
	
	
	private Date msgSendDate;
	private Date msgReadDate;
	
	public static MessageVO convertMessage(String source) {
		MessageVO message = new MessageVO();
		Gson gson = new Gson();
		message = gson.fromJson(source,MessageVO.class);
		return message;
	}
}
