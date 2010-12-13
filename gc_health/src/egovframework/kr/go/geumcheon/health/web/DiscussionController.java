package egovframework.kr.go.geumcheon.health.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.DiscussionService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.vo.Discussion;
import egovframework.kr.go.geumcheon.health.vo.Division;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class DiscussionController {

    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "discussionService")
    protected DiscussionService discussionService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

    @Resource(name = "webFactory")
    protected WebFactory WebFactory;

	@RequestMapping("/health/discussion/writeDiscussionPage.do")
	public String writeDiscussionPage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null)
    	{
    		WebFactory.setForwardPage(request, response);
    		return null;
    	}
		model.addAttribute("includePage", "/health/dev_content/discussion/insertDiscussion.jsp");
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/discussion/insertDiscussion.do")
	public void insertDiscussion(
			@ModelAttribute("discussion") Discussion discussion,
			@RequestParam("categoryId") String categoryId,
			HttpServletRequest request, 
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null)
    	{
    		throw new EgovBizException("사용자 정보가없습니다.");
    	}
		discussionService.insertDiscussion(discussion);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
    			"/health/discussion/selectDiscussionList.do?categoryId="+categoryId);
	}

	@RequestMapping("/health/discussion/modifyDiscussionPage.do")
	public String modifyDiscussionPageA(
			@ModelAttribute("discussion") Discussion discussion,
			@RequestParam("categoryId") String categoryId,
			HttpServletRequest request,
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null)
    	{
    		throw new EgovBizException("사용자 정보가없습니다.");
    	}
		EgovMap result = discussionService.selectDiscussionByDisseq(discussion.getDisseq());
		model.addAttribute("result", result);
		

		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(discussion.getPageIndex());
		paginationInfo.setRecordCountPerPage(discussion.getPageUnit());
		paginationInfo.setPageSize(discussion.getPageSize());

		discussion.setFirstIndex(paginationInfo.getFirstRecordIndex());
		discussion.setLastIndex(paginationInfo.getLastRecordIndex());
		discussion.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		int disseq = discussion.getDisseq();
		List divisionList = discussionService.selectDivisionList(discussion);
		int divisionCnt = discussionService.selectDivisionCnt(disseq);
		paginationInfo.setTotalRecordCount(divisionCnt);
		
		String pageNav = PageUtil.getSgPageNavString(discussion.getPageUnit(), divisionCnt, discussion.getPageIndex(), 
				"/health/discussion/modifyDiscussionPage.do?disseq="+disseq+"&categoryId="+categoryId);

		model.addAttribute("divisionList", divisionList);
		model.addAttribute("divisionCnt", divisionCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNav", pageNav);
    	
		model.addAttribute("includePage", "/health/discussion/insertDiscussion.jsp");
		
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/discussion/modifyDiscussion.do")
	public void modifyDiscussionA(
			@ModelAttribute("discussion") Discussion discussion,
			@RequestParam("categoryId") String categoryId,
			HttpServletRequest request, 
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null)
    	{
    		throw new EgovBizException("사용자 정보가없습니다.");
    	}
		discussionService.modifyDiscussion(discussion);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
    			"/health/discussion/selectDiscussionList.do?categoryId="+categoryId);
	}

	@RequestMapping("/health/discussion/selectDiscussionList.do")
	public String selectDiscussionList(
			@ModelAttribute("discussion") Discussion discussion,
			@RequestParam("categoryId") String categoryId,
			HttpServletRequest request,
			ModelMap model) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(discussion.getPageIndex());
		paginationInfo.setRecordCountPerPage(discussion.getPageUnit());
		paginationInfo.setPageSize(discussion.getPageSize());

		discussion.setFirstIndex(paginationInfo.getFirstRecordIndex());
		discussion.setLastIndex(paginationInfo.getLastRecordIndex());
		discussion.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	
		List discussionList = discussionService.selectDiscussionListA(discussion);
		int discussionCnt = discussionService.selectDiscussionCntA();
		paginationInfo.setTotalRecordCount(discussionCnt);
		
		String pageNav = PageUtil.getSgPageNavString(discussion.getPageUnit(), discussionCnt, discussion.getPageIndex(), 
				"/health/discussion/selectDiscussionList.do?categoryId="+categoryId);

		model.addAttribute("discussionList", discussionList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNav", pageNav);

		model.addAttribute("includePage", "/health/dev_content/discussion/selectDiscussionList.jsp");
		
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/discussion/selectDiscussion.do")
	public String selectDiscussion(
			@ModelAttribute("discussion") Discussion discussion,
			@RequestParam("categoryId") String categoryId,
			HttpServletRequest request,
			ModelMap model) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(discussion.getPageIndex());
		paginationInfo.setRecordCountPerPage(discussion.getPageUnit());
		paginationInfo.setPageSize(discussion.getPageSize());

		discussion.setFirstIndex(paginationInfo.getFirstRecordIndex());
		discussion.setLastIndex(paginationInfo.getLastRecordIndex());
		discussion.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		int disseq = discussion.getDisseq();
		
		EgovMap discussionZvl = discussionService.selectDiscussionByDisseq(disseq);
		List divisionList = discussionService.selectDivisionList(discussion);
		int divisionCnt = discussionService.selectDivisionCnt(disseq);
		paginationInfo.setTotalRecordCount(divisionCnt);
		
		String pageNav = PageUtil.getSgPageNavString(discussion.getPageUnit(), divisionCnt, discussion.getPageIndex(), 
				"/health/discussion/selectDiscussion.do?disseq="+disseq+"&categoryId="+categoryId);

		model.addAttribute("result", discussionZvl);
		model.addAttribute("divisionList", divisionList);
		model.addAttribute("divisionCnt", divisionCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNav", pageNav);
		
		discussionService.addHit(disseq);

    	String includePage = "/health/dev_content/discussion/selectDiscussion.jsp";
		log.debug("includePage :: " + includePage);

		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/discussion/writeDivisionPage.do")
	public String writeDivisionPage(
			@ModelAttribute("discussion") Discussion discussion,
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null)
    	{
    		WebFactory.setForwardPage(request, response);
    		return null;
    	}

		EgovMap discussionZvl = discussionService.selectDiscussionByDisseq(discussion.getDisseq());
		model.addAttribute("result", discussionZvl);

		model.addAttribute("includePage", "/health/dev_content/discussion/writeDivision.jsp");
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/discussion/writeDivision.do")
	public void writeDivision(
			@ModelAttribute("division") Division division,
			@RequestParam("categoryId") String categoryId,
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null)
    	{
    		throw new EgovBizException("사용자 정보가 없습니다.!");
    	}
    	
    	discussionService.insertDivision(division);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
    			"/health/discussion/selectDiscussion.do?disseq="+division.getDisseq()+"&categoryId="+categoryId);
	}

	@RequestMapping("/health/discussion/modifyDivisionPage.do")
	public String modifyDivisionPage(
			@ModelAttribute("division") Division division,
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null)
    	{
    		throw new EgovBizException("사용자 정보가 없습니다.!");
    	}
		EgovMap discussionZvl = discussionService.selectDiscussionByDisseq(division.getDisseq());
		EgovMap divionZvl = discussionService.selectDivisionByDivseq(division.getDivseq());

		model.addAttribute("result", discussionZvl);
		model.addAttribute("division", divionZvl);

		model.addAttribute("includePage", "/health/dev_content/discussion/writeDivision.jsp");
		return Globals.HEALTH_MAIN_PAGE;
	}
	
	@RequestMapping("/health/discussion/modifyDivision.do")
	public void modifyDivision(
			@ModelAttribute("division") Division division,
			@RequestParam("categoryId") String categoryId,
			HttpServletRequest request, 
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null)
    	{
    		throw new EgovBizException("사용자 정보가 없습니다.!");
    	}
		discussionService.modifyDivision(division);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
    			"/health/discussion/selectDiscussion.do?disseq="+division.getDisseq()+"&categoryId="+categoryId);
	}	
}
