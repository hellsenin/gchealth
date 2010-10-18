package egovframework.kr.go.geumcheon.health.service;

import java.util.List;

import egovframework.kr.go.geumcheon.health.vo.Discussion;
import egovframework.kr.go.geumcheon.health.vo.Division;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface DiscussionService {

	public List selectProgressiveDiscussionList() throws Exception;

	public List selectCompletedDiscussionList(Discussion discussion) throws Exception;

	public List selectDivisionList(Discussion discussion) throws Exception;
	
	public List selectDiscussionListA(Discussion discussion) throws Exception;
	
	public int selectCompletedDiscussionCnt() throws Exception;

	public int selectDiscussionCntA() throws Exception;
	
	public int selectDivisionCnt(int disseq) throws Exception;

	public EgovMap selectDiscussionByDisseq(int disseq) throws Exception;

	public EgovMap selectDivisionByDivseq(int divseq) throws Exception;
	
	public void insertDiscussion(Discussion discussion) throws Exception;

	public void modifyDiscussion(Discussion discussion) throws Exception;
	
	public void insertDivision(Division division) throws Exception;

	public void modifyDivision(Division division) throws Exception;

	public void addHit(int disseq) throws Exception;
}
