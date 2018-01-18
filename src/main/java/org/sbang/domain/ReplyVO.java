package org.sbang.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private Integer replyNo;
	private Integer studyNo;
	private Integer studyWriter;
	private Integer userNo;
	
	private String userNick;
	private String replyText;
	
	private boolean replySecret;

	private Date replyRegDate;
	private Date replyUpdateDate;
}
