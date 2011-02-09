package egovframework.kr.go.geumcheon.health.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.ServletContextAware;

import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.InfoCustomMadeService;
import egovframework.kr.go.geumcheon.health.service.MasterMenuManagerService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Controller
public class AdminCategoryController implements ServletContextAware 
{
    @Resource(name = "masterMenuManagerService")
    protected MasterMenuManagerService masterMenuManagerService;

    @Resource(name = "infoCustomMadeService")
    protected InfoCustomMadeService infoCustomMadeService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	private ServletContext servletContext;
	
	public void setServletContext(ServletContext servletContext)
	{
		this.servletContext = servletContext;
	}

    @RequestMapping(value="/admin/health/category/reloadList.do")
    public String reloadList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
    {
    	return "admin/health/category/reloadList";
    }

	@RequestMapping("/admin/health/category/reloadMenu.do")
	public void reloadMenu(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{	
    	ZValue zvl = WebFactory.getAttributes(request);
    	String siteId = zvl.getString("siteId");
    	if("14".equals(siteId)) //보건소
    	{
    		HashMap<String, Object> map = masterMenuManagerService.reloadMenu("14");
    		servletContext.setAttribute("healthMenuCategoryMap", map.get("healthMenuCategoryMap"));
    		servletContext.setAttribute("healthMenuMap", map.get("healthMenuMap"));
    	}
    	else if("15".equals(siteId)) //영문보건소
    	{
    		masterMenuManagerService.initXmlCategory("eng");
			List<ZValue> menuList = masterMenuManagerService.getXMLCategoryList("eng");
	    	HashMap<String, List<ZValue>> menuCategoryMap = masterMenuManagerService.getMenuCategories(menuList);
	    	servletContext.setAttribute("englishMenuCategoryMap", menuCategoryMap);
	    	servletContext.setAttribute("englishMenuMap", masterMenuManagerService.getCategoryMap(menuList));
    	}
    	else if("16".equals(siteId)) //일문보건소
    	{
    		masterMenuManagerService.initXmlCategory("jap");
			List<ZValue> menuList = masterMenuManagerService.getXMLCategoryList("jap");
	    	HashMap<String, List<ZValue>> menuCategoryMap = masterMenuManagerService.getMenuCategories(menuList);
	    	servletContext.setAttribute("japaneseMenuCategoryMap", menuCategoryMap);
	    	servletContext.setAttribute("japaneseMap", masterMenuManagerService.getCategoryMap(menuList));
    	}
    	else if("17".equals(siteId)) //중문보건소
    	{
    		masterMenuManagerService.initXmlCategory("chn");
			List<ZValue> menuList = masterMenuManagerService.getXMLCategoryList("chn");
	    	HashMap<String, List<ZValue>> menuCategoryMap = masterMenuManagerService.getMenuCategories(menuList);
	    	servletContext.setAttribute("chinaMenuCategoryMap", menuCategoryMap);
	    	servletContext.setAttribute("chinaMenuMap", masterMenuManagerService.getCategoryMap(menuList));
    	}
    	else if("18".equals(siteId)) //베트남보건소
    	{
    		masterMenuManagerService.initXmlCategory("btn");
			List<ZValue> menuList = masterMenuManagerService.getXMLCategoryList("btn");
	    	HashMap<String, List<ZValue>> menuCategoryMap = masterMenuManagerService.getMenuCategories(menuList);
	    	servletContext.setAttribute("btnMenuCategoryMap", menuCategoryMap);
	    	servletContext.setAttribute("btnMenuMap", masterMenuManagerService.getCategoryMap(menuList));
    	}

    	
		WebFactory.printHtml(response, "성공적으로 적용되었습니다.", "javascript:history.back();");
				
	}

	@RequestMapping("/admin/health/category/gcReloadMenu.do")
	public void gcReloadMenu(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{	
    	ZValue zvl = WebFactory.getAttributes(request);
		HashMap<String, Object> map = masterMenuManagerService.gcReloadMenu(zvl.getString("siteId"));

		servletContext.setAttribute("healthMenuCategoryMap", map.get("healthMenuCategoryMap"));
		servletContext.setAttribute("healthMenuMap", map.get("healthMenuMap"));
    	
		WebFactory.printHtml(response, "성공적으로 적용되었습니다.", "");
				
	}

	@RequestMapping("/admin/health/category/createTempContentsFile.do")
	public void createTempContentsFile(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
		masterMenuManagerService.createTempContentsFile();
    	
		WebFactory.printHtml(response, "성공적으로 적용되었습니다.", "javascript:history.back()");
				
	}

	@RequestMapping("/admin/health/category/addTempFolderMap.do")
	public void addTempFolderMap(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
		masterMenuManagerService.addTempFolderMap();
    	
		WebFactory.printHtml(response, "성공적으로 적용되었습니다.", "javascript:history.back()");
				
	}

    @RequestMapping(value="/admin/main/arrangeProgramList.do")
    public String arrangeProgramList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
    {
    	ZValue zvl = WebFactory.getAttributes(request);
    	String siteId = zvl.getString("siteId");
    	List<ZValue> resultList = masterMenuManagerService.selectProgramList(siteId);
    	
    	String prefix = "http://bogunso.geumcheon.go.kr";
    	for(ZValue result : resultList)
    	{
    		URLConnection connection = null;
    		String fullMenuLink = result.getString("fullMenuLink").replaceAll("&amp;", "&")+"&dong=01";
    		try 
    		{
    			URL url = new URL(prefix+fullMenuLink);
    			connection = url.openConnection();
    		} 
    		catch (MalformedURLException e) 
    		{
    			e.printStackTrace();
    		} 
    		catch (IOException e) 
    		{
    			e.printStackTrace();
    		}
    		BufferedReader in = null;
    		try 
    		{
    			in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));

    			String inputLine;
    			while ((inputLine = in.readLine()) != null) 
    			{
    			}
    		} 
    		catch (IOException e) 
    		{
    			e.printStackTrace();
    		}
    		finally
    		{
    			try
    			{
    				if(in != null) in.close();
    			}
    			catch(Exception ignore)
    			{
    				
    			}
    		}
    	}

        model.addAttribute("resultList", resultList);

    	return "admin/programList";
    }

