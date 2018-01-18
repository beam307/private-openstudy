package org.sbang.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class AlarmVO {
	
	private Integer alarmNo;
	private Integer alarmTarget;
	private Integer alarmSender;
	private Integer alarmFlag;
	private Integer alarmTargetStudy;
	
	private String studyName;
	private String userNick;
	private String userProfileImgPath;
	
	private Boolean alarmReadState;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="MM월dd일 a hh:mm", timezone="Asia/Seoul")
	private Date alarmRegDate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="MM월dd일 a hh:mm", timezone="Asia/Seoul")
	private Date alarmOpenDate;
}
