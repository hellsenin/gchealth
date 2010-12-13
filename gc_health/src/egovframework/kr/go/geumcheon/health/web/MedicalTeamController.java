package egovframework.kr.go.geumcheon.health.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.ApplicationFactory;
import egovframework.kr.go.geumcheon.health.service.ApplicationService;
import egovframework.kr.go.geumcheon.health.service.ApplyMstService;
import egovframework.kr.go.geumcheon.health.service.MedicalTeamService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class MedicalTeamController
{    
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name="MedicalTeamService")
	private MedicalTeamService medicalTeamService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

    @Resource(name = "applicationFactory")
    protected ApplicationFactory applicationFactory;

    @Resource(name = "applyMstService")
    protected ApplyMstService applyMstService;

	@RequestMapping("/health/medicalTeam/selectMedicalTeamList.do")
	public String selectMedicalTeamList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	model.addAttribute("resultList", medicalTeamService.selectMedicalTeamList(zvl));    	
		String includePage = "/health/dev_content/application/RELY0001/medicalTeamList.jsp";

		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/medicalTeam/selectApplyList.do")
	public String selectApplyList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	ZValue medicalTeam = medicalTeamService.selectMedicalTeam(zvl.getInt("petiGubun"));
		model.addAttribute("medicalTeam", medicalTeam);
    	
		String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);

		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
		
		Map<String, Object> map = service.selectApplyList(pageInfo);
    	
    	String link = "/health/medicalTeam/selectApplyList.do?applyCode="+applyCode+
    		"&petiGubun="+zvl.getString("petiGubun")+
    		"&categoryId="+zvl.getString("categoryId");
    	pageInfo.put("link", link);

		String pageNav = PageUtil.getSgPageNavString(pageInfo);
		log.debug("###########pageNav :: " + pageNav);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("pageNav", pageNav);
    			
    	String includePage = 
    		applicationFactory.getForwardPage(ApplicationFactory.LIST_PAGE, zvl);
    	
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/medicalTeam/selectApplyView.do")
	public String selectApplyView(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	ZValue medicalTeam = medicalTeamService.selectMedicalTeam(zvl.getInt("petiGubun"));
		model.addAttribute("medicalTeam", medicalTeam);
    	
		String applyCode = zvl.getString("applyCode");

		HttpSession session = request.getSession();
		UsersVO user = (UsersVO)session.getAttribute("user");

    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);

    	ZValue result = service.selectApplyViewByApplyId(zvl);
    	boolean accessable = service.isAccessable(result, user);
		model.addAttribute("accessable", accessable);
		
		ZValue applyMst = applyMstService.selectApplyMst(applyCode);
		String replyYn = applyMst.getString("replyYn");
		String fileAttatchYn = applyMst.getString("fileAttatchYn");
		String applyAttrb = applyMst.getString("applyAttrb");
		
		if(!accessable && "N".equals(result.getString("openFlag")))
		{
			String forwardPage = 
				applicationFactory.getForwardPage(ApplicationFactory.LIST_FORWARD, zvl);
    		WebFactory.printHtml(response, "비공개글입니다.", forwardPage);
    		return null;
		}
		
		if("Y".equals(replyYn))
		{
			List<ZValue> answerList = service.selectAnswerList(zvl);
			model.addAttribute("answerList", answerList);
		}
		
		if("Y".equals(fileAttatchYn))
		{
			List fileList = service.selectFileListById(zvl);			
			model.addAttribute("fileList", fileList);
		}
		
		service.addHit(zvl);

		model.addAttribute("result", result);
		
		String includePage = 
			applicationFactory.getForwardPage(ApplicationFactory.VIEW_PAGE, zvl);
		
		log.debug("###########includePage :: " + includePage);
		model.addAttribute("includePage", includePage);
		//model.addAttribute("includePage", "/health/dev_content/application/PRTLTAPPLY_"+applyCode+"/"+applyCode+"View.jsp");
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/medicalTeam/writePage.do")
	public String writePage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null || "".equals(user.getWebMemId()))
    	{
    		WebFactory.setForwardPage2(request, response, "로그인이 필요한 페이지입니다. 로그인페이지로 이동하시겠습니까?");
    		return null;
    	}
    	
    	ZValue zvl = WebFactory.getAttributes(request);
		zvl.put("memberId", user.getWebMemId());
		zvl.put("pinno", user.getPin());
		
    	ZValue medicalTeam = medicalTeamService.selectMedicalTeam(zvl.getInt("petiGubun"));
		model.addAttribute("medicalTeam", medicalTeam);
    	
    	String includePage = 
    		applicationFactory.getForwardPage(ApplicationFactory.WRITE_PAGE, zvl);
		log.debug("###########includePage :: " + includePage);
    	
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/medicalTeam/modifyApplyPage.do")
	public String modifyApplyPage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		UsersVO user = WebFactory.getUserInfo(request);		
    	if(user == null)
    	{
    		WebFactory.setForwardPage(request, response);
    		return null;
    	}

    	ZValue zvl = WebFactory.getAttributes(request);
		zvl.put("memberId", user.getWebMemId());
		zvl.put("pinno", user.getPin());

    	ZValue medicalTeam = medicalTeamService.selectMedicalTeam(zvl.getInt("petiGubun"));
		model.addAttribute("medicalTeam", medicalTeam);
    	
		String applyCode = zvl.getString("applyCode");

    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);
		ZValue result = service.selectApplyViewByApplyId(zvl);
    	if(!service.isAccessable(result, user))
    	{
    		throw new EgovBizException("잘못된 경로 입니다.");
    	}
		
		zvl.put("memberId", user.getWebMemId());
		zvl.put("pinno", user.getPin());
		
		model.addAttribute("result", result);

		ZValue applyMst = applyMstService.selectApplyMst(applyCode);
		String replyYn = applyMst.getString("replyYn");
		String fileAttatchYn = applyMst.getString("fileAttatchYn");
		String applyAttrb = applyMst.getString("applyAttrb");
		
		if("Y".equals(replyYn))
		{
			List<ZValue> answerList = service.selectAnswerList(zvl);
			model.addAttribute("answerList", answerList);
		}
		
		if("Y".equals(fileAttatchYn))
		{
			List fileList = service.selectFileListById(zvl);			
			model.addAttribute("fileList", fileList);
		}
		
		String includePage = 
			applicationFactory.getForwardPage(ApplicationFactory.WRITE_PAGE, zvl);
		log.debug("###########includePage :: " + includePage);
		model.addAttribute("includePage", includePage);
		//model.addAttribute("includePage", "/health/dev_content/application/PRTLTAPPLY_"+applyCode+"/"+applyCode+"Write.jsp");
		return Globals.HEALTH_MAIN_PAGE;
	}

}
