package egovframework.kr.go.geumcheon.health.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kr.go.geumcheon.health.dao.DiscussionDAO;
import egovframework.kr.go.geumcheon.health.vo.Discussion;
import egovframework.kr.go.geumcheon.health.vo.Division;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("discussionService")
public class DiscussionServiceImpl implements DiscussionService{

	@Resource(name="discussionDAO")
	private DiscussionDAO discussionDAO;
	
	public List selectProgressiveDiscussionList() throws Exception
	{
        return discussionDAO.selectProgressiveDiscussionList();
	}

	public List selectCompletedDiscussionList(Discussion discussion) throws Exception
	{
        return discussionDAO.selectCompletedDiscussionList(discussion);
	}

	public List selectDivisionList(Discussion discussion) throws Exception
	{
        return discussionDAO.selectDivisionList(discussion);
	}

	public List selectDiscussionListA(Discussion discussion) throws Exception
	{
        return discussionDAO.selectDiscussionListA(discussion);
	}
	
	public int selectCompletedDiscussionCnt() throws Exception
	{
		return discussionDAO.selectCompletedDiscussionCnt();
	}

	public int selectDiscussionCntA() throws Exception
	{
		return discussionDAO.selectDiscussionCntA();
	}
	
	public int selectDivisionCnt(int disseq) throws Exception
	{
		return discussionDAO.selectDivisionCnt(disseq);
	}

	public EgovMap selectDiscussionByDisseq(int disseq) throws Exception
	{
		return discussionDAO.selectDiscussionByDisseq(disseq);
	}

	public EgovMap selectDivisionByDivseq(int divseq) throws Exception
	{
		return discussionDAO.selectDivisionByDivseq(divseq);
	}
	
	public void insertDiscussion(Discussion discussion) throws Exception
	{
		discussionDAO.insertDiscussion(discussion);
	}

	public void modifyDiscussion(Discussion discussion) throws Exception
	{
		discussionDAO.modifyDiscussion(discussion);
	}
	
	public void insertDivision(Division division) throws Exception
	{
		discussionDAO.insertDivision(division);
	}

	public void modifyDivision(Division division) throws Exception
	{
		discussionDAO.modifyDivision(division);
	}

	public void addHit(int disseq) throws Exception
	{
		discussionDAO.addHit(disseq);
	}
}
