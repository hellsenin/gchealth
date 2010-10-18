package egovframework.kr.go.geumcheon.health.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.kr.go.geumcheon.health.service.PollService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Answer;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.Question;
import egovframework.kr.go.geumcheon.health.vo.Question2;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdminPollController {

    Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "pollService")
	private PollService service;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@Resource(name="pageUtil")
	private PageUtil PageUtil;
	
	@RequestMapping("/admin/health/poll/checkform/list.do")
	public String selectCheckformList(
			  HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/poll/checkform/list";

		service.selectCheckformList(model);
		
		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/forInsert.do")
	public String forInsertCheckform(ModelMap model) {
		
		String returnURL = "/admin/health/poll/checkform/insert";		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/insert.do")
	public String insertCheckform(
			@ModelAttribute("Bean") Master bean
			, MultipartHttpServletRequest multiRequest 
			, ModelMap model) {

		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		service.insertCheckform(bean, model, files);

		service.selectCheckformList(bean, model);
		
		String returnURL = "/admin/health/poll/checkform/list";
		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/read.do")
	public String selectCheckform(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/poll/checkform/read";

		service.selectCheckform(bean, model);
		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/forUpdate.do")
	public String forUpdateCheckform(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/poll/checkform/update";
		service.forUpdateCheckform(bean, model);
		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/update.do")
	public String updateCheckform(
			@ModelAttribute("Bean") Master bean
			, MultipartHttpServletRequest multiRequest
			, ModelMap model) {

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		service.updateCheckform(bean, model, files);
		

		String returnURL = "/admin/health/poll/checkform/read";
		service.selectCheckform(bean, model);
		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/list_question.do")
	public String selectQuestionList(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		// 리스트 조회
		service.selectQuestionList(bean, model);
		

		String returnURL = "/admin/health/poll/checkform/list_question";

		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/forInsertQuestion1.do")
	public String forInsertQuestion(
			@ModelAttribute("Bean") Question bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/poll/checkform/insert_question1";
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/insertQuestion1.do")
	public String insertQuestion(
			@ModelAttribute("Bean") Question bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		service.insertQuestion(bean, model);
		
		
		// 파라메터
		Master param = new Master();
		param.setYear_cd(PollService.POLL_YEAR_CD);
		param.setMaster_cd(bean.getMaster_cd());
		
		service.selectQuestionList(param, model);
		
		String returnURL = "/admin/health/poll/checkform/list_question";
		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/forUpdateQuestion1.do")
	public String forUpdateQuestion(
			@ModelAttribute("Bean") Question bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
		String returnURL = "/admin/health/poll/checkform/update_question1";

		
		service.forUpdateQuestion(bean, model);
		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/updateQuestion1.do")
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
		
		String returnURL = "/admin/health/poll/checkform/list_question";
		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/selectQuestion2ForUpdate.do")
	public String selectQuestion2(
			@ModelAttribute("Bean") Question2 bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		String returnURL = "/admin/health/poll/checkform/update_question2";
		ZValue zvl = WebFactory.getAttributes(request);
		service.selectQuestion2ForUpdate(bean, zvl, model);
		if("save".equals(bean.getView_state())) {
			bean.setView_state("select");
			service.selectQuestion2ForUpdate(bean, zvl, model);
		}
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/delete.do")
	public void delete(
			HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		

		ZValue zvl = WebFactory.getAttributes(request);
		service.delete(zvl.getInt("masterCd"));
		
		String returnURL = "/admin/health/poll/checkform/list.do";
		
		WebFactory.printHtml(response, "성공적으로 삭제되었습니다.", returnURL);
	}

	@RequestMapping("/admin/health/poll/checkform/deleteQuestion1.do")
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
		
		String returnURL = "/admin/health/poll/checkform/list_question";
		
		
		return returnURL;
	}

	@RequestMapping("/admin/health/poll/checkform/checkedList.do")
	public String checked_company_list(
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {
		
				
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
		service.selectCheckedList(bean, model);
		
		// 페이징 처리 (2)
		String returnURL = "/admin/health/poll/checkform/checkedList";

		String url = "/admin/health/poll/checkform/checkedList.do";
		url += "?master_cd="+bean.getMaster_cd();
		url += "&year_cd="+bean.getYear_cd();
		
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		return returnURL;
	}


	@RequestMapping("/admin/health/poll/checkform/checkedList/delete.do")
	public void list_checked_company_delete (
			@ModelAttribute("Bean") Master bean
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception{
		String p = request.getParameter("delete_company_id");
		if(p != null) {
			Company param = new Company();
			param.setId(p);
			param.setMaster_cd(bean.getMaster_cd());
			service.deleteAnswerForCompanyId(param);
		}

		String url = "/admin/health/poll/checkform/checkedList.do";
		url += "?master_cd="+bean.getMaster_cd();
		
		WebFactory.printHtml(response, "성공적으로 삭제되었습니다.", url);
		
	}

	@RequestMapping("/admin/health/poll/forCheck.do")
	public String forCheck(
			@ModelAttribute("Bean") Company bean
			, HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {
		
		// 점검표 불러오기 (생략 가능)
		service.selectCheckStateView(bean, model);
		
		// 업소 정보 불러오기 
		service.selectCompanyInfoA(bean, model);
		
		String includePage = "admin/health/poll/checkform/check";
		return includePage;
	}

	@RequestMapping("/admin/health/poll/checkUpdate.do")
	public void check(
			  HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {
		 
		// Answer1 체크하기
		ZValue zvl = WebFactory.getAttributes(request);
		log.debug(">>>>>>>>>>>zvl : " + zvl);
		List<Answer> answer2list = service.getZvl(zvl);
		Company bean = new Company();
		bean.setMaster_cd(zvl.getInt("masterCd"));
		bean.setCompany_id(zvl.getString("companyId"));
		bean.setId(zvl.getString("companyId"));
		service.checkUpdate(bean, answer2list, model);

		WebFactory.printHtml(response, "성공적으로 수정되었습니다.", "/admin/health/poll/checkform/checkedList.do?master_cd="+zvl.getString("masterCd"));
	}

}
