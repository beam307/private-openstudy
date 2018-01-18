package org.sbang.domain;

import java.util.List;

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