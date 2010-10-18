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
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Discussion;
import egovframework.kr.go.geumcheon.health.vo.Division;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdminDiscussionController {

    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "discussionService")
    protected DiscussionService discussionService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

    @Resource(name = "webFactory")
    protected WebFactory WebFactory;

	@RequestMapping("/admin/health/discussion/writeDiscussionPage.do")
	public String writePage(
			HttpServletRequest request,
			ModelMap model) throws Exception
	{		
    	String forwardPage = "admin/health/discussion/insertDiscussion";
    	log.debug("forwardPage :: " + forwardPage);
		return forwardPage;
	}

	@RequestMapping("/admin/health/discussion/insertDiscussion.do")
	public void insertDiscussion(
			@ModelAttribute("discussion") Discussion discussion,
			HttpServletRequest request, 
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
		discussionService.insertDiscussion(discussion);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
    			"/admin/health/discussion/selectDiscussionList.do");
	}

	@RequestMapping("/admin/health/discussion/selectDiscussionList.do")
	public String selectDiscussionListA(
			@ModelAttribute("discussion") Discussion discussion,
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
    	
		List resultList = discussionService.selectDiscussionListA(discussion);
		int totCnt = discussionService.selectDiscussionCntA();
		paginationInfo.setTotalRecordCount(totCnt);
		
		String pageNav = PageUtil.getSgPageNavString(discussion.getPageUnit(), totCnt, discussion.getPageIndex(), 
				"/admin/health/discussion/selectDiscussionList.do");

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNav", pageNav);

    	String includePage = "admin/health/discussion/selectDiscussionList";
		log.debug("includePage :: " + includePage);

		return includePage;
	}

	@RequestMapping("/admin/health/discussion/modifyDiscussionPage.do")
	public String modifyDiscussionPageA(
			@ModelAttribute("discussion") Discussion discussion,
			HttpServletRequest request,
			ModelMap model) throws Exception
	{
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
				"/admin/health/discussion/modifyDiscussionPage.do?disseq="+disseq);

		model.addAttribute("divisionList", divisionList);
		model.addAttribute("divisionCnt", divisionCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNav", pageNav);
    	
		return "admin/health/discussion/insertDiscussion";
	}

	@RequestMapping("/admin/health/discussion/modifyDiscussion.do")
	public void modifyDiscussionA(
			@ModelAttribute("discussion") Discussion discussion,
			HttpServletRequest request, 
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
		discussionService.modifyDiscussion(discussion);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
    			"/admin/health/discussion/selectDiscussionList.do");
	}

	@RequestMapping("/admin/health/discussion/modifyDivision.do")
	public void modifyDivisionA(
			@ModelAttribute("division") Division division,
			HttpServletRequest request, 
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
		discussionService.modifyDivision(division);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
    			"/admin/health/discussion/selectDiscussionList.do");
	}
}
