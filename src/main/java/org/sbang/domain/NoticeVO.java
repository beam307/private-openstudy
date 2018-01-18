package org.sbang.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private Integer noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeRegDate;
	private Date noticeUpdateDate;
}
