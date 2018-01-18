package org.sbang.service;

import java.util.List;

import org.sbang.domain.AlarmVO;

public interface AlarmService {
	
	public void create(AlarmVO vo) throws Exception;
	
	public void delete(Integer alarmNo) throws Exception;
	
	public List<AlarmVO> alarmList(Integer alarmTarget) throws Exception;
	
	public void openState(Integer alarmTarget) throws Exception;
	
	public void readState(Integer alarmNo) throws Exception;
	
	public Integer countReceiveAlarm(Integer alarmTarget) throws Exception;
	
}
