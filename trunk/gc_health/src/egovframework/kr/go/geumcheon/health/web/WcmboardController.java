package egovframework.kr.go.geumcheon.health.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.WcmboardService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class WcmboardController
{    
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name="wcmboardService")
	private WcmboardService wcmboardService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/health/wcmboard/searchWcmboardList.do")
	public String searchWcmboardList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	log.debug(" zvl : " + zvl);
    	
    	String categoryId = zvl.getString("categoryId");
    	String branchId = zvl.getString("branchId");
    	if("".equals(categoryId) && !"".equals(branchId))
    	{
    		if("75".equals(branchId))
    			categoryId = "2993";
    		else if("76".equals(branchId))
    			categoryId = "2994";
    		else if("77".equals(branchId))
    			categoryId = "2995";
    		else if("78".equals(branchId))
    			categoryId = "2996";
    		else if("79".equals(branchId))
    			categoryId = "2997";
    		else if("80".equals(branchId))
    			categoryId = "2998";
    		else if("81".equals(branchId))
    			categoryId = "2999";
    		else if("82".equals(branchId))
    			categoryId = "3000";
    		else if("84".equals(branchId))
    			categoryId = "3001";
    		else if("85".equals(branchId))
    			categoryId = "3002";
    		else if("86".equals(branchId))
    			categoryId = "3003";
    		else if("87".equals(branchId))
    			categoryId = "3004";
    		else if("88".equals(branchId))
    			categoryId = "3005";
    		else if("89".equals(branchId))
    			categoryId = "3006";
    		else if("90".equals(branchId))
    			categoryId = "3007";
    	}

    	String link = "/health/wcmboard/selectWcmboardList.do?" +
    		"categoryId="+categoryId+
    		"&amp;communityId="+zvl.getString("communityId")+
    		"&amp;branchId="+branchId+
    		"&amp;searchType="+zvl.getString("searchType")+
    		"&amp;searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8")+
    		"&amp;position="+URLEncoder.encode(zvl.getString("position"),"UTF-8");
    	
    	return "forward:"+link;
	}

	@RequestMapping("/health/wcmboard/selectWcmboardList.do")
	public String selectWcmboardList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	log.debug(" zvl : " + zvl);
    	
    	String categoryId = zvl.getString("categoryId");
    	String branchId = zvl.getString("branchId");

    	String link = "/health/wcmboard/selectWcmboardList.do?" +
    		"categoryId="+categoryId+
    		"&amp;communityId="+zvl.getString("communityId")+
    		"&amp;branchId="+branchId+
    		"&amp;searchType="+zvl.getString("searchType")+
    		"&amp;searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8")+
    		"&amp;position="+URLEncoder.encode(zvl.getString("position"),"UTF-8");
    	zvl.put("link", link);

		int totCnt = wcmboardService.selectWcmboardListCnt(zvl);
		zvl.put("totCnt", totCnt);
		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
		
		List<ZValue> resultList = wcmboardService.selectWcmboardList(pageInfo);
		HashMap<String, List<ZValue>> fileMap = wcmboardService.selectWcmboardFileMap(pageInfo);

		String pageNav = PageUtil.getSgPageNavString(pageInfo);

		model.addAttribute("resultList", resultList);
		model.addAttribute("fileMap", fileMap);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("pageNav", pageNav);
		model.addAttribute("categoryId", categoryId);

		String includePage = "/health/dev_content/wcmboard/" + zvl.getString("communityId") + "List.jsp";
		model.addAttribute("includePage", includePage);
		
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/wcmboard/selectWcmboard.do")
	public String selectWcmboard(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	ZValue result = wcmboardService.selectWcmboard(zvl);
    	List<ZValue> fileList = wcmboardService.selectWcmboardFileListByBoardId(zvl);
		
		model.addAttribute("result", result);
		model.addAttribute("fileList", fileList);

		String includePage = "/health/dev_content/wcmboard/" + zvl.getString("communityId") + "View.jsp";
		model.addAttribute("includePage", includePage);
		
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/admin/wcmboard/uploadExcel.do")
	public void uploadExcel(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{

	    String msg = null;    	
    	if(wcmboardService.uploadTempExcel())
    	{
    		msg = "성공적으로 등록되었습니다.";
    	}
    	else
    	{
    		msg = "등록에 실패하였습니다.";
    	}
		WebFactory.printHtml(response, msg, "/admin/wcmboard/forUploadExcel.do");
	}

}
