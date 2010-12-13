package egovframework.kr.go.geumcheon.health.web;

import java.io.PrintWriter;
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

import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.MemberService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;


@Controller
public class MemberController {

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@Resource(name="memberService") 
	protected MemberService memberService;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/health/member/loginPage.do")
	public String writePage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	String includePage = "/health/dev_content/member/login.jsp";
		log.debug("###########includePage :: " + includePage);
    	
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

    @RequestMapping(value="/portal/member/login.do")
    public String login(
    		HttpServletRequest request,
			HttpServletResponse response,
    		ModelMap model)
            throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);
    	System.out.println("before actionLogin-----zvl:"+zvl);
    	    	
    	// 1. 일반 로그인 처리
        UsersVO user = memberService.selectMember(zvl);
        System.out.println("after actionLogin-----UsersVO:"+user);

    	HttpSession session = request.getSession();
    	
        if (user != null) 
        {
        	//실명인증번호가 없는회원 실명인증화면으로 유도
        	
        	if("".equals(user.getPin()))
        	{
        		session.setAttribute("loginVoForPinno", user);
        		WebFactory.printHtml(response, "실명인증번호가 없습니다. 실명인증이 필요합니다.", 
        				"/portal/member/loginPage.do?menuId=0802010101&amp;menuNo=100002");
        		return null;
        	}
        	
        	session.setAttribute("user", user);

        	String forwardPage = (String)session.getAttribute("forwardPage");;
        	if(forwardPage == null) forwardPage = "/health/main/main.do";
        	
    		WebFactory.printHtml(response, "성공적으로 로그인되었습니다.", forwardPage);
    		return null;
    		
        } 
        else 
        {        	
    		WebFactory.printHtml(response, "비밀번호 또는 아이디가 맞지않습니다.", "javascript:history.back();");
    		return null;
        }
    }    

    @RequestMapping(value="/health/member/logout.do")
	public void logout(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {
    	
    	// 1. Security 연동
    	//return "redirect:/j_spring_security_logout";
    	
    	HttpSession session = request.getSession();
    	session.removeAttribute("user");

    	String forwardPage = "/health/main/main.do";
    	Company company = (Company)session.getAttribute("company");
    	if(company != null) forwardPage = "/health/freecheck/loginPage.do?categoryId=2589";
    	
    	session.removeAttribute("company"); //의약업소 로그인시
		WebFactory.printHtml(response, "성공적으로 로그아웃되었습니다.", forwardPage);
    }

    @RequestMapping(value="/health/member/testLogin.do")
	public void testLogin(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html>");
		out.println("<head>");		
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=utf-8\">");
		out.println("</head>");
		out.println("<body>");
		out.println("<form name='frm' action='/health/member/actionMain.do' method='post'>");
		out.println("<input type='hidden' name='txtRCode' />");
		out.println("<input type='hidden' name='webMemId' />");
		out.println("<input type='hidden' name='memNm' />");
		out.println("<input type='hidden' name='birthday' />");
		out.println("<input type='hidden' name='sex' />");
		out.println("<input type='hidden' name='phone' />");
		out.println("<input type='hidden' name='handphone' />");
		out.println("<input type='hidden' name='otherEmail' />");
		out.println("<input type='hidden' name='zipcode' />");
		out.println("<input type='hidden' name='address1' />");
		out.println("<input type='hidden' name='address2' />");
		out.println("<input type='hidden' name='authCode' />");
		out.println("</form>");
		out.println("</body>");
		out.println("<script type=\"text/javascript\">");
		out.println("document.frm.txtRCode.value='001';");		
		out.println("document.frm.webMemId.value='test';");
		out.println("document.frm.memNm.value='테스트';");
		out.println("document.frm.birthday.value='1974-01-27';");
		out.println("document.frm.sex.value='2';");
		out.println("document.frm.phone.value='02-123-1111';");
		out.println("document.frm.handphone.value='010-2222-3333';");
		out.println("document.frm.otherEmail.value='dinocplus@hodi.co.kr';");
		out.println("document.frm.zipcode.value='627-812';");
		out.println("document.frm.address1.value='경남 밀양시 산외면 금천리';");
		out.println("document.frm.address2.value='890-4323232';");
		out.println("document.frm.authCode.value='ROLE_MT1';");
		out.println("document.frm.submit();");		
		out.println("</script><noscript>");
		out.println("새로운 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("</noscript>");
		out.flush();
    }
    
    /**
	 * 로그인 후 메인화면으로 들어간다
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
    @RequestMapping(value="/health/member/actionMain.do")
	public String actionMain(HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);
    	log.debug("#####################zvl : " + zvl);
    	
    	String webMemId = zvl.getString("webMemId");
    	String authCode = memberService.selectAuthCodeByWebMemId(webMemId);
    	
    	HttpSession session = request.getSession();

    	String forwardPage = WebFactory.getForwardPage(request);
    	WebFactory.removeForwardPage(request);
    	
    	UsersVO user = new UsersVO();
    	user.setWebMemId(webMemId);
    	user.setPasswd(zvl.getString("passwd"));
    	user.setMemNm(zvl.getString("memNm"));
    	user.setBirthday(zvl.getString("birthday"));
    	user.setSex(zvl.getString("sex"));
    	user.setEmail(zvl.getString("email"));
    	user.setOtherEmail(zvl.getString("otherEmail"));
    	user.setUseGcmail(zvl.getString("useGcmail"));
    	user.setAllowMailing(zvl.getString("allowMailing"));
    	user.setZipcode(zvl.getString("zipcode"));
    	user.setAddress1(zvl.getString("address1"));
    	user.setAddress2(zvl.getString("address2"));
    	user.setAddress3(zvl.getString("address3"));
    	user.setPhone(zvl.getString("phone"));
    	user.setHandphone(zvl.getString("handphone"));
    	user.setPin(zvl.getString("pin"));
    	user.setAge(zvl.getInt("age"));
    	user.setAuthCode(authCode);
    	
    	log.debug("@@@@@@@@@@@@@@@@@@user : " + user);
    	

    	session.setAttribute("user", user);
    	
		// 2. 메인 페이지 이동
    	String msg = null;
    	if( forwardPage == null)
    	{
    		msg = "성공적으로 로그인 되었습니다.";
    		forwardPage = (String)session.getAttribute("forwardPage");
    		if(forwardPage == null)
    		{
				forwardPage = "/health/main/main.do";
    		}
    	}
    	log.debug("#####################forwardPage : " + forwardPage);
		WebFactory.printHtml(response, msg, forwardPage);
    	return null;
	}

    @RequestMapping(value="/health/member/selectStaffList.do")
	public String selectStaffList(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);
    	String link = "/health/member/selectStaffList.do?" +
			"?searchType="+zvl.getString("searchType")+
			"&searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"), "UTF-8")+
			"&department="+URLEncoder.encode(zvl.getString("department"), "UTF-8")+
			"&organ="+URLEncoder.encode(zvl.getString("organ"), "UTF-8")+
			"&categoryId="+zvl.getString("categoryId");
    	zvl.put("link", link);
	
		ZValue pageInfo = PageUtil.getJnPaginationInfo(zvl);
    	HashMap<String, Object> map = memberService.selectStaffList(pageInfo);
    	List<ZValue> resultList = (List<ZValue>)map.get("resultList");
    	int totCnt = (Integer)map.get("resultListCnt");

		pageInfo.put("totCnt", totCnt);
    	
		String pageNav = PageUtil.getSgPageNavString(pageInfo);

		model.addAttribute("resultList", resultList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("pageNav", pageNav);

    	String includePage = "/health/dev_content/member/selectStaffList.jsp";
    	
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
    }

    public static void main(String[] args)
    {
    }
}
