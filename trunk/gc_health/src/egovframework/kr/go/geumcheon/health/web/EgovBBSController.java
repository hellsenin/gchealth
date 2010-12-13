package egovframework.kr.go.geumcheon.health.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.kr.go.geumcheon.health.service.CommentService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller 
public class EgovBBSController {

    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;

    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name="webFactory")
    protected WebFactory WebFactory;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name="pageUtil")
	private PageUtil PageUtil;

	@Resource(name="CommentService")
	private CommentService commentService;
	
    Logger log = Logger.getLogger(this.getClass());
    
    /**
     * XSS 방지 처리.
     * 
     * @param data
     * @return
     */
    protected String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }
        
        String ret = data;
        
        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
        
        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
        
        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
        
        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        
        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

        return ret;
    }

    /**
     * 게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/bbs/selectBoardList.do")
    public String selectBoardArticles(
    		@ModelAttribute("searchVO") BoardVO boardVO, 
    		HttpServletRequest request, 
    		HttpServletResponse response, 
			ModelMap model) throws Exception {
	    //LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	
		//log.debug(this.getClass().getName() + " user.getId() "+ user.getId());
		//log.debug(this.getClass().getName() + " user.getName() "+ user.getName());
		//log.debug(this.getClass().getName() + " user.getUniqId() "+ user.getUniqId());
		//log.debug(this.getClass().getName() + " user.getOrgnztId() "+ user.getOrgnztId());
		//log.debug(this.getClass().getName() + " user.getUserSe() "+ user.getUserSe());
		//log.debug(this.getClass().getName() + " user.getEmail() "+ user.getEmail());
	
		//String attrbFlag = "";
    	if(boardVO.getBbsId().equals("BBSMSTR_000000001158")){
			HttpSession session = request.getSession();
			Company company = (Company)session.getAttribute("company");
			  
			String backwardPage = "/health/freecheck/loginPage.do?categoryId=2583";
			if(company == null){
				WebFactory.printHtml(response, (String)model.get("message"), backwardPage);
				return null;
			}
    	}  
    	  
		boardVO.setBbsId(boardVO.getBbsId());
		boardVO.setBbsNm(boardVO.getBbsNm());
	
		BoardMasterVO vo = new BoardMasterVO();
		
		vo.setBbsId(boardVO.getBbsId());
		vo.setUniqId("USRCNFRM_00000000000");
		
		BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
		
		//-------------------------------
		// 방명록이면 방명록 URL로 forward
		//-------------------------------
		if (master.getBbsTyCode().equals("BBST04")) {
		    return "forward:/health/bbs/selectGuestList.do";
		}
		////-----------------------------
	
		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
		boardVO.setPageSize(propertyService.getInt("pageSize"));
		
		int pageUnit = propertyService.getInt("pageUnit");
		int pageSize = propertyService.getInt("pageSize");
		int pageIndex = boardVO.getPageIndex();
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		if(master.getReplyPosblAt().equals("Y")){
			boardVO.setType("2");
		}else if(boardVO.getBbsId().equals("BBSMSTR_000000000271")){
			boardVO.setHealth("Y");
		}else if(boardVO.getBbsId().equals("BBSMSTR_000000000991")){
			boardVO.setType("1");
		}else{
			boardVO.setType("9");
		}
		
		//if(boardVO.getBbsId().equals("BBSMSTR_000000000271")) boardVO.setType("health");
		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		int totalPage = (totCnt - 1) / pageSize + 1;
		
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("brdMstrVO", master);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("includePage", "/health/dev_content/bbs/"+boardVO.getBbsId()+"/List.jsp");
		
		String pagenation = PageUtil.getJnPageNavString(boardVO.getPageSize(), totCnt, 
				boardVO.getPageIndex(), "/health/bbs/selectBoardList.do?bbsId="+boardVO.getBbsId()+"&amp;menuId="+boardVO.getMenuId()
				+ "&amp;searchCnd="+boardVO.getSearchCnd() + "&amp;searchWrd="+boardVO.getSearchWrd()
				+ "&amp;optionCndLike="+boardVO.getOptionCndLike()+"&amp;optionWrdLike="+boardVO.getOptionWrdLike());
		model.addAttribute("pagination", pagenation);
		
		String pageNav = PageUtil.getSgPageNavString(pageUnit, totCnt, pageIndex,
				"/health/bbs/selectBoardList.do?bbsId="+boardVO.getBbsId()+"&amp;categoryId="+boardVO.getCategoryId()
				+ "&amp;searchCnd="+boardVO.getSearchCnd() + "&amp;searchWrd="+boardVO.getSearchWrd()
				+ "&amp;optionCnd="+boardVO.getOptionCnd() + "&amp;optionWrd="+boardVO.getOptionWrd()
				+ "&amp;optionCnd2="+boardVO.getOptionCnd2() + "&amp;optionWrd2="+boardVO.getOptionWrd2()
				+ "&amp;optionCndLike="+boardVO.getOptionCndLike() + "&amp;optionWrdLike="+boardVO.getOptionWrdLike());
		
		model.addAttribute("pageNav", pageNav);
		
		return Globals.HEALTH_MAIN_PAGE;
    }

    /**
     * 게시물에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/bbs/selectBoardArticle.do")
    public String selectBoardArticle(HttpServletRequest request, HttpServletResponse response,@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {

    	UsersVO user = WebFactory.getUserInfo(request);
    	
    	if(user == null){
    		user = new UsersVO();
    	}
    	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	// 조회수 증가 여부 지정
	boardVO.setPlusCount(true);

	boardVO.setLastUpdusrId(user.getWebMemId());
	BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

	model.addAttribute("result", vo);
	//CommandMap의 형태로 개선????   

	model.addAttribute("sessionUniqId", user.getWebMemId());

	//----------------------------
	// template 처리 (기본 BBS template 지정  포함)
	//----------------------------
	BoardMasterVO master = new BoardMasterVO();
	
	master.setBbsId(boardVO.getBbsId());
	master.setUniqId(user.getWebMemId());
	
	BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);

	model.addAttribute("brdMstrVO", masterVo);
	
	////-----------------------------

	if(boardVO.getBbsId().equals("BBSMSTR_000000001158")){
		ZValue zvl = WebFactory.getAttributes(request);
		log.debug(">>>>>>>>>>>..zvl : " + zvl);
		List<ZValue> commentList = commentService.selectCommentListA(zvl);
		model.addAttribute("commentList", commentList);
	}  

	model.addAttribute("includePage", "/health/dev_content/bbs/"+boardVO.getBbsId()+"/Read.jsp");
	return Globals.HEALTH_MAIN_PAGE;	
    }

    /**
     * 게시물 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/bbs/addBoardArticle.do")
    public String addBoardArticle(HttpServletRequest request, HttpServletResponse response,@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	UsersVO	user = WebFactory.getUserInfo(request);
    	
    	if(!boardVO.getBbsId().equals("BBSMSTR_000000001158")){
			if(user == null){
				WebFactory.setForwardPage(request, response);
				return null;
			}	
    	}
	
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    Boolean isAuthenticated = true;
    
	BoardMasterVO bdMstr = new BoardMasterVO();

	if (isAuthenticated) {

	    BoardMasterVO vo = new BoardMasterVO();
	    vo.setBbsId(boardVO.getBbsId());
	    vo.setUniqId("USRCNFRM_00000000000");

	    bdMstr = bbsAttrbService.selectBBSMasterInf(vo);
	    model.addAttribute("bdMstr", bdMstr);
	}
	
	model.addAttribute("user", user);
	model.addAttribute("brdMstrVO", bdMstr);
	////-----------------------------

	model.addAttribute("includePage", "/health/dev_content/bbs/"+boardVO.getBbsId()+"/Reg.jsp");
	return Globals.HEALTH_MAIN_PAGE;	

    }

    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/health/bbs/insertBoardArticle.do")
    public String insertBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, SessionStatus status,
	    ModelMap model) throws Exception {

    	if("BBSMSTR_000000001158".equals(board.getBbsId()))
    	{
    		Company company = WebFactory.getCompanyInfo(multiRequest);
    	    board.setFrstRegisterId(company.getId());
    	    board.setPassword(company.getPasswd());
    	}
    	else
    	{	
    		UsersVO user = WebFactory.getUserInfo(multiRequest);
    	    board.setFrstRegisterId(user.getWebMemId());
    	    board.setPassword(user.getPin());
    	}
    	
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    Boolean isAuthenticated = true;

//	beanValidator.validate(board, bindingResult);
//	if (bindingResult.hasErrors()) {
//
//	    BoardMasterVO master = new BoardMasterVO();
//	    BoardMasterVO vo = new BoardMasterVO();
//	    
//	    vo.setBbsId(boardVO.getBbsId());
//	    vo.setUniqId("USRCNFRM_00000000000");
//
//	    master = bbsAttrbService.selectBBSMasterInf(vo);
//	    
//	    model.addAttribute("bdMstr", master);
//
//	    //----------------------------
//	    // 기본 BBS template 지정 
//	    //----------------------------
//	    if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
//		master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
//	    }
//
//	    model.addAttribute("brdMstrVO", master);
//	    ////-----------------------------
//	    
//	    model.addAttribute("includePage", "/health/dev_content/bbs/"+boardVO.getBbsId()+"/Reg.jsp");
//		return Globals.HEALTH_MAIN_PAGE;	
//
//	}
	
	if (isAuthenticated) {
		
	    List<FileVO> result = null;
	    String atchFileId = "";
	    
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
		result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
		atchFileId = fileMngService.insertFileInfs(result);
	    }
	    board.setAtchFileId(atchFileId);
	    board.setBbsId(board.getBbsId());
	    	    
	    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
	    
	    board.setPinNo("TEST1");

	    /*int pinCnt = pininfoService.selectPininfoCount(board);
	    
	    if(!board.getPinName().equals("")){
		    if(pinCnt == 0){
		    	pininfoService.insertPininfoArticle(board);
		    } else {
		    	pininfoService.updatePininfoArticle(board);
		    }
	    }*/
	    
	    bbsMngService.insertBoardArticle(board);
	}

	//status.setComplete();
	return "forward:/health/bbs/selectBoardList.do";
    }

    /**
     * 게시물에 대한 답변 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/bbs/addReplyBoardArticle.do")
    public String addReplyBoardArticle(HttpServletRequest request, HttpServletResponse response,@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	UsersVO	user = WebFactory.getUserInfo(request);
    	if(user == null){
    		WebFactory.setForwardPage(request, response);
    		return null;
    	}

	BoardMasterVO master = new BoardMasterVO();
	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	vo.setUniqId(user.getWebMemId());

	master = bbsAttrbService.selectBBSMasterInf(vo);
	
	model.addAttribute("bdMstr", master);
	model.addAttribute("result", boardVO);

	model.addAttribute("brdMstrVO", master);
	////-----------------------------
	
	model.addAttribute("includePage", "/health/dev_content/bbs/"+boardVO.getBbsId()+"/Reply.jsp");
	return Globals.HEALTH_MAIN_PAGE;	

    }

    /**
     * 게시물에 대한 답변을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/health/bbs/replyBoardArticle.do")
    public String replyBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status) throws Exception {

    	UsersVO user = WebFactory.getUserInfo(multiRequest);
    	
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    Boolean isAuthenticated = true;
	
	beanValidator.validate(board, bindingResult);
	if (bindingResult.hasErrors()) {
	    BoardMasterVO master = new BoardMasterVO();
	    BoardMasterVO vo = new BoardMasterVO();
	    
	    vo.setBbsId(boardVO.getBbsId());
	    vo.setUniqId(user.getWebMemId());

	    master = bbsAttrbService.selectBBSMasterInf(vo);
	    
	    model.addAttribute("bdMstr", master);
	    model.addAttribute("result", boardVO);

	    model.addAttribute("brdMstrVO", master);
	    ////-----------------------------

	    model.addAttribute("includePage", "/health/dev_content/bbs/"+boardVO.getBbsId()+"/Reply.jsp");
		return Globals.HEALTH_MAIN_PAGE;	
	}

	if (isAuthenticated) {
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    String atchFileId = "";

	    if (!files.isEmpty()) {
		List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
		atchFileId = fileMngService.insertFileInfs(result);
	    }

	    board.setAtchFileId(atchFileId);
	    board.setReplyAt("Y");
	    board.setFrstRegisterId(user.getWebMemId());
	    board.setBbsId(board.getBbsId());
	    board.setParnts(Long.toString(boardVO.getNttId()));
	    board.setSortOrdr(boardVO.getSortOrdr());
	    board.setReplyLc(Integer.toString(Integer.parseInt(boardVO.getReplyLc()) + 1));
	    
	    board.setPassword(user.getPin());	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
	    
	    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
	    
	    bbsMngService.insertBoardArticle(board);
	}
	
	return "forward:/health/bbs/selectBoardList.do";
    }

    /**
     * 게시물 수정을 위한 수정페이지로 이동한다.
     * 
     * @param boardVO
     * @param vo
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/bbs/forUpdateBoardArticle.do")
    public String selectBoardArticleForUpdt(HttpServletRequest request, HttpServletResponse response,@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") BoardVO vo, ModelMap model)
	    throws Exception {

    	String id = null;
    	String passwd = null;
    	//의약업소나눔센터
    	if("BBSMSTR_000000001158".equals(boardVO.getBbsId()))
    	{
    		Company company = WebFactory.getCompanyInfo(request);
    		id = company.getId();
    		passwd = company.getPasswd();
    	}
    	else
    	{	
    		UsersVO user = WebFactory.getUserInfo(request);
    		id = user.getWebMemId();
    		passwd = user.getPin();
    	}
	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getNttId "+boardVO.getNttId());
	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getBbsId "+boardVO.getBbsId());

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    Boolean isAuthenticated = true;

	boardVO.setFrstRegisterId(id);
	
	BoardMaster master = new BoardMaster();
	BoardMasterVO bmvo = new BoardMasterVO();
	BoardVO bdvo = new BoardVO();
	//PininfoVO pin = new PininfoVO();
	
	vo.setBbsId(boardVO.getBbsId());
	
	master.setBbsId(boardVO.getBbsId());
	master.setUniqId(id);
    //pin.setPinNo("TEST1");
    
	if (isAuthenticated) {
	    bmvo = bbsAttrbService.selectBBSMasterInf(master);
	    bdvo = bbsMngService.selectBoardArticle(boardVO);
	    
	    //pin = pininfoService.selectPininfoDetail(pin);
	    
		model.addAttribute("brdMstrVO", bmvo);
	}

	model.addAttribute("result", bdvo);
	//model.addAttribute("pininfo", pin);
	model.addAttribute("bdMstr", bmvo);

	//----------------------------
	// 기본 BBS template 지정 
	//----------------------------
	if (bmvo.getTmplatCours() == null || bmvo.getTmplatCours().equals("")) {
	    bmvo.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	////-----------------------------
	
	model.addAttribute("includePage", "/health/dev_content/bbs/"+boardVO.getBbsId()+"/Update.jsp");
	return Globals.HEALTH_MAIN_PAGE;	
    }

    /**
     * 게시물에 대한 내용을 수정한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/health/bbs/updateBoardArticle.do")
    public String updateBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status) throws Exception {

    	String id = null;
    	String passwd = null;
    	//의약업소나눔센터
    	if("BBSMSTR_000000001158".equals(boardVO.getBbsId()))
    	{
    		Company company = WebFactory.getCompanyInfo(multiRequest);
    		id = company.getId();
    		passwd = company.getPasswd();
    	}
    	else
    	{	
    		UsersVO user = WebFactory.getUserInfo(multiRequest);
    		id = user.getWebMemId();
    		passwd = user.getPin();
    	}
		//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    Boolean isAuthenticated = true;
	
		String atchFileId = boardVO.getAtchFileId();

//	beanValidator.validate(board, bindingResult);
//	if (bindingResult.hasErrors()) {
//
//	    boardVO.setFrstRegisterId("USRCNFRM_00000000000");
//	    
//	    BoardMaster master = new BoardMaster();
//	    BoardMasterVO bmvo = new BoardMasterVO();
//	    BoardVO bdvo = new BoardVO();
//	    
//	    master.setBbsId(boardVO.getBbsId());
//	    master.setUniqId("USRCNFRM_00000000000");
//
//	    bmvo = bbsAttrbService.selectBBSMasterInf(master);
//	    bdvo = bbsMngService.selectBoardArticle(boardVO);
//
//	    model.addAttribute("result", bdvo);
//	    model.addAttribute("bdMstr", bmvo);
//
//	    model.addAttribute("includePage", "/health/dev_content/bbs/"+boardVO.getBbsId()+"/Update.jsp");
//		return Globals.HEALTH_MAIN_PAGE;	
//	}
	
	/*
	boardVO.setFrstRegisterId(user.getUniqId());
	BoardMaster _bdMstr = new BoardMaster();
	BoardMasterVO bmvo = new BoardMasterVO();
	BoardVO bdvo = new BoardVO();
	vo.setBbsId(boardVO.getBbsId());
	_bdMstr.setBbsId(boardVO.getBbsId());
	_bdMstr.setUniqId(user.getUniqId());

	if (isAuthenticated) {
	    bmvo = bbsAttrbService.selectBBSMasterInf(_bdMstr);
	    bdvo = bbsMngService.selectBoardArticle(boardVO);
	}
	//*/

	if (isAuthenticated) {
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
		if ("".equals(atchFileId)) {
		    List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
		    atchFileId = fileMngService.insertFileInfs(result);
		    board.setAtchFileId(atchFileId);
		} else {
		    FileVO fvo = new FileVO();
		    fvo.setAtchFileId(atchFileId);
		    int cnt = fileMngService.getMaxFileSN(fvo);
		    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
		    fileMngService.updateFileInfs(_result);
		}
	    }

	    board.setLastUpdusrId(id);
	    
	    board.setPassword(passwd);	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
	    
	    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
	    
	    board.setPinNo("TEST1");
	    board.setPinEmail("TEST1@test.com");
	    
	    //pininfoService.updatePininfoArticle(board);
	    
	    bbsMngService.updateBoardArticle(board);
	}
	
	return "forward:/health/bbs/selectBoardList.do";
    }

    /**
     * 게시물에 대한 내용을 삭제한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/bbs/deleteBoardArticle.do")
    public String deleteBoardArticle(HttpServletRequest request, HttpServletResponse response,@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, ModelMap model) throws Exception {

    	String id = null;
    	String passwd = null;
    	//의약업소나눔센터
    	if("BBSMSTR_000000001158".equals(boardVO.getBbsId()))
    	{
    		Company company = WebFactory.getCompanyInfo(request);
    		id = company.getId();
    		passwd = company.getPasswd();
    	}
    	else
    	{	
    		UsersVO user = WebFactory.getUserInfo(request);
    		id = user.getWebMemId();
    		passwd = user.getPin();
    	}
		//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    Boolean isAuthenticated = true;
	
		if (isAuthenticated) {
		    board.setLastUpdusrId(id);
		    
		    bbsMngService.deleteBoardArticle(board);
		}
	
		return "forward:/health/bbs/selectBoardList.do";
    }
    
    /*
     * 엑셀관련 추가 20101006
     */
    @RequestMapping("/health/bbs/forUploadExcel.do")
	public String forUploadExcel(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		return "admin/health/bbs/uploadExcel";
	}
    
    @RequestMapping("/health/bbs/uploadExcel.do")
	public void uploadExcel(
			MultipartHttpServletRequest multiRequest, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();

	    String msg = null;    	
    	if(bbsMngService.uploadCompanyExcel(files))
    	{
    		msg = "성공적으로 등록되었습니다.";
    	}
    	else 
    	{
    		msg = "등록에 실패하였습니다.";
    	}
		WebFactory.printHtml(response, msg, "/health/bbs/forUploadExcel.do");
	}
    
}
