package egovframework.kr.go.geumcheon.health.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.kr.go.geumcheon.health.dao.CategoryDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("masterMenuManagerService")
public class MasterMenuManagerService{

	protected Log log = LogFactory.getLog(MasterMenuManagerService.class);

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	private static HashMap<String, ZValue> menuCategory = new HashMap<String, ZValue>();
	
	private final String prefix = "menu_";	
	
	private final String HEALTH_SITE_ID = "14";

	@Resource(name="categoryDAO")
	private CategoryDAO categoryDAO;
	
	public HashMap<String, ZValue> getMenuCategory()
	{
		return menuCategory;
	}
	
	public HashMap<String, List<ZValue>> getMenuCategoryMapBySiteId(String siteId) throws Exception
	{
		List<ZValue> menuStructure = categoryDAO.selectCategoryListBySiteId(HEALTH_SITE_ID);
    	HashMap<String, List<ZValue>> menuCategoryMap = getMenuCategories(menuStructure);
    	return setMenuCategory(menuCategoryMap, "menu_0", 0, new String[5]);
	}

	public HashMap<String, List<ZValue>> getGcMenuCategoryMapBySiteId(String siteId) throws Exception
	{
		List<ZValue> menuStructure = categoryDAO.selectCategoryListBySiteId(siteId);
    	HashMap<String, List<ZValue>> menuCategoryMap = getMenuCategories(menuStructure);
    	return setGcMenuCategory(menuCategoryMap, "menu_0", 0, new String[4]);
	}
	
	public HashMap<String, List<ZValue>> getMenuCategories(List<ZValue> list)
	{
		HashMap<String, List<ZValue>> categoryMap = new HashMap<String, List<ZValue>>();
		//log.debug("list.size() : " + list.size());
		int size = list.size();
		for(int i=0; i<size; i++)
		{
			ZValue zvl = list.get(i);
			String parentId = prefix+zvl.getString("parentId");
			if(categoryMap.containsKey(parentId))
			{
				List<ZValue> categoryList = categoryMap.get(parentId);
				categoryList.add(zvl);
			}
			else
			{
				ArrayList<ZValue> categoryList = new ArrayList<ZValue>();
				categoryList.add(zvl);
				categoryMap.put(parentId, categoryList);
			}
		}
		//System.out.println("###########################################categoryMap : " + categoryMap);
		return categoryMap;
	}

	public HashMap<String, List<ZValue>> setMenuCategory(
			HashMap<String, List<ZValue>> menuCategoryMap, 
			String parentId, int depth, String[] pos)
	{		
		return setMenuCategory(menuCategoryMap, parentId, depth, pos, null);
	}

	public HashMap<String, List<ZValue>> setGcMenuCategory(
			HashMap<String, List<ZValue>> menuCategoryMap, 
			String parentId, int depth, String[] pos)
	{		
		return setGcMenuCategory(menuCategoryMap, parentId, depth, pos, null);
	}
	
