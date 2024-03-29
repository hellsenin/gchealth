package egovframework.kr.go.geumcheon.health.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.clb.service.ClubUser;
import egovframework.com.cop.clb.service.EgovClubManageService;
import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 게시판 속성관리를 위한 컨트롤러  클래스
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
 *   2009.3.12  이삼섭          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller
public class AdminEgovBBSAttributeManageController {

    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;	// 커뮤니티 관리자 권한 확인
    
    @Resource(name = "EgovClubManageService")
    private EgovClubManageService clubService;		// 동호회 운영자 권한 확인

    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());
    
    /**
     * 커뮤니티 관리자 및 동호회 운영자 권한을 확인한다.
     * 
     * @param boardMaster
     * @throws EgovBizException
     */
    protected void checkAuthority(BoardMaster boardMaster) throws Exception {
	String targetId = boardMaster.getTrgetId();
	
//	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//	
//	if (user == null) {
//	    throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
//	}
	
	if (targetId.startsWith("CMMNTY_")) {
	    CommunityUser cmmntyUser = new CommunityUser();
	    
	    cmmntyUser.setCmmntyId(boardMaster.getTrgetId());
//	    cmmntyUser.setEmplyrId(user.getId());
	    
	    if (cmmntyService.isManager(cmmntyUser)) {
		// no-op
	    } else {
		throw new EgovBizException("해당 커뮤니티 관리자만 사용하실 수 있습니다.");
	    }
	} else if (targetId.startsWith("CLB_")) {
	    ClubUser clubUser = new ClubUser();
	    
	    clubUser.setClbId(boardMaster.getTrgetId());
//	    clubUser.setEmplyrId(user.getId());
	    
	    if (clubService.isOperator(clubUser)) {
		// no-op
	    } else {
		throw new EgovBizException("해당 동호회 운영자만 사용하실 수 있습니다.");
	    }
	} else {
	    throw new EgovBizException("대상ID 정보가 정확하지 않습니다.");
	}
    }
	
	/**
     * 신규 게시판 마스터 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/bbs/addBBSMaster.do")
    public String addBBSMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	BoardMaster boardMaster = new BoardMaster();

	ComDefaultCodeVO vo = new ComDefaultCodeVO();
	
	vo.setCodeId("COM004");
	
	List codeResult = cmmUseService.selectCmmCodeDetail(vo);
	
	model.addAttribute("typeList", codeResult);

	vo.setCodeId("COM009");
	
	codeResult = cmmUseService.selectCmmCodeDetail(vo);
	
	model.addAttribute("attrbList", codeResult);
	model.addAttribute("boardMaster", boardMaster);

	return "admin/share/system/uni_bbs/EgovBoardMstrRegist";
    }

    /**
     * 신규 게시판 마스터 정보를 등록한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param status
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/bbs/insertBBSMasterInf.do")
    public String insertBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
	    BindingResult bindingResult, SessionStatus status, ModelMap model) throws Exception {
	
//	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	
	beanValidator.validate(boardMaster, bindingResult);
	if (bindingResult.hasErrors()) {

	    ComDefaultCodeVO vo = new ComDefaultCodeVO();
	    
	    vo.setCodeId("COM004"); 
	    
	    List codeResult = cmmUseService.selectCmmCodeDetail(vo);
	    
	    model.addAttribute("typeList", codeResult); 

	    vo.setCodeId("COM009");
	   
	    codeResult = cmmUseService.selectCmmCodeDetail(vo);
	    
	    model.addAttribute("attrbList", codeResult);

	    return "admin/share/system/uni_bbs/EgovBoardMstrRegist";
	}
	
//    boardMaster.setFrstRegisterId(user.getId());
    boardMaster.setUseAt("Y");
    boardMaster.setTrgetId("SYSTEMDEFAULT_REGIST");

    bbsAttrbService.insertBBSMastetInf(boardMaster);

	return "forward:/admin/bbs/SelectBBSMasterInfs.do";
    }

    /**
     * 게시판 마스터 목록을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/SelectBBSMasterInfs.do")
    public String selectBBSMasterInfs(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	boardMasterVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardMasterVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
	paginationInfo.setPageSize(boardMasterVO.getPageSize());

	boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsAttrbService.selectBBSMasterInfs(boardMasterVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));	
	model.addAttribute("paginationInfo", paginationInfo);

	return "admin/share/system/uni_bbs/EgovBoardMstrList";
    }

    /**
     * 게시판 마스터 상세내용을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/SelectBBSMasterInf.do")
    public String selectBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO searchVO, ModelMap model) throws Exception {
	BoardMasterVO vo = bbsAttrbService.selectBBSMasterInf(searchVO);

	model.addAttribute("result", vo);
	
	return "admin/share/system/uni_bbs/EgovBoardMstrUpdt";
    }

    /**
     * 게시판 마스터 정보를 수정한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/UpdateBBSMasterInf.do")
    public String updateBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
	    BindingResult bindingResult, ModelMap model) throws Exception {

//	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	beanValidator.validate(boardMaster, bindingResult);
	if (bindingResult.hasErrors()) {
	    BoardMasterVO vo = bbsAttrbService.selectBBSMasterInf(boardMasterVO);

	    model.addAttribute("result", vo);
	    
	    return "admin/share/system/uni_bbs/EgovBoardMstrUpdt";
	}

//	boardMaster.setLastUpdusrId(user.getId());
    bbsAttrbService.updateBBSMasterInf(boardMaster);

	return "forward:/admin/bbs/SelectBBSMasterInfs.do";
    }

    /**
     * 게시판 마스터 정보를 삭제한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/DeleteBBSMasterInf.do")
    public String deleteBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
	    SessionStatus status) throws Exception {

//	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

//    boardMaster.setLastUpdusrId(user.getId());
    bbsAttrbService.deleteBBSMasterInf(boardMaster);
	// status.setComplete();
	return "forward:/admin/bbs/SelectBBSMasterInfs.do";
    }

    /**
     * 게시판 마스터 선택 팝업을 위한 목록을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/SelectBBSMasterInfsPop.do")
    public String selectBBSMasterInfsPop(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	boardMasterVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardMasterVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
	paginationInfo.setPageSize(boardMasterVO.getPageSize());

	boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	boardMasterVO.setUseAt("Y");
	
	Map<String, Object> map = bbsAttrbService.selectNotUsedBdMstrList(boardMasterVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));	
	model.addAttribute("paginationInfo", paginationInfo);

	return "admin/share/system/uni_bbs/EgovBoardMstrListPop";
    }

    /**
     * 게시판 사용을 위한 신규 게시판 속성정보를 생성한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param bindingResult
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/bbs/insertBdMstrByTrget.do")
    public String insertBdMstrByTrget(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO,
	    @ModelAttribute("boardMaster") BoardMaster boardMaster, BindingResult bindingResult, SessionStatus status, ModelMap model)
	    throws Exception {

	checkAuthority(boardMasterVO);	// server-side 권한 확인
	
//	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	beanValidator.validate(boardMaster, bindingResult);
	if (bindingResult.hasErrors()) {

	    ComDefaultCodeVO vo = new ComDefaultCodeVO();
	    
	    vo.setCodeId("COM004");
	    
	    List codeResult = cmmUseService.selectCmmCodeDetail(vo);
	    
	    model.addAttribute("typeList", codeResult);

	    vo.setCodeId("COM009");
	    
	    codeResult = cmmUseService.selectCmmCodeDetail(vo);
	    
	    model.addAttribute("attrbList", codeResult);

	    return "admin/share/system/uni_bbs/EgovBdMstrRegistByTrget";
	}

//	boardMaster.setFrstRegisterId(user.getId());
	boardMaster.setUseAt("Y");
	boardMaster.setBbsUseFlag("Y");

	String registSeCode = "REGC06";

	if ("CLB".equals(EgovStringUtil.cutString(boardMaster.getTrgetId(), 3))) {
	    registSeCode = "REGC05";
	}
	boardMaster.setRegistSeCode(registSeCode);

	if (isAuthenticated) {
	    bbsAttrbService.insertBBSMastetInf(boardMaster);
	    model.addAttribute("S_FLAG", "S");
	}

	return "forward:/admin/bbs/selectBdMstrListByTrget.do";
    }

    /**
     * 사용중인 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectBdMstrListByTrget.do")
    public String selectBdMstrListByTrget(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	checkAuthority(boardMasterVO);	// server-side 권한 확인
	
	boardMasterVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardMasterVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
	paginationInfo.setPageSize(boardMasterVO.getPageSize());

	boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsAttrbService.selectBdMstrListByTrget(boardMasterVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("paginationInfo", paginationInfo);
	model.addAttribute("trgetId", boardMasterVO.getTrgetId());
	
	return "admin/share/system/uni_bbs/EgovBBSListByTrget";
    }

    /**
     * 게시판 사용을 위한 게시판 속성정보 한 건을 상세조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/SelectBBSMasterInfByTrget.do")
    public String selectBBSMasterInfByTrget(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, Map<String, Object> commandMap, ModelMap model)
	    throws Exception {

	checkAuthority(boardMasterVO);	// server-side 권한 확인
	
	BoardMasterVO vo = bbsAttrbService.selectBBSMasterInf(boardMasterVO);
	
	//String trgetId = (String)commandMap.get("param_trgetId");
	//String bbsId = (String)commandMap.get("param_bbsId");

	vo.setTrgetId(boardMasterVO.getTrgetId());
	
	model.addAttribute("result", vo);
	
	return "admin/share/system/uni_bbs/EgovBdMstrUpdtByTrget";
    }

    /**
     * 게시판 사용을 위한 게시판 속성정보를 수정한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/UpdateBBSMasterInfByTrget.do")
    public String updateBBSMasterInfByTrget(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO,
	    @ModelAttribute("boardMaster") BoardMaster boardMaster, BindingResult bindingResult, ModelMap model) throws Exception {

	checkAuthority(boardMasterVO);	// server-side 권한 확인
	
//	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	beanValidator.validate(boardMaster, bindingResult);
	if (bindingResult.hasErrors()) {
	    BoardMasterVO vo = new BoardMasterVO();
	    
	    vo = bbsAttrbService.selectBBSMasterInf(boardMasterVO);

	    model.addAttribute("result", vo);
	    
	    return "admin/share/system/uni_bbs/EgovBoardMstrUpdt";
	}

//	boardMaster.setLastUpdusrId(user.getId());
	boardMaster.setUseAt("Y");
	
	bbsAttrbService.updateBBSMasterInf(boardMaster);

	return "forward:/admin/bbs/selectBdMstrListByTrget.do";
    }

    /**
     * 커뮤니티, 동호회에서 사용을 위한 게시판 마스터 등록 화면으로 이동한다.
     * 
     * @param boardMasterVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/bbs/addBBSMasterByTrget.do")
    public String addBBSMasterByTrget(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	checkAuthority(boardMasterVO);	// server-side 권한 확인
	
	ComDefaultCodeVO vo = new ComDefaultCodeVO();
	
	vo.setCodeId("COM004");
	
	List codeResult = cmmUseService.selectCmmCodeDetail(vo);
	
	model.addAttribute("typeList", codeResult);

	vo.setCodeId("COM009");
	
	codeResult = cmmUseService.selectCmmCodeDetail(vo);
	
	model.addAttribute("attrbList", codeResult);

	BoardMaster boardMaster = new BoardMaster();
	
	model.addAttribute("boardMaster", boardMaster);

	return "admin/share/system/uni_bbs/EgovBdMstrRegistByTrget";
    }

    /**
     * 등록된 게시판 속성정보를 삭제한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param sessionVO
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/DeleteBBSMasterInfByTrget.do")
    public String deleteBBSMasterInfByTrget(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO,
	    @ModelAttribute("boardMaster") BoardMaster boardMaster, SessionStatus status) throws Exception {

	checkAuthority(boardMasterVO);	// server-side 권한 확인
	
//	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

//	boardMaster.setLastUpdusrId(user.getId());
	
    bbsAttrbService.deleteBBSMasterInf(boardMaster);

	// status.setComplete();
	return "forward:/admin/bbs/selectBdMstrListByTrget.do";
    }

    /**
     * 커뮤니티, 동호회에서 사용중인 게시판 속성 정보의 목록 조회한다.
     * 
     * @param commandMap
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectAllBdMstrByTrget.do")
    public String selectAllBdMstrByTrget(Map<String, Object> commandMap, ModelMap model) throws Exception {
	String trgetId = (String)commandMap.get("param_trgetId");
	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setTrgetId(trgetId);
	
	List<BoardMasterVO> result = bbsAttrbService.selectAllBdMstrByTrget(vo);

	model.addAttribute("resultList", result);
	
	return "admin/share/system/uni_bbs/EgovBdListPortlet";
    }
}
