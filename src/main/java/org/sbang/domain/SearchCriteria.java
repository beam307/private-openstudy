package org.sbang.domain;

import lombok.Data;

@Data
public class SearchCriteria extends Criteria {
	
	private String searchType;
	private String keyword;
	private String lineUp;
	private String upRegion;
	private String downRegion;
	private String upCategory;
	private String category;
}