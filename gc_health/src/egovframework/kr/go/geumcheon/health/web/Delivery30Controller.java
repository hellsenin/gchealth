package egovframework.kr.go.geumcheon.health.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.kr.go.geumcheon.health.service.ApplicationFactory;
import egovframework.kr.go.geumcheon.health.service.ApplyMstService;
import egovframework.kr.go.geumcheon.health.service.CalenderService;
import egovframework.kr.go.geumcheon.health.service.OnlineApplyService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class Delivery30Controller {

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

	@RequestMapping("/health/delibery/selectDelivery30Calendar.do")
	public String selectDelivery30Calendar(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);
		
		String calendarStr = calenderService.getDeliveryCalendar(zvl);
		model.addAttribute("calendarStr", calendarStr);
		
		if(request.getParameter("dayAfter") != null){
			int dayAfter = Integer.parseInt(request.getParameter("dayAfter"));
			model.addAttribute("dayAfter", dayAfter);
		}
		
		String includePage = "/health/dev_content/delivery30/delivery30Calendar.jsp";
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}
	
	@RequestMapping("/health/delibery/resultDelivery30Calendar.do")
	public String resultDelivery30Calendar(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);
		
		String selMonth = request.getParameter("selMonth");
    	if(Integer.parseInt(request.getParameter("selMonth")) < 10 ){
    		selMonth = "0"+request.getParameter("selMonth");
    	}
    	String selDay = request.getParameter("selDay");
    	if(Integer.parseInt(request.getParameter("selDay")) < 10 ){
    		selDay = "0"+request.getParameter("selDay");
    	}
		String date = request.getParameter("selYear")+selMonth;
		String delDay = request.getParameter("selYear")+selMonth+selDay;
		zvl.setValue("date", date);
		zvl.setValue("delDay", delDay);
		String calendarStr = calenderService.getDeliveryCalendar(zvl);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); 
		String today = sdf.format(new Date());
		int dayAfter = EgovDateUtil.getDaysDiff(today,delDay);
		model.addAttribute("dayAfter", dayAfter);
		model.addAttribute("calendarStr", calendarStr);
		
		String includePage = "/health/dev_content/delivery30/delivery30Calendar.jsp";
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

}
