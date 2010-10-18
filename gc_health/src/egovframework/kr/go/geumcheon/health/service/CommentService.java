package egovframework.kr.go.geumcheon.health.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.com.cop.bbs.service.Board;
import egovframework.kr.go.geumcheon.health.dao.CommentDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("CommentService")
public class CommentService {
	
	@Resource(name = "CommentDAO")
    private CommentDAO commentDAO;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    Logger log = Logger.getLogger(this.getClass());
	
	/**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @see egovframework.com.cop.bbs.CommentService.service.CommentService#selectBoardArticles(egovframework.com.cop.bbs.CommentDto.service.CommentDto)
     */
    public Map<String, Object> selectCommentList(ZValue zvl) throws Exception {
		List<ZValue> result = commentDAO.selectCommentList(zvl);
		
		int cnt = commentDAO.selectCommentListCnt(zvl);
		
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

    public List<ZValue> selectCommentListA(ZValue zvl) throws Exception {
		List<ZValue> result = commentDAO.selectCommentList(zvl);	
		return result;
    }
    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#insertBoardArticle(egovframework.com.cop.bbs.PininfoVO.service.Board)
     */
    public boolean insertCommentArticle(ZValue zvl) throws Exception {
	// SORT_ORDR는 부모글의 소트 오더와 같게, NTT_NO는 순서대로 부여
    	
    	return commentDAO.insertCommentArticle(zvl);
    }
    
    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#deleteBoardArticle(egovframework.com.cop.bbs.PininfoVO.service.Board)
     */
    public void deleteCommentArticle(ZValue zvl) throws Exception {
    	commentDAO.deleteCommentArticle(zvl);
    }
    
    /**
     * 댓글의 등록상태를 변경한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#deleteBoardArticle(egovframework.com.cop.bbs.PininfoVO.service.Board)
     */
    /*public int updateCommentState(CommentDto dto) throws Exception {
    	return commentDAO.updateCommentState(dto);
    }*/
    
    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#deleteBoardArticle(egovframework.com.cop.bbs.PininfoVO.service.Board)
     */
    /*public void deleteCommentArticleForAdmin(CommentDto dto) throws Exception {
    	commentDAO.deleteCommentArticleForAdmin(dto);
    }*/
	
}
