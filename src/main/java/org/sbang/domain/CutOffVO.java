package org.sbang.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CutOffVO {
	
	Integer cutOffNo;
	
	String cutOffSender;
	String cutOffTarget;
	String userNick;
	
	Date cutOffRegDate;
}
