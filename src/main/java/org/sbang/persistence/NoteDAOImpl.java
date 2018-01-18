package org.sbang.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sbang.domain.CutOffVO;
import org.sbang.domain.NoteVO;
import org.sbang.domain.SearchCriteria;
import org.springframework.stereotype.Repository;

@Repository
public class NoteDAOImpl implements NoteDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace="org.sbang.mapper.NoteMapper";
	
	@Override
	public void create(NoteVO vo) throws Exception{
		session.insert(namespace+".create",vo);
	}
	
	@Override
	public void delete(Integer noteNo) throws Exception{
		session.delete(namespace+".delete",noteNo);
	}
	
	@Override
	public NoteVO readNote(Integer noteNo) throws Exception{
		return session.selectOne(namespace+".readNote",noteNo);
	}
	
	@Override
	public List<NoteVO> noteList(SearchCriteria cri, Integer noteTarget) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("noteTarget", noteTarget);
		paramMap.put("cri", cri);
		return session.selectList(namespace+".noteList",paramMap);
	}
	
	@Override
	public List<NoteVO> noteListSender(SearchCriteria cri, Integer noteSender) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("noteSender", noteSender);
		paramMap.put("cri", cri);
		return session.selectList(namespace+".noteListSender",paramMap);
	}
	
	@Override
	public List<NoteVO> noteListToMe(SearchCriteria cri, Integer noteTarget) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("noteTarget", noteTarget);
		paramMap.put("cri", cri);
		return session.selectList(namespace+".noteListToMe",paramMap);
	}
	
	@Override
	public Integer noteListCount(Integer noteTarget) throws Exception{
		return session.selectOne(namespace+".noteListCount", noteTarget);
	}
	
	@Override
	public Integer noteListSenderCount(Integer noteSender) throws Exception{
		return session.selectOne(namespace+".noteListSenderCount", noteSender);
	}
	
	@Override
	public Integer noteListToMeCount(Integer noteTarget) throws Exception{
		return session.selectOne(namespace+".noteListToMeCount", noteTarget);
	}
	
	@Override
	public Integer countReceiveNote(Integer noteTarget) throws Exception{//웹소켓 핸들러로 보내는 카운트
		return session.selectOne(namespace+".countReceiveNote",noteTarget);
	}
	
	@Override
	public void openState(Integer noteNo) throws Exception{
		session.update(namespace+".openState",noteNo);
	}
	
	@Override
	public Integer targetChk(String noteTarget) throws Exception{
		return session.selectOne(namespace+".targetChk",noteTarget);
	}
	
	@Override
	public void addCutOff(Integer cutOffTarget, Integer cutOffSender) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("cutOffTarget", cutOffTarget);
		paramMap.put("cutOffSender", cutOffSender);
		session.insert(namespace+".addCutOff",paramMap);
	}
	
	@Override
	public Integer chkCutOff(Integer cutOffTarget, Integer cutOffSender) throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("cutOffTarget", cutOffTarget);
		paramMap.put("cutOffSender", cutOffSender);
		return session.selectOne(namespace+".chkCutOff",paramMap);
	}
	
	@Override
	public List<CutOffVO> cutOffList(Integer cutOffSender) throws Exception{
		return session.selectList(namespace+".cutOffList",cutOffSender);
	}
	
	@Override
	public Integer cutOffListCount(Integer cutOffSender) throws Exception{
		return session.selectOne(namespace+".cutOffListCount",cutOffSender);
	}
	
	@Override
	public void cutOffDelete(Integer cutOffNo) throws Exception{
		session.delete(namespace+".cutOffDelete",cutOffNo);
	}
}
