package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.vo.Discussion;
import egovframework.kr.go.geumcheon.health.vo.Division;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("discussionDAO")
public class DiscussionDAO  extends EgovAbstractDAO{

	public List selectProgressiveDiscussionList() throws Exception
	{
        return list("discussionDAO.selectProgressiveDiscussionList", null);
	}

	public List selectCompletedDiscussionList(Discussion discussion) throws Exception
	{
        return list("discussionDAO.selectCompletedDiscussionList", discussion);
	}

	public List selectDivisionList(Discussion discussion) throws Exception
	{
        return list("discussionDAO.selectDivisionList", discussion);
	}
	
	public List selectDiscussionListA(Discussion discussion) throws Exception
	{
        return list("discussionDAO.selectDiscussionListA", discussion);
	}

	public int selectCompletedDiscussionCnt() throws Exception
	{
		return (Integer)getSqlMapClientTemplate().queryForObject("discussionDAO.selectCompletedDiscussionCnt", null);
	}

	public int selectDiscussionCntA() throws Exception
	{
		return (Integer)getSqlMapClientTemplate().queryForObject("discussionDAO.selectDiscussionCntA", null);
	}
	
	public int selectDivisionCnt(int disseq) throws Exception
	{
		return (Integer)getSqlMapClientTemplate().queryForObject("discussionDAO.selectDivisionCnt", disseq);
	}

	public EgovMap selectDiscussionByDisseq(int disseq) throws Exception
	{
		return (EgovMap)selectByPk("discussionDAO.selectDiscussionByDisseq", disseq);
	}

	public EgovMap selectDivisionByDivseq(int disseq) throws Exception
	{
		return (EgovMap)selectByPk("discussionDAO.selectDivisionByDivseq", disseq);
	}
	
	public void insertDiscussion(Discussion discussion) throws Exception
	{
		insert("discussionDAO.insertDiscussion", discussion);
	}

	public void modifyDiscussion(Discussion discussion) throws Exception
	{
		update("discussionDAO.modifyDiscussion", discussion);
	}
	
	public void insertDivision(Division division) throws Exception
	{
		insert("discussionDAO.insertDivision", division);
	}

	public void modifyDivision(Division division) throws Exception
	{
		update("discussionDAO.modifyDivision", division);
	}

	public void addHit(int disseq) throws Exception
	{
		update("discussionDAO.addHit", disseq);
	}
}
