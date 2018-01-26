package org.sbang.controller;

import java.util.List;

import javax.inject.Inject;

import org.sbang.domain.AlarmVO;
import org.sbang.service.AlarmService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/alarm")
public class AlarmController {
	@Inject
	private AlarmService alarmService;

	@RequestMapping(value = "/all/{alarmTarget}", method = RequestMethod.GET)
	public ResponseEntity<List<AlarmVO>> list(@PathVariable("alarmTarget") Integer alarmTarget) {
		ResponseEntity<List<AlarmVO>> entity = null;
		try {
			entity = new ResponseEntity<>(alarmService.alarmList(alarmTarget), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	@RequestMapping(value = "/{alarmTarget}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> openState(@PathVariable("alarmTarget") Integer alarmTarget) {
		ResponseEntity<String> entity = null;
		try {
			
			alarmService.openState(alarmTarget);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/read/{alarmNo}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> readState(@PathVariable("alarmNo") Integer alarmNo) {
		ResponseEntity<String> entity = null;
		try {
			
			alarmService.readState(alarmNo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	

}