	public HashMap<String, List<ZValue>> setMenuCategory(
			HashMap<String, List<ZValue>> menuCategoryMap, 
			String parentId, int depth, String[] pos, String gubun)
	{		
		List<ZValue> menuCategories = menuCategoryMap.get(parentId);
		//System.out.println("###########################################parentId : " + parentId);
		if(menuCategories != null)
		{
			depth++;			
			for(int i=0; i<menuCategories.size(); i++)
			{
				ZValue zvl = menuCategories.get(i);
				String siteId = zvl.getString("siteId");
				String menuLink = zvl.getString("menuLink");
				String categoryId = zvl.getString("categoryId");
				pos[depth-1] = EgovStringUtil.fillZero(String.valueOf(i+1), 2, true);
				String position = getPosition(pos, depth);
				
				String contentsPath = zvl.getString("contentsPath");
				if("".equals(contentsPath))
				{
					if("15".equals(siteId))
						contentsPath = "/english/open_content/";
					else if("16".equals(siteId))
						contentsPath = "/japanese/open_content/";
					else if("17".equals(siteId))
						contentsPath = "/china/open_content/";
					else if("18".equals(siteId))
						contentsPath = "/btn/open_content/";
					else
						contentsPath = "/health/open_content/";
					contentsPath += position.substring(0, 2) + "/";
					contentsPath += position.substring(2, 4) + "/";
					contentsPath += position.substring(4, 6) + "/";
					contentsPath += position+".jsp";
					zvl.put("contentsPath", contentsPath);
				}
				else if(!"".equals(contentsPath) && !contentsPath.startsWith("/"))
				{
					contentsPath = "/" + contentsPath;
					zvl.put("contentsPath", contentsPath);
				}
				
				//일반컨텐츠 페이지
				if("".equals(menuLink))
				{
					if("15".equals(siteId))
						menuLink = "/english/main/contents.do?categoryId=" + categoryId;
					else if("16".equals(siteId))
						menuLink = "/japanese/main/contents.do?categoryId=" + categoryId;
					else if("17".equals(siteId))
						menuLink = "/china/main/contents.do?categoryId=" + categoryId;
					else if("18".equals(siteId))
						menuLink = "/btn/main/contents.do?categoryId=" + categoryId;
					else
						menuLink = "/health/main/contents.do?categoryId=" + categoryId;
				}
				//팝업 
				else if(!"Y".equals(zvl.getString("menuPopupYn")))
				{
					if(menuLink.indexOf("?") != -1)
						menuLink += "&amp;categoryId=" + categoryId;
					else
						menuLink += "?categoryId=" + categoryId;	
				}
				
				zvl.put("fullMenuLink", menuLink);
				zvl.put("position", position);
				
				//임시 컨텐츠경로 저장......
				/*
				String contentsPath = "/health/open_content/";
				contentsPath += position.substring(0, 2) + "/";
				contentsPath += position.substring(2, 4) + "/";
				contentsPath += position.substring(4, 6) + "/";
				contentsPath += position+".jsp";
				zvl.put("contentsPath", contentsPath);
				*/
				
				menuCategory.put(prefix+categoryId, zvl);

				System.out.println("###########################################zvl : " + zvl);
								
				setMenuCategory(menuCategoryMap, prefix+categoryId, depth, pos, gubun);
			}
		}
		
		return menuCategoryMap;
	}

	public HashMap<String, List<ZValue>> setGcMenuCategory(
			HashMap<String, List<ZValue>> menuCategoryMap, 
			String parentId, int depth, String[] pos, String gubun)
	{		
		List<ZValue> menuCategories = menuCategoryMap.get(parentId);
		//System.out.println("###########################################parentId : " + parentId);
		if(menuCategories != null)
		{
			depth++;			
			for(int i=0; i<menuCategories.size(); i++)
			{
				ZValue zvl = menuCategories.get(i);
				int siteId = zvl.getInt("siteId");
				String menuLink = zvl.getString("menuLink");
				String categoryId = zvl.getString("categoryId");
				pos[depth-1] = EgovStringUtil.fillZero(String.valueOf(i+1), 2, true);
				String position = getGcPosition(pos, depth);
				
				String contentsPath = zvl.getString("contentsPath");
				if("".equals(contentsPath))
				{
					contentsPath = "/english/open_content/";
					contentsPath += position.substring(0, 2) + "/";
					contentsPath += position.substring(2, 4) + "/";
					contentsPath += position.substring(4, 6) + "/";
					contentsPath += position+".jsp";
					zvl.put("contentsPath", contentsPath);
				}
				else if(!"".equals(contentsPath) && !contentsPath.startsWith("/"))
				{
					contentsPath = "/" + contentsPath;
					zvl.put("contentsPath", contentsPath);
				}
				
				//일반컨텐츠 페이지
				if("".equals(menuLink))
				{
					if(siteId == 3)
						menuLink = "/main.do?pageKey=" + position;
					else if(siteId == 6) //동주민
						menuLink = "/dong.do?pageKey=" + position;
					else if(siteId == 7) //국별
						menuLink = "/station.do?station=1&pageKey=" + position;
					else if(siteId == 8) //도시디자인비전21
						menuLink = "/city.do?pageKey=" + position;
					else if(siteId == 9) //아동
						menuLink = "/child.do?pageKey=" + position;
				}
				//팝업 
				else if(!"Y".equals(zvl.getString("menuPopupYn")))
				{
					if(menuLink.indexOf("?") != -1)
						menuLink += "&amp;pageKey=" + position;
					else
						menuLink += "?pageKey=" + position;	
				}
				
				zvl.put("fullMenuLink", menuLink);
				zvl.put("position", position);
								
				menuCategory.put(prefix+categoryId, zvl);

				//System.out.println("###########################################zvl : " + zvl);
								
				setGcMenuCategory(menuCategoryMap, prefix+categoryId, depth, pos, gubun);
			}
		}
		
		return menuCategoryMap;
	}
	
