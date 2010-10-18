package egovframework.kr.go.geumcheon.health.service;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("applicationFactory")
public class ApplicationFactory implements ServletContextAware{

	public static int LIST_PAGE = 1;

	public static int WRITE_PAGE = 2;

	public static int VIEW_PAGE = 3;

	public static int LIST_FORWARD = 4;
	
    @Resource(name = "applicationBeanName")
    private HashMap<String, String> applicationBeanName;
    
	private ServletContext servletContext;

    @Resource(name = "applicationListPage")
    protected HashMap<String, String> applyListPage;

    @Resource(name = "applicationViewPage")
    protected HashMap<String, String> applyViewPage;

    @Resource(name = "applicationWritePage")
    protected HashMap<String, String> applyWritePage;

    @Resource(name = "applicationListForward")
    protected HashMap<String, String> applyListForward;

    @Resource(name = "adminApplicationListPage")
    protected HashMap<String, String> adminApplyListPage;

    @Resource(name = "adminApplicationWritePage")
    protected HashMap<String, String> adminApplyWritePage;

    @Resource(name = "adminApplicationListForward")
    protected HashMap<String, String> adminApplyListForward;
    
	public void setServletContext(ServletContext servletContext)
	{
		this.servletContext = servletContext;
	}

	public String getAdminForwardPage(int viewType, ZValue zvl)
	{
    	String applyCode = zvl.getString("applyCode");
    	String petiGubun = zvl.getString("petiGubun");
    	String onlineId = zvl.getString("onlineId");
    	String forwardPage = null;
    	HashMap<String, String> forwardMap = null;
    	if(viewType == LIST_PAGE)
    	{
    		forwardMap = adminApplyListPage;
    	}
    	else if(viewType == WRITE_PAGE)
    	{
    		forwardMap = adminApplyWritePage;
    	}
    	else if(viewType == LIST_FORWARD)
    	{
    		forwardMap = adminApplyListForward;
    	}
    	
    	forwardPage = forwardMap.get(applyCode);
		if(forwardPage == null) 
			forwardPage = forwardMap.get("default");
    	forwardPage = 
    		forwardPage.replaceAll(":applyCode", applyCode)
    			       .replaceAll(":petiGubun", petiGubun)
    			       .replaceAll(":onlineId", onlineId);
    	
    	return forwardPage;
	}
	
    public String getForwardPage(int viewType, ZValue zvl)
    {
    	String applyCode = zvl.getString("applyCode");
    	String petiGubun = zvl.getString("petiGubun");
    	String onlineId = zvl.getString("onlineId");
    	String categoryId = zvl.getString("categoryId");
    	String forwardPage = null;
    	HashMap<String, String> forwardMap = null;
    	if(viewType == LIST_PAGE)
    	{
    		forwardMap = applyListPage;
    	}
    	else if(viewType == WRITE_PAGE)
    	{
    		forwardMap = applyWritePage;
    	}
    	else if(viewType == VIEW_PAGE)
    	{
    		forwardMap = applyViewPage;
    	}
    	else if(viewType == LIST_FORWARD)
    	{
    		forwardMap = applyListForward;
    	}

    	forwardPage = forwardMap.get(applyCode);
		if(forwardPage == null) 
			forwardPage = forwardMap.get("default");
    	forwardPage = 
    		forwardPage.replaceAll(":applyCode", applyCode)
    				   .replaceAll(":petiGubun", petiGubun)
    				   .replaceAll(":onlineId", onlineId)
    				   .replaceAll(":categoryId", categoryId);
    	
    	return forwardPage;
    }
    
	public ApplicationService getApplicationBean(String applyCode)
	{
		String beanName = applicationBeanName.get(applyCode);
		if(beanName == null)
			beanName = applicationBeanName.get("default");
		
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);
		ApplicationService applicationService = (ApplicationService)context.getBean(beanName);
		return applicationService;
	}

}
