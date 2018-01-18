package org.sbang.controller;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.sbang.domain.SearchCriteria;
import org.sbang.domain.StudyVO;
import org.sbang.persistence.StudyDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BoardDAOTest {

	@Inject 
	StudyDAO dao;
	
	private static Logger logger=LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Test
	public void testDynamic1() throws Exception{
		SearchCriteria cri=new SearchCriteria();
		cri.setPage(1);
		cri.setKeyword("d");
		cri.setSearchType("t");
		
		logger.info("========================");
		
		List<StudyVO> list=dao.listSearch(cri);
		
		for(StudyVO studyVO :list) {
			logger.info(studyVO.getStudyNo()+": "+studyVO.getStudyName());
		}
		logger.info("==========================");
		logger.info("COUNT: "+dao.listSearchCount(cri));
	}
}
