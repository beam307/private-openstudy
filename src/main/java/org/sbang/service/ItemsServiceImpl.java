package org.sbang.service;

import javax.inject.Inject;

import org.sbang.persistence.ItemsDAO;
import org.springframework.stereotype.Service;

@Service
public class ItemsServiceImpl implements ItemsService {
	
	@Inject
	private ItemsDAO itemsDAO;

	@Override
	public String readUpRegionNo(String upRegionName) throws Exception {
		return itemsDAO.readUpRegionNo(upRegionName);
	}

	@Override
	public String readDownRegionNo(String downRegionName) throws Exception {
		return itemsDAO.readDownRegionNo(downRegionName);
	}

	@Override
	public String readCategoryNo(String categoryName) throws Exception {
		return itemsDAO.readCategoryNo(categoryName);
	}
}
