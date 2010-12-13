package egovframework.com.cop.com.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cop.com.service.BoardUseInf;
import egovframework.com.cop.com.service.BoardUseInfVO;
import egovframework.com.cop.com.service.EgovBBSUseInfoManageService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 게시판 이용정보를 관리하기 위한 서비스 구현 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.4.2  이삼섭          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Service("EgovBBSUseInfoManageService")
public class EgovBBSUseInfoManageServiceImpl extends AbstractServiceImpl implements EgovBBSUseInfoManageService {
	
    @Resource(name = "BBSUseInfoManageDAO")
    private BBSUseInfoManageDAO bbsUseDAO;

    /**
     * 게시판 사용 정보를 삭제한다.
     * 
     * @see egovframework.com.cop.bbs.com.service.EgovBBSUseInfoManageService#deleteBBSUseInf(egovframework.com.cop.bbs.com.service.BoardUseInf)
     */
    public void deleteBBSUseInf(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.deleteBBSUseInf(bdUseInf);
    }

    /**
     * 게시판 사용정보를 등록한다.
     * 
     * @see egovframework.com.cop.bbs.com.service.EgovBBSUseInfoManageService#insertBBSUseInf(egovframework.com.cop.bbs.com.service.BoardUseInf)
     */
    public void insertBBSUseInf(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.insertBBSUseInf(bdUseInf);
    }

    /**
     * 게시판 사용정보 목록을 조회한다.
     * 
     * @see egovframework.com.cop.bbs.com.service.EgovBBSUseInfoManageService#selectBBSUseInfs(egovframework.com.cop.bbs.com.service.BoardUseInfVO)
     */
    public Map<String, Object> selectBBSUseInfs(BoardUseInfVO bdUseVO) throws Exception {

	List<BoardUseInfVO> result = bbsUseDAO.selectBBSUseInfs(bdUseVO);
	int cnt = bbsUseDAO.selectBBSUseInfsCnt(bdUseVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 게시판 사용정보를 수정한다.
     * 
     * @see egovframework.com.cop.bbs.com.service.EgovBBSUseInfoManageService#updateBBSUseInf(egovframework.com.cop.bbs.com.service.BoardUseInf)
     */
    public void updateBBSUseInf(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.updateBBSUseInf(bdUseInf);
    }

    /**
     * 게시판 사용정보에 대한 상세정보를 조회한다.
     * 
     * @see egovframework.com.cop.bbs.com.service.EgovBBSUseInfoManageService#selectBBSUseInf(egovframework.com.cop.bbs.com.service.BoardUseInfVO)
     */
    public BoardUseInfVO selectBBSUseInf(BoardUseInfVO bdUseVO) throws Exception {
	return bbsUseDAO.selectBBSUseInf(bdUseVO);
    }

    /**
     * 동호회에 사용되는 게시판 사용정보를 삭제한다.
     * 
     * @see egovframework.com.cop.com.service.EgovBBSUseInfoManageService#deleteBBSUseInfByClub(egovframework.com.cop.com.service.BoardUseInf)
     */
    public void deleteBBSUseInfByClub(BoardUseInfVO bdUseVO) throws Exception {
	List<BoardUseInf> result = bbsUseDAO.selectBBSUseInfByClub(bdUseVO);
	
	BoardUseInf bdUseInf = null;
	Iterator<BoardUseInf> iter = result.iterator();
	while (iter.hasNext()) {
	    bdUseInf = (BoardUseInf)iter.next();
	    
	    bdUseInf.setLastUpdusrId(bdUseVO.getLastUpdusrId());
	    bdUseInf.setTrgetId(bdUseVO.getClbId());
	    
	    bbsUseDAO.deleteBBSUseInf(bdUseInf);
	}
    }

    /**
     * 커뮤니티에 사용되는 게시판 사용정보를 삭제한다.
     * 
     * @see egovframework.com.cop.com.service.EgovBBSUseInfoManageService#deleteBBSUseInfByCmmnty(egovframework.com.cop.com.service.BoardUseInf)
     */
    public void deleteBBSUseInfByCmmnty(BoardUseInfVO bdUseVO) throws Exception {
	List<BoardUseInf> result = bbsUseDAO.selectBBSUseInfByCmmnty(bdUseVO);
	
	BoardUseInf bdUseInf = null;
	Iterator<BoardUseInf> iter = result.iterator();
	
	while (iter.hasNext()) {
	    bdUseInf = (BoardUseInf)iter.next();
	    
	    bdUseInf.setLastUpdusrId(bdUseVO.getLastUpdusrId());
	    bdUseInf.setTrgetId(bdUseVO.getCmmntyId());
	    
	    bbsUseDAO.deleteBBSUseInf(bdUseInf);
	}
    }

    /**
     * 동호회에 사용되는 모든 게시판 사용정보를 삭제한다.
     * 
     * @see egovframework.com.cop.com.service.EgovBBSUseInfoManageService#deleteAllBBSUseInfByClub(egovframework.com.cop.com.service.BoardUseInfVO)
     */
    public void deleteAllBBSUseInfByClub(BoardUseInfVO bdUseVO) throws Exception {
	bbsUseDAO.deleteAllBBSUseInfByClub(bdUseVO);
    }

    /**
     * 커뮤니티에 사용되는 모든 게시판 사용정보를 삭제한다.
     * 
     * @see egovframework.com.cop.com.service.EgovBBSUseInfoManageService#deleteAllBBSUseInfByCmmnty(egovframework.com.cop.com.service.BoardUseInfVO)
     */
    public void deleteAllBBSUseInfByCmmnty(BoardUseInfVO bdUseVO) throws Exception {
	bbsUseDAO.deleteAllBBSUseInfByCmmnty(bdUseVO);
    }

    /**
     * 게시판에 대한 사용정보를 삭제한다.
     * 
     * @see egovframework.com.cop.com.service.EgovBBSUseInfoManageService#deleteBBSUseInfByBoardId(egovframework.com.cop.com.service.BoardUseInf)
     */
    public void deleteBBSUseInfByBoardId(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.deleteBBSUseInfByBoardId(bdUseInf);
    }

    /**
     * 커뮤니티, 동호회에 사용되는 게시판 사용정보에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cop.com.service.EgovBBSUseInfoManageService#selectBBSUseInfsByTrget(egovframework.com.cop.com.service.BoardUseInfVO)
     */
    public Map<String, Object> selectBBSUseInfsByTrget(BoardUseInfVO bdUseVO) throws Exception {
	List<BoardUseInfVO> result = bbsUseDAO.selectBBSUseInfsByTrget(bdUseVO);
	int cnt = bbsUseDAO.selectBBSUseInfsCntByTrget(bdUseVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 커뮤니티, 동호회에 사용되는 게시판 사용정보를 수정한다.
     */
    public void updateBBSUseInfByTrget(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.updateBBSUseInfByTrget(bdUseInf);
    }
}
