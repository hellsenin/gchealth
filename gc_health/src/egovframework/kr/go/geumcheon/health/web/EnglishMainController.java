package egovframework.kr.go.geumcheon.health.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.ServletContextAware;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.kr.go.geumcheon.health.service.BannerService;
import egovframework.kr.go.geumcheon.health.service.CalenderService;
import egovframework.kr.go.geumcheon.health.service.InfoCustomMadeService;
import egovframework.kr.go.geumcheon.health.service.PollService;
import egovframework.kr.go.geumcheon.health.service.PortalAlertService;
import egovframework.kr.go.geumcheon.health.service.VisitorLogService;
import egovframework.kr.go.geumcheon.health.service.WcmboardService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Banner;
import egovframework.kr.go.geumcheon.health.vo.PortalAlert;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;

@Controller
public class EnglishMainController implements ServletContextAware {

	protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;
	
	@Resource(name = "BannerService")
	private BannerService bannerService;

    /** 메인 화면 알림을 읽어오기 위한 서비스 */
	@Resource(name="PortalAlertService")
	private PortalAlertService portalAlertService;

    @Resource(name = "visitorLogService")
    private VisitorLogService visitorLogService;

	@Resource(name="pollService")
	private PollService pollService = null;

	@Resource(name="calenderService")
	private CalenderService calenderService = null;

	@Resource(name="wcmboardService")
	private WcmboardService wcmboardService;
	
	@Resource(name = "pageUtil")
    protected PageUtil PageUtil;
	
    @Resource(name = "infoCustomMadeService")
    protected InfoCustomMadeService infoCustomMadeService;
	
	private ServletContext servletContext;
	
	public void setServletContext(ServletContext servletContext)
	{
		this.servletContext = servletContext;
	}

	@RequestMapping("/english/main/main.do")
	public String main(
			HttpServletRequest request,
			HttpServletResponse response,			
			ModelMap model)throws Exception
	{
		
    	return "english/open_content/main/englishMain";
	}
	
	@RequestMapping("/english/main/contents.do")
	public String contents(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception 
	{
		ZValue zvl = WebFactory.getAttributes(request);
		String incPage = zvl.getString("incPage"); 
		String categoryId = zvl.getString("categoryId"); 
		
		if("".equals(categoryId)) throw new Exception("categoryId 값이 없습니다.");

		HashMap<String, ZValue> englishMenuMap = (HashMap<String, ZValue>)servletContext.getAttribute("englishMenuMap");
		ZValue currMenuZvl = englishMenuMap.get("menu_" + categoryId);
		String contentsPath = currMenuZvl.getString("contentsPath");

		String includePage = null;
		if(!"".equals(incPage))
		{
			String incPath = EgovStringUtil.toSubString(contentsPath, 0, contentsPath.lastIndexOf('/'));
			includePage = incPath + "/" + incPage + ".jsp";
		}
		else
		{
			includePage = contentsPath;
		}
		
		log.debug("includePage : " + includePage);
		
		model.addAttribute("includePage", includePage);
		
		return "english/open_content/main/englishIndex";
	}

}
