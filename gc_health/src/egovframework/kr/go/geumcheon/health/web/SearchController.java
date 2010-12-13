package egovframework.kr.go.geumcheon.health.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.kr.go.geumcheon.health.service.SearchService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class SearchController
{    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name="searchService")
	private SearchService searchService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/health/search/search.do")
	public String saveSatisfaction(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	String searchTxt = zvl.getString("searchTxt");

    	String link = "/health/search/search.do?" +
    		"method="+zvl.getString("method")+
    		"&amp;searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8");
    	zvl.put("link", link);
    	
    	int totCnt = 0;
    	
    	String searchPage = null;
    	int method = zvl.getInt("method");
    	if(method == 0)
    	{
        	List<ZValue> menuList = searchService.selectCategoryListByName(searchTxt);
        	model.addAttribute("menuList", menuList);
        	int menuListCnt = searchService.selectCategoryListByNameCnt(searchTxt);
        	totCnt += menuListCnt;
        	model.addAttribute("menuListCnt", menuListCnt);

        	List<ZValue> deptList = searchService.selectStaffList(searchTxt);
        	model.addAttribute("deptList", deptList);
        	int deptListCnt = searchService.selectStaffListCnt(searchTxt);
        	model.addAttribute("deptListCnt", deptListCnt);
        	totCnt += deptListCnt;
        	
        	List<ZValue> bbsList = searchService.selectBBSListByContent(zvl);
        	model.addAttribute("bbsList", bbsList);
        	int bbsListCnt = searchService.selectBBSListCnt(searchTxt);
        	totCnt += bbsListCnt;
        	model.addAttribute("bbsListCnt", bbsListCnt);
        	
    		searchPage = "/health/dev_content/search/search.jsp";
    	}
    	else if(method == 1)
    	{
        	int menuListCnt = searchService.selectCategoryListByNameCnt(searchTxt);
        	totCnt += menuListCnt;
        	model.addAttribute("menuListCnt", menuListCnt);

    		zvl.put("totCnt", menuListCnt);
    		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
    		
        	List<ZValue> menuList = searchService.selectCategoryListByNameA(zvl);
    		String pageNav = PageUtil.getSgPageNavString(pageInfo);

        	model.addAttribute("menuList", menuList);
    		model.addAttribute("pageInfo", pageInfo);
    		model.addAttribute("pageNav", pageNav);
        	
    		searchPage = "/health/dev_content/search/menuSearch.jsp";
    	}
    	else if(method == 2)
    	{
    		int bbsListCnt = searchService.selectBBSListCnt(searchTxt);
        	totCnt += bbsListCnt;
        	model.addAttribute("bbsListCnt", bbsListCnt);
        	
        	zvl.put("totCnt", bbsListCnt);
    		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
    		
    		List<ZValue> bbsList = searchService.selectBBSListByContentA(zvl);
    		String pageNav = PageUtil.getSgPageNavString(pageInfo);

        	model.addAttribute("bbsList", bbsList);
    		model.addAttribute("pageInfo", pageInfo);
    		model.addAttribute("pageNav", pageNav);
        	
    		searchPage = "/health/dev_content/search/bbsSearch.jsp";
    	}
    	else if(method == 3)
    	{
        	int deptListCnt = searchService.selectStaffListCnt(searchTxt);
        	totCnt += deptListCnt;
        	model.addAttribute("deptListCnt", deptListCnt);

    		zvl.put("totCnt", deptListCnt);
    		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
    		
        	List<ZValue> deptList = searchService.selectStaffListA(zvl);
    		String pageNav = PageUtil.getSgPageNavString(pageInfo);

        	model.addAttribute("deptList", deptList);
    		model.addAttribute("pageInfo", pageInfo);
    		model.addAttribute("pageNav", pageNav);
    		searchPage = "/health/dev_content/search/deptSearch.jsp";
    	}
    	model.addAttribute("totCnt", totCnt);
    	
    	model.addAttribute("searchPage", searchPage);
    	
		return "health/dev_content/search/searchFrame";
	}

}
