package org.sbang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.sbang.domain.Criteria;
import org.sbang.domain.PageMaker;
import org.sbang.domain.ReplyVO;
import org.sbang.service.ReplyService;
import org.sbang.util.AlarmUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	
	@Inject
	private ReplyService replyService;
	
	@Inject
	private AlarmUtils alarmUtil;
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyVO vo) {
		ResponseEntity<String> entity = null;
		try {
			replyService.addReply(vo);
			if (vo.getUserNo() != vo.getStudyWriter()) {
				alarmUtil.createAlarm(vo.getStudyNo(), vo.getStudyWriter(), vo.getUserNo(), 4);
			}
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/all/{studyNo}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("studyNo") Integer studyNo) {
		ResponseEntity<List<ReplyVO>> entity = null;

		try {
			entity = new ResponseEntity<>(replyService.listReply(studyNo), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{replyNo}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> update(@PathVariable("replyNo") Integer replyNo, @RequestBody ReplyVO vo) {
		ResponseEntity<String> entity = null;
		try {
			vo.setReplyNo(replyNo);
			replyService.modifyReply(vo);

			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{replyNo}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("replyNo") Integer replyNo, @RequestBody ReplyVO vo) {
		ResponseEntity<String> entity = null;
		try {
			replyService.removeReply(replyNo, vo.getStudyNo());
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{studyNo}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("studyNo") Integer studyNo, @PathVariable("page") Integer page) {
		ResponseEntity<Map<String, Object>> entity = null;

		try {
			Criteria cri = new Criteria();
			cri.setPage(page);

			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);

			Map<String, Object> map = new HashMap<String, Object>();
			List<ReplyVO> list = replyService.listReplyPage(studyNo, cri);
			map.put("list", list);

			int replyCount = replyService.count(studyNo);
			pageMaker.setTotalCount(replyCount);

			map.put("pageMaker", pageMaker);
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

}
