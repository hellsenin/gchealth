package egovframework.kr.go.geumcheon.health.web;

import java.net.URLEncoder;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.kr.go.geumcheon.health.service.ApplicationFactory;
import egovframework.kr.go.geumcheon.health.service.ApplicationService;
import egovframework.kr.go.geumcheon.health.service.ApplyMstService;
import egovframework.kr.go.geumcheon.health.service.MemberService;
import egovframework.kr.go.geumcheon.health.service.OnlineApplyService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 민원 신청, 신고부분 통합클래스
 * 민원신청인 경우 코드값 applyCode = A001.. H001(보건소 신청코드)..등으로 표현됨
 * 민원신고인 경우 코드값 RELY, 각신고 구분은 petiGubun - 1(구청장에바란다)...등으로 표현됨
 * @author Administrator
 *
 */
@Controller
public class AdminApplicationController {

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

    @Resource(name = "memberService")
    protected MemberService memberService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/admin/health/application/writePage.do")
	public String writePageA(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

		ZValue applyMst = applyMstService.selectApplyMst(zvl.getString("applyCode"));
		String applyAttrb = applyMst.getString("applyAttrb");
		//교육신청
		if(ApplyMstService.EDUCATION_APPLY.equals(applyAttrb))
		{
			ZValue onlineResult = onlineApplyService.selectOnlineApply(zvl);
			model.addAttribute("onlineResult", onlineResult);
		}
				
		String forwardPage = applicationFactory.getAdminForwardPage(ApplicationFactory.WRITE_PAGE, zvl);
		return forwardPage;
	}

	@RequestMapping("/admin/health/application/apply.do")
	public void apply(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);

		if("RELY0001".equals(applyCode))
		{
			UsersVO user = WebFactory.getUserInfo(request);
			if(user == null || "".equals(user.getWebMemId()))
			{
				WebFactory.printHtml(response, "회원만 글쓰기 가능합니다.", "javascript:history.back();");
				return;
			}
		}
		service.apply(zvl);

		String forwardPage = applicationFactory.getAdminForwardPage(ApplicationFactory.LIST_FORWARD, zvl);
		
		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", forwardPage);
	}

	@RequestMapping("/admin/health/application/multiApply.do")
	public void multiApply(
			MultipartHttpServletRequest multiRequest, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(multiRequest);
    	String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		service.apply(zvl, files);

		String forwardPage = applicationFactory.getAdminForwardPage(ApplicationFactory.LIST_FORWARD, zvl);
		
		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", forwardPage);
	}

	@RequestMapping("/admin/health/application/selectApplicationList.do")
	public String selectApplicationList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);

		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
		
		Map<String, Object> map = service.selectApplyListA(pageInfo);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		pageInfo.put("totCnt", totCnt);
    	
    	String link = "/admin/health/application/selectApplicationList.do?applyCode="+applyCode+
			"&petiGubun="+zvl.getString("petiGubun")+
    		"&searchType="+zvl.getString("searchType")+
    		"&searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8");
    	pageInfo.put("link", link);
		
		String pageNav = PageUtil.getSgPageNavString(pageInfo);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("pageNav", pageNav);
    			
    	String forwardPage = applicationFactory.getAdminForwardPage(ApplicationFactory.LIST_PAGE, zvl);
		log.debug("###########forwardPage :: " + forwardPage);
    	
		return forwardPage;
	}

	@RequestMapping("/admin/health/application/modifyPage.do")
	public String modifyPage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);

		ZValue result = service.selectApplyViewByApplyId(zvl);
		model.addAttribute("result", result);

		ZValue applyMst = applyMstService.selectApplyMst(applyCode);
		model.addAttribute("applyMst", applyMst);
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

		//교육신청
		if(ApplyMstService.EDUCATION_APPLY.equals(applyAttrb))
		{
			zvl.put("onlineId", result.getString("onlineId"));
			ZValue onlineResult = onlineApplyService.selectOnlineApply(zvl);
			model.addAttribute("onlineResult", onlineResult);
		}
				
		String forwardPage = applicationFactory.getAdminForwardPage(ApplicationFactory.WRITE_PAGE, zvl);
    	log.debug("forwardPage :: " + forwardPage);
		return forwardPage;
	}

	@RequestMapping("/admin/health/application/modify.do")
	public void modify(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);

    	service.modifyApply(zvl);

		String forwardPage = applicationFactory.getAdminForwardPage(ApplicationFactory.LIST_FORWARD, zvl);
		WebFactory.printHtml(response, "성공적으로 수정되었습니다.", forwardPage);
	}

	@RequestMapping("/admin/health/application/multiModify.do")
	public void multiModify(
			MultipartHttpServletRequest multiRequest, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(multiRequest);
		String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);

	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
    	service.modifyApply(zvl, files);

		String forwardPage = applicationFactory.getAdminForwardPage(ApplicationFactory.LIST_FORWARD, zvl);
		WebFactory.printHtml(response, "성공적으로 수정되었습니다.", forwardPage);
	}

	@RequestMapping("/admin/health/apply/addAssignedDeptAnswer.do")
	public void addAssignedDeptAnswer(
			HttpServletRequest request, 
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);
    	
    	service.addAnswer(zvl);
	    
		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
				 applicationFactory.getAdminForwardPage(ApplicationFactory.LIST_FORWARD, zvl));
	}

	@RequestMapping("/admin/health/apply/updateAssignedDeptAnswer.do")
	public void updateAssignedDeptAnswer(
			HttpServletRequest request, 
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request); 
		String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);

    	service.updateAssignedDeptAnswer(zvl);

		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
				 applicationFactory.getAdminForwardPage(ApplicationFactory.LIST_FORWARD, zvl));
	}

	@RequestMapping("/admin/health/application/excelSelectApplyList.do")
	public String excelSelectApplyListA(
			HttpServletRequest request,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");
		
		log.debug("paramzvl :: " + zvl);

    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);
		List resultList = service.excelSelectApplyListA(zvl);
		
		model.addAttribute("resultList", resultList);

		String fileName = "Excel";
    	String includePage = "admin/health/application/"+applyCode+"/"+applyCode+fileName;
		log.debug("###########includePage :: " + includePage);

		return includePage;
	}

	@RequestMapping("/admin/health/application/cancelApply.do")
	public void cancelApply(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");
		log.debug("zvl : " + zvl);

    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);    	
    	service.cancelApplyA(zvl);    	    	

		WebFactory.printHtml(response, "성공적으로 삭제되었습니다.", 
				 applicationFactory.getAdminForwardPage(ApplicationFactory.LIST_FORWARD, zvl));
	}

	@RequestMapping("/admin/health/application/delApply.do")
	public void delApply(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");
		log.debug("zvl : " + zvl);

    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);    	
    	service.deleteApplyByApplyId(zvl);    	    	

		WebFactory.printHtml(response, "성공적으로 삭제되었습니다.", 
				 applicationFactory.getAdminForwardPage(ApplicationFactory.LIST_FORWARD, zvl));
	}

	@RequestMapping("/admin/health/apply/changeStatus.do")
	public void changeStatusA(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   

    	ApplicationService service = applicationFactory.getApplicationBean(zvl.getString("applyCode"));    	
    	service.changeStatus(zvl);
    	
    	zvl.put("resultCode", "1");

		String resultValue = zvl.getJSONValue();
		log.debug("resultValue : " + resultValue);
		response.setContentType("application/x-json; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(resultValue);
	}

}
