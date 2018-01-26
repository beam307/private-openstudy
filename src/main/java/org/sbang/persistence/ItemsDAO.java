package org.sbang.persistence;

import java.util.List;

import org.sbang.domain.StudyVO;

public interface ItemsDAO {
	
	public String readUpRegionNo(String upRegionName) throws Exception;

	public String readDownRegionNo(String downRegionName) throws Exception;
	
	public String readCategoryNo(String categoryName) throws Exception;

	public List<StudyVO> favStudyList(String[] categoryList, String favRegion) throws Exception;
}
