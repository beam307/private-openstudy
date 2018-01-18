package org.sbang.persistence;

import java.util.List;

import org.sbang.domain.WeekVO;

public interface WeekDAO {
	public void create(WeekVO vo) throws Exception;

	public List<WeekVO> list(Integer studyNo) throws Exception;

	public List<WeekVO> listEnd(Integer studyNo) throws Exception;

	public void replace(WeekVO vo,Integer studyNo) throws Exception;
	
	public void delete(Integer studyNo) throws Exception;
}
