package org.sbang.service;

import java.util.List;

import javax.inject.Inject;

import org.sbang.domain.CutOffVO;
import org.sbang.domain.NoteVO;
import org.sbang.domain.SearchCriteria;
import org.sbang.persistence.NoteDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class NoteServiceImpl implements NoteService {
	
	@Inject
	private NoteDAO noteDAO;

	@Transactional
	@Override
	public void addNote(NoteVO vo) throws Exception{
		noteDAO.create(vo);
	}
	
	@Transactional
	@Override
	public NoteVO readNote(Integer noteNo) throws Exception{
		return noteDAO.readNote(noteNo);
	}
	
	@Override
	public void removeNote(Integer[] noteNo) throws Exception{
		for (Integer no : noteNo)
			noteDAO.delete(no);
	}
	
	@Override
	public List<NoteVO> noteList(SearchCriteria cri, Integer noteTarget) throws Exception{
		return noteDAO.noteList(cri,noteTarget);
	}
	
	@Override
	public List<NoteVO> noteListSender(SearchCriteria cri, Integer noteSender) throws Exception{
		return noteDAO.noteListSender(cri,noteSender);
	}
	
	@Override
	public List<NoteVO> noteListToMe(SearchCriteria cri, Integer noteTarget) throws Exception{
		return noteDAO.noteListToMe(cri,noteTarget);
	}
	
	@Override
	public void openState(Integer noteNo) throws Exception{
		noteDAO.openState(noteNo);
	}
	
	@Override
	public Integer noteListCount(Integer noteTarget) throws Exception{
		return noteDAO.noteListCount(noteTarget);
	}
	
	@Override
	public Integer noteListSenderCount(Integer noteSender) throws Exception{
		return noteDAO.noteListSenderCount(noteSender);
	}
	
	@Override
	public Integer noteListToMeCount(Integer noteTarget) throws Exception{
		return noteDAO.noteListToMeCount(noteTarget);
	}
	
	@Override
	public void addCutOff(Integer cutOffTarget, Integer cutOffSender) throws Exception{
		noteDAO.addCutOff(cutOffTarget, cutOffSender);
	}
	
	@Override
	public Integer chkCutOff(Integer cutOffTarget, Integer cutOffSender) throws Exception{
		return noteDAO.chkCutOff(cutOffTarget, cutOffSender);
	}
	
	@Override
	public List<CutOffVO> cutOffList(Integer cutOffSender) throws Exception{
		return noteDAO.cutOffList(cutOffSender);
	}
	
	@Override
	public Integer cutOffListCount(Integer cutOffSender) throws Exception{
		return noteDAO.cutOffListCount(cutOffSender);
	}
	
	@Override
	public void cutOffDelete(Integer[] cutOffNo) throws Exception{
		for (Integer no : cutOffNo)
			noteDAO.cutOffDelete(no);
		
	}

}
