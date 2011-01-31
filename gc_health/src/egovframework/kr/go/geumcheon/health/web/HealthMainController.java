package egovframework.kr.go.geumcheon.health.web;

import java.net.URLEncoder;
import java.util.ArrayList;
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
public class HealthMainController implements ServletContextAware {

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

	@RequestMapping("/health/main/main.do")
	public String main(
			HttpServletRequest request,
			HttpServletResponse response,			
			ModelMap model)throws Exception
	{
		
		//게시물 리스트
		BoardVO boardVO = new BoardVO();
		boardVO.setFirstIndex(0);
		boardVO.setRecordCountPerPage(5);
		for(int i=0; i<5; i++){
			if(i == 0){
				//새소식
				boardVO.setBbsId("BBSMSTR_000000001151");
				Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "");
				model.addAttribute("resultList", map.get("resultList"));
			} else if(i == 1){
				//보건소식지
				boardVO.setBbsId("BBSMSTR_000000001152");
				Map<String, Object> map2 = bbsMngService.selectBoardArticles(boardVO, "");
				model.addAttribute("resultList2", map2.get("resultList"));
			} else if(i == 2){
				//의약공람
				Map<String, Object> map3 = bbsMngService.selectMainBoardArticleList3(boardVO, "");
				
				List<BoardVO> resultList3 = (List<BoardVO>)map3.get("resultList");

				model.addAttribute("resultList3", resultList3);
				
			} else if(i == 3){
				//식약청 정보
				boardVO.setBbsId("BBSMSTR_000000001163");
				Map<String, Object> map4 = bbsMngService.selectBoardArticles(boardVO, "");
				model.addAttribute("resultList4", map4.get("resultList"));
			} else if(i == 4){
				//고시공고
				ZValue zvl = WebFactory.getAttributes(request);

		    	String link = "/health/wcmboard/selectWcmboardList.do?communityId="+
		    	URLEncoder.encode("B0037","UTF-8");
		    	zvl.put("communityId", "B0037");
		    	zvl.put("recordCountPerPage", 5);
		    	zvl.put("link", link);
		    	
				int totCnt = wcmboardService.selectWcmboardListCnt(zvl);
				zvl.put("totCnt", totCnt);
				
				ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
				List<ZValue> resultList5 = wcmboardService.selectWcmboardList(pageInfo);
				model.addAttribute("resultList5", resultList5);
			}
		} 
		
		//배너 리스트
		Banner b_param = new Banner();
		b_param.setDept("88");
		b_param.setDong("88");
		b_param.visible_cnt = Banner.HEALTH_DISPLAY_CNT;
		List<List<Banner>> bannerList = bannerService.selectPublishList(b_param);
		model.addAttribute("bannerList", bannerList);

		//알림판
		List<PortalAlert> portalAlertList = portalAlertService.selectPublishList("88");
		model.addAttribute("portalAlertList", portalAlertList);

		//방문자로그
		ZValue logCount = visitorLogService.addLogCount("11");
		model.addAttribute("logCount", logCount);
		
		//설문
		ZValue poll = pollService.selectRescentPoll();
		model.addAttribute("poll", poll);
		
		//교육달력
		String calendarStr = calenderService.getOnlineApplyMainCalendar(null);
		model.addAttribute("calendarStr", calendarStr);

		//이벤트달력
		String evtCalendarStr = calenderService.getEventMainCalendar(null);
		model.addAttribute("evtCalendarStr", evtCalendarStr);
		
		model.addAttribute("today", EgovDateUtil.getCurrentDate(""));

		//커스텀메뉴
		List<ZValue> customMainMenuList = infoCustomMadeService.selectCustomMainMenuCategorySortOrdrList();
        model.addAttribute("customMainMenuList", customMainMenuList);
		
        Map<String, List<ZValue>> subMenuMap = infoCustomMadeService.selectedBasicCustomMainMenuMap();
        model.addAttribute("subMenuMap", subMenuMap);

