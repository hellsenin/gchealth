package egovframework.kr.go.geumcheon.health.web;

import java.util.HashMap;
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
import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.ApplicationFactory;
import egovframework.kr.go.geumcheon.health.service.ApplicationService;
import egovframework.kr.go.geumcheon.health.service.ApplyMstService;
import egovframework.kr.go.geumcheon.health.service.OnlineApplyService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * 민원 신청, 신고부분 통합클래스
 * 민원신청인 경우 코드값 applyCode = A001.. H001(보건소 신청코드)..등으로 표현됨
 * 민원신고인 경우 코드값 RELY, 각신고 구분은 petiGubun - 1(구청장에바란다)...등으로 표현됨
 * @author Administrator
 *
 */
@Controller
public class ApplicationController {

    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "EgovFileMngUtil")
    protected EgovFileMngUtil fileUtil;

    @Resource(name = "applicationFactory")
    protected ApplicationFactory applicationFactory;

    @Resource(name = "applyMstService")
    protected ApplyMstService applyMstService;

    @Resource(name = "onlineApplyService")
    protected OnlineApplyService onlineApplyService;

    @Resource(name = "webFactory")
    protected WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;
    
	@RequestMapping("/health/application/writePage.do")
	public String writePage(
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

		ZValue applyMst = applyMstService.selectApplyMst(zvl.getString("applyCode"));
		String applyAttrb = applyMst.getString("applyAttrb");
		//교육신청
		if(ApplyMstService.EDUCATION_APPLY.equals(applyAttrb))
		{
	    	String applyCode = zvl.getString("applyCode");
	    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);
	    	ZValue inwonZvl = onlineApplyService.getInwon(zvl);
	    	int cnt = inwonZvl.getInt("appInwon") + inwonZvl.getInt("waitInwon") - inwonZvl.getInt("inwonCnt");
	    	if(cnt <= 0)
	    	{
				WebFactory.printHtml(response, "신청인원이 마감되었습니다.", 
						"/health/onlineApply/selectOnlineApply.do" +
						"?categoryId="+zvl.getString("categoryId")+
						"&applyCode="+zvl.getString("applyCode")+
						"&onlineId="+zvl.getString("onlineId"));
				return null;
	    	}
			ZValue onlineResult = onlineApplyService.selectOnlineApply(zvl);
			if("N".equals(onlineResult.getString("dupYn")) && service.selectOnlineApplyCnt(zvl) > 0)
			{
				WebFactory.printHtml(response, "이미접수하셨습니다.", 
						"/health/onlineApply/selectOnlineApply.do" +
						"?categoryId="+zvl.getString("categoryId")+
						"&applyCode="+zvl.getString("applyCode")+
						"&onlineId="+zvl.getString("onlineId"));
				return null;
			}
			model.addAttribute("onlineResult", onlineResult);
		}
		
    	String includePage = 
    		applicationFactory.getForwardPage(ApplicationFactory.WRITE_PAGE, zvl);
		log.debug("###########includePage :: " + includePage);
    	
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	/**
	 * 신청,신고 등록 기본상태값(status=1 접수,미확인)으로 등록
	 * @param multiRequest
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/health/application/apply.do")
	public void apply(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		HttpSession session = request.getSession();
		UsersVO user = (UsersVO)session.getAttribute("user");		
    	if(user == null) throw new EgovBizException("잘못된 접근입니다.");
    	
    	ZValue zvl = WebFactory.getAttributes(request);
    	String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);
    			
		log.debug("#######################zvl : " + zvl);
				
		service.apply(zvl);

		String forwardPage = 
			applicationFactory.getForwardPage(ApplicationFactory.LIST_FORWARD, zvl);
		
		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", forwardPage);
	}

    @SuppressWarnings("unchecked")
	@RequestMapping("/health/application/multiApply.do")
	public void multiApply(
			MultipartHttpServletRequest multiRequest, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		HttpSession session = multiRequest.getSession();
		UsersVO user = (UsersVO)session.getAttribute("user");		
    	if(user == null) throw new EgovBizException("잘못된 접근입니다.");
    	
    	ZValue zvl = WebFactory.getAttributes(multiRequest);
    	String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);
    			
		log.debug("#######################zvl : " + zvl);
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		log.debug("files : " + files);
		
		service.apply(zvl, files);

		String forwardPage = 
			applicationFactory.getForwardPage(ApplicationFactory.LIST_FORWARD, zvl);
		
		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", forwardPage);
	}
    
	@RequestMapping("/health/application/cancelApply.do")
	public void cancelApply(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);
		log.debug("zvl : " + zvl);

		UsersVO user = WebFactory.getUserInfo(request);
    	if(user == null) throw new EgovBizException("사용자정보가 없습니다.");

    	ZValue result = service.selectApplyViewByApplyId(zvl);
    	if(!service.isAccessable(result, user))
    	{
    		throw new EgovBizException("잘못된 경로 입니다.");
    	}
    	
    	service.cancelApply(zvl);    	    	

		String forwardPage = 
			applicationFactory.getForwardPage(ApplicationFactory.LIST_FORWARD, zvl);
		
		WebFactory.printHtml(response, "성공적으로 신청취소되었습니다.", forwardPage);
	}

	@RequestMapping("/health/application/selectMyApplyList.do")
	public String selectMyApplyList(
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
		String applyCode = zvl.getString("applyCode");

		zvl.put("memberId", user.getWebMemId());
		zvl.put("pinno", user.getPin());

		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);

		ZValue applyMst = applyMstService.selectApplyMst(zvl.getString("applyCode"));
		String applyAttrb = applyMst.getString("applyAttrb");
		
		Map<String, Object> map = null;
		if(ApplyMstService.BASIC_APPLY.equals(applyAttrb))
		{
	    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);
			map = service.selectApplyListById(pageInfo);
		}
		else if(ApplyMstService.EDUCATION_APPLY.equals(applyAttrb))
		{
			map = onlineApplyService.selectMyOnlineApplyList(pageInfo);
		}
				
    	String link = "/health/application/selectMyApplyList.do?applyCode="+applyCode+
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

	@RequestMapping("/health/application/selectApplyList.do")
	public String selectApplyList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		String applyCode = zvl.getString("applyCode");
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);

		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
		
		Map<String, Object> map = service.selectApplyList(pageInfo);
    	
    	String link = "/health/application/selectApplyList.do?applyCode="+applyCode+
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

	@RequestMapping("/health/application/selectApplyView.do")
	public String selectApplyView(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
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

		//교육신청
		if(ApplyMstService.EDUCATION_APPLY.equals(applyAttrb))
		{
			ZValue onlineResult = onlineApplyService.selectOnlineApply(zvl);
			model.addAttribute("onlineResult", onlineResult);
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

	@RequestMapping("/health/application/modifyApplyPage.do")
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

		//교육신청
		if(ApplyMstService.EDUCATION_APPLY.equals(applyAttrb))
		{
			zvl.put("onlineId", result.getString("onlineId"));
			ZValue onlineResult = onlineApplyService.selectOnlineApply(zvl);
			model.addAttribute("onlineResult", onlineResult);
		}
		
		String includePage = 
			applicationFactory.getForwardPage(ApplicationFactory.WRITE_PAGE, zvl);
		log.debug("###########includePage :: " + includePage);
		model.addAttribute("includePage", includePage);
		//model.addAttribute("includePage", "/health/dev_content/application/PRTLTAPPLY_"+applyCode+"/"+applyCode+"Write.jsp");
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/application/modify.do")
	public void modify(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	String applyCode = zvl.getString("applyCode");

		UsersVO user = WebFactory.getUserInfo(request);	
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);	
		ZValue result = service.selectApplyViewByApplyId(zvl);
    	if(user == null || !service.isAccessable(result, user))
    	{
    		throw new EgovBizException("잘못된 경로 입니다.");
    	}
		
		
		log.debug("zvl : " + zvl);
		service.modifyApply(zvl);
	    

		String forwardPage = 
			applicationFactory.getForwardPage(ApplicationFactory.LIST_FORWARD, zvl);

		WebFactory.printHtml(response, "성공적으로 수정되었습니다.", forwardPage);
		
	}

	@RequestMapping("/health/application/multiModify.do")
	public void multiModify(
			MultipartHttpServletRequest multiRequest, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(multiRequest);
    	String applyCode = zvl.getString("applyCode");

		UsersVO user = WebFactory.getUserInfo(multiRequest);	
    	ApplicationService service = applicationFactory.getApplicationBean(applyCode);	
		ZValue result = service.selectApplyViewByApplyId(zvl);
    	if(user == null || !service.isAccessable(result, user))
    	{
    		throw new EgovBizException("잘못된 경로 입니다.");
    	}
		
		log.debug("zvl : " + zvl);
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		service.modifyApply(zvl, files);
	    

		String forwardPage = 
			applicationFactory.getForwardPage(ApplicationFactory.LIST_FORWARD, zvl);

		WebFactory.printHtml(response, "성공적으로 수정되었습니다.", forwardPage);
		
	}

	@RequestMapping("/health/apply/fileDown.do")
	public void fileDown(
			HttpServletRequest request,
			HttpServletResponse response,			
			ModelMap model)throws Exception
	{
    	ZValue paramZvl = WebFactory.getAttributes(request);

    	ApplicationService service = applicationFactory.getApplicationBean("default");
    	
    	ZValue zvl = service.selectFileByFileId(paramZvl.getString("fileId"));
    	log.debug("zvl ::: " + zvl);
    	String fileName = zvl.getString("fileName");
    	String orgFileName = zvl.getString("orgFileName");
    	String path = zvl.getString("filePath");
    	
    	WebFactory.download(path, fileName, orgFileName, request, response);    	
	}

	@RequestMapping("/health/apply/addAssignedDeptAnswer.do")
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
				 "/health/medicalTeam/selectApplyView.do"+
				 "?applyCode="+zvl.getString("applyCode")+
				 "&applyId="+zvl.getString("applyId")+
				 "&petiGubun="+zvl.getString("petiGubun")+
				 "&categoryId="+zvl.getString("categoryId"));
	}

	@RequestMapping("/health/apply/updateAssignedDeptAnswer.do")
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
				 "/health/medicalTeam/selectApplyView.do"+
				 "?applyCode="+zvl.getString("applyCode")+
				 "&applyId="+zvl.getString("applyId")+
				 "&petiGubun="+zvl.getString("petiGubun")+
				 "&categoryId="+zvl.getString("categoryId"));
	}

}
