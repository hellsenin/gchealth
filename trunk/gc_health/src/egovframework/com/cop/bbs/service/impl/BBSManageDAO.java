package egovframework.com.cop.bbs.service.impl;

import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardUser;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EBookFileVO;
import egovframework.com.cop.bbs.service.EBookVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 게시물 관리를 위한 데이터 접근 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Repository("BBSManageDAO")
public class BBSManageDAO extends EgovAbstractDAO {

	public  Log log = LogFactory.getLog(getClass()); 
	
    /**
     * 게시판에 게시물을 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public long insertBoardArticle(Board board) throws Exception {
		long nttId = (Long)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectMaxNttId");
		board.setNttId(nttId);
		board.setParnts(Long.toString(nttId));
		
		insert("BBSManageDAO.insertBoardArticle", board);
		
		return nttId;
    }

    /**
     * 게시판에 답변 게시물을 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public long replyBoardArticle(Board board) throws Exception {
	long nttId = (Long)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectMaxNttId");
	board.setNttId(nttId);
	
	insert("BBSManageDAO.replyBoardArticle", board);

	//----------------------------------------------------------
	// 현재 글 이후 게시물에 대한 NTT_NO를 증가 (정렬을 추가하기 위해)
	//----------------------------------------------------------
	//String parentId = board.getParnts();
	long nttNo = (Long)getSqlMapClientTemplate().queryForObject("BBSManageDAO.getParentNttNo", board);

	board.setNttNo(nttNo);
	update("BBSManageDAO.updateOtherNttNo", board);

	board.setNttNo(nttNo + 1);
	update("BBSManageDAO.updateNttNo", board);

	return nttId;
    }
	
    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
	return (BoardVO)selectByPk("BBSManageDAO.selectBoardArticle", boardVO);
    }

    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectBoardArticleList(BoardVO boardVO) throws Exception {
	return list("BBSManageDAO.selectBoardArticleList", boardVO);
    }

    @SuppressWarnings("unchecked")
    public List<BoardVO> selectMainBoardArticleList3(BoardVO boardVO) throws Exception {
	return list("BBSManageDAO.selectMainBoardArticleList3", boardVO);
    }

    /**
     * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectBoardArticleListCnt(BoardVO boardVO) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectBoardArticleListCnt", boardVO);
    }

    public int selectMainBoardArticleList3Cnt(BoardVO boardVO) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectMainBoardArticleList3Cnt", boardVO);
    }
    
    /**
     * 조건에 맞는 뉴스레터 최근글의 날짜를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public BoardVO selectBoardNewsArticle(BoardVO boardVO) throws Exception {
	return (BoardVO)selectByPk("BBSManageDAO.selectBoardNewsArticle", boardVO);
    }
    
    /**
     * 조건에 맞는 뉴스레터 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectBoardNewsArticleList(BoardVO boardVO) throws Exception {
	return list("BBSManageDAO.selectBoardNewsArticleList", boardVO);
    }

    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticle(Board board) throws Exception {
	update("BBSManageDAO.updateBoardArticle", board);
    }

    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void deleteBoardArticle(Board board) throws Exception {
	update("BBSManageDAO.deleteBoardArticle", board);
    }

    /**
     * 게시물에 대한 조회 건수를 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateInqireCo(BoardVO boardVO) throws Exception {
	update("BBSManageDAO.updateInqireCo", boardVO);
    }

    /**
     * 게시물에 대한 현재 조회 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectMaxInqireCo(BoardVO boardVO) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectMaxInqireCo", boardVO);
    }

    /**
     * 게시판에 대한 목록을 정렬 순서로 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectNoticeListForSort(Board board) throws Exception {
	return list("BBSManageDAO.selectNoticeListForSort", board);
    }

    /**
     * 게사판에 대한 정렬 순서를 수정 한다.
     * 
     * @param sortList
     * @throws Exception
     */
    public void updateSortOrder(List<BoardVO> sortList) throws Exception {
	BoardVO vo;
	Iterator<BoardVO> iter = sortList.iterator();
	while (iter.hasNext()) {
	    vo = (BoardVO)iter.next();
	    update("BBSManageDAO.updateSortOrder", vo);
	}
    }

