/**
 * 
 * 
 * @author 김명구
 * @since 2010. 1. 21.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      	수정자      	수정내용
 *  -------    		--------    --------------------------
 *   2010. 1. 21.  김명구      	최초 생성
 *
 * Copyright (C) 2010 by MOPAS  All right reserved.
 * </pre>
 */


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

import egovframework.kr.go.geumcheon.health.service.BannerService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Banner;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BannerAdminController {
	
	@Resource(name="BannerService")
	private BannerService bannerService;

    @Resource(name = "webFactory")
    protected WebFactory webFactory;

	@Resource(name="pageUtil")
	private PageUtil PageUtil;
	
	@RequestMapping(value = "/admin/health/banner/List.do")
	public String selectList(@ModelAttribute("Bean") Banner bean
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
		
		bannerService.selectList(bean, model);
		
		String returnURL = "admin/health/banner/List";

		String url = "/admin/health/banner/List.do";
		url += "?searchKeyword="+bean.getSearchKeyword();
		url += "&searchCondition="+bean.getSearchCondition();
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return returnURL;
	}

	@RequestMapping(value = "/admin/health/banner/Read.do")
	public String select(@ModelAttribute("Bean") Banner bean
			, ModelMap model) {
		String returnURL = "admin/health/banner/Read";

		bannerService.select(bean, model);
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		
		return returnURL;
	}

	@RequestMapping(value = "/admin/health/banner/forInsert.do")
	public String forInsert(@ModelAttribute("Bean") Banner bean
			, ModelMap model) {
		
		String returnURL = "admin/health/banner/Insert";
		//LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		//bean.setReg_user_id(user.getId()); 
		//bean.setLast_mod_user_id(user.getId());
		//bean.setReg_user_name(user.getName()); 
		//bean.setLast_mod_user_name(user.getName());
		bean.setReg_dt(Calendar.getInstance().getTime());
		bean.setLast_mod_dt(Calendar.getInstance().getTime());
		
		//model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return returnURL;
	}

	@RequestMapping(value = "/admin/health/banner/forUpdate.do")
	public String forUpdate(@ModelAttribute("Bean") Banner bean
			, ModelMap model) {
		
		String returnURL = "admin/health/banner/Update";

//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setLast_mod_user_id(user.getId());
//		bean.setLast_mod_user_name(user.getName());
		bean.setLast_mod_dt(Calendar.getInstance().getTime());
		
		bannerService.select(bean, model);
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return returnURL;
	}
	
	@RequestMapping(value = "/admin/health/banner/insert.do")
	public String insert(@ModelAttribute("Bean") Banner bean
			, MultipartHttpServletRequest multiRequest
			, ModelMap model) {

		ZValue zvl = webFactory.getAttributes(multiRequest);
		String useBanner = multiRequest.getParameter("useBanner");
		if("portal".equals(useBanner)) {
			bean.setDept("00");
			bean.setDong("00");
		} else if("english".equals(useBanner)) {
			bean.setDept("44");
			bean.setDong("44");
		} else if("china".equals(useBanner)) {
			bean.setDept("55");
			bean.setDong("55");
		} else if("japan".equals(useBanner)) {
			bean.setDept("66");
			bean.setDong("66");
		} else if("health".equals(useBanner)) {
			bean.setDept("88");
			bean.setDong("88");
		}
		
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String returnURL = "/admin/health/banner/List";

//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setDept_id(user.getDept_id());
//		bean.setDept_name(user.getDept_name());
//		bean.setReg_user_id(user.getId()); 
//		bean.setLast_mod_user_id(user.getId());
//		bean.setReg_user_name(user.getName()); 
//		bean.setLast_mod_user_name(user.getName());
		bean.setReg_dt(Calendar.getInstance().getTime());
		bean.setLast_mod_dt(Calendar.getInstance().getTime());
		
		bannerService.insert(bean, files);
		
		
		
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
		
		bannerService.selectList(bean, model);
		
		String url = "/admin/health/banner/List.do";
		String pagination = PageUtil.getJnPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		return returnURL;
	}
	
	@RequestMapping(value = "/admin/health/banner/update.do")
	public String update(@ModelAttribute("Bean") Banner bean
			, MultipartHttpServletRequest multiRequest
			, ModelMap model) {

		ZValue zvl = webFactory.getAttributes(multiRequest);
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		String useBanner = multiRequest.getParameter("useBanner");
		if("portal".equals(useBanner)) {
			bean.setDept("00");
			bean.setDong("00");
		} else if("english".equals(useBanner)) {
			bean.setDept("44");
			bean.setDong("44");
		} else if("china".equals(useBanner)) {
			bean.setDept("55");
			bean.setDong("55");
		} else if("japan".equals(useBanner)) {
			bean.setDept("66");
			bean.setDong("66");
		} else if("health".equals(useBanner)) {
			bean.setDept("88");
			bean.setDong("88");
		}
		System.out.println(">>>>>>> " + useBanner);
		String returnURL = "admin/health/banner/List";

//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setDept_id(user.getDept_id());
//		bean.setDept_name(user.getDept_name());
//		bean.setLast_mod_user_id(user.getId());
//		bean.setLast_mod_user_name(user.getName());
		bean.setLast_mod_dt(Calendar.getInstance().getTime());
		
		bannerService.update(bean, files);

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
		
		bannerService.selectList(bean, model);
		
		String url = "/admin/health/banner/List.do";
		url += "?searchKeyword="+bean.getSearchKeyword();
		url += "&searchCondition="+bean.getSearchCondition();
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		return returnURL;
	}
	

	@RequestMapping(value = "/admin/health/banner/delete.do")
	public String delete(@ModelAttribute("Bean") Banner bean
			, ModelMap model) {

		String returnURL = "admin/health/banner/List";

		bannerService.delete(bean);

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
		
		bannerService.selectList(bean, model);
		
		String url = "/admin/health/banner/List.do";
		url += "?searchKeyword="+bean.getSearchKeyword();
		url += "&searchCondition="+bean.getSearchCondition();
		
		String pagination = PageUtil.getJnPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		return returnURL;
	}
	
	
}
