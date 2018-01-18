package org.sbang.domain;

import lombok.Data;

@Data
public class WeekVO {

	private Integer weekNo;
	private Integer studyNo;

	private String weekDay;

	private String weekStartDate;
	private String weekEndDate;
} 
