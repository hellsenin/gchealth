package egovframework.kr.go.geumcheon.health.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardUser;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EBookFileVO;
import egovframework.com.cop.bbs.service.EBookVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.utl.DateUtil;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
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
public class AdminEgovBBSManageController {

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
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

    @Resource(name = "webFactory")
    protected WebFactory WebFactory;

    @Autowired
    private DefaultBeanValidator beanValidator;

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
    @RequestMapping("/admin/bbs/selectBoardList.do")
    public String selectBoardArticles(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    //LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	//log.debug(this.getClass().getName() + " user.getId() "+ user.getId());
	//log.debug(this.getClass().getName() + " user.getName() "+ user.getName());
	//log.debug(this.getClass().getName() + " user.getUniqId() "+ user.getUniqId());
	//log.debug(this.getClass().getName() + " user.getOrgnztId() "+ user.getOrgnztId());
	//log.debug(this.getClass().getName() + " user.getUserSe() "+ user.getUserSe());
	//log.debug(this.getClass().getName() + " user.getEmail() "+ user.getEmail());

	//String attrbFlag = "";
    
	boardVO.setBbsId(boardVO.getBbsId());
	boardVO.setBbsNm(boardVO.getBbsNm());

	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	//vo.setUniqId(user.getId());
	
	BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	
	//-------------------------------
	// 방명록이면 방명록 URL로 forward
	//-------------------------------
	if (master.getBbsTyCode().equals("BBST04")) {
	    return "forward:/admin/bbs/selectGuestList.do";
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
	
	String deptCode = boardVO.getDept();
	String dongCode = boardVO.getDong();
	if(boardVO.getBbsId().equals("BBSMSTR_000000000471") || boardVO.getBbsId().equals("BBSMSTR_000000000263") || boardVO.getBbsId().equals("BBSMSTR_000000000405")){
		boardVO.setDept("");
	}
	if(boardVO.getBbsId().equals("BBSMSTR_000000000341") || boardVO.getBbsId().equals("BBSMSTR_000000000173") || boardVO.getBbsId().equals("BBSMSTR_000000000263") || boardVO.getBbsId().equals("BBSMSTR_000000000405")){
		boardVO.setDong("");
	}
	
	if(master.getReplyPosblAt().equals("Y")){
		boardVO.setType("2");
	}else if(boardVO.getBbsId().equals("BBSMSTR_000000000991")){
		boardVO.setType("1");
	}else{
		boardVO.setType("9");
	}
	
	
	
	Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	boardVO.setDong(dongCode);
	boardVO.setDept(deptCode);
	
	paginationInfo.setTotalRecordCount(totCnt);

	//-------------------------------
	// 기본 BBS template 지정 
	//-------------------------------
	if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
	    master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}
	////-----------------------------

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("brdMstrVO", master);
	model.addAttribute("paginationInfo", paginationInfo);
	
	String pageNav = PageUtil.getSgPageNavString(pageUnit, totCnt, pageIndex,
			"/admin/bbs/selectBoardList.do?bbsId="+boardVO.getBbsId()+"&amp;menuId="+boardVO.getMenuId()
			+ "&amp;searchCnd="+boardVO.getSearchCnd() + "&amp;searchWrd="+boardVO.getSearchWrd()
			+ "&amp;optionCnd="+boardVO.getOptionCnd() + "&amp;optionWrd="+boardVO.getOptionWrd()
			+ "&amp;optionCnd2="+boardVO.getOptionCnd2() + "&amp;optionWrd2="+boardVO.getOptionWrd2()
			+ "&amp;optionCndLike="+boardVO.getOptionCndLike() + "&amp;optionWrdLike="+boardVO.getOptionWrdLike());
	model.addAttribute("pageNav", pageNav); 
	
	return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/List";
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
    @RequestMapping("/admin/bbs/selectBoardArticle.do")
    public String selectBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	// 조회수 증가 여부 지정
	boardVO.setPlusCount(true);

	//boardVO.setLastUpdusrId(user.getId());
	BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

	model.addAttribute("result", vo);
	//CommandMap의 형태로 개선????

	//model.addAttribute("sessionUniqId", user.getId());

	//----------------------------
	// template 처리 (기본 BBS template 지정  포함)
	//----------------------------
	BoardMasterVO master = new BoardMasterVO();
	
	master.setBbsId(boardVO.getBbsId());
	//master.setUniqId(user.getId());
	
	BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);

