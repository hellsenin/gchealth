package egovframework.kr.go.geumcheon.health.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.kr.go.geumcheon.health.service.ApplyMstService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Controller
public class AdminApplyMstController
{    
    @Resource(name = "applyMstService")
    protected ApplyMstService applyMstService;
    
	@Resource(name = "webFactory")
	private WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/admin/health/applyMst/writePage.do")
	public String writePage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{		
		return "admin/health/applyMst/applyMstWrite";
	}

	@RequestMapping("/admin/health/applyMst/modifyPage.do")
	public String modifyPage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
    	ZValue result = applyMstService.selectApplyMst(zvl.getString("applyCode"));
		model.addAttribute("result", result);
		return "admin/health/applyMst/applyMstWrite";
	}

	@RequestMapping("/admin/health/applyMst/modifyApplyMst.do")
	public void modifyApplyMst(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	applyMstService.modifyApplyMst(zvl);
    	
		WebFactory.printHtml(response, "성공적으로 수정되었습니다.", "/admin/health/applyMst/selectApplyMstList.do");
				
	}

	@RequestMapping("/admin/health/applyMst/addApplyMst.do")
	public void addApplyMst(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	applyMstService.addApplyMst(zvl);
    	
		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", "/admin/health/applyMst/selectApplyMstList.do");
				
	}

	@RequestMapping("/admin/health/applyMst/selectApplyMstList.do")
	public String selectApplyMstList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
		
		int totCnt = applyMstService.selectApplyMstListCnt(zvl);
		pageInfo.put("totCnt", totCnt);
		List<ZValue> resultList = applyMstService.selectApplyMstList(zvl);
    	String link = "/admin/health/applyMst/selectApplyMstList.do" +
    			"?searchType="+zvl.getString("searchType")+
    			"&searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8");
    	pageInfo.put("link", link);
		
		String pageNav = PageUtil.getSgPageNavString(pageInfo);

		model.addAttribute("resultList", resultList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("pageNav", pageNav);
		
		return "admin/health/applyMst/applyMstList";
	}
}
