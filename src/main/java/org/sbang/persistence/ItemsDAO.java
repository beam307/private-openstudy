package org.sbang.persistence;

public interface ItemsDAO {
	
	public String readUpRegionNo(String upRegionName) throws Exception;

	public String readDownRegionNo(String downRegionName) throws Exception;
	
	public String readCategoryNo(String categoryName) throws Exception;
}
