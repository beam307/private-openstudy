package org.sbang.domain;

import lombok.Data;

@Data
public class UserStudyVO {

	private Integer userNo;
	private Integer studyNo;
	private Integer userApprove;
	private String denyMsg;

}
