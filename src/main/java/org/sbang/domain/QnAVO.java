package org.sbang.domain;

import lombok.Data;

@Data
public class QnAVO {
	private Integer qnANo;
	private String qnATitle;
	private String qnAContent;
	private String qnAReply;
	private Integer qnAWriterNo;
	private String qnAWriterNick;
}
