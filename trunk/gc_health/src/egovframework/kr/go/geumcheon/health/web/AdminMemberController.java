package egovframework.kr.go.geumcheon.health.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.kr.go.geumcheon.health.service.MedicalTeamService;
import egovframework.kr.go.geumcheon.health.service.MemberService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.AdminUserVO;


@Controller
public class AdminMemberController {

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@Resource(name="memberService") 
	protected MemberService memberService;

	@Resource(name="MedicalTeamService")
	private MedicalTeamService medicalTeamService;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

    @RequestMapping(value="/admin/health/member/login.do")
    public void login(
    		HttpServletRequest request,
			HttpServletResponse response,
    		ModelMap model)
            throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);
    	System.out.println(">>>before actionLogin-----zvl:"+zvl);
    	    	
    	// 1. 일반 로그인 처리
        AdminUserVO adminUser = new AdminUserVO();
        adminUser.setUserId(zvl.getString("userId"));
        adminUser.setLoginId(zvl.getString("loginId"));
        adminUser.setPassword(zvl.getString("password"));
        adminUser.setName(zvl.getString("name"));
        adminUser.setEmail(zvl.getString("email"));
        adminUser.setPhone(zvl.getString("phone"));
        adminUser.setMobile(zvl.getString("mobile"));
        adminUser.setDepartment(zvl.getString("department"));
        adminUser.setDepartmentCode(zvl.getString("departmentCode"));
        
    	HttpSession session = request.getSession();
    	session.setAttribute("adminUser", adminUser);
    }    

    @RequestMapping(value="/admin/health/member/logout.do")
	public void logout(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {
    	
    	// 1. Security 연동
    	//return "redirect:/j_spring_security_logout";

    	HttpSession session = request.getSession();
    	session.removeAttribute("adminUser");
    }

    @RequestMapping(value="/admin/health/member/selectMemberAuthList.do")
	public String selectMemberAuthList(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);
		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
    	HashMap<String, Object> map = memberService.selectMemberList(pageInfo);
    	List<ZValue> resultList = (List<ZValue>)map.get("resultList");
    	int totCnt = (Integer)map.get("resultListCnt");

		pageInfo.put("totCnt", totCnt);
    	
    	String link = "/admin/health/member/selectMemberAuthList.do" +
    		"?searchType="+zvl.getString("searchType")+
    		"&searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8");
    	pageInfo.put("link", link);
		
		String pageNav = PageUtil.getSgPageNavString(pageInfo);

		model.addAttribute("resultList", resultList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("pageNav", pageNav);
		
		List<ZValue> mtList = medicalTeamService.selectMedicalTeamList();
		model.addAttribute("mtList", mtList);
		
		return "admin/health/member/selectMemberAuthList";
    }

    @RequestMapping(value="/admin/health/member/applyUsersAuth.do")
	public void applyUsersAuth(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);

    	memberService.applyUsersAuth(zvl);

    	String link = "/admin/health/member/selectMemberAuthList.do" +
    		"?searchType="+zvl.getString("searchType")+
    		"&searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8");
		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", link);
    }

    public static void main(String[] args)
    {
    }
}
