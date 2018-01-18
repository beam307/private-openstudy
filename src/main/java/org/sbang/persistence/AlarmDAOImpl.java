package org.sbang.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.AlarmVO;
import org.springframework.stereotype.Repository;

@Repository
public class AlarmDAOImpl implements AlarmDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "org.sbang.mapper.AlarmMapper";

	@Override
	public void create(AlarmVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public void delete(Integer alarmNo) throws Exception {
		session.delete(namespace + ".delete", alarmNo);
	}

	@Override
	public List<AlarmVO> alarmList(Integer alarmTarget) throws Exception {
		return session.selectList(namespace + ".alarmList", alarmTarget);
	}

	@Override
	public void openState(Integer alarmTarget) throws Exception {
		session.update(namespace + ".openState", alarmTarget);
	}

	@Override
	public void readState(Integer alarmNo) throws Exception {
		session.update(namespace + ".readState", alarmNo);
	}

	@Override
	public Integer countReceiveAlarm(Integer alarmTarget) throws Exception {// 웹소켓 핸들러로 보내는 카운트
		return session.selectOne(namespace + ".countReceiveAlarm", alarmTarget);
	}
}
