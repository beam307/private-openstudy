package org.sbang.service;

import java.util.List;

import org.sbang.domain.StudyVO;

public interface ItemsService {

	public String readUpRegionNo(String upRegionName) throws Exception;
	
	public String readDownRegionNo(String downRegionName) throws Exception;
	
	public String readCategoryNo(String categoryName) throws Exception;
	
	public List<StudyVO> favStudyList(String[] favCategoryArr, String favRegion) throws Exception;
}