    @RequestMapping(value="/admin/main/selectProgramList.do")
    public String selectProgramList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
    {
    	ZValue zvl = WebFactory.getAttributes(request);
    	String siteId = zvl.getString("siteId");
    	List<ZValue> resultList = masterMenuManagerService.selectProgramList(siteId);
    	
        model.addAttribute("resultList", resultList);

    	return "admin/programList";
    }

    @RequestMapping(value="/admin/main/selectMenuCategory.do")
    public String selectMenuCategory(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
    {
    	ZValue zvl = WebFactory.getAttributes(request);

    	List list_menulist = infoCustomMadeService.selectCustomMainMenuA(zvl);
    	HashMap menuCategoryMap = masterMenuManagerService.getMenuCategories(list_menulist);
        model.addAttribute("menuCategoryMap", menuCategoryMap);
        
    	String categoryId = zvl.getString("categoryId");
    	ZValue result = masterMenuManagerService.selectContent(categoryId);
        model.addAttribute("result", result);

    	return "admin/health/contents/contents";
    }

    @RequestMapping(value="/admin/main/selectContent.do")
    public String selectContentsPath(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
    {
    	ZValue zvl = WebFactory.getAttributes(request);
    	String categoryId = zvl.getString("categoryId");
    	ZValue result = masterMenuManagerService.selectContent(categoryId);
        model.addAttribute("result", result);

    	return "admin/health/contents/incContents";
    }

    @RequestMapping(value="/admin/main/saveContent.do")
    public void saveContent(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
    {
    	ZValue zvl = WebFactory.getAttributes(request);
    	String categoryId = zvl.getString("categoryId");
    	String content = "<%@page contentType=\"text/html;charset=utf-8\" %>" + zvl.getString("content");
    	if(masterMenuManagerService.saveContent(zvl.getString("contentsPath"), content)){
    		WebFactory.printHtml(response, "성공적으로 저장되었습니다.", "/admin/main/selectContent.do?categoryId="+categoryId);
    	}
    	else
    	{
    		WebFactory.printHtml(response, "파일저장시 오류가 발생하였습니다.", "javascript:history.back();");
    	}

    }

}