	public HashMap<String, Object> reloadMenu(String siteId) throws Exception
	{
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		categoryDAO.delCategoryAdditionBySiteId(siteId);
		
		HashMap<String, ZValue> menuMap = new HashMap<String, ZValue>();
    	HashMap<String, List<ZValue>> map = getMenuCategoryMapBySiteId(HEALTH_SITE_ID);
    	Set<String> keyes = map.keySet();
    	for(String key : keyes)
    	{
    		List<ZValue> values = map.get(key);
    		for(ZValue value : values)
    		{
    			categoryDAO.addCategoryAddition(value);
    			menuMap.put(prefix+value.getString("categoryId"), value);
    		}
    	}

    	result.put("healthMenuCategoryMap", map);
    	result.put("healthMenuMap", menuMap);
    	
    	return result;
	}

	public HashMap<String, Object> gcReloadMenu(String siteId) throws Exception
	{
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		categoryDAO.delCategoryAdditionBySiteId(siteId);
		
		HashMap<String, ZValue> menuMap = new HashMap<String, ZValue>();
    	HashMap<String, List<ZValue>> map = getGcMenuCategoryMapBySiteId(siteId);
    	Set<String> keyes = map.keySet();
    	for(String key : keyes)
    	{
    		List<ZValue> values = map.get(key);
    		for(ZValue value : values)
    		{
    			categoryDAO.addCategoryAddition(value);
    			menuMap.put(prefix+value.getString("categoryId"), value);
    		}
    	}

    	result.put("healthMenuCategoryMap", map);
    	result.put("healthMenuMap", menuMap);
    	
    	return result;
	}
	
	public void createTempContentsFile() throws Exception
	{
		File src = new File("C:/temp.jsp");
		String content = FileUtils.readFileToString(src);
		log.debug(">>content : " + content);
		List<ZValue> menuStructure = categoryDAO.selectCategoryListBySiteId(HEALTH_SITE_ID);
		for(ZValue zvl : menuStructure)
		{
			String contentsPath = zvl.getString("contentsPath");
			if(!"".equals(contentsPath))
			{	
				String realPath = "S:/workspace-jongno/workspace/gc_health/WebContent/temp_contents" + contentsPath;

				log.debug(">>realPath : " + realPath);
				
				File des = new File(realPath);
				
				FileUtils.writeStringToFile(des, content, "UTF-8");

				/*
				ZValue param = new ZValue();
				param.put("categoryId", zvl.getString("categoryId"));
				param.put("targetPath", contentsPath);
				
				categoryDAO.addFolderMap(param);
				*/
				
			}
		}
	}
	
	public List<ZValue> getXMLCategoryList(String type) throws Exception
	{
		String path = propertyService.getString("WEB_ROOT") + 
			"WEB-INF/classes/egovframework/kr/go/geumcheon/health/xml/";
		return getXMLCategoryList(type, path);
	}

