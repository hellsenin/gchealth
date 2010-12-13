package egovframework.kr.go.geumcheon.health.web;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import egovframework.kr.go.geumcheon.health.service.MasterMenuManagerService;
import egovframework.kr.go.geumcheon.health.util.ZValue;

public class MenuLoadServlet extends HttpServlet 
{
	
	private static final long serialVersionUID = 1L;
	
	private static MasterMenuManagerService MasterMenuManager = new MasterMenuManagerService();
	
	public void init(ServletConfig config) throws ServletException 
	{
		System.out.println("####################### MenuLoadingServlet Loading.............................");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
	
		StringBuffer query = new StringBuffer();
		try
		{
			/*
			query.append("		SELECT \n");
			query.append("			 A.CATEGORY_ID \n");
			query.append("			,A.PARENT_ID \n");
			query.append("			,A.NAME \n");
			query.append("			,A.FULL_PATH \n");
			query.append("			,A.MENU_LINK \n");
			query.append("			,A.UPDATE_DATE \n");
			query.append("			,B.POSITION \n");
			query.append("			,B.FULL_MENU_LINK \n");
			query.append("			,B.FULL_LINK_PATH \n");
			query.append("			,C.TARGET_PATH AS CONTENTS_PATH \n");
			query.append("          ,A.SITE_ID \n");
			query.append("          ,A.MENU_POPUP_YN \n");
			query.append("		FROM gcweb.WCM_CATEGORY A \n");
			query.append("		LEFT OUTER JOIN CATEGORY_ADDITION B ON B.CATEGORY_ID = A.CATEGORY_ID \n");
			query.append("		LEFT OUTER JOIN gcweb.WCM_FOLDER_MAP C ON C.CATEGORY_ID = A.CATEGORY_ID \n");
			query.append("		WHERE A.SITE_ID = 11 AND A.STATUS = 'A' \n");
			query.append("		ORDER BY A.PARENT_ID ASC, A.SEQUENCE ASC \n");
			System.out.println("query : \n" + query);
		*/

			query.append("		SELECT \n");
			query.append("			 A.CATEGORY_ID \n");
			query.append("			,A.PARENT_ID \n");
			query.append("			,A.NAME \n");
			query.append("			,A.FULL_PATH \n");
			query.append("			,A.MENU_LINK \n");
			query.append("			,A.UPDATE_DATE \n");
			query.append("			,B.POSITION \n");
			query.append("			,B.FULL_MENU_LINK \n");
			query.append("			,B.FULL_LINK_PATH \n");
			query.append("			,C.TARGET_PATH AS CONTENTS_PATH \n");
			query.append("          ,A.SITE_ID \n");
			query.append("          ,A.MENU_POPUP_YN \n");
			query.append("          ,D.NAME AS USER_NAME \n");
			query.append("          ,D.EMAIL \n");
			query.append("          ,D.PHONE \n");
			query.append("          ,D.MOBILE \n");
			query.append("          ,D.DEPARTMENT \n");
			query.append("          ,D.DEPARTMENT_CODE \n");
			query.append("          ,D.OFFICETELNO \n");
			query.append("		FROM gcweb.WCM_CATEGORY A \n");
			query.append("		LEFT OUTER JOIN CATEGORY_ADDITION B ON B.CATEGORY_ID = A.CATEGORY_ID \n");
			query.append("		LEFT OUTER JOIN gcweb.WCM_FOLDER_MAP C ON C.CATEGORY_ID = A.CATEGORY_ID \n");
			query.append("		LEFT OUTER JOIN gcweb.WCM_USER D ON D.USER_ID = A.ADMIN_ID \n");
			query.append("		WHERE A.SITE_ID = 14 AND A.STATUS = 'A' AND NVL(A.MENU_USE_YN,'N') = 'Y' \n");
			query.append("		ORDER BY A.PARENT_ID ASC, A.SEQUENCE ASC \n");
			System.out.println("query : \n" + query);
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			/*
			conn = DriverManager.getConnection("jdbc:oracle:thin:@118.220.42.29:1521:www", "gcweb", "rmacjsweb");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.168:1521:orcl", "health", "health");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "health", "health");
			*/
			conn = DriverManager.getConnection("jdbc:oracle:thin:@118.220.42.29:1521:www", "health", "health0");
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query.toString());
			List<ZValue> healthList = new ArrayList<ZValue>();
			while (rs.next()) {			
				ZValue zvl = new ZValue();
				zvl.put("categoryId", rs.getInt("CATEGORY_ID"));
				zvl.put("parentId", rs.getInt("PARENT_ID"));
				zvl.put("name", rs.getString("NAME"));
				zvl.put("fullPath", rs.getString("FULL_PATH"));
				zvl.put("menuLink", rs.getString("MENU_LINK"));
				zvl.put("updateDate", rs.getString("UPDATE_DATE"));
				zvl.put("position", rs.getString("POSITION"));
				zvl.put("fullMenuLink", rs.getString("FULL_MENU_LINK"));
				zvl.put("fullLinkPath", rs.getString("FULL_LINK_PATH"));
				zvl.put("userName", rs.getString("USER_NAME"));
				zvl.put("email", rs.getString("EMAIL"));
				zvl.put("phone", rs.getString("PHONE"));
				zvl.put("mobile", rs.getString("MOBILE"));
				zvl.put("department", rs.getString("DEPARTMENT"));
				zvl.put("departmentCode", rs.getString("DEPARTMENT_CODE"));
				zvl.put("officetelno", rs.getString("OFFICETELNO"));

				String contentsPath = rs.getString("CONTENTS_PATH");
				if(contentsPath != null && !contentsPath.startsWith("/"))
				{
					contentsPath = "/" + contentsPath;
				}
				zvl.put("contentsPath", contentsPath);
				
				zvl.put("siteId", rs.getInt("SITE_ID"));
				zvl.put("menuPopupYn", rs.getString("MENU_POPUP_YN"));
	
				healthList.add(zvl);
			}
	
	    	HashMap<String, List<ZValue>> menuCategoryMap = MasterMenuManager.getMenuCategories(healthList);
			//System.out.println("healthMenuCategoryMap ....." + map);
			ServletContext context = config.getServletContext();
			context.setAttribute("healthMenuCategoryMap", menuCategoryMap);
			context.setAttribute("healthMenuMap", MasterMenuManager.getCategoryMap(healthList));
			System.out.println("healthMenuCategoryMap Loaded.....");

			/*
			String path = "S:/workspace-jongno/workspace/gc_health/WebContent/WEB-INF/classes/egovframework/kr/go/geumcheon/health/xml/";
			String path = "/App/usr/local/health_web/WEB-INF/classes/egovframework/kr/go/geumcheon/health/xml/";
			*/
			String path = "/App/usr/local/health_web/WEB-INF/classes/egovframework/kr/go/geumcheon/health/xml/";
			//영문보건소 메뉴로드
			List<ZValue> engMenuList = MasterMenuManager.getXMLCategoryList("eng", path);
	    	menuCategoryMap = MasterMenuManager.getMenuCategories(engMenuList);
			context.setAttribute("englishMenuCategoryMap", menuCategoryMap);
			context.setAttribute("englishMenuMap", MasterMenuManager.getCategoryMap(engMenuList));
			System.out.println("englishMenuCategoryMap Loaded.....");
			
			//일문보건소 메뉴로드
			List<ZValue> japaneseMenuList = MasterMenuManager.getXMLCategoryList("jap", path);
	    	menuCategoryMap = MasterMenuManager.getMenuCategories(japaneseMenuList);
			context.setAttribute("japaneseMenuCategoryMap", menuCategoryMap);
			context.setAttribute("japaneseMenuMap", MasterMenuManager.getCategoryMap(japaneseMenuList));
			System.out.println("japaneseMenuCategoryMap Loaded.....");

			//중문보건소 메뉴로드
			List<ZValue> chinaMenuList = MasterMenuManager.getXMLCategoryList("chn", path);
	    	menuCategoryMap = MasterMenuManager.getMenuCategories(chinaMenuList);
			context.setAttribute("chinaMenuCategoryMap", menuCategoryMap);
			context.setAttribute("chinaMenuMap", MasterMenuManager.getCategoryMap(chinaMenuList));
			System.out.println("chinaMenuCategoryMap Loaded.....");

			//베트남보건소 메뉴로드
			List<ZValue> btnMenuList = MasterMenuManager.getXMLCategoryList("btn", path);
	    	menuCategoryMap = MasterMenuManager.getMenuCategories(btnMenuList);
			context.setAttribute("btnMenuCategoryMap", menuCategoryMap);
			context.setAttribute("btnMenuMap", MasterMenuManager.getCategoryMap(btnMenuList));
			System.out.println("btnMenuCategoryMap Loaded.....");
	
	
		}
		catch(Exception e)
		{
			System.out.println("error2 :(" + e);
		}
		finally
		{
			try
			{
				rs.close();
				stmt.close();
				conn.close();
				rs = null;
				stmt = null;
				conn = null;
			}
			catch(Exception e)
			{
				
			}
			
		}
				
		System.out.println("####################### MenuLoadingServlet Finished.............................");
	}
	
}
