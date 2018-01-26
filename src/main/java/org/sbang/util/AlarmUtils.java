package org.sbang.util;

import javax.inject.Inject;

import org.sbang.domain.AlarmVO;
import org.sbang.service.AlarmService;
import org.springframework.stereotype.Component;

@Component
public class AlarmUtils {

	@Inject
	AlarmService alarmService;

	public void createAlarm(Integer studyNo, Integer target, Integer sender, Integer flag) throws Exception {
		AlarmVO alarm = new AlarmVO();
		alarm.setAlarmSender(sender);
		alarm.setAlarmTargetStudy(studyNo);
		alarm.setAlarmTarget(target);
		alarm.setAlarmFlag(flag);
		alarmService.create(alarm);
	}
}