	public List<ZValue> getXMLCategoryList(String type, String path) throws Exception
	{
		List<ZValue> result = new ArrayList<ZValue>();
		SAXBuilder builder = new SAXBuilder();
		String src = path + "category_" + type + "_result.xml";
		Document doc = builder.build(new FileInputStream(new File(src)));
		Element categories = doc.getRootElement();
		
		String siteId = categories.getChild("siteId").getText();
		List<Element> categoryList = categories.getChildren("category");
		
		for(Element category : categoryList)
		{
			ZValue categoryZvl = new ZValue();

			categoryZvl.put("categoryId", category.getChild("categoryId").getText());
			categoryZvl.put("parentId", category.getChild("parentId").getText());
			categoryZvl.put("name", category.getChild("name").getText());
			categoryZvl.put("fullPath", category.getChild("fullPath").getText());
			categoryZvl.put("menuLink", category.getChild("menuLink").getText());
			categoryZvl.put("updateDate", category.getChild("updateDate").getText());
			categoryZvl.put("position", category.getChild("position").getText());
			categoryZvl.put("fullMenuLink", category.getChild("fullMenuLink").getText());
			categoryZvl.put("userName", category.getChild("userName").getText());
			categoryZvl.put("email", category.getChild("email").getText());
			categoryZvl.put("phone", category.getChild("phone").getText());
			categoryZvl.put("mobile", category.getChild("mobile").getText());
			categoryZvl.put("department", category.getChild("department").getText());
			categoryZvl.put("departmentCode", category.getChild("departmentCode").getText());
			categoryZvl.put("officetelno", category.getChild("officetelno").getText());
			categoryZvl.put("contentsPath", category.getChild("contentsPath").getText());
			categoryZvl.put("siteId", siteId);
			categoryZvl.put("menuPopupYn", category.getChild("menuPopupYn").getText());
			
			result.add(categoryZvl);
		}
		
		return result;
	}
	 
	public void initXmlCategory(String type) throws Exception
	{
		List<ZValue> result = new ArrayList<ZValue>();
		SAXBuilder builder = new SAXBuilder();
		Document doc = builder.build(getClass().getResourceAsStream("/egovframework/kr/go/geumcheon/health/xml/category_"+type+".xml"));
		Element categories = doc.getRootElement();
		
		String siteId = categories.getChild("siteId").getText();
		List<Element> categoryList = categories.getChildren("category");
		
		for(Element category : categoryList)
		{
			ZValue categoryZvl = new ZValue();

			categoryZvl.put("categoryId", category.getChild("categoryId").getText());
			categoryZvl.put("parentId", category.getChild("parentId").getText());
			categoryZvl.put("name", category.getChild("name").getText());
			categoryZvl.put("fullPath", category.getChild("fullPath").getText());
			categoryZvl.put("menuLink", category.getChild("menuLink").getText());
			categoryZvl.put("updateDate", category.getChild("updateDate").getText());
			categoryZvl.put("position", category.getChild("position").getText());
			categoryZvl.put("fullMenuLink", category.getChild("fullMenuLink").getText());
			categoryZvl.put("userName", category.getChild("userName").getText());
			categoryZvl.put("email", category.getChild("email").getText());
			categoryZvl.put("phone", category.getChild("phone").getText());
			categoryZvl.put("mobile", category.getChild("mobile").getText());
			categoryZvl.put("department", category.getChild("department").getText());
			categoryZvl.put("departmentCode", category.getChild("departmentCode").getText());
			categoryZvl.put("officetelno", category.getChild("officetelno").getText());
			categoryZvl.put("contentsPath", category.getChild("contentsPath").getText());
			categoryZvl.put("siteId", siteId);
			categoryZvl.put("menuPopupYn", category.getChild("menuPopupYn").getText());
			
			result.add(categoryZvl);
		}

    	HashMap<String, List<ZValue>> menuCategoryMap = getMenuCategories(result);
    	setMenuCategory(menuCategoryMap, "menu_0", 0, new String[5]);

		for(Element category : categoryList)
		{
			String categoryId = category.getChild("categoryId").getText();
			ZValue categoryZvl = menuCategory.get(prefix+categoryId);
			category.getChild("position").setText(categoryZvl.getString("position"));
			category.getChild("fullMenuLink").setText(categoryZvl.getString("fullMenuLink"));
			category.getChild("contentsPath").setText(categoryZvl.getString("contentsPath"));
		}
		
		Format format = Format.getPrettyFormat();
		XMLOutputter outputter = new XMLOutputter(format);
		String target = propertyService.getString("WEB_ROOT") +
			"WEB-INF/classes/egovframework/kr/go/geumcheon/health/xml/category_"+type+"_result.xml";
		FileOutputStream output = new FileOutputStream(target);
		outputter.output(doc, output);
	}
	
