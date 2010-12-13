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
public class AdminMetabolicSyndromeController {

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

	@RequestMapping("/admin/health/metabolicSyndrome/forAdd.do")
	public String forAdd(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		return "admin/health/metabolicSyndrome/add";
	}

	@RequestMapping("/admin/health/metabolicSyndrome/uploadExcel.do")
	public void uploadExcel(
			MultipartHttpServletRequest multiRequest, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(multiRequest);   
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();

	    String msg = null;    	
    	if(APP000046ApplicationService.uploadExcel(zvl, files))
    	{
    		msg = "성공적으로 등록되었습니다.";
    	}
    	else
    	{
    		msg = "등록에 실패하였습니다.";
    	}
		WebFactory.printHtml(response, msg, "/admin/health/application/selectApplicationList.do?applyCode=APP000046");
	}

}
