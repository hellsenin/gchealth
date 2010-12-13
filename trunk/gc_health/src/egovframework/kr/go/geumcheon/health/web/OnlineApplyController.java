package egovframework.kr.go.geumcheon.health.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.ApplicationFactory;
import egovframework.kr.go.geumcheon.health.service.ApplyMstService;
import egovframework.kr.go.geumcheon.health.service.CalenderService;
import egovframework.kr.go.geumcheon.health.service.OnlineApplyService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class OnlineApplyController {

    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "applyMstService")
    protected ApplyMstService applyMstService;

    @Resource(name = "onlineApplyService")
    protected OnlineApplyService onlineApplyService;

    @Resource(name = "applicationFactory")
    protected ApplicationFactory applicationFactory;

	@Resource(name="calenderService")
	private CalenderService calenderService = null;

	@Resource(name = "webFactory")
	protected WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/health/onlineApply/selectOnlineApplyCalendar.do")
	public String selectOnlineApplyCalendar(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);

		String calendarStr = calenderService.getOnlineApplyCalendar(zvl);
		model.addAttribute("calendarStr", calendarStr);
		
		String includePage = "/health/dev_content/onlineApply/onlineApplyCalendar.jsp";
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/onlineApply/selectEventCalendar.do")
	public String selectEventCalendar(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);

		String calendarStr = calenderService.getEventCalendar(zvl);
		model.addAttribute("calendarStr", calendarStr);
		
		String includePage = "/health/dev_content/onlineApply/onlineApplyCalendar.jsp";
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/onlineApply/listOnlineApply.do")
	public String listOnlineApply(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		

    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");

		ZValue applyMst = applyMstService.selectApplyMst(applyCode);
		model.addAttribute("applyMst", applyMst);
		
		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
    	
		Map<String, Object> map = onlineApplyService.selectOnlineApplyList(pageInfo);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    	zvl.put("totCnt", totCnt);
		log.debug("zvl :: " + zvl);

    	String link = "/health/onlineApply/listOnlineApply.do?applyCode="+applyCode+"&categoryId="+zvl.getString("categoryId");
    	pageInfo.put("link", link);
		
		String pageNav = PageUtil.getSgPageNavString(pageInfo);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("zvl", zvl);
		model.addAttribute("pageNav", pageNav);

    	String includePage = "/health/dev_content/onlineApply/listOnlineApply.jsp";
		log.debug("includePage :: " + includePage);

		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/onlineApply/selectOnlineApply.do")
	public String selectOnlinApply(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);

		String applyCode = zvl.getString("applyCode");
		
		ZValue applyMst = applyMstService.selectApplyMst(applyCode);
		model.addAttribute("applyMst", applyMst);
		
		ZValue result = onlineApplyService.selectOnlineApply(zvl);
		model.addAttribute("result", result);
		String includePage = "/health/dev_content/onlineApply/selectOnlineApply.jsp";
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/onlineApply/selectRecentOnlineApply.do")
	public String selectRecentOnlineApply(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);
		ZValue result = onlineApplyService.selectRecentOnlineApply(zvl.getString("applyCode"));
		model.addAttribute("result", result);
		String includePage = "/health/dev_content/onlineApply/"+zvl.getString("applyCode")+"SelectOnlineApply.jsp";
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

}
