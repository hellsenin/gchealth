package egovframework.kr.go.geumcheon.health.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.kr.go.geumcheon.health.service.InfoCustomMadeService;
import egovframework.kr.go.geumcheon.health.service.MasterMenuManagerService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminInfoCustomMadeController
{    	
	protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "infoCustomMadeService")
    protected InfoCustomMadeService infoCustomMadeService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "masterMenuManagerService")
    protected MasterMenuManagerService masterMenuManagerService;
    
    @Resource(name = "webFactory")
    protected WebFactory WebFactory;

	@RequestMapping("/admin/health/infoCustomMade/selectCustomMainMenuCategoryList.do")
	public String selectCustomMainMenuCategoryList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
		List<ZValue> sortedResultList = infoCustomMadeService.selectCustomMainMenuCategorySortOrdrList();
        model.addAttribute("sortedResultList", sortedResultList);
		
        Map<String, List<ZValue>> resultMap = infoCustomMadeService.selectCustomMainMenuCategoryList();
        model.addAttribute("resultMap", resultMap);
		return "admin/health/infoCustomMade/selectCustomMainMenuCategoryList";
	}

	@RequestMapping("/admin/health/infoCustomMade/selectCustomMainMenuCategory.do")
	public String selectCustomMainMenuCategory(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	ZValue result = infoCustomMadeService.selectCustomMainMenuCategory(zvl.getString("cstmId"));
        model.addAttribute("result", result);
    	
    	List list_menulist = infoCustomMadeService.selectCustomMainMenuA(zvl);
    	HashMap menuCategoryMap = masterMenuManagerService.getMenuCategories(list_menulist);
        model.addAttribute("menuCategoryMap", menuCategoryMap);
		return "admin/health/infoCustomMade/addCustomMainMenu";
	}

	@RequestMapping("/admin/health/infoCustomMade/addCustomMainMenuCategoryPage.do")
	public String addCustomMainMenuCategoryPage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
		return "admin/health/infoCustomMade/addCustomMainMenuCategory";
	}

	@RequestMapping("/admin/health/infoCustomMade/delCustomMainMenuCategory.do")
	public void delCustomMainMenuCategory(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	String resultCode = "1";
    	String resultMsg = "성공적으로 업데이트 되었습니다.";
    	try
    	{
    		infoCustomMadeService.delCustomMainMenuCategory(zvl.getString("cstmId"));
    	}
    	catch(Exception e)
    	{
    		resultCode = "0";
    		resultMsg = e.getMessage();
    	}
    	
    	ZValue result = new ZValue();
    	result.put("resultCode", resultCode);
    	result.put("resultMsg", resultMsg);
		String resultValue = result.getJSONValue();
		log.debug("resultValue : " + resultValue);
		response.setContentType("application/x-json; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(resultValue);
	}

	@RequestMapping("/admin/health/infoCustomMade/modifyCustomMainMenuCategoryPage.do")
	public String modifyCustomMainMenuCategoryPage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		ZValue result = infoCustomMadeService.selectCustomMainMenuCategory(zvl.getString("cstmId"));
        model.addAttribute("result", result);
		return "admin/health/infoCustomMade/addCustomMainMenuCategory";
	}

	@RequestMapping("/admin/health/infoCustomMade/modifyCustomMainMenuCategory.do")
	public void modifyCustomMainMenuCategory(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	infoCustomMadeService.updateCustomMainMenuCategory(zvl);
    	
    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
    			"/admin/health/infoCustomMade/selectCustomMainMenuCategoryList.do?siteId="+zvl.getString("siteId"));
	}
	
	@RequestMapping("/admin/health/infoCustomMade/addCustomMainMenuCategory.do")
	public void addCustomMainMenuCategory(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	infoCustomMadeService.addCustomMainMenuCategory(zvl);
    	
    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
    			"/admin/health/infoCustomMade/selectCustomMainMenuCategoryList.do");
	}
	
	@RequestMapping("/admin/health/infoCustomMade/addCustomMainMenuPage.do")
	public String addCustomMainMenuPage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	List list_menulist = infoCustomMadeService.selectCustomMainMenuA(zvl);
    	HashMap menuCategoryMap = masterMenuManagerService.getMenuCategories(list_menulist);
        model.addAttribute("menuCategoryMap", menuCategoryMap);
		return "admin/health/infoCustomMade/addCustomMainMenu";
	}

	@RequestMapping("/admin/health/infoCustomMade/addCustomMainMenu.do")
	public void addCustomMainMenu(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	String[] checkFieldes = request.getParameterValues("checkField");
    	zvl.put("checkFieldes", checkFieldes);
    	
    	String resultMsg = "성공적으로 등록되었습니다.";
    	log.debug("###############zvl : " + zvl);
    	infoCustomMadeService.addCustomMainMenu(zvl);
		//model.addAttribute("resultMsg", resultMsg);
		//WebFactory.printHtml(response, resultMsg, 
		//		"/admin/health/deptMenuCreatSelect.do?mapcreatId="+zvl.getString("mapcreatId"));
    	WebFactory.printHtml(response, resultMsg, 
    			"/admin/health/infoCustomMade/selectCustomMainMenuCategoryList.do?siteId="+zvl.getString("siteId"));
	}

	@RequestMapping("/admin/health/infoCustomMade/updateCustomMainMenu.do")
	public void updateCustomMainMenu(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	String[] checkFieldes = request.getParameterValues("checkField");
    	zvl.put("checkFieldes", checkFieldes);
    	
    	String resultMsg = "성공적으로 등록되었습니다.";
    	log.debug("###############zvl : " + zvl);
    	infoCustomMadeService.addCustomMainMenu(zvl);
		//model.addAttribute("resultMsg", resultMsg);
		//WebFactory.printHtml(response, resultMsg, 
		//		"/admin/health/deptMenuCreatSelect.do?mapcreatId="+zvl.getString("mapcreatId"));
    	WebFactory.printHtml(response, resultMsg, "javascript:history.back();");
	}

	@RequestMapping("/admin/health/infoCustomMade/customMainMenuList.do")
	public String customMainMenuList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	List list_menulist = infoCustomMadeService.selectedCustomMainMenuA(zvl.getString("cstmId"));
    	HashMap menuCategoryMap = masterMenuManagerService.getMenuCategories(list_menulist);
        model.addAttribute("menuCategoryMap", menuCategoryMap);
		return "admin/health/infoCustomMade/customMainMenuList";
	}

	@RequestMapping("/admin/health/infoCustomMade/updateCstmMenu.do")
	public void updateCstmMenu(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	String resultCode = "1";
    	String resultMsg = "성공적으로 업데이트 되었습니다.";
    	try
    	{
    		infoCustomMadeService.updateCustomMainMenu(zvl);
    	}
    	catch(Exception e)
    	{
    		resultCode = "0";
    		resultMsg = e.getMessage();
    	}
    	
    	ZValue result = new ZValue();
    	result.put("resultCode", resultCode);
    	result.put("resultMsg", resultMsg);
		String resultValue = result.getJSONValue();
		log.debug("resultValue : " + resultValue);
		response.setContentType("application/x-json; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(resultValue);
	}

	@RequestMapping("/admin/health/infoCustomMade/delCstmMenu.do")
	public void delCstmMenu(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	String resultCode = "1";
    	String resultMsg = "성공적으로 삭제 되었습니다.";
    	try
    	{
    		infoCustomMadeService.delCustomMainMenu(zvl);
    	}
    	catch(Exception e)
    	{
    		resultCode = "0";
    		resultMsg = e.getMessage();
    	}
    	
    	ZValue result = new ZValue();
    	result.put("resultCode", resultCode);
    	result.put("resultMsg", resultMsg);
		String resultValue = result.getJSONValue();
		log.debug("resultValue : " + resultValue);
		response.setContentType("application/x-json; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(resultValue);
	}

}
