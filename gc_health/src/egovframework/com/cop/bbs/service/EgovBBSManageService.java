package egovframework.com.cop.bbs.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;


/**
 * 게시물 관리를 위한 서비스 인터페이스  클래스
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
public interface EgovBBSManageService {

    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void deleteBoardArticle(Board Board) throws Exception;

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public long insertBoardArticle(Board Board) throws Exception;

    /**
     * 게시물 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception;

    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoardArticles(BoardVO boardVO, String attrbFlag) throws Exception;

    public Map<String, Object> selectMainBoardArticleList3(BoardVO boardVO, String attrbFlag) throws Exception;
    
    /**
     * 조건에 맞는 뉴스레터 최근글의 날짜를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public BoardVO selectBoardNewsArticle(BoardVO boardVO) throws Exception;
    
    /**
     * 조건에 맞는 뉴스레터 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoardNewsArticles(BoardVO boardVO) throws Exception;

    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void updateBoardArticle(Board Board) throws Exception;

    /**
     * 방명록에 대한 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectGuestList(BoardVO boardVO) throws Exception;

    /**
     * 방명록 내용을 삭제 한다.
     * 
     * @param boardVO
     * @throws Exception
     */
    public void deleteGuestList(BoardVO boardVO) throws Exception;

    /**
     * 방명록에 대한 패스워드를 조회 한다.
     * 
     * @param Board
     * @return
     * @throws Exception
     */
    public String getPasswordInf(Board Board) throws Exception;

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void insertBoardUserArticle(BoardUser boardUser) throws Exception;

    /**
     * 사진신청및 삭제요청 리스트
     * @param boardUser
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoardUserArticle(BoardUser boardUser) throws Exception;
    
    /**
     * EBOOK 게시물의 제목 목록
     * @param vo
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBBSTitleArticles(BoardVO vo) throws Exception;
    
    /**
     * EBook 리스트
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectEBookArticles(EBookVO ebookVO) throws Exception;
    
    /**
     * EBook 상세정보
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public EBookVO selectEBookArticle(EBookVO ebookVO) throws Exception;
    
    /**
     * EBook 상세정보 등록
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public int insertEBookArticle(EBookVO ebookVO) throws Exception;
    
    /**
     * EBook 상세정보 수정
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public void updateEBookArticle(EBookVO ebookVO) throws Exception;
    
    /**
     * EBook 상세정보 삭제
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public void deleteEBookArticle(EBookVO ebookVO) throws Exception;
    
    /**
     * EBook 첨부파일 정보조회
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public EBookFileVO selectEBookFileArticle(EBookFileVO fileDto) throws Exception;
    
    /**
     * EBook 첨부파일 등록
     * @param ebookVO
     * @return
     * @throws Exception
     */
    public void insertEBookFileArticle(EBookFileVO fileDto) throws Exception;
    
    /**
     * EBook 첨부파일 삭제
     * @param ebookVO 
     * @return
     * @throws Exception
     */
    public void deleteEBookFileArticle(EBookFileVO fileDto) throws Exception;
    
    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectMyBoardArticles(BoardVO boardVO) throws Exception;
    
    public boolean uploadCompanyExcel(Map<String, MultipartFile> files) throws Exception;
    
}