	public void addTempFolderMap() throws Exception
	{
		List<ZValue> list = categoryDAO.selectCategoryListBySiteId(HEALTH_SITE_ID);
		for(ZValue zvl : list)
		{ 
			String position = zvl.getString("position");
			String contentsPath = "/health/open_content/";
			contentsPath += position.substring(0, 2) + "/";
			contentsPath += position.substring(2, 4) + "/";
			contentsPath += position.substring(4, 6) + "/";
			contentsPath += position+".jsp";
			//String targetPath = egovframework.rte.fdl.string.EgovStringUtil.toSubString(contentsPath, 0, contentsPath.lastIndexOf('/'));
			
			ZValue param = new ZValue();
			param.put("categoryId", zvl.getString("categoryId"));
			param.put("targetPath", contentsPath);
			
			categoryDAO.addFolderMap(param);
		}
	}
	
	public HashMap<String, ZValue> getCategoryMap(List<ZValue> categoryList)
	{
		HashMap<String, ZValue> categoryMap = new HashMap<String, ZValue>();
		for(ZValue category : categoryList)
		{
			categoryMap.put(prefix+category.getString("categoryId"), category);
		}
		return categoryMap;
	}

	public List selectProgramList(String siteId) throws Exception
	{
		return categoryDAO.selectProgramList(siteId);
	}

	public void insertProgramList(ZValue zvl) throws Exception
	{	
		if(categoryDAO.existCategoryIdInProgramList(zvl.getString("categoryId")) > 0)
		{
			categoryDAO.updateProgramList(zvl);
		}
		else
		{
			categoryDAO.insertProgramList(zvl);
		}
	}

	public ZValue selectContent(String categoryId) throws Exception
	{
		ZValue result = new ZValue();
		String contentsPath = categoryDAO.selectContentsPath(categoryId);
		contentsPath = propertyService.getString("WEB_ROOT") + contentsPath;
		result.put("contentsPath", contentsPath);
		
		String content = null;
		try
		{
			content = FileUtils.readFileToString(new File(contentsPath), "UTF-8");
		}catch(Exception e)
		{
			log.debug("Exception - " + e);
			content = "";
		}
		result.put("content", content);
		return result;
	}

	public List selectCategoryByName(String name) throws Exception
	{
		return categoryDAO.selectCategoryByName(name);
	}

	public boolean saveContent(String contentsPath, String content) throws Exception
	{
		boolean result = true;
		try
		{
			String curDate = EgovDateUtil.getToday();
			
			File org = new File(contentsPath);
			org.renameTo(new File(contentsPath+"_"+curDate));
			content = EgovStringUtil.replace(content, "&quot;", "\"");
			//content = EgovStringUtil.replace(content, "&amp;", "&");
			content = EgovStringUtil.replace(content, "&lt;", "<");
			content = EgovStringUtil.replace(content, "&gt;", ">");
			
			log.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>content - \n" + content);
			
			FileUtils.writeStringToFile(org, content, "UTF-8");

		}catch(Exception e)
		{
			log.debug("Exception - " + e);
			result = false;
		}
		return result;
	}


	private String getPosition(String[] pos, int depth)
	{
		String position = "";
		for(int i=0; i<depth; i++)
		{
			position += pos[i];
		}
		
		for(int i=depth; i<5; i++)
		{
			position += "01";
		}
		
		return position;
	}
	
	private String getGcPosition(String[] pos, int depth)
	{
		String position = "";
		for(int i=0; i<depth; i++)
		{
			position += pos[i];
		}
		
		for(int i=depth; i<4; i++)
		{
			position += "01";
		}
		
		return position;
	}
	
	public static void main(String[] args) throws Exception
	{
		MasterMenuManagerService MasterMenuManager = new MasterMenuManagerService();
		MasterMenuManager.initXmlCategory("jap");
	}

}
