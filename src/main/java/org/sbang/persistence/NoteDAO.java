package org.sbang.persistence;

import java.util.List;

import org.sbang.domain.CutOffVO;
import org.sbang.domain.NoteVO;
import org.sbang.domain.SearchCriteria;

public interface NoteDAO {
	public void create(NoteVO vo) throws Exception;
	
	public NoteVO readNote(Integer noteNo) throws Exception;
	
	public void delete(Integer noteNo) throws Exception;
	
	public List<NoteVO> noteList(SearchCriteria cri,Integer noteTarget) throws Exception;
	
	public List<NoteVO> noteListSender(SearchCriteria cri,Integer noteSender) throws Exception;
	
	public List<NoteVO> noteListToMe(SearchCriteria cri,Integer noteTarget) throws Exception;
	
	public void openState(Integer noteNo) throws Exception;
	
	public Integer noteListCount(Integer noteTarget) throws Exception;
	
	public Integer noteListSenderCount(Integer noteSender) throws Exception;
	
	public Integer noteListToMeCount(Integer noteTarget) throws Exception;

	public Integer countReceiveNote(Integer noteTarget) throws Exception;
	
	public Integer targetChk(String noteTarget) throws Exception;
	
	public void addCutOff(Integer cutOffTarget, Integer cutOffSender) throws Exception;
	
	public Integer chkCutOff(Integer cutOffTarget, Integer cutOffSender) throws Exception;
	
	public List<CutOffVO> cutOffList(Integer cutOffSender) throws Exception;
	
	public Integer cutOffListCount(Integer cutOffSender) throws Exception;
	
	public void cutOffDelete(Integer cutOffNo) throws Exception;
	
}
