package egovframework.kr.go.geumcheon.health.web;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.APP000046ApplicationService;
import egovframework.kr.go.geumcheon.health.service.ApplicationFactory;
import egovframework.kr.go.geumcheon.health.service.ApplicationService;
import egovframework.kr.go.geumcheon.health.service.ApplyMstService;
import egovframework.kr.go.geumcheon.health.service.MemberService;
import egovframework.kr.go.geumcheon.health.service.OnlineApplyService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 민원 신청, 신고부분 통합클래스
 * 민원신청인 경우 코드값 applyCode = A001.. H001(보건소 신청코드)..등으로 표현됨
 * 민원신고인 경우 코드값 RELY, 각신고 구분은 petiGubun - 1(구청장에바란다)...등으로 표현됨
 * @author Administrator
 *
 */
@Controller
public class MetabolicSyndromeController {

    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name = "EgovFileMngUtil")
    protected EgovFileMngUtil fileUtil;

    @Resource(name = "applyMstService")
    protected ApplyMstService applyMstService;

    @Resource(name = "applicationFactory")
    protected ApplicationFactory applicationFactory;

    @Resource(name = "onlineApplyService")
    protected OnlineApplyService onlineApplyService;

    @Resource(name = "APP000046ApplicationService")
    protected APP000046ApplicationService APP000046ApplicationService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/health/metabolicSyndrome/input.do")
	public String forAdd(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		String includePage = "/health/dev_content/metabolicSyndrome/input.jsp";
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/metabolicSyndrome/read.do")
	public String uploadExcel(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   
    	ZValue result = APP000046ApplicationService.read(zvl.getString("regno"));
    	if(result == null)
    	{
    		WebFactory.printHtml(response, "일치하는 정보가 없습니다.", 
    				"/health/metabolicSyndrome/input.do?categoryId="+zvl.getString("categoryId"));
    		return null;
    	}
    	else
    	{
			model.addAttribute("result", result);
	    	
			String includePage = "/health/dev_content/metabolicSyndrome/read.jsp";
			model.addAttribute("includePage", includePage);
			return Globals.HEALTH_MAIN_PAGE;
    	}
	}

}
