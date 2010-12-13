package egovframework.kr.go.geumcheon.health.web;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.FileDownloadService;
import egovframework.kr.go.geumcheon.health.service.PollService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Answer;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;

@Controller
public class PollController {

    Logger log = Logger.getLogger(this.getClass());

	@Resource(name="pollService")
	private PollService service = null;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;
    
	@RequestMapping("/health/poll/list.do")
	public String list(
		 HttpServletRequest request
		, HttpServletResponse response 
		, ModelMap model) throws Exception 
	{
		// 리스트 불러오기
    	ZValue zvl = WebFactory.getAttributes(request);
		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
		
		HashMap<String, Object> map = service.selectAllMasterList(pageInfo);
		model.addAttribute("ongoingResultList", map.get("ongoingResultList"));
		
		int totCnt = (Integer)map.get("finishedCnt");

    	zvl.put("totCnt", totCnt);
    	String link = "/health/poll/list.do"+
    		"?categoryId="+zvl.getString("categoryId");
    	zvl.put("link", link);

		String pageNav = PageUtil.getSgPageNavString(pageInfo);
		log.debug("###########pageNav :: " + pageNav);

		model.addAttribute("finishedResultList", map.get("finishedResultList"));
		model.addAttribute("zvl", pageInfo);
		model.addAttribute("pageNav", pageNav);
		
		String includePage = "/health/dev_content/poll/list.jsp";

		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}
	
	@RequestMapping("/health/poll/view.do")
	public String selectCheckStateView(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{	
		// 점검표 불러오기
		service.selectCheckStateView(bean, model);
		
		String includePage = "/health/dev_content/poll/view.jsp";

		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/poll/forCheck.do")
	public String forCheck(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{	
		// 점검표 불러오기 (생략 가능)
		service.selectCheckStateView(bean, model);

		// 업소 정보 불러오기 
		service.selectCompanyInfo(bean, model);
		
		UsersVO user = WebFactory.getUserInfo(request);
		if(user == null) user = new UsersVO();

		bean.setCompany_id(user.getWebMemId());
		model.addAttribute("companyInfo", bean);
		
		String includePage = "/health/dev_content/poll/check.jsp";
		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/poll/check.do")
	public void check(
			@ModelAttribute("Bean") Answer bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {
		 
		// Answer1 체크하기
		ZValue zvl = WebFactory.getAttributes(request);
		log.debug(">>>>>>>>>>>zvl : " + zvl);
		
		UsersVO user = WebFactory.getUserInfo(request);
		if(user == null)
		{
			zvl.put("companyId", "ananymouse");
		}
		else
		{
			zvl.put("companyId", user.getWebMemId());
		}
		
		List<Answer> answer2list = service.getZvl(zvl);
		service.check(bean, answer2list, model);

		WebFactory.printHtml(response, "설문에 응해주셔서 감사합니다.", 
				"/health/poll/checkResult.do" +
				"?master_cd="+zvl.getString("masterCd") +
				"&categoryId="+zvl.getString("categoryId"));
	}

	@RequestMapping("/health/poll/testCheckResult.do")
	public String testCheckResult(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{
		// 리스트 조회
		service.selectTestQuestionList(bean, model);
		
		String includePage = "/health/dev_content/poll/checkResult.jsp";
		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}

	/**
	 * 금천구 지역보건의료계획 관련 설문조사 만족도 체크한경ㅇ
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/health/poll/checkResult.do")
	public String checkResult(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{
		// 리스트 조회
		service.selectQuestionList(bean, model);
		
		String includePage = "/health/dev_content/poll/checkResult.jsp";
		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/poll/selectOtherList.do")
	public String selectOtherList(
			  HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{
		ZValue zvl = WebFactory.getAttributes(request);
		
		// 리스트 조회
		List<ZValue> otherList = service.selectOtherList(zvl);
		model.addAttribute("otherList", otherList);
		
		String includePage = "health/dev_content/poll/otherList";
		model.addAttribute("includePage", includePage);
		return includePage;
	}

	@RequestMapping("/health/poll/selectEssayList.do")
	public String selectEssayList(
			  HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{
		ZValue zvl = WebFactory.getAttributes(request);
		log.debug("--------zvl : " + zvl);
		// 리스트 조회
		List<ZValue> otherList = service.selectEssayList(zvl);
		model.addAttribute("otherList", otherList);
		
		String includePage = "health/dev_content/poll/otherList";
		model.addAttribute("includePage", includePage);
		return includePage;
	}

	@Resource(name = "FileDownloadService")
	private FileDownloadService fileDownloadService = null;

	@RequestMapping("/health/poll/download.do")
	public String download(
		@ModelAttribute("Bean") Company bean
		, HttpServletRequest request
		, HttpServletResponse response 
		, ModelMap model) throws Exception {


		fileDownloadService.download(request, response, "poll", request.getParameter("file"));
		
		return "";
	}
    
}
