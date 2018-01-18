package org.sbang.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoteVO {
	
	private Integer noteNo;
	private Integer userNo;
	
	private Integer noteTarget;
	private Integer noteSender;
	
	private String noteTargetNick;
	private String noteSenderNick;
	private String noteText;
	private String userNick;
	
	private Date noteOpenDate;
	private Date noteSendDate;

}
