package egovframework.kr.go.geumcheon.health.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.kr.go.geumcheon.health.service.ApplyMstService;
import egovframework.kr.go.geumcheon.health.service.OnlineApplyService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminOnlineApplyController {

    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "applyMstService")
    protected ApplyMstService applyMstService;

    @Resource(name = "onlineApplyService")
    protected OnlineApplyService onlineApplyService;

	@Resource(name = "webFactory")
	protected WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/admin/health/onlineApply/registOnlineApplyPage.do")
	public String registOnlineApplyPageA(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
		ZValue applyMst = applyMstService.selectApplyMst(zvl.getString("applyCode"));
		model.addAttribute("applyMst", applyMst);
		return "admin/health/onlineApply/RegistOnlineApply";
	}

	@RequestMapping("/admin/health/onlineApply/modifyOnlineApplyPage.do")
	public String modifyOnlineApplyPageA(
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
		
		String forwardPage = "admin/health/onlineApply/RegistOnlineApply";
		
		return forwardPage;
	}

	@RequestMapping("/admin/health/onlineApply/excelApplicantList.do")
	public String excelApplicantListA(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
		ZValue applyMst = applyMstService.selectApplyMst(zvl.getString("applyCode"));
		model.addAttribute("applyMst", applyMst);
		
		List resultList = onlineApplyService.excelApplicantList(zvl);
		model.addAttribute("resultList", resultList);
		return "admin/health/onlineApply/ExcelApplicantList";
	}

	@RequestMapping("/admin/health/onlineApply/modifyOnlineApply.do")
	public void modifyOnlineApplyA(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);
		
		onlineApplyService.modifyOnlineApply(zvl);

	    String forwardUrl = "/admin/health/onlineApply/listOnlineApply.do?applyCode="+zvl.getString("applyCode");
	    
	    WebFactory.printHtml(response, "성공적으로 수정되었습니다.", forwardUrl);	    
	}
	/**
	 * 대학생 아르바이트 신청자리스트
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/health/onlineApply/selectApplicantList.do")
	public String selectA013ApplicantList(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		

    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");

		ZValue result = onlineApplyService.selectOnlineApply(zvl);
		model.addAttribute("result", result);
		
		if("".equals(zvl.getString("status")))
		{
			zvl.put("status", "1");
		}

		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
    	
		Map<String, Object> map = onlineApplyService.selectApplicantList(pageInfo);
		int totCnt = (Integer)map.get("resultCnt");
    	zvl.put("totCnt", totCnt);
		log.debug("zvl :: " + zvl);

    	String link = "/admin/health/onlineApply/selectApplicantList.do?applyCode="+applyCode+
			"&onlineId="+zvl.getString("onlineId")+
			"&status="+zvl.getString("status");
    	zvl.put("link", link);
		
		String pageNav = PageUtil.getSgPageNavString(pageInfo);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("zvl", zvl);
		model.addAttribute("pageNav", pageNav);

    	String includePage = "admin/health/onlineApply/SelectApplicantList";
		log.debug("includePage :: " + includePage);

		return includePage;
	}
	
	@RequestMapping("/admin/health/onlineApply/registOnlineApply.do")
	public void registOnlineApplyA(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);
		
		onlineApplyService.registOnlineApply(zvl);

	    String forwardUrl = "/admin/health/onlineApply/listOnlineApply.do?applyCode="+zvl.getString("applyCode");
	    
	    WebFactory.printHtml(response, "성공적으로 등록되었습니다.", forwardUrl);	    
	}

	@RequestMapping("/admin/health/onlineApply/delOnlineApply.do")
	public void delOnlineApplyA(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);
		
		onlineApplyService.delOnlineApply(zvl);

	    String forwardUrl = "/admin/health/onlineApply/listOnlineApply.do?applyCode="+zvl.getString("applyCode");
	    
	    WebFactory.printHtml(response, "성공적으로 삭제되었습니다.", forwardUrl);	    
	}
	
	@RequestMapping("/admin/health/onlineApply/listOnlineApply.do")
	public String listOnlineApplyA(
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

    	String link = "/health/onlineApply/listOnlineApply.do?applyCode="+applyCode;
    	zvl.put("link", link);

		String pageNav = PageUtil.getSgPageNavString(pageInfo);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("zvl", zvl);
		model.addAttribute("pageNav", pageNav);

    	String includePage = "admin/health/onlineApply/ListOnlineApply";
		log.debug("includePage :: " + includePage);

		return includePage;
	}

	@RequestMapping("/admin/health/onlineApply/lotteryOnlineApply.do")
	public void lotteryOnlineApplyA(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl : " + zvl);

    	String resultCode = "1";
    	try
    	{
    		onlineApplyService.lotteryOnlineApply(zvl);
    	}
    	catch(Exception e)
    	{
    		resultCode = "0";
    	}
    	
    	zvl.put("resultCode", resultCode);

		String resultValue = zvl.getJSONValue();
		log.debug("resultValue : " + resultValue);
		response.setContentType("application/x-json; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(resultValue);	    
	}
}