    /**
     * 게시판에 대한 현재 게시물 번호의 최대값을 구한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public long selectNoticeItemForSort(Board board) throws Exception {
	return (Long)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectNoticeItemForSort", board);
    }

    /**
     * 방명록에 대한 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectGuestList(BoardVO boardVO) throws Exception {
	return list("BBSManageDAO.selectGuestList", boardVO);
    }

    /**
     * 방명록에 대한 목록 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectGuestListCnt(BoardVO boardVO) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectGuestListCnt", boardVO);
    }

    /**
     * 방명록 내용을 삭제 한다.
     * 
     * @param boardVO
     * @throws Exception
     */
    public void deleteGuestList(BoardVO boardVO) throws Exception {
	update("BBSManageDAO.deleteGuestList", boardVO);
    }

    /**
     * 방명록에 대한 패스워드를 조회 한다.
     * 
     * @param board
     * @return
     * @throws Exception
     */
    public String getPasswordInf(Board board) throws Exception {
	return (String)getSqlMapClientTemplate().queryForObject("BBSManageDAO.getPasswordInf", board);
    }
    
    /**
     * 게시판에 게시물을 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void insertBoardUserArticle(BoardUser boardUser) {
    	try{
			insert("BBSManageDAO.insertBoardUserArticle", boardUser);
		} catch (Exception ex) {
			if(log.isErrorEnabled()) {
				if(log.isErrorEnabled()) {	log.error("Insert Fail : ", ex);}
			}
		}		
    }
    
    /**
     * 사진신청및 삭제요청 리스트
     * @param boardUser
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectBoardUserArticle(BoardUser boardUser) throws Exception {
	return list("BBSManageDAO.selectBoardUserArticle", boardUser);
    }
    
    /**
     * EBOOK 게시물의 제목 목록
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectBBSTitleArticles(BoardVO vo) throws Exception {
	return list("BBSManageDAO.selectBBSTitleArticles", vo);
    }
    
    /**
     * EBook 게시물의 목록
     * @param ebookVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<EBookVO> selectEBookArticles(EBookVO ebookVO) throws Exception {
	return list("BBSManageDAO.selectEBookArticles", ebookVO);
    }
    
    /**
     * EBook 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
     * 
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public int selectEBookArticleListCnt(EBookVO ebookVO) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectEBookArticleListCnt", ebookVO);
    }
    
    /**
     * EBook 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public EBookVO selectEBookArticle(EBookVO ebookVO) throws Exception {
	return (EBookVO)selectByPk("BBSManageDAO.selectEBookArticle", ebookVO);
    }

    /**
     * EBook 게시물 한 건에 대하여 상세 내용을 등록한다.
     * 
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public int insertEBookArticle(EBookVO ebookVO) throws Exception {
	return (Integer)insert("BBSManageDAO.insertEBookArticle", ebookVO);
    }
    
    /**
     * EBook 게시물 한 건에 대하여 상세 내용을 수정한다.
     * 
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public void updateEBookArticle(EBookVO ebookVO) throws Exception {
    	update("BBSManageDAO.updateEBookArticle", ebookVO);
    }
    
    /**
     * EBook 게시물 한 건에 대하여 삭제한다.
     * 
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public void deleteEBookArticle(EBookVO ebookVO) throws Exception {
    	update("BBSManageDAO.deleteEBookArticle", ebookVO);
    }
    
    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public EBookFileVO selectEBookFileArticle(EBookFileVO fileDto) throws Exception {
	return (EBookFileVO)selectByPk("BBSManageDAO.selectEBookFileArticle", fileDto);
    }
    
    /**
     * EBook 첨부파일을 등록한다.
     * 
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public void insertEBookFileArticle(EBookFileVO fileDto) throws Exception {
    	insert("BBSManageDAO.insertEBookFileArticle", fileDto);
    }
    
    /**
     * EBook 첨부파일을 삭제한다.
     * 
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public void deleteEBookFileArticle(EBookFileVO fileDto) throws Exception {
    	delete("BBSManageDAO.deleteEBookFileArticle", fileDto);
    }
    
    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectMyBoardArticleList(BoardVO boardVO) throws Exception {
	return list("BBSManageDAO.selectMyBoardArticleList", boardVO);
    }
    
    /**
     * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectMyBoardArticleListCnt(BoardVO boardVO) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectMyBoardArticleListCnt", boardVO);
    }
    
}