    	return "health/open_content/main/healthMain";
	}

	@RequestMapping("/health/main/testmain.do")
	public String testmain(
			HttpServletRequest request,
			HttpServletResponse response,			
			ModelMap model)throws Exception
	{
		
		//게시물 리스트
		BoardVO boardVO = new BoardVO();
		boardVO.setFirstIndex(0);
		boardVO.setRecordCountPerPage(5);
		for(int i=0; i<5; i++){
			if(i == 0){
				//새소식
				boardVO.setBbsId("BBSMSTR_000000001151");
				Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "");
				model.addAttribute("resultList", map.get("resultList"));
			} else if(i == 1){
				//보건소식지
				boardVO.setBbsId("BBSMSTR_000000001152");
				Map<String, Object> map2 = bbsMngService.selectBoardArticles(boardVO, "");
				model.addAttribute("resultList2", map2.get("resultList"));
			} else if(i == 2){
				//의약공람
				boardVO.setBbsId("BBSMSTR_000000001155"); 
				Map<String, Object> map3 = bbsMngService.selectBoardArticles(boardVO, "");
				model.addAttribute("resultList3", map3.get("resultList"));
			} else if(i == 3){
				//식약청 정보
				boardVO.setBbsId("BBSMSTR_000000001163");
				Map<String, Object> map4 = bbsMngService.selectBoardArticles(boardVO, "");
				model.addAttribute("resultList4", map4.get("resultList"));
			} else if(i == 4){
				//고시공고
				ZValue zvl = WebFactory.getAttributes(request);

		    	String link = "/health/wcmboard/selectWcmboardList.do?communityId="+
		    	URLEncoder.encode("B0037","UTF-8");
		    	zvl.put("communityId", "B0037");
		    	zvl.put("recordCountPerPage", 5);
		    	zvl.put("link", link);
		    	
				int totCnt = wcmboardService.selectWcmboardListCnt(zvl);
				zvl.put("totCnt", totCnt);
				
				ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
				List<ZValue> resultList5 = wcmboardService.selectWcmboardList(pageInfo);
				model.addAttribute("resultList5", resultList5);
			}
		} 
		
		//배너 리스트
		Banner b_param = new Banner();
		b_param.setDept("88");
		b_param.setDong("88");
		b_param.visible_cnt = Banner.HEALTH_DISPLAY_CNT;
		List<List<Banner>> bannerList = bannerService.selectPublishList(b_param);
		model.addAttribute("bannerList", bannerList);

		//알림판
		List<PortalAlert> portalAlertList = portalAlertService.selectPublishList("88");
		model.addAttribute("portalAlertList", portalAlertList);

		//방문자로그
		ZValue logCount = visitorLogService.addLogCount("11");
		model.addAttribute("logCount", logCount);
		
		//설문
		ZValue poll = pollService.selectRescentPoll();
		model.addAttribute("poll", poll);
		
		//교육달력
		String calendarStr = calenderService.getOnlineApplyMainCalendar(null);
		model.addAttribute("calendarStr", calendarStr);

		//이벤트달력
		String evtCalendarStr = calenderService.getEventMainCalendar(null);
		model.addAttribute("evtCalendarStr", evtCalendarStr);
		
		model.addAttribute("today", EgovDateUtil.getCurrentDate(""));

		//커스텀메뉴
		List<ZValue> customMainMenuList = infoCustomMadeService.selectCustomMainMenuCategorySortOrdrList();
        model.addAttribute("customMainMenuList", customMainMenuList);
		
        Map<String, List<ZValue>> subMenuMap = infoCustomMadeService.selectedBasicCustomMainMenuMap();
        model.addAttribute("subMenuMap", subMenuMap);

    	return "health/open_content/main/healthMain_1011";
	}
	
	@RequestMapping("/health/main/contents.do")
	public String contents(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception 
	{
		ZValue zvl = WebFactory.getAttributes(request);
		String incPage = zvl.getString("incPage"); 
		String categoryId = zvl.getString("categoryId"); 
		
		if("".equals(categoryId)) throw new Exception("categoryId 값이 없습니다.");

		HashMap<String, ZValue> healthMenuMap = (HashMap<String, ZValue>)servletContext.getAttribute("healthMenuMap");
		ZValue currMenuZvl = healthMenuMap.get("menu_" + categoryId);
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
		
		return "health/open_content/main/healthIndex";
	}

	@RequestMapping("/health/main/contentsDownload.do")
	public void contentsDownload(
			HttpServletRequest request,
			HttpServletResponse response,			
			ModelMap model)throws Exception
	{
    	String path = propertyService.getString("Contents.fileStorePath");
    	WebFactory.contentsDownload(path, request, response);
	}

	@RequestMapping("/health/main/print.do")
	public String print(
			HttpServletRequest request,
			HttpServletResponse response,			
			ModelMap model)throws Exception
	{
		return "health/open_content/main/healthPrint";
	}

	@RequestMapping("/health/main/sitemap.do")
	public String sitemap(
			HttpServletRequest request,
			HttpServletResponse response,			
			ModelMap model)throws Exception
	{
		model.addAttribute("includePage", "/health/open_content/main/sitemap.jsp");
		return "health/open_content/main/healthIndex";
	}
}