	if (masterVo.getTmplatCours() == null || masterVo.getTmplatCours().equals("")) {
	    masterVo.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", masterVo);
	//model.addAttribute("user", user);

	return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/Read";
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
    @RequestMapping("/admin/bbs/addBoardArticle.do")
    public String addBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	BoardMasterVO bdMstr = new BoardMasterVO();
	
	DateUtil dateUtil = new DateUtil(); 

    BoardMasterVO vo = new BoardMasterVO();
    vo.setBbsId(boardVO.getBbsId());
    //vo.setUniqId(user.getId());

    bdMstr = bbsAttrbService.selectBBSMasterInf(vo);
    model.addAttribute("bdMstr", bdMstr);

	//----------------------------
	// 기본 BBS template 지정 
	//----------------------------
	if (bdMstr.getTmplatCours() == null || bdMstr.getTmplatCours().equals("")) {
	    bdMstr.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", bdMstr);
	//model.addAttribute("user", user);
	model.addAttribute("dateUtil", dateUtil);
	////-----------------------------

	return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/Reg";
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
    @RequestMapping("/admin/bbs/insertBoardArticle.do")
    public String insertBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, SessionStatus status,
	    ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

    ZValue zvl = WebFactory.getAttributes(multiRequest);
    log.debug(">>>>>>>>>>>>.zvl " + zvl);
	String srcLocalPath = multiRequest.getParameter("srclocalpath");
	String urlRefer = "forward:/admin/bbs/selectBoardList.do?optionCnd="+zvl.getString("optionCnd")+"&optionWrd="+zvl.getString("optionCnd");
	
	//beanValidator.validate(board, bindingResult);
	
	
	boardVO.setBbsId(boardVO.getBbsId());
	boardVO.setBbsNm(boardVO.getBbsNm());

	BoardMasterVO masterVO = new BoardMasterVO();
	
	masterVO.setBbsId(boardVO.getBbsId());
	//masterVO.setUniqId(user.getId());
	
	BoardMasterVO masterInfo = bbsAttrbService.selectBBSMasterInf(masterVO);
	
	if (bindingResult.hasErrors()) {

	    BoardMasterVO master = new BoardMasterVO();
	    BoardMasterVO vo = new BoardMasterVO();
	    
	    vo.setBbsId(boardVO.getBbsId());
	    //vo.setUniqId(user.getId());

	    master = bbsAttrbService.selectBBSMasterInf(vo);
	    
	    model.addAttribute("bdMstr", master);
	    model.addAttribute("brdMstrVO", master);
	    ////-----------------------------

	    return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/Reg";
	}
	
	List<FileVO> result = null;
    String atchFileId = "";
    
    final Map<String, MultipartFile> files = multiRequest.getFileMap();
    if (!files.isEmpty()) {
    String storePathString = boardVO.getBbsId()+"/";
	result = fileUtil.parseFileInf(files, "BBS_", 0, "", storePathString);
	atchFileId = fileMngService.insertFileInfs(result);
    }
    board.setAtchFileId(atchFileId);
    //board.setFrstRegisterId(user.getId());
    board.setBbsId(board.getBbsId());
    
    //board.setNtcrNm(user.getName());	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
    
    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
    
    long nttId = bbsMngService.insertBoardArticle(board);
	if(bdMstr.getBbsTyCode().equals("BBST05")){
		return "redirect:http://210.99.170.223/Trans/Engine.aspx?title=&srclocalpath=" + srcLocalPath + "&wm=C:\\inetpub\\wwwroot\\Trans\\wm.jpg&twm=C:\\inetpub\\wwwroot\\Trans\\twm.jpg&resulturl=http://www.jongno.go.kr/admin/bbs/updateUccArticle.do?bbsQu="+boardVO.getBbsId()+"/"+nttId+"/"+board.getFileNm()+"/ucc&bu=http://www.jongno.go.kr/admin/bbs/selectBoardList.do?bbsId="+boardVO.getBbsId();
    }

	//status.setComplete();

	return urlRefer;
    } 

    /**
     * 구청 게시판과 연계
     * @param multiRequest
     * @param boardVO
     * @param bdMstr
     * @param board
     * @param bindingResult
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/bbs/insertBoardArticle2.do")
    public void insertBoardArticle2(
    		final MultipartHttpServletRequest multiRequest,
    		HttpServletResponse response,
    		ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

    ZValue zvl = WebFactory.getAttributes(multiRequest);
    log.debug(">>>>>>>>>>>>.zvl " + zvl);
    
	//beanValidator.validate(board, bindingResult);
    BoardVO board = new BoardVO();
	String communityKey = zvl.getString("communityKey");
	String bbsId = null;
	if("B0034".equals(communityKey))
	{
		bbsId = "BBSMSTR_000000001151";
		board.setBbsId(bbsId);
		board.setBbsAttrbCode("BBSA03");
		board.setBbsTyCode("BBST03");
		board.setReplyPosblAt("N");
		board.setFileAtchPosblAt("Y");
		board.setPosblAtchFileNumber(0);
		board.setSecret("N");
		
		board.setNttSj(zvl.getString("title"));
		board.setOption1(zvl.getString("position"));
		board.setNttCn(zvl.getString("contents"));
		
	}
	
	List<FileVO> result = null;
    String atchFileId = "";
    
    final Map<String, MultipartFile> files = multiRequest.getFileMap();
    if (!files.isEmpty()) {
    String storePathString = bbsId+"/";
	result = fileUtil.parseFileInf(files, "BBS_", 0, "", storePathString);
	atchFileId = fileMngService.insertFileInfs(result);
    }
    board.setAtchFileId(atchFileId);
    //board.setFrstRegisterId(user.getId());
    board.setBbsId(board.getBbsId());
    
    //board.setNtcrNm(user.getName());	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
    
    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
    
    String event = "success.insert.msg";
    String msg = "성공적으로 등록되었습니다.";
    try
    {
    	bbsMngService.insertBoardArticle(board);
    }catch(Exception e)
    {
    	event = "error.insert.msg";
    	msg = "등록에 실패하였습니다.";
    }

	model.addAttribute("event", event);
	WebFactory.printHtml(response, msg, "javascript:history.back()");
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
    @RequestMapping("/admin/bbs/addReplyBoardArticle.do")
    public String addReplyBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	BoardMasterVO master = new BoardMasterVO();
	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	//vo.setUniqId(user.getId());

	master = bbsAttrbService.selectBBSMasterInf(vo);
	
	model.addAttribute("bdMstr", master);
	model.addAttribute("result", boardVO);

	//----------------------------
	// 기본 BBS template 지정 
	//----------------------------
	if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
	    master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", master);
	////-----------------------------

	return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/Reply";
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
    @RequestMapping("/admin/bbs/replyBoardArticle.do")
    public String replyBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status) throws Exception {

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
	beanValidator.validate(board, bindingResult);
	if (bindingResult.hasErrors()) {
	    BoardMasterVO master = new BoardMasterVO();
	    BoardMasterVO vo = new BoardMasterVO();
	    
	    vo.setBbsId(boardVO.getBbsId());
	    //vo.setUniqId(user.getId());

	    master = bbsAttrbService.selectBBSMasterInf(vo);
	    
	    model.addAttribute("bdMstr", master);
	    model.addAttribute("result", boardVO);

	    //----------------------------
	    // 기본 BBS template 지정 
	    //----------------------------
	    if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
		master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	    }

	    model.addAttribute("brdMstrVO", master);
	    ////-----------------------------

	    return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/Reply";
	}

	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    String atchFileId = "";

	    if (!files.isEmpty()) {
		List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
		atchFileId = fileMngService.insertFileInfs(result);
	    }

	    board.setAtchFileId(atchFileId);
	    board.setReplyAt("Y");
	    //board.setFrstRegisterId(user.getId());
	    board.setBbsId(board.getBbsId());
	    board.setParnts(Long.toString(boardVO.getNttId()));
	    board.setSortOrdr(boardVO.getSortOrdr());
	    board.setReplyLc(Integer.toString(Integer.parseInt(boardVO.getReplyLc()) + 1));
	    
	    board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
	    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
	    
	    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
	    
	    bbsMngService.insertBoardArticle(board);
	
	return "forward:/admin/bbs/selectBoardList.do";
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
    @RequestMapping("/admin/bbs/forUpdateBoardArticle.do")
    public String selectBoardArticleForUpdt(
    		@ModelAttribute("searchVO") BoardVO boardVO, 
    		@ModelAttribute("board") BoardVO vo, ModelMap model)
	    throws Exception {

	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getNttId "+boardVO.getNttId());
	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getBbsId "+boardVO.getBbsId());

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	DateUtil dateUtil = new DateUtil(); 
	//boardVO.setFrstRegisterId(user.getId());
	
	BoardMaster master = new BoardMaster();
	BoardMasterVO bmvo = new BoardMasterVO();
	BoardVO bdvo = new BoardVO();
	
	vo.setBbsId(boardVO.getBbsId());
	
	master.setBbsId(boardVO.getBbsId());
	//master.setUniqId(user.getId());

	    bmvo = bbsAttrbService.selectBBSMasterInf(master);
	    bdvo = bbsMngService.selectBoardArticle(boardVO);

	model.addAttribute("result", bdvo);
	model.addAttribute("bdMstr", bmvo);
	model.addAttribute("dateUtil", dateUtil);

	model.addAttribute("brdMstrVO", bmvo);
	////-----------------------------
	
	return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/Update";
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
    @RequestMapping("/admin/bbs/updateBoardArticle.do")
    public String updateBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status) throws Exception {

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	String srcLocalPath = multiRequest.getParameter("srclocalpath");
	String atchFileId = boardVO.getAtchFileId();
    ZValue zvl = WebFactory.getAttributes(multiRequest);
	String urlRefer = "forward:/admin/bbs/selectBoardList.do?optionCnd="+zvl.getString("optionCnd")+"&optionWrd="+zvl.getString("optionCnd");
	
		
	BoardMasterVO masterVO = new BoardMasterVO();
	
	masterVO.setBbsId(boardVO.getBbsId());
	//masterVO.setUniqId(user.getId());
	
	BoardMasterVO masterInfo = bbsAttrbService.selectBBSMasterInf(masterVO);
	
	if (bindingResult.hasErrors()) {

	    //boardVO.setFrstRegisterId(user.getId());
	    
	    BoardMaster master = new BoardMaster();
	    BoardMasterVO bmvo = new BoardMasterVO();
	    BoardVO bdvo = new BoardVO();
	    
	    master.setBbsId(boardVO.getBbsId());
	    //master.setUniqId(user.getId());

	    bmvo = bbsAttrbService.selectBBSMasterInf(master);
	    bdvo = bbsMngService.selectBoardArticle(boardVO);

	    model.addAttribute("result", bdvo);
	    model.addAttribute("bdMstr", bmvo);

	    return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/Update";
	}
	
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
	String storePathString = "";

		if(bdMstr.getBbsTyCode().equals("BBST05")){
		    //board.setLastUpdusrId(user.getId());
		    
		    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    
		    bbsMngService.updateBoardArticle(board);			
			return "redirect:http://210.99.170.223/Trans/Engine.aspx?title=&srclocalpath=" + srcLocalPath + "&wm=C:\\inetpub\\wwwroot\\Trans\\wm.jpg&twm=C:\\inetpub\\wwwroot\\Trans\\twm.jpg&resulturl=http://www.jongno.go.kr/admin/bbs/updateUccArticle.do?bbsQu="+boardVO.getBbsId()+"/"+board.getNttId()+"/"+board.getFileNm()+"/ucc&bu=http://www.jongno.go.kr/admin/bbs/selectBoardList.do?bbsId="+boardVO.getBbsId();
	    }
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    if (!files.isEmpty()) {
			if ("".equals(atchFileId)) {
				storePathString = boardVO.getBbsId()+"/";
			    List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, storePathString);
			    atchFileId = fileMngService.insertFileInfs(result);
			    board.setAtchFileId(atchFileId);
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(atchFileId);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    storePathString = boardVO.getBbsId()+"/";
			    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, storePathString);
			    fileMngService.updateFileInfs(_result);
			}
			
	    }

	    //board.setLastUpdusrId(user.getId());
	    
	    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
	    
	    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
	    
	    bbsMngService.updateBoardArticle(board);
	
	return urlRefer;
    }
    
    /**
     * UCC 파일을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/bbs/updateUccArticle.do")
    public void updateUccFile(HttpServletRequest request, HttpServletResponse response, ModelMap model,
	    SessionStatus status) throws Exception {

    String bbsQu = request.getParameter("bbsQu");

    String [] bbsParam = bbsQu.split("/");
    String [] bbsParam2 = bbsQu.split("[?]seq=");
	
    String files = bbsParam2[1];
    String cok = request.getParameter("cok");
    String atchFileId = "";

    BoardVO boardVO = new BoardVO();
    boardVO.setBbsId(bbsParam[0]);
    boardVO.setNttId(Long.parseLong(bbsParam[1]));
    Board board = bbsMngService.selectBoardArticle(boardVO);
    
    if (cok.equals("y")) {
    	 if(request.getParameter("tp") != ""){
			    List<FileVO> result = fileUtil.parseUccFileInf(files, "BBS_", 0, atchFileId, bbsParam[2], request.getParameter("tp"));
			    atchFileId = fileMngService.insertFileInfs(result);
			    board.setAtchFileId(atchFileId);
    	 }
    }

    board.setBbsId(bbsParam[0]);
    board.setNttId(Long.parseLong(bbsParam[1]));
    
    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
    
    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
    
    bbsMngService.updateBoardArticle(board);
	
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
    @RequestMapping("/admin/bbs/deleteBoardArticle.do")
    public String deleteBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, ModelMap model) throws Exception {
	
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	    //board.setLastUpdusrId(user.getId());
	    
	    bbsMngService.deleteBoardArticle(board);

	return "forward:/admin/bbs/selectBoardList.do";
    }

    /**
     * 방명록에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectGuestList.do")
    public String selectGuestList(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//@SuppressWarnings("unused")
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
	// 수정 및 삭제 기능 제어를 위한 처리
	//model.addAttribute("sessionUniqId", user.getId());
	
	BoardVO vo = new BoardVO();

	vo.setBbsId(boardVO.getBbsId());
	vo.setBbsNm(boardVO.getBbsNm());
	//vo.setNtcrNm(user.getName());
	//vo.setNtcrId(user.getId());

	BoardMasterVO masterVo = new BoardMasterVO();
	
	masterVo.setBbsId(vo.getBbsId());
	//masterVo.setUniqId(user.getId());
	
	BoardMasterVO mstrVO = bbsAttrbService.selectBBSMasterInf(masterVo);

	vo.setPageUnit(propertyService.getInt("pageUnit"));
	vo.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	paginationInfo.setCurrentPageNo(vo.getPageIndex());
	paginationInfo.setRecordCountPerPage(vo.getPageUnit());
	paginationInfo.setPageSize(vo.getPageSize());

	vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
	vo.setLastIndex(paginationInfo.getLastRecordIndex());
	vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsMngService.selectGuestList(vo);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("brdMstrVO", mstrVO);
	model.addAttribute("boardVO", vo);
	model.addAttribute("paginationInfo", paginationInfo);

	return "admin/share/system/uni_bbs/EgovGuestList";
    }

    /**
     * 방명록 수정을 위한 특정 내용을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectSingleGuestList.do")
    public String selectSingleGuestList(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("brdMstrVO") BoardMasterVO brdMstrVO,
	    ModelMap model) throws Exception {

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//@SuppressWarnings("unused")
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

	boardVO.setBbsId(boardVO.getBbsId());
	boardVO.setBbsNm(boardVO.getBbsNm());
	//boardVO.setNtcrNm(user.getName());

	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsMngService.selectGuestList(boardVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", vo);
	model.addAttribute("brdMstrVO", brdMstrVO);
	model.addAttribute("paginationInfo", paginationInfo);

	return "admin/share/system/uni_bbs/EgovGuestList";
    }

    /**
     * 방명록에 대한 내용을 삭제한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/deleteGuestList.do")
    public String deleteGuestList(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board, ModelMap model) throws Exception {
	//@SuppressWarnings("unused")
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
	    bbsMngService.deleteGuestList(boardVO);
	
	return "forward:/admin/bbs/selectGuestList.do";
    }

    /**
     * 방명록 수정의 위한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/updateGuestList.do")
    public String updateGuestList(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board, BindingResult bindingResult,
	    ModelMap model) throws Exception {

	//BBST02, BBST04
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	beanValidator.validate(board, bindingResult);
	if (bindingResult.hasErrors()) {

	    BoardVO vo = new BoardVO();

	    vo.setBbsId(boardVO.getBbsId());
	    vo.setBbsNm(boardVO.getBbsNm());
	    //vo.setNtcrNm(user.getName());
	    //vo.setNtcrId(user.getId());

	    BoardMasterVO masterVo = new BoardMasterVO();
	    
	    masterVo.setBbsId(vo.getBbsId());
	    //masterVo.setUniqId(user.getId());
	    
	    BoardMasterVO mstrVO = bbsAttrbService.selectBBSMasterInf(masterVo);

	    vo.setPageUnit(propertyService.getInt("pageUnit"));
	    vo.setPageSize(propertyService.getInt("pageSize"));

	    PaginationInfo paginationInfo = new PaginationInfo();
	    paginationInfo.setCurrentPageNo(vo.getPageIndex());
	    paginationInfo.setRecordCountPerPage(vo.getPageUnit());
	    paginationInfo.setPageSize(vo.getPageSize());

	    vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
	    vo.setLastIndex(paginationInfo.getLastRecordIndex());
	    vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	    Map<String, Object> map = bbsMngService.selectGuestList(vo);
	    int totCnt = Integer.parseInt((String)map.get("resultCnt"));

	    paginationInfo.setTotalRecordCount(totCnt);
	    
	    model.addAttribute("resultList", map.get("resultList"));
	    model.addAttribute("resultCnt", map.get("resultCnt"));
	    model.addAttribute("brdMstrVO", mstrVO);
	    model.addAttribute("boardVO", vo);
	    model.addAttribute("paginationInfo", paginationInfo);

	    return "admin/share/system/uni_bbs/EgovGuestList";
	}

	    bbsMngService.updateBoardArticle(board);
	    boardVO.setNttCn("");
	    boardVO.setPassword("");
	    boardVO.setNtcrId("");
	    boardVO.setNttId(0);

	return "forward:/admin/bbs/selectGuestList.do";
    }

    /**
     * 방명록에 대한 내용을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/insertGuestList.do")
    public String insertGuestList(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board, BindingResult bindingResult,
	    ModelMap model) throws Exception {

	//그러니까 무인증은 아니고  - _- 익명으로 등록이 가능한 부분임
	// 무인증이 되려면 별도의 컨트롤러를 하나 더 등록해야함

    System.out.println("test1111");
    //LoginVO user = WebFactory.getUserInfo(request);
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	//beanValidator.validate(board, bindingResult);
	if (bindingResult.hasErrors()) {

	    BoardVO vo = new BoardVO();

	    vo.setBbsId(boardVO.getBbsId());
	    vo.setBbsNm(boardVO.getBbsNm());
	    //vo.setNtcrNm(user.getName());
	    //vo.setNtcrId(user.getId());

	    BoardMasterVO masterVo = new BoardMasterVO();
	    
	    masterVo.setBbsId(vo.getBbsId());
	    //masterVo.setUniqId(user.getId());
	    
	    BoardMasterVO mstrVO = bbsAttrbService.selectBBSMasterInf(masterVo);

	    vo.setPageUnit(propertyService.getInt("pageUnit"));
	    vo.setPageSize(propertyService.getInt("pageSize"));

	    PaginationInfo paginationInfo = new PaginationInfo();
	    paginationInfo.setCurrentPageNo(vo.getPageIndex());
	    paginationInfo.setRecordCountPerPage(vo.getPageUnit());
	    paginationInfo.setPageSize(vo.getPageSize());

	    vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
	    vo.setLastIndex(paginationInfo.getLastRecordIndex());
	    vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	    Map<String, Object> map = bbsMngService.selectGuestList(vo);
	    int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	    
	    paginationInfo.setTotalRecordCount(totCnt);

	    model.addAttribute("resultList", map.get("resultList"));
	    model.addAttribute("resultCnt", map.get("resultCnt"));
	    model.addAttribute("brdMstrVO", mstrVO);
	    model.addAttribute("boardVO", vo);	    
	    model.addAttribute("paginationInfo", paginationInfo);

	    return "admin/share/system/uni_bbs/EgovGuestList";

	}

	//if (isAuthenticated) {
	    //board.setFrstRegisterId(user.getId());
	    
	    bbsMngService.insertBoardArticle(board);

	    boardVO.setNttCn("");
	    boardVO.setPassword("");
	    boardVO.setNtcrId("");
	    boardVO.setNttId(0);
	//}

	return "forward:/admin/bbs/selectGuestList.do";
    }
    
    /**
     * 익명게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/anonymous/selectBoardList.do")
    public String selectAnonymousBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	//log.debug(this.getClass().getName() + " user.getId() "+ user.getId());
	//log.debug(this.getClass().getName() + " user.getName() "+ user.getName());
	//log.debug(this.getClass().getName() + " user.getUniqId() "+ user.getUniqId());
	//log.debug(this.getClass().getName() + " user.getOrgnztId() "+ user.getOrgnztId());
	//log.debug(this.getClass().getName() + " user.getUserSe() "+ user.getUserSe());
	//log.debug(this.getClass().getName() + " user.getEmail() "+ user.getEmail());

	//String attrbFlag = "";

	boardVO.setBbsId(boardVO.getBbsId());
	boardVO.setBbsNm(boardVO.getBbsNm());

	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	vo.setUniqId("ANONYMOUS");	// 익명
	
	BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	
	//-------------------------------
	// 익명게시판이 아니면.. 원래 게시판 URL로 forward
	//-------------------------------
	if (!master.getBbsTyCode().equals("BBST02")) {
	    return "forward:/admin/bbs/selectBoardList.do";
	}
	////-----------------------------

	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	//-------------------------------
	// 기본 BBS template 지정 
	//-------------------------------
	if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
	    master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}
	////-----------------------------

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("brdMstrVO", master);
	model.addAttribute("paginationInfo", paginationInfo);
	
	model.addAttribute("anonymous", "true");

	return "admin/share/system/uni_bbs/EgovNoticeList";
    }
    
    /**
     * 익명게시물 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/anonymous/addBoardArticle.do")
    public String addAnonymousBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	Boolean isAuthenticated = true;

	BoardMasterVO bdMstr = new BoardMasterVO();

	if (isAuthenticated) {
	    BoardMasterVO vo = new BoardMasterVO();
	    vo.setBbsId(boardVO.getBbsId());
	    vo.setUniqId("ANONYMOUS");

	    bdMstr = bbsAttrbService.selectBBSMasterInf(vo);
	    model.addAttribute("bdMstr", bdMstr);
	}
	
	//-------------------------------
	// 익명게시판이 아니면.. 원래 게시판 URL로 forward
	//-------------------------------
	if (!bdMstr.getBbsTyCode().equals("BBST02")) {
	    return "forward:/admin/bbs/addBoardArticle.do";
	}
	////-----------------------------

	//----------------------------
	// 기본 BBS template 지정 
	//----------------------------
	if (bdMstr.getTmplatCours() == null || bdMstr.getTmplatCours().equals("")) {
	    bdMstr.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", bdMstr);
	////-----------------------------
	
	model.addAttribute("anonymous", "true");

	return "admin/share/system/uni_bbs/EgovNoticeRegist";
    }
    
    /**
     * 익명게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/bbs/anonymous/insertBoardArticle.do")
    public String insertAnonymousBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, SessionStatus status,
	    ModelMap model) throws Exception {

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	Boolean isAuthenticated = true;

	beanValidator.validate(board, bindingResult);
	if (bindingResult.hasErrors()) {
	    
	    BoardMasterVO master = new BoardMasterVO();
	    BoardMasterVO vo = new BoardMasterVO();
	    
	    vo.setBbsId(boardVO.getBbsId());
	    vo.setUniqId("ANONYMOUS");

	    master = bbsAttrbService.selectBBSMasterInf(vo);
	    
	    model.addAttribute("bdMstr", master);
	    
	    //-------------------------------
	    // 익명게시판이 아니면.. 원래 게시판 URL로 forward
	    //-------------------------------
	    if (!bdMstr.getBbsTyCode().equals("BBST02")) {
		return "forward:/admin/bbs/insertBoardArticle.do";
	    }
	    ////-----------------------------

	    //----------------------------
	    // 기본 BBS template 지정 
	    //----------------------------
	    if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
		master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	    }

	    model.addAttribute("brdMstrVO", master);
	    ////-----------------------------
	    
	    model.addAttribute("anonymous", "true");

	    return "admin/share/system/uni_bbs/EgovNoticeRegist";
	}
	
	if (isAuthenticated) {
	    List<FileVO> result = null;
	    String atchFileId = "";
	    
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
		result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
		atchFileId = fileMngService.insertFileInfs(result);
	    }
	    board.setAtchFileId(atchFileId);
	    board.setFrstRegisterId("ANONYMOUS");
	    board.setBbsId(board.getBbsId());
	    
	    // 익명게시판 관련
	    board.setNtcrNm(board.getNtcrNm());
	    board.setPassword(EgovFileScrty.encryptPassword(board.getPassword()));
	    
	    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
	    
	    bbsMngService.insertBoardArticle(board);
	}

	//status.setComplete();
	return "forward:/admin/bbs/anonymous/selectBoardList.do";
    }
    
    /**
     * 익명게시물에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/anonymous/selectBoardArticle.do")
    public String selectAnonymousBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	// 조회수 증가 여부 지정
	boardVO.setPlusCount(true);

	boardVO.setLastUpdusrId("ANONYMOUS");
	BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

	model.addAttribute("result", vo);
	//CommandMap의 형태로 개선????

	model.addAttribute("sessionUniqId", "ANONYMOUS");

	//----------------------------
	// template 처리 (기본 BBS template 지정  포함)
	//----------------------------
	BoardMasterVO master = new BoardMasterVO();
	
	master.setBbsId(boardVO.getBbsId());
	master.setUniqId("ANONYMOUS");
	
	BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);
	
	//-------------------------------
	// 익명게시판이 아니면.. 원래 게시판 URL로 forward
	//-------------------------------
	if (!masterVo.getBbsTyCode().equals("BBST02")) {
	    return "forward:/admin/bbs/selectBoardArticle.do";
	}
	////-----------------------------

	if (masterVo.getTmplatCours() == null || masterVo.getTmplatCours().equals("")) {
	    masterVo.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", masterVo);
	////-----------------------------
	
	model.addAttribute("anonymous", "true");

	return "admin/share/system/uni_bbs/EgovNoticeInqire";
    }
    
    /**
     * 익명게시물에 대한 내용을 삭제한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/anonymous/deleteBoardArticle.do")
    public String deleteAnonymousBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, ModelMap model) throws Exception {
	
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	Boolean isAuthenticated = true;
	
	//--------------------------------------------------
	// 마스터 정보 얻기
	//--------------------------------------------------
	BoardMasterVO master = new BoardMasterVO();
	
	master.setBbsId(boardVO.getBbsId());
	master.setUniqId("ANONYMOUS");
	
	BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);
	
	//-------------------------------
	// 익명게시판이 아니면.. 원래 게시판 URL로 forward
	//-------------------------------
	if (!masterVo.getBbsTyCode().equals("BBST02")) {
	    return "forward:/admin/bbs/deleteBoardArticle.do";
	}
	////-----------------------------
	
	//-------------------------------
	// 패스워드 비교
	//-------------------------------
	String dbpassword = bbsMngService.getPasswordInf(board);
	String enpassword = EgovFileScrty.encryptPassword(board.getPassword());
	
	if (!dbpassword.equals(enpassword)) {
	    
	    model.addAttribute("msg", egovMessageSource.getMessage("cop.password.not.same.msg"));
	    
	    return "forward:/admin/bbs/anonymous/selectBoardArticle.do";
	}
	////-----------------------------

	if (isAuthenticated) {
	    board.setLastUpdusrId("ANONYMOUS");
	    
	    bbsMngService.deleteBoardArticle(board);
	}

	return "forward:/admin/bbs/anonymous/selectBoardList.do";
    }
    
    /**
     * 익명게시물 수정을 위한 수정페이지로 이동한다.
     * 
     * @param boardVO
     * @param vo
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/anonymous/forUpdateBoardArticle.do")
    public String selectAnonymousBoardArticleForUpdt(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") BoardVO vo, ModelMap model)
	    throws Exception {

	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getNttId "+boardVO.getNttId());
	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getBbsId "+boardVO.getBbsId());

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	Boolean isAuthenticated = true;

	boardVO.setFrstRegisterId("ANONYMOUS");
	
	BoardMaster master = new BoardMaster();
	BoardMasterVO bmvo = new BoardMasterVO();
	BoardVO bdvo = new BoardVO();
	
	vo.setBbsId(boardVO.getBbsId());
	
	master.setBbsId(boardVO.getBbsId());
	master.setUniqId("ANONYMOUS");

	if (isAuthenticated) {
	    bmvo = bbsAttrbService.selectBBSMasterInf(master);

	    //-------------------------------
	    // 익명게시판이 아니면.. 원래 게시판 URL로 forward
	    //-------------------------------
	    if (!bmvo.getBbsTyCode().equals("BBST02")) {
		return "forward:/admin/bbs/forUpdateBoardArticle.do";
	    }
	    ////-----------------------------

	    //-------------------------------
	    // 패스워드 비교
	    //-------------------------------
	    String dbpassword = bbsMngService.getPasswordInf(boardVO);
	    String enpassword = EgovFileScrty.encryptPassword(boardVO.getPassword());

	    if (!dbpassword.equals(enpassword)) {

		model.addAttribute("msg", egovMessageSource.getMessage("cop.password.not.same.msg"));

		return "forward:/admin/bbs/anonymous/selectBoardArticle.do";
	    }
	    ////-----------------------------

	    bdvo = bbsMngService.selectBoardArticle(boardVO);
	}

	model.addAttribute("result", bdvo);
	model.addAttribute("bdMstr", bmvo);

	//----------------------------
	// 기본 BBS template 지정 
	//----------------------------
	if (bmvo.getTmplatCours() == null || bmvo.getTmplatCours().equals("")) {
	    bmvo.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", bmvo);
	////-----------------------------
	
	model.addAttribute("anonymous", "true");
	
	return "admin/share/system/uni_bbs/EgovNoticeUpdt";
    }
    
    /**
     * 익명게시물에 대한 내용을 수정한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/bbs/anonymous/updateBoardArticle.do")
    public String updateAnonymousBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status) throws Exception {

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	Boolean isAuthenticated = true;

	String atchFileId = boardVO.getAtchFileId();

	beanValidator.validate(board, bindingResult);
	if (bindingResult.hasErrors()) {

	    boardVO.setFrstRegisterId("ANONYMOUS");
	    
	    BoardMaster master = new BoardMaster();
	    BoardMasterVO bmvo = new BoardMasterVO();
	    BoardVO bdvo = new BoardVO();
	    
	    master.setBbsId(boardVO.getBbsId());
	    master.setUniqId("ANONYMOUS");

	    bmvo = bbsAttrbService.selectBBSMasterInf(master);
	    
	    //-------------------------------
	    // 익명게시판이 아니면.. 원래 게시판 URL로 forward
	    //-------------------------------
	    if (!bdMstr.getBbsTyCode().equals("BBST02")) {
		return "forward:/admin/bbs/updateBoardArticle.do";
	    }
	    ////-----------------------------
	    
	    bdvo = bbsMngService.selectBoardArticle(boardVO);

	    model.addAttribute("result", bdvo);
	    model.addAttribute("bdMstr", bmvo);
	    
	    model.addAttribute("anonymous", "true");

	    return "admin/share/system/uni_bbs/EgovNoticeUpdt";
	}

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

	    board.setLastUpdusrId("ANONYMOUS");
	    
	    // 익명게시판 관련
	    board.setNtcrNm(board.getNtcrNm());
	    board.setPassword(EgovFileScrty.encryptPassword(board.getPassword()));
	    
	    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
	    
	    bbsMngService.updateBoardArticle(board);
	}
	
	return "forward:/admin/bbs/anonymous/selectBoardList.do";
    }
    
    /**
     * 익명게시물에 대한 답변 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/anonymous/addReplyBoardArticle.do")
    public String addAnonymousReplyBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	BoardMasterVO master = new BoardMasterVO();
	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	vo.setUniqId("ANONYMOUS");

	master = bbsAttrbService.selectBBSMasterInf(vo);
	
	//-------------------------------
	// 익명게시판이 아니면.. 원래 게시판 URL로 forward
	//-------------------------------
	if (!master.getBbsTyCode().equals("BBST02")) {
	    return "forward:/admin/bbs/addReplyBoardArticle.do";
	}
	////-----------------------------
	
	model.addAttribute("bdMstr", master);
	model.addAttribute("result", boardVO);

	//----------------------------
	// 기본 BBS template 지정 
	//----------------------------
	if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
	    master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", master);
	////-----------------------------
	
	model.addAttribute("anonymous", "true");

	return "admin/share/system/uni_bbs/EgovNoticeReply";
    }
    
    /**
     * 익명게시물에 대한 답변을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/bbs/anonymous/replyBoardArticle.do")
    public String replyAnonymousBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status) throws Exception {

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	Boolean isAuthenticated = true;
	
	beanValidator.validate(board, bindingResult);
	if (bindingResult.hasErrors()) {
	    BoardMasterVO master = new BoardMasterVO();
	    BoardMasterVO vo = new BoardMasterVO();
	    
	    vo.setBbsId(boardVO.getBbsId());
	    vo.setUniqId("ANONYMOUS");

	    master = bbsAttrbService.selectBBSMasterInf(vo);
	    
		//-------------------------------
		// 익명게시판이 아니면.. 원래 게시판 URL로 forward
		//-------------------------------
		if (!master.getBbsTyCode().equals("BBST02")) {
		    return "forward:/admin/bbs/replyBoardArticle.do";
		}
		////-----------------------------
	    
	    model.addAttribute("bdMstr", master);
	    model.addAttribute("result", boardVO);

	    //----------------------------
	    // 기본 BBS template 지정 
	    //----------------------------
	    if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
		master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
	    }

	    model.addAttribute("brdMstrVO", master);
	    ////-----------------------------
	    
	    model.addAttribute("anonymous", "true");

	    return "admin/share/system/uni_bbs/EgovNoticeReply";
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
	    board.setFrstRegisterId("ANONYMOUS");
	    board.setBbsId(board.getBbsId());
	    board.setParnts(Long.toString(boardVO.getNttId()));
	    board.setSortOrdr(boardVO.getSortOrdr());
	    board.setReplyLc(Integer.toString(Integer.parseInt(boardVO.getReplyLc()) + 1));
	    
	    // 익명게시판 관련
	    board.setNtcrNm(board.getNtcrNm());
	    board.setPassword(EgovFileScrty.encryptPassword(board.getPassword()));
	    
	    board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
	    
	    bbsMngService.insertBoardArticle(board);
	}
	
	return "forward:/admin/bbs/anonymous/selectBoardList.do";
    }
    
    /**
     * 템플릿에 대한 미리보기용 게시물 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/previewBoardList.do")
    public String previewBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	String template = boardVO.getSearchWrd();	// 템플릿 URL
	
	BoardMasterVO master = new BoardMasterVO();
	
	master.setBbsNm("미리보기 게시판");

	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
	BoardVO target = null;
	List<BoardVO> list = new ArrayList<BoardVO>();
	
	target = new BoardVO();
	target.setNttSj("게시판 기능 설명");
	target.setFrstRegisterId("ID");
	target.setFrstRegisterNm("관리자");
	target.setFrstRegisterPnttm("2009-01-01");
	target.setInqireCo(7);
	target.setParnts("0");
	target.setReplyAt("N");
	target.setReplyLc("0");
	target.setUseAt("Y");
	
	list.add(target);
	
	target = new BoardVO();
	target.setNttSj("게시판 부가 기능 설명");
	target.setFrstRegisterId("ID");
	target.setFrstRegisterNm("관리자");
	target.setFrstRegisterPnttm("2009-01-01");
	target.setInqireCo(7);
	target.setParnts("0");
	target.setReplyAt("N");
	target.setReplyLc("0");
	target.setUseAt("Y");
	
	list.add(target);
	
	boardVO.setSearchWrd("");

	int totCnt = list.size();
	
	paginationInfo.setTotalRecordCount(totCnt);

	master.setTmplatCours(template);
	
	model.addAttribute("resultList", list);
	model.addAttribute("resultCnt", Integer.toString(totCnt));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("brdMstrVO", master);
	model.addAttribute("paginationInfo", paginationInfo);
	
	model.addAttribute("preview", "true");

	return "admin/share/system/uni_bbs/EgovNoticeList";
    }
    
    /**
     * 게시물 답변을 위한 답변페이지로 이동한다.
     * 
     * @param boardVO
     * @param vo
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/forAnswerBoardArticle.do")
    public String selectBoardArticleForAns(
    		@ModelAttribute("searchVO") BoardVO boardVO, 
    		@ModelAttribute("board") BoardVO vo, ModelMap model)
	    throws Exception {

	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getNttId "+boardVO.getNttId());
	//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getBbsId "+boardVO.getBbsId());

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	//boardVO.setFrstRegisterId(user.getId());
	
	BoardMaster master = new BoardMaster();
	BoardMasterVO bmvo = new BoardMasterVO();
	BoardVO bdvo = new BoardVO();
	
	vo.setBbsId(boardVO.getBbsId());
	
	master.setBbsId(boardVO.getBbsId());
	//master.setUniqId(user.getId());

	    bmvo = bbsAttrbService.selectBBSMasterInf(master);
	    bdvo = bbsMngService.selectBoardArticle(boardVO);
	
	//오늘 날짜 
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
	
	model.addAttribute("today", date.format(today));
	model.addAttribute("result", bdvo);
	model.addAttribute("bdMstr", bmvo);
	//model.addAttribute("user", user);
	model.addAttribute("brdMstrVO", bmvo);
	////-----------------------------
	
	return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/Answer";
    }
    
    /**
     * 게시물 답변수정을 위한 답변수정페이지로 이동한다.
     * 
     * @param boardVO
     * @param vo
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/forAnswerUPBoardArticle.do")
    public String selectBoardArticleForAnsUP(
    		@ModelAttribute("searchVO") BoardVO boardVO, 
    		@ModelAttribute("board") BoardVO vo, ModelMap model)
	    throws Exception {

	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	//boardVO.setFrstRegisterId(user.getId());
	
	BoardMaster master = new BoardMaster();
	BoardMasterVO bmvo = new BoardMasterVO();
	BoardVO bdvo = new BoardVO();
	
	vo.setBbsId(boardVO.getBbsId());
	
	master.setBbsId(boardVO.getBbsId());
	//master.setUniqId(user.getId());

	    bmvo = bbsAttrbService.selectBBSMasterInf(master);
	    bdvo = bbsMngService.selectBoardArticle(boardVO);
	
	model.addAttribute("result", bdvo);
	model.addAttribute("bdMstr", bmvo);
	//model.addAttribute("user", user);
	model.addAttribute("brdMstrVO", bmvo);
	////-----------------------------
	
	return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/AnswerUP";
    }
    
    /**
     * 사진신청및 삭제요청 리스트
     * @param request
     * @param response
     * @param boardUser
     * @param boardVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectBoardUserArticle.do")
    public String selectBoardUserArticle(
    		HttpServletRequest request, 
    		HttpServletResponse response, 
    		@ModelAttribute("searchVO") BoardUser boardUser,
    		@ModelAttribute("BoardVO") BoardVO boardVO,
    		ModelMap model) throws Exception {
    	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    
    	BoardMasterVO vo = new BoardMasterVO();
    	
    	vo.setBbsId(boardVO.getBbsId());
    	//vo.setUniqId(user.getId());
    	
    	BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
    	
    	Map<String, Object> map = bbsMngService.selectBoardUserArticle(boardUser);
	
    	model.addAttribute("resultList", map.get("resultList"));
    	model.addAttribute("boardVO", boardVO);
    	model.addAttribute("brdMstrVO", master);
	
	return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/AppList";
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
    @RequestMapping("/admin/bbs/selectEBookList.do")
    public String selectEBookArticles(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchVO") BoardVO boardVO, EBookVO ebookVO, ModelMap model) throws Exception {

	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsMngService.selectEBookArticles(ebookVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);


	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("paginationInfo", paginationInfo);
	
	return "admin/share/system/EBook/EBookList";
    }
    
    /**
     * EBooK 게시물에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param ebookVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectEBookArticle.do")
    public String selectEBookArticle(@ModelAttribute("searchVO") BoardVO boardVO, EBookVO ebookVO, ModelMap model) throws Exception {

    	EBookVO vo = bbsMngService.selectEBookArticle(ebookVO);
    	
    	EBookFileVO fileVO = new EBookFileVO();
    	fileVO.setPfPiSeq(ebookVO.getPiSeq());
    	
    	fileVO = bbsMngService.selectEBookFileArticle(fileVO);

		model.addAttribute("result", vo);
		model.addAttribute("resultFile", fileVO);
		return "admin/share/system/EBook/EBookRead";
    }
    
    /**
     * EBooK 게시물에 대한 상세 정보를 등록한다.
     * 
     * @param boardVO
     * @param ebookVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/addEBookArticle.do")
    public String addEBookArticle(@ModelAttribute("searchVO") BoardVO boardVO, EBookVO ebookVO, ModelMap model) throws Exception {
    	
    	return "admin/share/system/EBook/EBookReg";
    }

    /**
     * EBooK 게시물에 대한 정보를 등록처리한다.
     * 
     * @param boardVO
     * @param ebookVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/insertEBookArticle.do")
    public String insertEBookArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO, EBookVO ebookVO, ModelMap model) throws Exception {
    	
		List<FileVO> result = null;
	    
		int pfPiSeq = bbsMngService.insertEBookArticle(ebookVO);
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
		    String storePathString = "EBOOK/Image/";
			result = fileUtil.parseFileInf(files, "EBK_", 0, "", storePathString);

			FileVO vo = (FileVO)result.get(0);
			
			Iterator iter = result.iterator();
			while (iter.hasNext()) {
			    vo = (FileVO)iter.next();
			    
			    EBookFileVO fileDto = new EBookFileVO();
				
				fileDto.setPfPiSeq(pfPiSeq);
				fileDto.setPfNttId(ebookVO.getPiNttId());
				fileDto.setPfStreName(vo.getStreFileNm());
				fileDto.setPfPath(vo.getFileStreCours());
				fileDto.setPfSize(vo.getFileMg());
				fileDto.setPfOrignlName(vo.getOrignlFileNm());
				fileDto.setPfExtsn(vo.getFileExtsn());
				
				bbsMngService.insertEBookFileArticle(fileDto);
			}
	    }
	    
    	return "redirect:/admin/bbs/selectEBookList.do?piNttId="+ebookVO.getPiNttId();
    }
    
    /**
     * EBooK 게시물에 대한 정보를 수정한다.
     * 
     * @param boardVO
     * @param ebookVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/forUpdateEBookArticle.do")
    public String updateEBookArticle(@ModelAttribute("searchVO") BoardVO boardVO, EBookVO ebookVO, ModelMap model) throws Exception {
    	
    	EBookVO vo = bbsMngService.selectEBookArticle(ebookVO);
    	EBookFileVO fileVO = new EBookFileVO();
    	fileVO.setPfPiSeq(ebookVO.getPiSeq());
    	
    	fileVO = bbsMngService.selectEBookFileArticle(fileVO);

		model.addAttribute("result", vo);
		model.addAttribute("resultFile", fileVO);
    	return "admin/share/system/EBook/EBookMod";
    }
    
    /**
     * EBooK 게시물에 대한 정보를 삭제한다.
     * 
     * @param boardVO
     * @param ebookVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/deleteEBookArticle.do")
    public String deleteEBookArticle(@ModelAttribute("searchVO") EBookVO ebookVO, EBookFileVO ebookFileVO, ModelMap model) throws Exception {
    	
    	bbsMngService.deleteEBookArticle(ebookVO);
    	bbsMngService.deleteEBookFileArticle(ebookFileVO);

    	return "redirect:/admin/bbs/selectEBookList.do?piNttId="+ebookVO.getPiNttId();
    }
    
    /**
     * EBooK 게시물에 대한 정보를 수정처리한다.
     * 
     * @param boardVO
     * @param ebookVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/updateEBookArticle.do")
    public String updateEBookArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO, EBookVO ebookVO, ModelMap model) throws Exception {
    	
		List<FileVO> result = null;
	    
		bbsMngService.updateEBookArticle(ebookVO);
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
		    String storePathString = "EBOOK/Image/";
			result = fileUtil.parseFileInf(files, "EBK_", 0, "", storePathString);

			FileVO vo = (FileVO)result.get(0);
			
			Iterator iter = result.iterator();
			while (iter.hasNext()) {
			    vo = (FileVO)iter.next();
			    
			    EBookFileVO fileDto = new EBookFileVO();
				
				fileDto.setPfPiSeq(ebookVO.getPiSeq());
				fileDto.setPfNttId(ebookVO.getPiNttId());
				fileDto.setPfStreName(vo.getStreFileNm());
				fileDto.setPfPath(vo.getFileStreCours());
				fileDto.setPfSize(vo.getFileMg());
				fileDto.setPfOrignlName(vo.getOrignlFileNm());
				fileDto.setPfExtsn(vo.getFileExtsn());
				
				bbsMngService.insertEBookFileArticle(fileDto);
			}
	    }
	    
    	return "redirect:/admin/bbs/selectEBookList.do?piNttId="+ebookVO.getPiNttId();
    }
    
    /**
     * EBooK 첨부파일을 삭제한다.
     * 
     * @param boardVO
     * @param ebookVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/deleteEBookFileArticle.do")
    public String deleteEBookFileArticle(@ModelAttribute("searchVO") EBookVO ebookVO, EBookFileVO ebookFileVO, ModelMap model) throws Exception {
    	
    	bbsMngService.deleteEBookFileArticle(ebookFileVO);

		return "redirect:/admin/bbs/selectEBookArticle.do?piNttId="+ebookVO.getPiNttId()+"&piSeq="+ebookVO.getPiSeq();
    }
    
    
    /**
     * 
     * @param request
     * @param boardVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectNewsPop.do")
    public String selectNewsPop(HttpServletRequest request,@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	
    	//LoginVO user = WebFactory.getUserInfo(request);

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
		    return "forward:/portal/bbs/selectGuestList.do";
		}
		////-----------------------------
	
		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
		boardVO.setPageSize(propertyService.getInt("pageSize"));
	
		int pageUnit = propertyService.getInt("pageUnit");
		int pageSize = propertyService.getInt("pageSize");
		int pageIndex = boardVO.getPageIndex();
		
		PaginationInfo paginationInfo = new PaginationInfo();		
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);
		
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		BoardVO newsVO = bbsMngService.selectBoardNewsArticle(boardVO);
		boardVO.setOptionCnd2("option2");
		boardVO.setOptionWrd2(boardVO.getOptionWrd2());
		boardVO.setType("1");
		
		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
		
		
		//Map<String, Object> map2 = bbsMngService.selectBoardNewsArticles(boardVO);
		//model.addAttribute("resultList2", map2.get("resultList"));
		
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
	
		//-------------------------------
		// 기본 BBS template 지정 
		//-------------------------------
		if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
		    master.setTmplatCours("/css/egovframework/cop/bbs/egovBaseTemplate.css");
		}
		////-----------------------------
		
		String pageNav = PageUtil.getJnPageNavString(pageUnit, totCnt, pageIndex,
				"/portal/bbs/selectBoardList.do?bbsId="+boardVO.getBbsId()+"&amp;menuId="+boardVO.getMenuId()
				+ "&amp;searchCnd="+boardVO.getSearchCnd() + "&amp;searchWrd="+boardVO.getSearchWrd()
				+ "&amp;optionCnd="+boardVO.getOptionCnd() + "&amp;optionWrd="+boardVO.getOptionWrd()
				+ "&amp;optionCnd2="+boardVO.getOptionCnd2() + "&amp;optionWrd2="+boardVO.getOptionWrd2()
				+ "&amp;optionCndLike="+boardVO.getOptionCndLike() + "&amp;optionWrdLike="+boardVO.getOptionWrdLike());
		
		model.addAttribute("today", EgovDateUtil.getToday());
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("brdMstrVO", master);
		model.addAttribute("pageNav", pageNav);
		//model.addAttribute("user", user);
		
		return "admin/share/system/uni_bbs/"+boardVO.getBbsId()+"/Pop";
    }
    
}
