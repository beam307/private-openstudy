package org.sbang.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ItemsDAOImpl implements ItemsDAO{
	@Inject
	private SqlSession session;

	private static String namespace = "org.sbang.mapper.ItemsMapper";
	
	@Override
	public String readUpRegionNo(String upRegionName) throws Exception {
		return session.selectOne(namespace + ".readUpRegionNo", upRegionName);
	}
	
	@Override
	public String readDownRegionNo(String downRegionName) throws Exception {
		return session.selectOne(namespace + ".readDownRegionNo", downRegionName);
	}

	@Override
	public String readCategoryNo(String categoryName) throws Exception {
		return session.selectOne(namespace + ".readCategoryNo", categoryName);
	}

}
