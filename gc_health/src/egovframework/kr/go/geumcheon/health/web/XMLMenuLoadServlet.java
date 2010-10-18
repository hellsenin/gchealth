package egovframework.kr.go.geumcheon.health.web;


import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import egovframework.kr.go.geumcheon.health.service.MasterMenuManagerService;
import egovframework.kr.go.geumcheon.health.util.ZValue;

public class XMLMenuLoadServlet extends HttpServlet 
{
	
	private static final long serialVersionUID = 1L;
	
	private static MasterMenuManagerService MasterMenuManager = new MasterMenuManagerService();
	
	public void init(ServletConfig config) throws ServletException 
	{
		System.out.println("####################### XMLMenuLoadServlet Loading.............................");
		try
		{
			List<ZValue> healthList = MasterMenuManager.getXMLCategoryList("eng");
	    	HashMap<String, List<ZValue>> menuCategoryMap = MasterMenuManager.getMenuCategories(healthList);
			//System.out.println("healthMenuCategoryMap ....." + map);
			ServletContext context = config.getServletContext();
			context.setAttribute("healthMenuCategoryMap", menuCategoryMap);
			context.setAttribute("healthMenuMap", MasterMenuManager.getCategoryMap(healthList));
			System.out.println("healthMenuCategoryMap Loaded.....");
	
		}
		catch(Exception e)
		{
			System.out.println("error2 :(" + e);
		}
		finally
		{
			
		}
		
		System.out.println("####################### XMLMenuLoadServlet Finished.............................");
	}
	
	public static void main(String[] args)throws Exception{

		List<ZValue> healthList = MasterMenuManager.getXMLCategoryList("eng");
    	HashMap<String, List<ZValue>> menuCategoryMap = MasterMenuManager.getMenuCategories(healthList);
	}
}
