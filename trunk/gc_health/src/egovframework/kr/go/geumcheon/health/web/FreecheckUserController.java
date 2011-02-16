package egovframework.kr.go.geumcheon.health.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.FileDownloadService;
import egovframework.kr.go.geumcheon.health.service.FreecheckUserService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Answer;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;

@Controller
public class FreecheckUserController {
	
	@Resource(name="FreecheckUserService")
	private FreecheckUserService service = null;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@RequestMapping("/health/freecheck/loginPage.do")
	public String loginPage(
		 HttpServletRequest request
		, HttpServletResponse response 
		, ModelMap model) throws Exception {
		
		String includePage = "/health/dev_content/freecheck/login.jsp";

		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/freecheck/login.do")
	public void login(
		@ModelAttribute("Bean") Company bean
		, HttpServletRequest request
		, HttpServletResponse response 
		, ModelMap model) throws Exception {
		// 로그인 체크 

		String backwardPage = "/health/freecheck/loginPage.do?categoryId=2589";
		bean.setForLogin("Y");
		if(!service.loginFreecheck(bean, model))
		{
			WebFactory.printHtml(response, (String)model.get("message"), backwardPage);
		}
		else
		{
			HttpSession session = request.getSession();
			Company _company = (Company)model.get("company");
			session.setAttribute("company", _company);
			WebFactory.printHtml(response, "성공적으로 로그인되었습니다.", "/health/freecheck/list.do?categoryId=2589");
		}
	}
	
	@RequestMapping("/health/freecheck/list.do")
	public String selectCheckStateList(
		@ModelAttribute("Bean") Company bean
		, HttpServletRequest request
		, HttpServletResponse response 
		, ModelMap model) throws Exception {
		// 로그인 체크 
		
		HttpSession session = request.getSession();
		Company company = (Company)session.getAttribute("company");
		
		String backwardPage = "/health/freecheck/loginPage.do?categoryId=2589";
		if(company == null)
		{
			WebFactory.printHtml(response, (String)model.get("message"), backwardPage);
			return null;
		}
		
		// 점검표 리스트 불러오기
		service.selectCheckStateList(company, model);
		
		String includePage = "/health/dev_content/freecheck/list.jsp";

		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}
	
	@RequestMapping("/health/freecheck/view.do")
	public String selectCheckStateView(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {

		HttpSession session = request.getSession();
		Company company = (Company)session.getAttribute("company");
		
		String backwardPage = "/health/freecheck/loginPage.do?categoryId=2589";
		if(company == null)
		{
			WebFactory.printHtml(response, (String)model.get("message"), backwardPage);
			return null;
		}
		
		// 점검표 불러오기
		service.selectCheckStateView(bean, model);
		
		
		String includePage = "/health/dev_content/freecheck/view.jsp";

		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/freecheck/forCheck.do")
	public String forCheck(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {

		HttpSession session = request.getSession();
		Company company = (Company)session.getAttribute("company");
		
		String backwardPage = "/health/freecheck/loginPage.do?categoryId=2589";
		if(company == null)
		{
			WebFactory.printHtml(response, (String)model.get("message"), backwardPage);
			return null;
		}
		
		// 점검표 불러오기 (생략 가능)
		service.selectCheckStateView(bean, model);
		
		// 업소 정보 불러오기 
		service.selectCompanyInfo(bean, model);
		
		String includePage = "/health/dev_content/freecheck/check.jsp";
		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}

	@RequestMapping("/health/freecheck/check.do")
	public String check(
			@ModelAttribute("Bean") Answer bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {

		HttpSession session = request.getSession();
		Company company = (Company)session.getAttribute("company");
		
		String backwardPage = "/health/freecheck/loginPage.do?categoryId=2589";
		if(company == null)
		{
			WebFactory.printHtml(response, (String)model.get("message"), backwardPage);
			return null;
		}
		
		// 사용자 정보 
		UsersVO user = WebFactory.getUserInfo(request);
		model.addAttribute("user", user);
		
		// Answer1 체크하기
		String other5 = "";
		String[] checkedItem = request.getParameterValues("item");
		if(checkedItem != null)
		{
			for(int i=0; i<checkedItem.length; i++)
			{
				if(i == checkedItem.length-1)
					other5 += checkedItem[i];
				else
					other5 += checkedItem[i] + ",";
			}
		}
		bean.setOther5(other5);
		List<Answer> answer2list = getZvl(WebFactory.getAttributes(request));
		service.check(bean, answer2list, model);
		
		
		// 점검표 체크 후 페이지 이동 
		String includePage = "";
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>company : "+company);
		if("writable".equals(bean.getView_state()) || "update".equals(bean.getView_state())) {
			String divideCd = company.getDivide_cd();
			//if("k10".equals(divideCd) || "k01".equals(divideCd) || "k02".equals(divideCd))
			if(true)
			{
				List<ZValue> handleItemList = service.selectHandleitemListU(company);
				model.addAttribute("handleItemList", handleItemList);
				includePage = "/health/dev_content/freecheck/drugList.jsp";
			}
			else
			{
				Company param = new Company();
				param.setId(bean.getCompany_id());
				service.loginFreecheck(param, model);
				
				param = (Company) model.get("company");
	
				int company_cd = bean.getCompany_cd();
				int master_cd = bean.getMaster_cd();
				String year_cd = bean.getYear_cd();
				param.setCompany_cd(company_cd);
				param.setMaster_cd(master_cd);
				param.setYear_cd(year_cd);
	
				service.selectCheckStateList(param, model);
				
				model.addAttribute("Bean", param);
				
				includePage = "/health/dev_content/freecheck/list.jsp";	
				model.addAttribute("view_state", "checked");
			}
		} 
		

		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}
	

	@RequestMapping("/health/freecheck/checkHandleitem.do")
	public void checkHandleitem(
			HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {

		HttpSession session = request.getSession();
		Company company = (Company)session.getAttribute("company");
		
		String backwardPage = "/health/freecheck/loginPage.do?categoryId=2589";
		if(company == null)
		{
			WebFactory.printHtml(response, (String)model.get("message"), backwardPage);
			return;
		}
		
		ZValue zvl = WebFactory.getAttributes(request);
		
		service.checkHandleitem(company, zvl);
		
		String forwardUrl = "/health/freecheck/list.do?categoryId=2589";
		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", forwardUrl);
	}
	
	
	private void alertLogin(HttpServletRequest request, HttpServletResponse response, String forwardPage, String backwardPage) {
		HttpSession session = request.getSession();
		session.setAttribute("forwardPage", forwardPage);
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (Exception e) {
			e.printStackTrace();
		}

		out.print("<script>\n");
//		out.print("if(confirm('로그인또는 실명인증이 필요한 페이지입니다. 로그인 페이지로 이동하시겠습니까?'))\n");
		out.print("location.href='/health/member/loginPage.do?menuId=0602010101&menuNo=4518'\n");
//		out.print("else location.href='"+backwardPage+"'\n");
		out.print("</script>");
	}

	
//	private HashMap getAttributeForRequest(HttpServletRequest request) {
//		HashMap zvl = new HashMap();
//		String name = "";
//		Enumeration e = request.getParameterNames();
//		while (e.hasMoreElements()) {
//			name = (String) e.nextElement();
//			zvl.put(name, request.getParameter(name));
//		}
//		return zvl;
//	}
	
	private List<Answer> getZvl(ZValue zvl) {
		List<Answer> list = new ArrayList<Answer>();
		int size = zvl.getInt("questionListSize");
		
		int masterCd = zvl.getInt("masterCd");
		String companyId = zvl.getString("companyId");
		int companyCd = zvl.getInt("companyCd");
		
		for(int i=1; i<=size; i++) {

			int questionCd = zvl.getInt("questionCd"+i);
			
			Object multi_check_yn = zvl.get("multiCheckYn"+i);
			
			int question2Cd = 0;
			String other = "";
			if(multi_check_yn != null && multi_check_yn.toString().length() != 0) {
				if("Y".equals(multi_check_yn.toString())) {
					
					int checkboxCount = zvl.getInt("checkboxCount" + i);
					for(int j=1; j<=checkboxCount; j++) {
						
						question2Cd = zvl.getInt("question2Cd"+i+""+j);
						
						Answer item = new Answer();
						item.setQuestion2_cd(question2Cd);
						item.setQuestion_cd(questionCd);
						item.setOther(other);
						item.setMaster_cd(masterCd);
						item.setCompany_cd(companyCd);
						item.setCompany_id(companyId);
						
						list.add(item);
					}
				} else if("N".equals(multi_check_yn.toString())) {
					Object question2CdObj = null;
					try {
						question2CdObj = zvl.get("question2Cd"+i);
						if(question2CdObj.toString().length() != 0) {;
							question2Cd = Integer.parseInt(question2CdObj.toString());
		
							Answer item = new Answer();
							item.setQuestion2_cd(question2Cd);
							item.setQuestion_cd(questionCd);
							item.setOther(other);
							item.setMaster_cd(masterCd);
							item.setCompany_cd(companyCd);
							item.setCompany_id(companyId);
							
							list.add(item);
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			} else {
				other = zvl.getString("other"+i);
				Answer item = new Answer();
				item.setQuestion2_cd(question2Cd);
				item.setQuestion_cd(questionCd);
				item.setOther(other);
				item.setMaster_cd(masterCd);
				item.setCompany_cd(companyCd);
				item.setCompany_id(companyId);
				
				list.add(item);
			}
			
		}
		
		return list;
	}

	@RequestMapping("/health/freecheck/list_info.do")
	public String selectFreecheckInfoList(
		@ModelAttribute("Bean") Company bean
		, HttpServletRequest request
		, HttpServletResponse response 
		, ModelMap model) throws Exception {

		// 점검표 리스트 불러오기
		service.selectFreecheckInfoList(bean, model);
		model.addAttribute("Bean", bean);
		
		String includePage = "/health/dev_content/freecheck/list_info.jsp";

		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}
	

	@RequestMapping("/health/freecheck/read_info.do")
	public String selectFreecheckInfo(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		// 점검표 리스트 불러오기
		service.selectFreecheckInfo(bean, model);
		model.addAttribute("Bean", bean);
		
		String includePage = "/health/dev_content/freecheck/read_info.jsp";

		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return Globals.HEALTH_MAIN_PAGE;
	}
	

    /**
	 * 일반 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping(value="/health/company/login.do")
    public String login(
    		HttpServletRequest request,
			HttpServletResponse response,
    		ModelMap model)
            throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);
    	System.out.println("before actionLogin-----zvl:"+zvl);
    	    	
    	// 1. 일반 로그인 처리
        ZValue loginZvl = service.actionLogin(zvl);
        System.out.println("after actionLogin-----loginZvl:"+loginZvl);

        if (loginZvl != null) 
        {
        	UsersVO user = new UsersVO();
        	user.setWebMemId(loginZvl.getString("id"));
        	user.setMemNm(loginZvl.getString("name"));
        	user.setZipcode(loginZvl.getString("zipcode"));
        	user.setAddress1(loginZvl.getString("addr1"));
        	user.setAddress2(loginZvl.getString("addr2"));
        	user.setUseGcmail(loginZvl.getString("email"));
        	user.setPhone(loginZvl.getString("tel"));
        	user.setHandphone(loginZvl.getString("cellPhone"));
        	
        	HttpSession session = request.getSession();
        	session.setAttribute("user", user);

        	String forwardPage = (String)session.getAttribute("forwardPage");;
        	if(forwardPage == null) forwardPage = "/health/freecheck/list.do?menuId=0602010101&menuNo=4518";
        	
    		WebFactory.printHtml(response, "성공적으로 로그인되었습니다.", forwardPage);
    		return null;	
        } 
        else 
        {        	
    		WebFactory.printHtml(response, "비밀번호가 맞지않습니다.", "javascript:history.back();");
    		return null;
        }
    }
    

	@Resource(name = "FileDownloadService")
	private FileDownloadService fileDownloadService = null;

	@RequestMapping("/health/freecheck/download.do")
	public String download(
		@ModelAttribute("Bean") Company bean
		, HttpServletRequest request
		, HttpServletResponse response 
		, ModelMap model) throws Exception {


		fileDownloadService.download(request, response, "freecheck", request.getParameter("file"));
		
		return "";
	}

	@RequestMapping("/health/freecheck/drugList.do")
	public String drupList(
		 HttpServletRequest request
		, HttpServletResponse response 
		, ModelMap model) throws Exception {
		
		String includePage = "/health/dev_content/freecheck/drugList.jsp";

		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

}
