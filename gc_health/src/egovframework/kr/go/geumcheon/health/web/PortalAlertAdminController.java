package egovframework.kr.go.geumcheon.health.web;

import java.util.Calendar;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.kr.go.geumcheon.health.service.PortalAlertService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.PortalAlert;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class PortalAlertAdminController {

	@Resource(name="PortalAlertService")
	private PortalAlertService portalAlertService;
	
	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@Resource(name="pageUtil")
	private PageUtil PageUtil;
	
//    @Resource(name = "SampleFileUploadService")
//    private SampleFileUploadService fileUploadService = null;
    
	@RequestMapping(value = "/admin/health/portalAlert/List.do")
	public String selectList(@ModelAttribute("Bean") PortalAlert bean
			, ModelMap model) {
		bean.setPageUnit(10);
		bean.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		portalAlertService.selectList(bean, model);
		
		String returnURL = "/admin/health/portalAlert/List";

		String url = "/admin/health/portalAlert/List.do";
		url += "?searchKeyword="+bean.getSearchKeyword();
		url += "&category="+bean.getCategory();
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return returnURL;
	}

	@RequestMapping(value = "/admin/health/portalAlert/Read.do")
	public String select(@ModelAttribute("Bean") PortalAlert bean
			, ModelMap model) {
		String returnURL = "/admin/health/portalAlert/Read";

		portalAlertService.select(bean, model);
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		
		return returnURL;
	}

	@RequestMapping(value = "/admin/health/portalAlert/forInsert.do")
	public String forInsert(@ModelAttribute("Bean") PortalAlert bean
			, ModelMap model) {
		
		String returnURL = "/admin/health/portalAlert/Insert";
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setReg_user_id(user.getId()); 
//		bean.setLast_mod_user_id(user.getId());
//		bean.setReg_user_name(user.getName()); 
//		bean.setLast_mod_user_name(user.getName());
		bean.setReg_dt(Calendar.getInstance().getTime());
		bean.setLast_mod_dt(Calendar.getInstance().getTime());

		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return returnURL;
	}

	@RequestMapping(value = "/admin/health/portalAlert/forUpdate.do")
	public String forUpdate(@ModelAttribute("Bean") PortalAlert bean
			, ModelMap model) {
		
		String returnURL = "/admin/health/portalAlert/Update";

//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setLast_mod_user_id(user.getId());
//		bean.setLast_mod_user_name(user.getName());
		bean.setLast_mod_dt(Calendar.getInstance().getTime());
		
		portalAlertService.select(bean, model);
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return returnURL;
	}
	
	@RequestMapping(value = "/admin/health/portalAlert/insert.do")
	public String insert(@ModelAttribute("Bean") PortalAlert bean
			, MultipartHttpServletRequest multiRequest
			, ModelMap model) {

		ZValue zvl = WebFactory.getAttributes(multiRequest);
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String returnURL = "/admin/health/portalAlert/List";

//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setDept_id(user.getDept_id());
//		bean.setDept_name(user.getDept_name());
//		bean.setReg_user_id(user.getId()); 
//		bean.setLast_mod_user_id(user.getId());
//		bean.setReg_user_name(user.getName()); 
//		bean.setLast_mod_user_name(user.getName());
		bean.setReg_dt(Calendar.getInstance().getTime());
		bean.setLast_mod_dt(Calendar.getInstance().getTime());
		
		portalAlertService.insert(bean, files);
		
		
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		

		// 리스트 조회
		
		bean.setPageUnit(10);
		bean.setPageSize(10);

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		portalAlertService.selectList(bean, model);
		
		String url = "/admin/health/portalAlert/List.do";
		url += "?searchKeyword="+bean.getSearchKeyword();
		url += "&category="+bean.getCategory();
				
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		return returnURL;
	}
	
	@RequestMapping(value = "/admin/health/portalAlert/update.do")
	public String update(@ModelAttribute("Bean") PortalAlert bean
			, MultipartHttpServletRequest multiRequest
			, ModelMap model) {

		ZValue zvl = WebFactory.getAttributes(multiRequest);
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		
		String returnURL = "/admin/health/portalAlert/List";

//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setDept_id(user.getDept_id());
//		bean.setDept_name(user.getDept_name());
//		bean.setLast_mod_user_id(user.getId());
//		bean.setLast_mod_user_name(user.getName());
		bean.setLast_mod_dt(Calendar.getInstance().getTime());
		
		portalAlertService.update(bean, files);

		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());


		// 리스트 조회
		
		bean.setPageUnit(10);
		bean.setPageSize(10);

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		portalAlertService.selectList(bean, model);
		
		String url = "/admin/health/portalAlert/List.do";
		url += "?searchKeyword="+bean.getSearchKeyword();
		url += "&category="+bean.getCategory();
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		return returnURL;
	}
	

	@RequestMapping(value = "/admin/health/portalAlert/delete.do")
	public String delete(@ModelAttribute("Bean") PortalAlert bean
			, ModelMap model) {

		String returnURL = "/admin/health/portalAlert/List";

		portalAlertService.delete(bean);

		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());


		// 리스트 조회
		
		bean.setPageUnit(10);
		bean.setPageSize(10);

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		portalAlertService.selectList(bean, model);
		
		String url = "/admin/health/portalAlert/List.do";
		url += "?searchKeyword="+bean.getSearchKeyword();
		url += "&category="+bean.getCategory();
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		return returnURL;
	}
	
	
}