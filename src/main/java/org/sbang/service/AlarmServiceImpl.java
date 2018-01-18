package org.sbang.service;

import java.util.List;

import javax.inject.Inject;

import org.sbang.domain.AlarmVO;
import org.sbang.persistence.AlarmDAO;
import org.springframework.stereotype.Service;

@Service
public class AlarmServiceImpl implements AlarmService {

	@Inject
	private AlarmDAO alarmDAO;

	@Override
	public void create(AlarmVO vo) throws Exception {
		alarmDAO.create(vo);
	}

	@Override
	public void delete(Integer alarmNo) throws Exception {
		alarmDAO.delete(alarmNo);
	}

	@Override
	public List<AlarmVO> alarmList(Integer alarmTarget) throws Exception {
		return alarmDAO.alarmList(alarmTarget);
	}

	@Override
	public void openState(Integer alarmTarget) throws Exception {
		alarmDAO.openState(alarmTarget);
	}

	@Override
	public void readState(Integer alarmNo) throws Exception {
		alarmDAO.readState(alarmNo);
	}

	@Override
	public Integer countReceiveAlarm(Integer alarmTarget) throws Exception {// 웹소켓 핸들러로 보내는 카운트
		return alarmDAO.countReceiveAlarm(alarmTarget);
	}
}
