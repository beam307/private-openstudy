package org.sbang.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.StudyVO;
import org.springframework.stereotype.Repository;

@Repository
public class ItemsDAOImpl implements ItemsDAO {
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

	@Override
	public List<StudyVO> favStudyList(String[] categoryList, String favRegion) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("categoryList", categoryList);
		map.put("favRegion", favRegion);
		
		return session.selectList(namespace + ".studyList", map);
	}

}
