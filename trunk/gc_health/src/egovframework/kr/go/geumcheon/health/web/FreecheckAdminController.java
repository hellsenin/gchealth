package egovframework.kr.go.geumcheon.health.web;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.kr.go.geumcheon.health.service.FileDownloadService;
import egovframework.kr.go.geumcheon.health.service.FreecheckAdminService;
import egovframework.kr.go.geumcheon.health.service.FreecheckUserService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.service.XlsCreateService;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Answer;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Industry;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.Question;
import egovframework.kr.go.geumcheon.health.vo.Question2;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class FreecheckAdminController {
	
	@Resource(name = "FreecheckAdminService")
	private FreecheckAdminService service;

	@Resource(name = "FreecheckUserService")
	private FreecheckUserService userService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@Resource(name="pageUtil")
	private PageUtil PageUtil;
	
	/**
	 * 업종 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/industry/list.do")
	public String selectIndustryList(
			@ModelAttribute("Bean") Industry bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		bean.setPageSize(10000);
		bean.setPageUnit(10000);
		bean.setPageIndex(1);
		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
			bean.setSearchCondition("1");
		}
		service.selectIndustryList(bean, model);
		
		String returnURL = "/admin/health/freecheck/industry/list";

		return returnURL;
	}
	


	/**
	 * 업종 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/industry/select.do")
	public String selectIndustry(
			@ModelAttribute("Bean") Industry bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/freecheck/industry/read";
		service.selectIndustry(bean, model);
		
		return returnURL;
	}

	/**
	 * 업종 관리 (등록을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/industry/forInsert.do")
	public String forInsertIndustry(
			@ModelAttribute("Bean") Industry bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/freecheck/industry/insert";
		service.forInsertIndustry(bean, model);
		
		return returnURL;
	}
	
	/**
	 * 업종 관리 (등록)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/industry/insert.do")
	public String insertIndustry(
			@ModelAttribute("Bean") Industry bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {

		service.insertIndustry(bean, model);

		service.selectIndustryList(bean, model);
		
		String returnURL = "/admin/health/freecheck/industry/list";
		
		return returnURL;
	}

	/**
	 * 업종 관리 (수정을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/industry/forUpdate.do")
	public String forUpdateIndustry(
			@ModelAttribute("Bean") Industry bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/freecheck/industry/update";
		service.forUpdateIndustry(bean, model);
		
		return returnURL;
	}

	/**
	 * 업종 관리 (수정)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/industry/update.do")
	public String updateIndustry(
			@ModelAttribute("Bean") Industry bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		System.out.println(WebFactory.getAttributes(request));
		service.updateIndustry(bean, model);


		String returnURL = "/admin/health/freecheck/industry/read";
		service.selectIndustry(bean, model);
		
		return returnURL;
	}

	
	/**
	 * 업종 관리 (삭제)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/industry/delete.do")
	public String deleteIndustry(
			@ModelAttribute("Bean") Industry bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		

		service.deleteIndustry(bean, model);

		service.selectIndustryList(bean, model);
		String returnURL = "/admin/health/freecheck/industry/list";
		
		
		return returnURL;
	}


	/**
	 * 업소 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/company/list.do")
	public String selectCompanyList(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {

		
		service.selectCompanyList(bean, model);
		
		String returnURL = "/admin/health/freecheck/company/list";
		
		return returnURL;
	}
	
	/**
	 * 업소 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/company/select.do")
	public String selectCompany(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/freecheck/company/read";
		service.selectCompany(bean, model);
		
		
		return returnURL;
	}
	
//	FreecheckAdminDAO.checkCompanyId

	/**
	 * 업소 관리 (등록을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/company/checkId.do")
	public String checkCompanyId(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		int count = service.checkCompanyId(bean);
		

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		out.print("<script>\n");
		out.print("var retVal = new Object();");
		out.print("retVal.count = "+count+";");
		out.print("window.returnValue = retVal;");
		out.print("window.close();\n");
		out.print("</script>");	
		
		return null;
	}

	
	/**
	 * 업소 관리 (등록을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/company/forInsert.do")
	public String forInsertCompany(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/freecheck/company/insert";
		
		service.forInsertCompany(bean, model);
		
		return returnURL;
	}
	
	/**
	 * 업소 관리 (등록)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/company/insert.do")
	public String insertCompany(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {

		service.insertCompany(bean, model);

		service.selectCompanyList(bean, model);
		
		String returnURL = "/admin/health/freecheck/company/list";
		
		return returnURL;
	}

	@RequestMapping("/admin/freecheck/forUploadExcel.do")
	public String forUploadExcel(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		return "admin/health/freecheck/company/uploadExcel";
	}

	@RequestMapping("/admin/freecheck/uploadExcel.do")
	public void uploadExcel(
			MultipartHttpServletRequest multiRequest, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
		ZValue zvl = WebFactory.getAttributes(multiRequest);
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();

	    String msg = null;    	
    	if(service.uploadCompanyExcel(zvl, files))
    	{
    		msg = "성공적으로 등록되었습니다.";
    	}
    	else
    	{
    		msg = "등록에 실패하였습니다.";
    	}
		WebFactory.printHtml(response, msg, "/admin/freecheck/forUploadExcel.do?industry_cd="+zvl.getString("industryCd"));
	}

	/**
	 * 업소 관리 (수정을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/company/forUpdate.do")
	public String forUpdateCompany(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/freecheck/company/update";
		service.forUpdateCompany(bean, model);
		
		return returnURL;
	}

	/**
	 * 업소 관리 (수정)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/company/update.do")
	public String updateCompany(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {

		service.updateCompany(bean, model);


		String returnURL = "/admin/health/freecheck/company/read";
		service.forUpdateCompany(bean, model);
		
		return returnURL;
	}

	
	/**
	 * 업소 관리 (삭제)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/company/delete.do")
	public String deleteCompany(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		

		service.deleteCompany(bean, model);

		service.selectCompanyList(bean, model);
		String returnURL = "/admin/health/freecheck/company/list";
		
		
		return returnURL;
	}
	

//	
//		

	@RequestMapping("/admin/freecheck/checkform/list_checked_company/delete.do")
	public String list_checked_company_delete(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		Object p = request.getParameter("delete_company_id");
		if(p != null) {
			Company param = new Company();
			param.setId(p.toString());
			param.setMaster_cd(bean.getMaster_cd());
			param.setYear_cd(bean.getYear_cd());
			param.setType_cd(bean.getType_cd());
			service.deleteAnswerForCompanyId(param);
		}
		
		
		
		
		
		// 디폴트 값 설정
		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy"); //운영서버 배포시 주석 해제 할 것
//			SimpleDateFormat dateFormat = new SimpleDateFormat("200901");
			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		
		// 페이징 처리 (1)
		bean.setPageUnit(10);
		bean.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 리스트 조회
		service.selectCheckedCompanyList(bean, model);
		
		// 페이징 처리 (2)
		String returnURL = "/admin/health/freecheck/checkform/list_checked_company";

		String url = "/admin/freecheck/checkform/list_checked_company.do";
		url += "?master_cd="+bean.getMaster_cd();
		url += "&year_cd="+bean.getYear_cd();
		
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		return returnURL;
	}
	
	
	
	/**
	 * 점검표 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/list.do")
	public String selectCheckformList(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/freecheck/checkform/list";

		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
//			SimpleDateFormat dateFormat = new SimpleDateFormat("200901");
			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		service.selectCheckformList(bean, model);
		
		
		return returnURL;
	}



	/**
	 * 점검표 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/read.do")
	public String selectCheckform(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/freecheck/checkform/read";

		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
//			SimpleDateFormat dateFormat = new SimpleDateFormat("200901");
			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		service.selectCheckform(bean, model);
		
		return returnURL;
	}

	@RequestMapping("/admin/freecheck/checkform/list_checked_company.do")
	public String checked_company_list(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		// 디폴트 값 설정
		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy"); //운영서버 배포시 주석 해제 할 것
//			SimpleDateFormat dateFormat = new SimpleDateFormat("200901");
			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		
		// 페이징 처리 (1)
		bean.setPageUnit(10);
		bean.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 리스트 조회
		service.selectCheckedCompanyList(bean, model);
		
		// 페이징 처리 (2)
		String returnURL = "/admin/health/freecheck/checkform/list_checked_company";

		String url = "/admin/freecheck/checkform/list_checked_company.do";
		url += "?master_cd="+bean.getMaster_cd();
		url += "&year_cd="+bean.getYear_cd();
		
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		return returnURL;
	}
	
	@RequestMapping("/admin/freecheck/checkform/checked_handleitem_list.do")
	public String checked_handleitem_list(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/freecheck/checkform/list_checked_handleitem";
		
		service.selectCheckedHandleitemList(bean, model);
		return returnURL;
	}
	
	
	/**
	 * 점검표 관리 (등록을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/forInsert.do")
	public String forInsertCheckform(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/freecheck/checkform/insert";
		service.forInsertCheckform(bean, model);
		
		return returnURL;
	}
	
	/**
	 * 점검표 관리 (등록)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/insert.do")
	public String insertCheckform(
			@ModelAttribute("Bean") Master bean
			, MultipartHttpServletRequest multiRequest 
			, ModelMap model) {

    	ZValue zvl = WebFactory.getAttributes(multiRequest);
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		service.insertCheckform(bean, model, files);

		service.selectCheckformList(bean, model);
		
		String returnURL = "/admin/health/freecheck/checkform/list";
		
		return returnURL;
	}

	/**
	 * 점검표 관리 (수정을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/forUpdate.do")
	public String forUpdateCheckform(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/freecheck/checkform/update";
		service.forUpdateCheckform(bean, model);
		
		return returnURL;
	}

	/**
	 * 점검표 관리 (첨부파일 삭제)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/checkform/checkform/deleteAttachFile.do")
	public String deleteCheckformAttachFile(
			@ModelAttribute("Bean") Master bean
			, MultipartHttpServletRequest multiRequest
			, HttpServletResponse response
			, ModelMap model) {
		
		ZValue zvl = WebFactory.getAttributes(multiRequest);
		
		String file = zvl.get("file").toString();
		service.deleteCheckformAttachFile(bean, model, file, response);
		String returnURL = "/admin/health/freecheck/checkform/update";
		model.addAttribute("result", bean);
		return returnURL;
	}
	
	
	/**
	 * 점검표 관리 (수정)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/update.do")
	public String updateCheckform(
			@ModelAttribute("Bean") Master bean
			, MultipartHttpServletRequest multiRequest
			, ModelMap model) {

    	ZValue zvl = WebFactory.getAttributes(multiRequest);
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		service.updateCheckform(bean, model, files);
		

		String returnURL = "/admin/health/freecheck/checkform/read";
		service.selectCheckform(bean, model);
		
		return returnURL;
	}

	
	/**
	 * 점검표 관리 (삭제)
	 * @param bean
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/delete.do")
	public String deleteCheckform(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		

		service.deleteCheckform(bean, model);

		service.selectCheckformList(bean, model);
		String returnURL = "/admin/health/freecheck/checkform/list";
		
		
		return returnURL;
	}
	
	
	

	@RequestMapping("/admin/freecheck/checkform/list_not_checked_company.do")
	public String not_checked_company_list(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		// 디폴트 값 설정
		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy"); //운영서버 배포시 주석 해제 할 것
//			SimpleDateFormat dateFormat = new SimpleDateFormat("200901");
			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		
		// 페이징 처리 (1)
		bean.setPageUnit(10);
		bean.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 리스트 조회
		service.selectNotCheckedCompanyList(bean, model);
		
		// 페이징 처리 (2)
		String returnURL = "/admin/health/freecheck/checkform/list_not_checked_company";

		String url = "/admin/freecheck/checkform/list_not_checked_company.do";
		url += "?master_cd="+bean.getMaster_cd();
		url += "&year_cd="+bean.getYear_cd();
		
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		return returnURL;
	}

	
	@RequestMapping("/admin/freecheck/checkform/list_question.do")
	public String selectQuestionList(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		// 리스트 조회
		service.selectQuestionList(bean, model);
		

		String returnURL = "/admin/health/freecheck/checkform/list_question";

		return returnURL;
	}
	

	@Resource(name = "FileDownloadService")
	private FileDownloadService fileDownloadService = null;
	
	@Resource(name = "XlsCreateService")
	private XlsCreateService xlsCreateService = null;

	@RequestMapping("/admin/freecheck/checkform/report_answer.do")
	public String report_answer(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {
		String filename = request.getParameter("file");
		String key = "freecheck";
		String typeNo = "1";
		List list = service.downloadExcelAnswerList(bean, model);
		if(list.size() == 0) {
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			out.print("<script>\n");
			out.print("alert('응모한 업소 레코드가 "+list.size()+"개 이므로 다운로드가 불가능 합니다.');\n");
			out.print("location.href='/admin/freecheck/checkform/list_question.do?master_cd="+bean.getMaster_cd()+"&question_cd="+bean.getQuestion_cd()+"';\n");
			out.print("</script>");	
			
//			return "forward:/admin/freecheck/checkform/list_question.do";
			return null;
		}
		xlsCreateService.createXls(key, typeNo, list, filename);
		fileDownloadService.downloadXls(response, key, filename);
		
		return null;
	}
	
	
	
	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) :  (등록을 위한 조회)
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/readQuestion1.do")
	public String selectQuestion(
			@ModelAttribute("Bean") Question bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/freecheck/checkform/read_question1";

		service.selectQuestion(bean, model);
		
		return returnURL;
	}

	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 입력
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/forInsertQuestion1.do")
	public String forInsertQuestion(
			@ModelAttribute("Bean") Question bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/freecheck/checkform/insert_question1";
		service.forInsertQuestion(model);
		
		return returnURL;
	}
	
	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : (수정을 위한 조회)
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/insertQuestion1.do")
	public String insertQuestion(
			@ModelAttribute("Bean") Question bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		service.insertQuestion(bean, model);
		
		
		// 파라메터
		Master param = new Master();
		param.setYear_cd(bean.getYear_cd());
		param.setMaster_cd(bean.getMaster_cd());
		param.setSearchKeyword(bean.getSearchKeyword());
		
		service.selectQuestionList(param, model);
		
		String returnURL = "/admin/health/freecheck/checkform/list_question";
		
		return returnURL;
	}

	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 수정
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/forUpdateQuestion1.do")
	public String forUpdateQuestion(
			@ModelAttribute("Bean") Question bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/freecheck/checkform/update_question1";

		
		service.forUpdateQuestion(bean, model);
		
		return returnURL;
	}

	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 수정
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/updateQuestion1.do")
	public String updateQuestion(
			@ModelAttribute("Bean") Question bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		service.updateQuestion(bean, model);
		

		// 파라메터
		Master param = new Master();
		param.setYear_cd(bean.getYear_cd());
		param.setMaster_cd(bean.getMaster_cd());
		param.setSearchKeyword(bean.getSearchKeyword());
		
		service.selectQuestionList(param, model);
		
		String returnURL = "/admin/health/freecheck/checkform/list_question";
		
		return returnURL;
	}

	
	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 삭제
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/deleteQuestion1.do")
	public String deleteQuestion(
			@ModelAttribute("Bean") Question bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		

		service.updateQuestionForDelete(bean, model);
		

		// 파라메터
		Master param = new Master();
		param.setYear_cd(bean.getYear_cd());
		param.setMaster_cd(bean.getMaster_cd());
		param.setSearchKeyword(bean.getSearchKeyword());
		
		service.selectQuestionList(param, model);
		
		String returnURL = "/admin/health/freecheck/checkform/list_question";
		
		
		return returnURL;
	}
	

	
	/**
	 * 의약업소 자율점검 (점검표관리) (질문HETB_CK_QUESTION1에 대한 답변 항목 HETB_CK_QUESTION2 조회)
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/selectQuestion2ForUpdate.do")
	public String selectQuestion2(
			@ModelAttribute("Bean") Question2 bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/freecheck/checkform/update_question2";
		ZValue zvl = WebFactory.getAttributes(request);
		service.selectQuestion2ForUpdate(bean, zvl, model);
		if("save".equals(bean.getView_state())) {
			bean.setView_state("select");
			service.selectQuestion2ForUpdate(bean, zvl, model);
		}
		return returnURL;
	}
	

	/**
	 * 의약업소 자율점검 (점검내용 엑셀저장) : 엑셀저장
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/saveExcel.do")
	public String saveExcel(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		bean.setCompany_cd(0);
		service.selectCompanyInfoList(bean, model);
		
		List list = (List) model.get("answer");
//		"freecheck.xls.template_type1"
//		"test."+key+".xls.template_type"+typeNo
		String filename = "";
		String key = "";
		switch (bean.getMaster_cd()) {
		case 37:
			filename = "2010_약국 자율점검.xls";
			key = "01";
			for (Object rec : list) {
				Map m = (Map) rec;
				String other5 = m.get("OTHER5").toString();
				other5 = other5.replaceAll("1", "한약(초제)")
				.replaceAll("2", "의료기기")
				.replaceAll("3", "향정신성의약품")
				.replaceAll("4", "마약")
				.replaceAll("5", "화장품")
				.replaceAll("6", "의약품만");
				m.put("OTHER5", other5);

				if(m.get("WORK_TIME2") == null || m.get("WORK_TIME2").toString().contains("근무 안함") || "".equals(m.get("WORK_TIME2").toString())) {
					m.put("WORK_TIME2", "근무 안함");
				}
				
				if(m.get("WORK_TIME3") == null || m.get("WORK_TIME3").toString().contains("근무 안함") || "".equals(m.get("WORK_TIME3").toString())) {
					m.put("WORK_TIME3", "근무 안함");
				}
			}
			
			
			break;
		case 38:
			filename = "2010_약업사 자율점검.xls";
			key = "02";
			break;
		case 39:
			filename = "2010_의약품 도매상 자율점검.xls";
			key = "03";

			for (Object rec : list) {
				Map m = (Map) rec;
				if(m.get("ARTICLE1_YN") == null || m.get("ARTICLE1_YN").toString().contains("N")) {
					m.put("ARTICLE1_YN", "아니요");
				} else {
					m.put("ARTICLE1_YN", "예");
				}
				String other3 = m.get("OTHER3").toString();
				other3 = other3.replaceAll("1", "마약")
				.replaceAll("2", "향정신성의약품")
				.replaceAll("3", "해당 없음");
				m.put("OTHER3", other3);
			}
			break;
		case 40:
			filename = "2010_한약업사 자율점검.xls";
			key = "04";
			break;
		case 41:
			filename = "2010_의료기기판매 (임대) 업소 자율점검.xls";
			key = "05";

			for (Object rec : list) {
				Map m = (Map) rec;
				if(m.get("ARTICLE1_YN") == null || m.get("ARTICLE1_YN").toString().contains("N")) {
					m.put("ARTICLE1_YN", "아니요");
				} else {
					m.put("ARTICLE1_YN", "예");
				}
			}
			
			break;
		case 43:
			filename = "2010_치과기공소 자율점검.xls";
			key = "07";
			break;
		case 44:
			filename = "2010_(종합,치과,한방,요양) 병원 자율점검.xls";
			key = "08";
			
			for (Object rec : list) {
				Map m = (Map) rec;

				if(m.get("OTHER1") != null) {
					String[] other1 = m.get("OTHER1").toString().split(",");
					m.put("OTHER1_1", other1[0]);
					m.put("OTHER1_2", other1[1]);
					m.put("OTHER1_3", other1[2]);
					m.put("OTHER1_4", other1[3]);
					m.put("OTHER1_5", other1[4]);
					m.put("OTHER1_6", other1[5]);
					m.put("OTHER1_7", other1[6]);
					m.put("OTHER1_8", other1[7]);
					m.put("OTHER1_9", other1[8]);
				}

				if(m.get("OTHER2") != null) {
					String[] other2 = m.get("OTHER2").toString().split(",");
					m.put("OTHER2_1", other2[0]);
					m.put("OTHER2_2", other2[1]);
					m.put("OTHER2_3", other2[2]);
					m.put("OTHER2_4", other2[3]);
					m.put("OTHER2_5", other2[4]);
				}

				if(m.get("OTHER3") != null) {
					String[] other3 = m.get("OTHER3").toString().split(",");
					m.put("OTHER3_1", other3[0]);
					m.put("OTHER3_2", other3[1]);
					m.put("OTHER3_3", other3[2]);
					m.put("OTHER3_4", other3[3]);
					m.put("OTHER3_5", other3[4]);
					m.put("OTHER3_6", other3[5]);
					m.put("OTHER3_7", other3[6]);
					m.put("OTHER3_8", other3[7]);
				}
				
				if(m.get("WORK_TIME2") == null || m.get("WORK_TIME2").toString().contains("근무 안함") || "".equals(m.get("WORK_TIME2").toString())) {
					m.put("WORK_TIME2", "근무 안함");
				}

				if(m.get("WORK_TIME3") == null || m.get("WORK_TIME3").toString().contains("근무 안함") || "".equals(m.get("WORK_TIME3").toString())) {
					m.put("WORK_TIME3", "근무 안함");
				}

				if(m.get("OTHER4") == null || m.get("OTHER4").toString().contains("근무 안함") || "".equals(m.get("OTHER4").toString())) {
					m.put("OTHER4", "근무 안함");
				}

				if(m.get("OTHER5").toString().contains("해당 없음")) {
					m.put("OTHER5", m.get("OTHER5").toString().replaceAll("해당 없음,", "").replaceAll(",", "~"));
				} else {
					m.put("OTHER5", m.get("OTHER5").toString().replaceAll(",00:00,00:00", ""));
				}
				
				
			}
			break;
		case 45:
			filename = "2010_의원,한의원,치과의원 자율점검.xls";
			key = "09";
			
			for (Object rec : list) {
				Map m = (Map) rec;

				/*if(m.get("OTHER1") != null) {
					String other1 = m.get("OTHER1").toString();
					
					int sIdx = 0;
					int eIdx = other1.indexOf(",", sIdx);
					int idx = 1;
					do {
						String tmp = other1.substring(sIdx, eIdx);
						if(tmp == null || tmp.equals("")) {
							m.put("OTHER1_"+idx, 0);
						} else {
							m.put("OTHER1_"+idx, tmp);
						}
						sIdx = eIdx+1;
						eIdx = other1.indexOf(",", sIdx);
						idx++;
					} while(eIdx <= other1.length() && eIdx > 0);
				}

				if(m.get("OTHER2") != null) {
					String other2 = m.get("OTHER2").toString();
					
					int sIdx = 0;
					int eIdx = other2.indexOf(",", sIdx);
					int idx = 1;
					do {
						String tmp = other2.substring(sIdx, eIdx);
						if(tmp == null || tmp.equals("")) {
							m.put("OTHER2_"+idx, 0);
						} else {
							m.put("OTHER2_"+idx, tmp);
						}
						sIdx = eIdx+1;
						eIdx = other2.indexOf(",", sIdx);
						idx++;
					} while(eIdx <= other2.length() && eIdx > 0);
				}

				if(m.get("OTHER3") != null) {
					String other3 = m.get("OTHER3").toString();
					
					int sIdx = 0;
					int eIdx = other3.indexOf(",", sIdx);
					int idx = 1;
					do {
						String tmp = other3.substring(sIdx, eIdx);
						if(tmp == null || tmp.equals("")) {
							m.put("OTHER3_"+idx, 0);
						} else {
							m.put("OTHER3_"+idx, tmp);
						}
						sIdx = eIdx+1;
						eIdx = other3.indexOf(",", sIdx);
						idx++;
					} while(eIdx <= other3.length() && eIdx > 0);
				}*/

				if(m.get("OTHER1") != null) {
					String[] other1 = m.get("OTHER1").toString().split(",");
					m.put("OTHER1_1", other1[0]);
					m.put("OTHER1_2", other1[1]);
					m.put("OTHER1_3", other1[2]);
					m.put("OTHER1_4", other1[3]);
					m.put("OTHER1_5", other1[4]);
					m.put("OTHER1_6", other1[5]);
					m.put("OTHER1_7", other1[6]);
					m.put("OTHER1_8", other1[7]);
					m.put("OTHER1_9", other1[8]);
				}

				if(m.get("OTHER2") != null) {
					String[] other2 = m.get("OTHER2").toString().split(",");
					m.put("OTHER2_1", other2[0]);
					m.put("OTHER2_2", other2[1]);
					m.put("OTHER2_3", other2[2]);
					m.put("OTHER2_4", other2[3]);
					m.put("OTHER2_5", other2[4]);
				}

				if(m.get("OTHER3") != null) {
					
					String[] other3 = m.get("OTHER3").toString().split(",");
					
//					System.out.println(other3.length + "  >>>>>>>>>>>>>> "+ m.get("OTHER3").toString());
					m.put("OTHER3_1", other3[0]);
					m.put("OTHER3_2", other3[1]);
					m.put("OTHER3_3", other3[2]);
					m.put("OTHER3_4", other3[3]);
					m.put("OTHER3_5", other3[4]);
					m.put("OTHER3_6", other3[5]);
					m.put("OTHER3_7", other3[6]);
				}
				
				if(m.get("WORK_TIME2") == null || m.get("WORK_TIME2").toString().contains("근무 안함") || "00:00~00:00".equals(m.get("WORK_TIME2").toString())) {
					m.put("WORK_TIME2", "근무 안함");
				}

				if(m.get("WORK_TIME3") == null || m.get("WORK_TIME3").toString().contains("근무 안함") || "00:00~00:00".equals(m.get("WORK_TIME3").toString())) {
					m.put("WORK_TIME3", "근무 안함");
				}

				if(m.get("OTHER4") == null || m.get("OTHER4").toString().contains("근무 안함") || "".equals(m.get("OTHER4").toString())) {
					m.put("OTHER4", "근무 안함");
				} else {
					m.put("OTHER4", m.get("OTHER4").toString().replaceAll(",", "~"));
				}
//				m.put("OTHER5_SRC", m.get("OTHER5"));
				if(m.get("OTHER5").toString().contains("해당 없음")) {
					String res = m.get("OTHER5").toString().replaceAll("\\,?+해당 없음\\,?+", "").replaceAll(",", "~");
					res = res.replace("00:00~00:0000:00~00:00", "해당 없음");
					m.put("OTHER5", "".equals(res) ? "해당 없음" : res);
				} else {
					String res = m.get("OTHER5").toString().replaceAll("\\,?+00:00,00:00", "");
					m.put("OTHER5", res);
				}
				
				
			}
			break;
		case 46:
			filename = "2010_안경업소 자율점검.xls";
			key = "10";
			break;
		case 47:
			filename = "2010_마약류 (향정신성의약품) 자율점검.xls";
			key = "11";

			for (Object rec : list) {
				Map m = (Map) rec;
				String article9_yn = m.get("ARTICLE9_YN").toString();
				article9_yn = article9_yn.replaceAll("Y", "자율점검일 현재 마약류 재고를 보유하고 사용, 관리")
				.replaceAll("N", "마약류의 처방전만 발행")
				.replaceAll("n", "현재 마약류를 전혀 취급하지 않음");
				m.put("ARTICLE9_YN", article9_yn);


				String other1 = m.get("OTHER1").toString();
				other1 = other1.replaceAll("1", "마약류도매업자")
				.replaceAll("2", "마약류취급의료업자")
				.replaceAll("3", "마약류소매업자")
				.replaceAll("4", "마약류관리자");
				m.put("OTHER1", other1);

				String other2 = m.get("OTHER2").toString();
				other2 = other2.replaceAll("1", "향정신성의약품")
				.replaceAll("2", "마약");
				m.put("OTHER2", other2);
			}
			
			break;
		}
		String type = "freecheck";
		xlsCreateService.createXls(type, key, list, filename);
		fileDownloadService.downloadXls(response, type, filename);
		
		return null;
	}
	
	public static void main(String[] args) {
		String a = ",3,,1,1,,,,";
		int sIdx = 0;
		int eIdx = a.indexOf(",", sIdx);
		do {
			System.err.print(sIdx + "/" + eIdx);
			System.err.println("["+a.substring(sIdx, eIdx)+"]");
			sIdx = eIdx+1;
			eIdx = a.indexOf(",", sIdx);
		} while(eIdx < a.length() && eIdx > 0);
		
//		System.out.println(a.substring());
	}
	/**
	 * 의약업소 자율점검 (점검내용보기) : 조회
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/freecheck/checkform/viewAnswer.do")
	public String viewAnswer(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		// 파라메터
		Master param = new Master();
		param.setSearchKeyword(bean.getSearchKeyword());
		userService.selectCheckStateView(bean, model);
		userService.selectCompanyInfo(bean, model);
		
		String returnURL = "/admin/health/freecheck/checkform/check";
		
		
		return returnURL;
	}
	
	

	@RequestMapping("/admin/freecheck/forCheck.do")
	public String forCheck(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {
		
		// 점검표 불러오기 (생략 가능)
		userService.selectCheckStateView(bean, model);
		
		// 업소 정보 불러오기 
		userService.selectCompanyInfo(bean, model);

		String returnURL = "/admin/health/freecheck/checkform/check";
		
		return returnURL;
	}

	@RequestMapping("/admin/freecheck/selectCheckedQuestionList.do")
	public String selectCheckedQuestionList(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {
		
		// 점검표 불러오기 (생략 가능)
		HashMap<String, ZValue> resultMap = service.selectCheckedQuestionList(bean);
		
		String returnURL = "/admin/health/freecheck/checkform/check";
		
		return returnURL;
	}
	

	@RequestMapping("/admin/freecheck/check.do")
	public String check(
			@ModelAttribute("Bean") Answer bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {
		
		// 사용자 정보 
		UsersVO user = WebFactory.getUserInfo(request);
		model.addAttribute("user", user);
		
		// Answer1 체크하기
		List<Answer> answer2list = getZvl(WebFactory.getAttributes(request));
		userService.check(bean, answer2list, model);
		
		
		// 점검표 체크 후 페이지 이동 
		String includePage = "";
		if("writable".equals(bean.getView_state()) || "update".equals(bean.getView_state())) {
			includePage = "/health/dev_content/freecheck/list.jsp";
			if("11".equals(bean.getType_cd())) {		// 마약류 자율점검
				if("Y".equals(bean.getArticle9_yn())){	// 마약류 품목 취급을 하는 업소
					includePage = "/health/dev_content/freecheck/2010/application_11_handleitem.jsp";
					int company_cd = bean.getCompany_cd();
					int master_cd = bean.getMaster_cd();
					String year_cd = bean.getYear_cd();
					
					bean.setView_state("select");
					userService.checkHandleitem(bean, model);
					model.addAttribute("Bean", bean);
				} else {
					// 로그인 체크
					Company param = new Company();
					param.setId(bean.getCompany_id());
					userService.loginFreecheck(param, model);
					
					param = (Company) model.get("Bean");

					int company_cd = bean.getCompany_cd();
					int master_cd = bean.getMaster_cd();
					param.setCompany_cd(company_cd);
					String year_cd = bean.getYear_cd();
					param.setMaster_cd(master_cd);
					param.setYear_cd(year_cd);
					
					param = userService.selectNextFreecheck(param, model);
					if("writable".equals(param.getView_state())) {
						// 작성할 자율점검 페이지가 있다면 점검 페이지로 이동
						userService.selectCheckStateView(param, model);
						userService.selectCompanyInfo(param, model);
						model.addAttribute("Bean", param);
						includePage = "/health/dev_content/freecheck/check.jsp";	
					} else {
						// 리스트 페이지 이동
						userService.selectCheckStateList(param, model);
						
						model.addAttribute("Bean", param);
						
						includePage = "/health/dev_content/freecheck/list.jsp";	
						model.addAttribute("view_state", "checked");
					}
				}
			} else {
				// 로그인 체크
				Company param = new Company();
				param.setId(bean.getCompany_id());
				userService.loginFreecheck(param, model);
				
				param = (Company) model.get("Bean");

				int company_cd = bean.getCompany_cd();
				int master_cd = bean.getMaster_cd();
				String year_cd = bean.getYear_cd();
				param.setCompany_cd(company_cd);
				param.setMaster_cd(master_cd);
				param.setYear_cd(year_cd);
				
				param = userService.selectNextFreecheck(param, model);
				if("writable".equals(param.getView_state())) {
					// 작성할 자율점검 페이지가 있다면 점검 페이지로 이동
					userService.selectCheckStateView(param, model);
					userService.selectCompanyInfo(param, model);
					model.addAttribute("Bean", param);
					includePage = "/health/dev_content/freecheck/check.jsp";	
				} else {
					// 리스트 페이지 이동
					userService.selectCheckStateList(param, model);
					
					model.addAttribute("Bean", param);
					
					includePage = "/health/dev_content/freecheck/list.jsp";	
					model.addAttribute("view_state", "checked");
				}
			}
		} 
		

		String returnURL = "/admin/health/freecheck/checkform/check";
		
		return returnURL;
	}

	@RequestMapping("/admin/freecheck/linkedMasterList.do")
	public String linkedMasterList(
			HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {
		
		List<ZValue> resultList = service.selectLinkedMasterList();
		List<ZValue> industryAttrList = service.selectIndustryAttrList();
		model.addAttribute("resultList", resultList);
		model.addAttribute("industryAttrList", industryAttrList);
		
		return "admin/health/freecheck/checkform/linkedMasterList";
		
	}

	@RequestMapping("/admin/freecheck/selectLinkedMasterByIndustry.do")
	public void selectLinkedMasterByIndustry(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   
    	
    	List<ZValue> list = service.selectLinkedMasterByIndustry(zvl.getString("industryCd"));
    	
    	zvl.put("resultCode", "1");

		String resultValue = ZValue.getArrayJSONValue(list);
		response.setContentType("application/x-json; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(resultValue);
	}

	@RequestMapping("/admin/freecheck/selectMasterListByIndustry.do")
	public void selectMasterListByIndustry(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   
    	
    	List<ZValue> list = service.selectMasterListByIndustry(zvl.getString("industryCd"));
    	
    	zvl.put("resultCode", "1");

		String resultValue = ZValue.getArrayJSONValue(list);
		response.setContentType("application/x-json; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(resultValue);
	}

	@RequestMapping("/admin/freecheck/addLinkedMaster.do")
	public void addLinkedMaster(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   
    	
    	service.addLinkedMaster(zvl);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", "/admin/freecheck/linkedMasterList.do");
	}

	@RequestMapping("/admin/freecheck/delLinkedMaster.do")
	public void delLinkedMaster(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   
    	
    	service.delLinkedMaster(zvl);

    	WebFactory.printHtml(response, "성공적으로 삭제되었습니다.", "/admin/freecheck/linkedMasterList.do");
	}

	@RequestMapping("/admin/freecheck/selectMasterCompanyPointList.do")
	public String selectMasterCompanyPointList(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	String yearCd = zvl.getString("yearCd");
    	if("".equals(yearCd))
    	{
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
    		yearCd = dateFormat.format(new Date());
    		zvl.put("yearCd", yearCd);
    	}
    	
    	List<ZValue> resultList = service.selectMasterCompanyPointList(zvl);
		model.addAttribute("resultList", resultList);

    	List<ZValue> industryAttrList = service.selectIndustryAttrList();
		model.addAttribute("industryAttrList", industryAttrList);
		
		return "admin/health/freecheck/checkform/checkedPointList";
	}

	@RequestMapping("/admin/freecheck/selectItemList.do")
	public String selectItemList(
			HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);
    	String yearCd = zvl.getString("yearCd");
    	if("".equals(yearCd))
    	{
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
    		yearCd = dateFormat.format(new Date());
    		zvl.put("yearCd", yearCd);
    	}
		List<ZValue> resultList = service.selectItemList(yearCd);
		List<ZValue> masterList = service.selectMasterListForItem(yearCd);
		model.addAttribute("resultList", resultList);
		model.addAttribute("masterList", masterList);
		model.addAttribute("zvl", zvl);
				
		return "admin/health/freecheck/item/itemList";
		
	}

	@RequestMapping("/admin/freecheck/addItem.do")
	public void addItem(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   
    	
    	service.addItem(zvl);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", "/admin/freecheck/selectItemList.do?yearCd="+zvl.getString("yearCd"));
	}

	@RequestMapping("/admin/freecheck/delItem.do")
	public void delItem(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   
    	
    	service.delItem(zvl.getInt("itemId"));

    	WebFactory.printHtml(response, "성공적으로 삭제되었습니다.", "/admin/freecheck/selectItemList.do?yearCd="+zvl.getString("yearCd"));
	}

	private List<Answer> getZvl(ZValue zvl) {
		List<Answer> list = new ArrayList<Answer>();
		int size = Integer.parseInt(zvl.get("questionListSize").toString());
		
		int masterCd = Integer.parseInt(zvl.get("masterCd").toString());
		String companyId = zvl.get("companyId").toString();
		int companyCd = Integer.parseInt(zvl.get("companyCd").toString());
		
		for(int i=1; i<=size; i++) {

			int questionCd = Integer.parseInt(zvl.get("questionCd"+i).toString());
			
			Object multi_check_yn = zvl.get("multiCheckYn"+i);
			
			int question2Cd = 0;
			String other = "";
			if(multi_check_yn != null && multi_check_yn.toString().length() != 0) {
				if("Y".equals(multi_check_yn.toString())) {
					
					int checkboxCount = Integer.parseInt(zvl.get("checkboxCount" + i).toString());
					for(int j=1; j<=checkboxCount; j++) {
						
						question2Cd = Integer.parseInt(zvl.get("question2Cd"+i+""+j).toString());
						
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
				other = zvl.get("other"+i).toString();
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

	@RequestMapping("/admin/freecheck/addCompanyForMigration.do")
	public void addCompanyForMigration(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   
    	
    	service.addCompanyForMigration(zvl);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", "/admin/freecheck/company/list.do?yearCd="+zvl.getString("yearCd"));
	}

	@RequestMapping("/admin/freecheck/addCheckFormForMigration.do")
	public void addCheckFormForMigration(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);   
    	
    	service.addCheckFormForMigration(zvl);

    	WebFactory.printHtml(response, "성공적으로 등록되었습니다.", "/admin/freecheck/checkform/list.do?yearCd="+zvl.getString("yearCd"));
	}

}
