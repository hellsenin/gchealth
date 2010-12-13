package egovframework.kr.go.geumcheon.health.web;

import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.kr.go.geumcheon.health.service.SatisfactionService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class SatisfactionController
{    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name="satisfactionService")
	private SatisfactionService satisfactionService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/health/satisfaction/saveSatisfaction.do")
	public void saveSatisfaction(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	
		String resultMsg = null;
    	String userIp = EgovClntInfo.getClntIP(request);
    	zvl.put("userIp", userIp);
    	
    	if(satisfactionService.existsUserIp(zvl) > 0)
    	{
    		resultMsg = "이미 참여하셨습니다.";
    	}
    	else
    	{
    		resultMsg = "만족도 평가에 참여해 주셔서 감사합니다.";
    		satisfactionService.saveSatisfaction(zvl);
    	}
    	
		WebFactory.printHtml(response, resultMsg, "javascript:history.back()");
				
	}

	@RequestMapping("/admin/health/satisfaction/satisfactionList.do")
	public String satisfactionList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
		
		Map<String, Object> map = satisfactionService.selectSatisfactionList(zvl);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    	zvl.put("totCnt", totCnt);

    	String link = 
    		"/admin/health/satisfaction/satisfactionList.do?" +
    		"siteId="+zvl.getString("siteId")+
    		"&searchType="+zvl.getString("searchType")+
    		"&searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8");
    	zvl.put("link", link);
		
		String pageNav = PageUtil.getSgPageNavString(pageInfo);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("zvl", zvl);
		model.addAttribute("pageNav", pageNav);
		
		return "admin/health/satisfaction/satisfactionList";
	}
}
