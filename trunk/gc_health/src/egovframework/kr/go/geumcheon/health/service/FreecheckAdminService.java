package egovframework.kr.go.geumcheon.health.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.kr.go.geumcheon.health.dao.FreecheckAdminDAO;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Handleitem;
import egovframework.kr.go.geumcheon.health.vo.Industry;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.Question;
import egovframework.kr.go.geumcheon.health.vo.Question2;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("FreecheckAdminService")
public class FreecheckAdminService {

    Logger log = Logger.getLogger(this.getClass());

	@Resource(name="FreecheckAdminDAO")
	private FreecheckAdminDAO dao;

	@Resource(name="pageUtil")
	private PageUtil PageUtil;

    @Resource(name = "EgovFileMngUtil")
    protected EgovFileMngUtil fileUtil;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;


	/**
	 * 업종 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public List<Industry> selectIndustryList(Industry bean, ModelMap model) {

		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");

			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		List<Industry> resultMany = new ArrayList<Industry>();

		resultMany = dao.selectIndustryList(bean); 
		int totCnt = dao.selectIndustryListTotCnt(bean);
		int totCnt2 = dao.selectIndustryListTotCnt2(bean);
		model.addAttribute("resultListSize", totCnt);
		model.addAttribute("resultListSize2", totCnt2);
		model.addAttribute("resultList", resultMany);

		String url = "/admin/freecheck/industry/list.do";
		url += "?searchCondition="+bean.getSearchCondition();
		url += "&searchKeyword="+bean.getSearchKeyword();
		url += "&year_cd="+bean.getYear_cd();
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, totCnt, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		
		return resultMany;
	}
//	a

	/**
	 * 업종 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public Industry selectIndustry(Industry bean, ModelMap model) {
		Industry result = dao.selectIndustry(bean);
		int industry_cd = bean.getIndustry_cd();
		String year_cd = bean.getYear_cd();

		Company company = new Company();
		company.setIndustry_cd(industry_cd);
		company.setYear_cd(year_cd);
		company.setSearchCondition("1");
		int pageIndex = bean.getPageIndex();
		
		
		company.setPageIndex(pageIndex);
		company.setPageUnit(10);
		company.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(company.getPageIndex());
		paginationInfo.setRecordCountPerPage(company.getPageUnit());
		paginationInfo.setPageSize(company.getPageSize());
		
		company.setFirstIndex(paginationInfo.getFirstRecordIndex());
		company.setLastIndex(paginationInfo.getLastRecordIndex());
		company.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<Company> resultMany = new ArrayList<Company>();
		resultMany = dao.selectCompanyList(company); 
		int totCnt = dao.selectCompanyListTotCnt(company);

		String url = "/admin/freecheck/industry/select.do";
		url += "?searchCondition="+company.getSearchCondition();
		url += "&industry_cd="+company.getIndustry_cd();
		url += "&year_cd="+company.getYear_cd();
		
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, totCnt, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		model.addAttribute("resultListSize", totCnt);
		model.addAttribute("resultList", resultMany);
		if(result != null) {
			model.addAttribute("result", result);
		}
		return result;
	}
	

	/**
	 * 업종 관리 (등록을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void forInsertIndustry(Industry bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
	}

	/**
	 * 업종 관리 (등록)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void insertIndustry(Industry bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
//		bean.setInsert_id(user.getId());
		dao.insertIndustry(bean);
	}

	public boolean uploadCompanyExcel(ZValue zvl, Map<String, MultipartFile> files) throws Exception
	{
		boolean result = true;
		
	    if (files.isEmpty()) {
	    	return false;
	    }
	    
	    List<FileVO> fList = fileUtil.parseFileInf(files, "M_", 0, "", "freecheck.fileStorePath");
	    
	    if(fList == null || fList.size() == 0)
	    {
	    	return false;
	    }
		
	    FileVO file = fList.get(0);
	    String fileName = file.getStreFileNm();
	    String path = propertyService.getString("freecheck.fileStorePath");
	    
	    try
	    {
	    	File f = new File(path+"/"+fileName);
	    	if(!f.exists())
	    	{
	    		log.debug("File not exist!!!!!! " + path+fileName);
	    		return false;
	    	}
	    	
	    	String year_cd = zvl.getString("yearCd");

	    	if("Y".equals(zvl.getString("chk")))
	    		dao.deleteCompanyForExcel(zvl);
	    	
	    	int industryCd = zvl.getInt("industryCd");
			Workbook workbook = Workbook.getWorkbook(f); 
			Sheet sheet = workbook.getSheet(0); 
			Cell companyCell;
			Cell ceoNameCell;
			Cell saNoCell;
			Cell pharmacistNoCell;
			Cell tellCell;
			Cell faxCell;
			Cell hpCell;
			Cell emailCell;
			Cell postCell;
			Cell addr1Cell;
	
			ArrayList<Company> dataList = new ArrayList<Company>();
			int colLen = sheet.getColumn(0).length;
			
			for(int j = 1 ; j <= colLen - 1 ; j++)
			{
				companyCell = sheet.getCell(0,j); 
				ceoNameCell = sheet.getCell(1,j);     
				saNoCell = sheet.getCell(2,j);       
				pharmacistNoCell = sheet.getCell(3,j);     
				
				tellCell = sheet.getCell(4,j);
				faxCell = sheet.getCell(5,j);   
				hpCell = sheet.getCell(6,j);     
				emailCell = sheet.getCell(7,j);     
				
				postCell = sheet.getCell(8,j);     
				
				addr1Cell = sheet.getCell(9,j);  
				
				Company data = new Company();
				data.setCompany(companyCell.getContents());
				data.setCeo_name(ceoNameCell.getContents());
				data.setSa_no(saNoCell.getContents());
				data.setPharmacist_no(pharmacistNoCell.getContents());				
				data.setTel(tellCell.getContents());
				data.setFax(faxCell.getContents());
				data.setHp(hpCell.getContents());
				data.setEmail(emailCell.getContents());				
				data.setPost(postCell.getContents());				
				data.setAddr1(addr1Cell.getContents());

				data.setYear_cd(year_cd);
				data.setIndustry_cd(industryCd);
				
				dataList.add(data);
			}
		
			for(Company data : dataList)
			{
				dao.insertCompany(data);
			}
		
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	result = false;
	    }
	    
	    return result;
	}

	/**
	 * 업종 관리 (수정을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public Industry forUpdateIndustry(Industry bean, ModelMap model) {
		Industry result = dao.selectIndustry(bean);
		if(result != null) {
			model.addAttribute("result", result);
		}
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return result;
	}

	/**
	 * 업종 관리 (수정)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void updateIndustry(Industry bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
		dao.updateIndustry(bean);
	}
	
	
	/**
	 * 업종 관리 (삭제)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void deleteIndustry(Industry bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
		dao.deleteIndustry(bean);
	}
	
//	a
	/**
	 * 업소 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public List<Company> selectCompanyList(Company bean, ModelMap model) {

		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");

			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		bean.setPageUnit(10);
		bean.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		List<Company> resultMany = new ArrayList<Company>();
		List<Industry> resultIndustrySelection = new ArrayList<Industry>();
		resultMany = dao.selectCompanyList(bean); 
		int totCnt = dao.selectCompanyListTotCnt(bean);
		
		Industry industry = new Industry();
		industry.setYear_cd(bean.getYear_cd());
		resultIndustrySelection = dao.selectIndustryListForSelection(industry);
		
		model.addAttribute("resultListSize", totCnt);
		model.addAttribute("resultList", resultMany);
		model.addAttribute("resultIndustrySelection", resultIndustrySelection);
		
		String url = "/admin/freecheck/company/list.do";
		url += "?searchCondition="+bean.getSearchCondition();
		url += "&industry_cd="+bean.getIndustry_cd();
		url += "&type_cd="+bean.getType_cd();
		url += "&company="+bean.getCompany();
		url += "&ceo_name="+bean.getCeo_name();
		url += "&id="+bean.getId();
		url += "&grade_cd="+bean.getGrade_cd();
		url += "&year_cd="+bean.getYear_cd();
		
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, totCnt, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		
		return resultMany;
	}

	/**
	 * 업소 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public Company selectCompany(Company bean, ModelMap model) {
		Company result = dao.selectCompany(bean);
		if(result != null) {
			model.addAttribute("result", result);
			
			List<String> checkList = dao.selectCheckListByCompany(bean.getCompany_cd());
			model.addAttribute("checkList", checkList);
		}
		return result;
	}
	
	/**
	 * 업소 관리 (등록을 위한 조회)
	 * @param bean
	 * @param model
	 * @return message
	 */
	public int checkCompanyId(Company bean) {
		int count = dao.checkCompanyId(bean);
		
		
		return count;
	}
	
	/**
	 * 업소 관리 (등록을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void forInsertCompany(Company bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());

		List<Industry> resultIndustrySelection = new ArrayList<Industry>();

		Industry industry = new Industry();
		industry.setYear_cd(bean.getYear_cd());
		resultIndustrySelection = dao.selectIndustryListForSelection(industry);
		
		if(bean.getIndustry_cd() == 0) {
			if(resultIndustrySelection.size() > 0) {
				bean.setIndustry_cd(resultIndustrySelection.get(0).getIndustry_cd());
			}
		}
		//bean.setId(dao.generateCompanyId(bean));
		
		
		model.addAttribute("resultIndustrySelection", resultIndustrySelection);
		model.addAttribute("Bean", bean);
	
	}
	
	/**
	 * 업소 관리 (등록)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void insertCompany(Company bean, ModelMap model) {		
		bean.setPost(bean.getZipcode1() + "-" + bean.getZipcode2());
		bean.setStatus("N");
		dao.insertCompany(bean);
	}
		
	/**
	 * 업소 관리 (수정을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public Company forUpdateCompany(Company bean, ModelMap model) {
		Company result = dao.selectCompany(bean);
		if(result != null) {
			model.addAttribute("result", result);
		}
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		List<Industry> resultIndustrySelection = new ArrayList<Industry>();
		
		Industry industry = new Industry();
		industry.setYear_cd(bean.getYear_cd());
		resultIndustrySelection = dao.selectIndustryListForSelection(industry);
		
		model.addAttribute("resultIndustrySelection", resultIndustrySelection);

		List<String> checkList = dao.selectCheckListByCompany(bean.getCompany_cd());
		model.addAttribute("checkList", checkList);
		
//		model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return result;
	}

	/**
	 * 업소 관리 (수정)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void updateCompany(Company bean, ModelMap model) {
		bean.setPost(bean.getZipcode1() + "-" + bean.getZipcode2());
		dao.updateCompany(bean);
	}
	
	
	/**
	 * 업소 관리 (삭제)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void deleteCompany(Company bean, ModelMap model) {
		dao.deleteCompany(bean);
		bean.setMaster_cd(0);
		dao.deleteAnswerForCompanyId(bean);
		dao.deleteAnswer2ForCompanyId(bean);
	}
	

	public void deleteAnswerForCompanyId(Company bean) {
		dao.deleteAnswerForCompanyId(bean);
		dao.deleteAnswer2ForCompanyId(bean);
		System.out.println("Type_cd : " + bean.getType_cd());
		if("11".equals(bean.getType_cd())) {
			dao.deleteHandleItem(bean);
		}
	}
	

	/**
	 * 점검표 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public List<HashMap> selectCheckformList(Master bean, ModelMap model) {
		List<HashMap> resultMany = new ArrayList<HashMap>();
		String master_cd = bean.getYear_cd();
		resultMany = dao.selectCheckformList(master_cd);

		int type_tot_cnt = 0;
		int answer_cnt = 0;
		int noanswer_cnt = 0;

		int type_tot_cnt_except_for_drug = 0;
		int answer_cnt_except_for_drug = 0;
		int noanswer_cnt_except_for_drug = 0;
		
		for (HashMap result : resultMany) {
			type_tot_cnt += Integer.parseInt(result.get("TYPE_TOT_CNT").toString());
			answer_cnt += Integer.parseInt(result.get("ANSWER_CNT").toString());
			noanswer_cnt += Integer.parseInt(result.get("NOANSWER_CNT").toString());
			type_tot_cnt_except_for_drug = type_tot_cnt;
			answer_cnt_except_for_drug = answer_cnt;
			noanswer_cnt_except_for_drug = noanswer_cnt;
		}

		model.addAttribute("sum_type_tot_cnt", type_tot_cnt);
		model.addAttribute("sum_answer_cnt", answer_cnt);
		model.addAttribute("sum_noanswer_cnt", noanswer_cnt);
		model.addAttribute("sum_type_tot_cnt_except_for_drug", type_tot_cnt_except_for_drug);
		model.addAttribute("sum_answer_cnt_except_for_drug", answer_cnt_except_for_drug);
		model.addAttribute("sum_noanswer_cnt_except_for_drug", noanswer_cnt_except_for_drug);
		if(resultMany != null) {
			model.addAttribute("resultList", resultMany);
		}
		return resultMany;
	}


	/**
	 * 점검표 관리 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public Master selectCheckform(Master bean, ModelMap model) {
		Master checkformInfo = new Master();

		// 파라메터 
		int master_cd = bean.getMaster_cd();
		
		// 쿼리 수행
		checkformInfo = dao.selectCheckform(master_cd);

		// 결과
		String contents = checkformInfo.getContents();
		if(contents != null) {
			checkformInfo.setContents(contents.replace("\n", "<br/>"));
		}
		model.addAttribute("result", checkformInfo);
		
		return checkformInfo;
	}


	/**
	 * 점검표 관리 (등록을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void forInsertCheckform(Master bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
	}

	/**
	 * 점검표 관리 (등록)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void insertCheckform(Master bean, ModelMap model, Map<String, MultipartFile> files) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
//		bean.setInsert_id(user.getId());
		
		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");

			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		
		ResourceBundle property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
		
		try {
			Iterator<Entry<String, MultipartFile>> iter = files.entrySet().iterator();
			MultipartFile file;
			
			while (iter.hasNext()) {
			    Entry<String, MultipartFile> entry = iter.next();
		
			    file = entry.getValue();
			    String orginFileName = file.getOriginalFilename();
			    
			    if (!"".equals(orginFileName)) {
			    	String filename = new String((property.getString("freecheck.upload.path")+orginFileName).getBytes("euc-kr"), "iso-8859-1");
					file.transferTo(new File(filename));
					bean.setAttachfile1(orginFileName);
			    }
			}
    	} catch (Exception e) {
    		e.printStackTrace();
		}
		
		
		dao.insertCheckform(bean);
	}

	/**
	 * 점검표 관리 (수정을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public Master forUpdateCheckform(Master bean, ModelMap model) {
		int master_cd = bean.getMaster_cd();
		Master result = dao.selectCheckform(master_cd);
		if(result != null) {
			model.addAttribute("result", result);
		}
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return result;
	}
	
	/**
	 * 점검표 관리 (수정)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void updateCheckform(Master bean, ModelMap model, Map<String, MultipartFile> files) {
		ResourceBundle property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
		
		try {
			Iterator<Entry<String, MultipartFile>> iter = files.entrySet().iterator();
			MultipartFile file;
			
			while (iter.hasNext()) {
			    Entry<String, MultipartFile> entry = iter.next();
		
			    file = entry.getValue();
			    String orginFileName = file.getOriginalFilename();
			    if (!"".equals(orginFileName)) {
			    	String filename = new String((property.getString("freecheck.upload.path")+orginFileName).getBytes("euc-kr"), "iso-8859-1");
					file.transferTo(new File(filename));
					bean.setAttachfile1(orginFileName);
			    }
			}
    	} catch (Exception e) {
    		e.printStackTrace();
		}

//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
		dao.updateCheckform(bean);
	}

	
	/**
	 * 점검표 관리 (수정)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void deleteCheckformAttachFile(Master bean, ModelMap model, String deleteFilename, HttpServletResponse response) {
		ResourceBundle property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
		
		try {
			deleteFilename = new String(deleteFilename.getBytes("euc-kr"), "iso-8859-1");
			
			File wfile = new File(property.getString("freecheck.upload.path"));
			if(!wfile.exists()) {
				wfile = new File(property.getString("freecheck.upload.path"+".test")+deleteFilename);
			} else {
				wfile = new File(property.getString("freecheck.upload.path")+deleteFilename);
			}
			String message = "";
			if(wfile.delete()) {
				message = "파일 삭제 성공";
			} else {
				message = "파일을 삭제하는데 오류가 발생했습니다.";
			}
			model.addAttribute("message", message);
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	bean.setAttachfile1(null);
		dao.deleteCheckformAttachFile(bean);
		
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
	}
	
	
	
	/**
	 * 점검표 관리 (삭제)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void deleteCheckform(Master bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
		dao.deleteCheckform(bean);
	}
	
	

	/**
	 * 점검표 체크한 업소 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public List<HashMap> selectCheckedCompanyList(Master bean, ModelMap model) {
		// 결과 
		Master checkformInfo = new Master();
		List<HashMap> resultMany = new ArrayList<HashMap>();
		int totCnt = 0;
		
		// 파라메터 
		String year_cd = bean.getYear_cd();
		int master_cd = bean.getMaster_cd();
		
		// 쿼리 수행
		checkformInfo = dao.selectCheckform(master_cd);
		resultMany = dao.selectCheckedCompanyList(bean);
		totCnt = dao.selectCheckedCompanyListTotCnt(bean);
		
		// 결과
		if(resultMany != null) {
			String contents = checkformInfo.getContents();
			if(contents != null) {
				checkformInfo.setContents(contents.replace("\n", "<br/>"));
			}
			model.addAttribute("checkformInfo", checkformInfo);
			model.addAttribute("resultList", resultMany);
			model.addAttribute("resultListSize", totCnt);
		}
		return resultMany;
	}

	public List<Handleitem> selectCheckedHandleitemList(Company bean, ModelMap model) {
		// 결과 
		Company companyInfo = new Company();
		List<Handleitem> resultMany = new ArrayList<Handleitem>();
		int totCnt = 0;
		
		// 파라메터 
		String year_cd = bean.getYear_cd();
		int master_cd = bean.getMaster_cd();
		
		// 쿼리 수행
		companyInfo = dao.selectCompany(bean);
		resultMany = dao.selectCheckedHandleitemList(bean);
		totCnt = dao.selectCheckedHandleitemListTotCnt(bean);
		
		// 결과
		if(resultMany != null) {
			model.addAttribute("companyInfo", companyInfo);
			model.addAttribute("resultList", resultMany);
			model.addAttribute("resultListSize", totCnt);
		}
		return resultMany;
	}

	

	/**
	 * 점검표 체크하지 않은 업소 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public List<HashMap> selectNotCheckedCompanyList(Master bean, ModelMap model) {
		// 결과 
		Master checkformInfo = new Master();
		List<HashMap> resultMany = new ArrayList<HashMap>();
		int totCnt = 0;
		
		// 파라메터 
		String year_cd = bean.getYear_cd();
		int master_cd = bean.getMaster_cd();
		
		// 쿼리 수행
		checkformInfo = dao.selectCheckform(master_cd);
		resultMany = dao.selectNotCheckedCompanyList(bean);
		totCnt = dao.selectNotCheckedCompanyListTotCnt(bean);
		
		// 결과  
		if(resultMany != null) {
			String contents = checkformInfo.getContents();
			if(contents != null) {
				checkformInfo.setContents(contents.replace("\n", "<br/>"));
			}
			model.addAttribute("checkformInfo", checkformInfo);
			model.addAttribute("resultList", resultMany);
			model.addAttribute("resultListSize", totCnt);
		}
		return resultMany;
	}

	/**
	 * 점검표 질문 리스트(조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public List<HashMap> selectQuestionList(Master bean, ModelMap model) {

		
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
		
		
		// 결과 
		Master checkformInfo = new Master();
		List<HashMap> resultMany = new ArrayList<HashMap>();
		
		
		int totCnt = 0;
		
		// 파라메터 
		int master_cd = bean.getMaster_cd();
		String year_cd = bean.getYear_cd();
		if(year_cd == null || "".equals(year_cd)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy"); // 운영서버 배포시 주석 해제 할 것

			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		
		
		// 쿼리 수행
		checkformInfo = dao.selectCheckform(master_cd);
		resultMany = dao.selectQuestionList(bean);
		List<HashMap> resultManyAnswerStatistics = null;
		for (HashMap question : resultMany) {
			int question_cd = Integer.parseInt(question.get("QUESTION_CD").toString());
			bean.setQuestion_cd(question_cd);
			resultManyAnswerStatistics = new ArrayList<HashMap>();				// 임시 결과 (답변 통계 리스트)
			resultManyAnswerStatistics = dao.selectAnswerStatisticsList(bean); 	// 임시 결과 (답변 통계 불러오기)
			question.put("ANSWER", resultManyAnswerStatistics);
			if(question.get("QUESTION") != null) {
				question.put("QUESTION", question.get("QUESTION").toString().replace("\n", "<br/>"));
			}
		}
		
		
		// 결과  
		if(resultMany != null) {
			String contents = checkformInfo.getContents();
			if(contents != null) {
				checkformInfo.setContents(contents.replace("\n", "<br/>"));
			}
			model.addAttribute("checkformInfo", checkformInfo);
			model.addAttribute("resultList", resultMany);
		}
		

		return resultMany;
	}

	/**
	 * 점검표 답변 통계 자료 다운로드 조회 (조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public List<HashMap> downloadExcelAnswerList(Master bean, ModelMap model) {
		// 결과 
		List<HashMap> resultMany = new ArrayList<HashMap>();
		
		// 쿼리 수행
		resultMany = dao.downloadExcelAnswerList(bean);
		
		// 결과  
		if(resultMany != null) {
			model.addAttribute("resultList", resultMany);
		}
		return resultMany;
	}
	
	
	


	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 조회 (단일 레코드)
	 * @param bean
	 * @param model
	 * @return
	 */
	public Map selectQuestion(Question bean, ModelMap model) {
		Map result = null;
		// 파라메터 
		Question param = new Question();
		param.setMaster_cd(bean.getMaster_cd());
		param.setQuestion_cd(bean.getQuestion_cd());
		
		// 쿼리 수행
		result = dao.selectQuestion(param);

		// 결과
		model.addAttribute("result", result);
		
		return result;
	}


	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) :  (등록을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public void forInsertQuestion(ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
	}

	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 입력
	 * @param bean
	 * @param model
	 * @return
	 */
	public void insertQuestion(Question bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
//		bean.setInsert_id(user.getId());
				
		dao.insertQuestion(bean);
	}

	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : (수정을 위한 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public Map forUpdateQuestion(Question bean, ModelMap model) {
		/* 질문 정보 가져오기 */
		Map result = null;

		// 쿼리 수행
		result = dao.selectQuestion(bean);

		// 결과
		if(result != null) {
			model.addAttribute("result", result);
		}
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		model.addAttribute("user", user);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		

		/* 자율점검 정보 가져오기 */
		Master checkformInfo = new Master();

		// 파라메터 
		int master_cd = bean.getMaster_cd();
		
		// 쿼리 수행
		checkformInfo = dao.selectCheckform(master_cd);

		// 결과
		String contents = checkformInfo.getContents();
		if(contents != null) {
			checkformInfo.setContents(contents.replace("\n", "<br/>"));
		}
		model.addAttribute("checkformInfo", checkformInfo);	
		
		
		return result;
	}
	
	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 수정
	 * @param bean
	 * @param model
	 * @return
	 */
	public void updateQuestion(Question bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
		dao.updateQuestion(bean);
	}

	
	/**
	 * 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 삭제
	 * @param bean
	 * @param model
	 * @return
	 */
	public void updateQuestionForDelete(Question bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
		dao.updateQuestionForDelete(bean);
	}
	
	


	/**
	 * 의약업소 자율점검 (점검표관리) (질문HETB_CK_QUESTION1에 대한 답변 항목 HETB_CK_QUESTION2 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public List<Question2> selectQuestion2ForUpdate(Question2 bean, ModelMap model) {
		List<Question2> result = null;
		
		// 쿼리 수행
		result = dao.selectQuestion2ForUpdate(bean);

		// 결과
		model.addAttribute("result", result);
		
		return result;
	}

	/**
	 * 의약업소 자율점검 (점검표관리) (질문HETB_CK_QUESTION1에 대한 답변 항목 HETB_CK_QUESTION2 조회)
	 * @param bean
	 * @param model
	 * @return
	 */
	public List<Question2> selectQuestion2ForUpdate(Question2 bean, ZValue zvl, ModelMap model) {
		List<Question2> resultList = new ArrayList<Question2>();
		int master_cd = bean.getMaster_cd();
		int question1_cd = bean.getQuestion1_cd();
		
		if("select".equals(bean.getView_state()) || "modify".equals(bean.getView_state())) {
			resultList = dao.selectQuestion2ForUpdate(bean);
		} else {
			Question2 resultItem = null;

			if(bean.getArr_status() != null) {
				for(int i=0; i<bean.getArr_question2().length; i++) {
					String validation = "N";
					String status = bean.getArr_status()[i];
					int orderby = Integer.parseInt(bean.getArr_orderby()[i]);
					String question2 = bean.getArr_question2()[i];
					int question2_cd = Integer.parseInt(bean.getArr_question2_cd()[i]);
					String validationOrdr = bean.getValidation();
					
					log.debug(">>>>>>validationOrdr : " + validationOrdr);
					if(String.valueOf(orderby).equals(validationOrdr))
					{
						log.debug(">>>>>>got validationOrdr !!!!!!! : " + validationOrdr);
						validation = "Y";
					}
					
					if(status.equals("Y") && question2_cd == 0) {
					} else {
						resultItem = new Question2();
						
						resultItem.setQuestion2_cd(question2_cd);
						resultItem.setStatus(status);
						resultItem.setOrderby(orderby);
						resultItem.setQuestion2(question2);
						resultItem.setValidation(validation);
						resultList.add(resultItem);
						
						resultItem.setQuestion1_cd(question1_cd);
						resultItem.setMaster_cd(master_cd);
					} 
				}
			}
			
			
			if("add".equals(bean.getView_state())) {
				resultItem = new Question2();
				
				resultItem.setQuestion1_cd(question1_cd);
				resultItem.setMaster_cd(master_cd);
				resultList.add(resultItem);
			} else if("save".equals(bean.getView_state())) {
				Iterator<Question2> iter = resultList.iterator();
				for (Question2 question2 : resultList) {
					if(question2.getQuestion2_cd() == 0) {
						dao.insertQuestion2(question2);
					} else {
						dao.updateQuestion2(question2);
					}
				}
			}
			
		} 
		
		model.put("resultList", resultList);
		
		
		/* 질문 정보 가져오기 */
		Map resultQuestion1 = null;
		// 파라메터 
		Question param = new Question();
		param.setMaster_cd(bean.getMaster_cd());
		param.setQuestion_cd(bean.getQuestion_cd());
		
		// 쿼리 수행
		resultQuestion1 = dao.selectQuestion(param);
		
		Object questionObj = resultQuestion1.get("QUESTION");
		if(questionObj != null) {
			resultQuestion1.put("QUESTION", questionObj.toString().replace("\n", "<br/>"));
		}
		
		model.put("resultQuestion1", resultQuestion1);
		
		
		
		/* 자율점검 정보 가져오기 */
		Master checkformInfo = new Master();

		// 파라메터 
		master_cd = bean.getMaster_cd();
		
		// 쿼리 수행
		checkformInfo = dao.selectCheckform(master_cd);

		// 결과
		String contents = checkformInfo.getContents();
		if(contents != null) {
			checkformInfo.setContents(contents.replace("\n", "<br/>"));
		}
		model.addAttribute("checkformInfo", checkformInfo);	
		return resultList;
	}
	
	

	public void selectCompanyInfoList(Company bean, ModelMap model) throws Exception {
		List answerList = dao.selectCompanyInfoList(bean);
		if(answerList != null) {
			model.addAttribute("answer", answerList);
		}	
	}

	public HashMap<String, ZValue> selectCheckedQuestionList(Company bean) throws Exception {
		HashMap<String, ZValue> result = new HashMap<String, ZValue>();
		HashMap<String, String> wrongQuestionMap = new HashMap<String, String>();
		List<ZValue> questionCntList = dao.selectCheckedQuestionCntList(bean);
		List<ZValue> wrongQuestionList = dao.selectWrongQuestionList(bean);

		for(ZValue val : wrongQuestionList)
		{
			String companyId = val.getString("companyId");
			String orderby = val.getString("orderby");
			String _orderby = wrongQuestionMap.get(companyId);
			if(_orderby == null)
			{
				_orderby = orderby;
			}
			else
			{
				_orderby += "," + orderby;
			}
			wrongQuestionMap.put(companyId, _orderby);
		}
		
		for(ZValue val : questionCntList)
		{
			String companyId = val.getString("companyId");
			String orderby = wrongQuestionMap.get(companyId);
			val.put("orderby", orderby);
			result.put(companyId, val);
		}
		log.debug(">>>>>>>>>>>>>>>>>>" + result);
		
		return result;
	}


	public List<ZValue> selectLinkedMasterList() throws Exception {
		return dao.selectLinkedMasterList();
	}

	public List<ZValue> selectIndustryAttrList() throws Exception {
		return dao.selectIndustryAttrList();
	}

	public List<ZValue> selectLinkedMasterByIndustry(String industryCd) throws Exception {
		return dao.selectLinkedMasterByIndustry(industryCd);
	}

	public List<ZValue> selectMasterListByIndustry(String industryCd) throws Exception {
		return dao.selectMasterListByIndustry(industryCd);
	}

	public void addLinkedMaster(ZValue zvl) throws Exception {
		dao.addLinkedMaster(zvl);
	}

	public void delLinkedMaster(ZValue zvl) throws Exception {
		dao.delLinkedMaster(zvl);
	}

	public List<ZValue> selectMasterCompanyPointList(ZValue zvl) throws Exception {
		return dao.selectMasterCompanyPointList(zvl);
	}

	public List<ZValue> selectMasterListForItem(String yearCd) throws Exception {
		return dao.selectMasterListForItem(yearCd);
	}

	public List<ZValue> selectItemList(String yearCd) throws Exception {
		return dao.selectItemList(yearCd);
	}

	public void addItem(ZValue zvl) throws Exception {
		dao.addItem(zvl);
	}

	public void delItem(int itemId) throws Exception {
		dao.delItem(itemId);
	}

	public void addCompanyForMigration(ZValue zvl) throws Exception {
		dao.deleteCompanyForMigration(zvl);
		dao.addCompanyForMigration(zvl);
	}

	public void addCheckFormForMigration(ZValue zvl) throws Exception {
		List<Integer> aFCdList = dao.selectAFMasterCdForMigration(zvl);
		for(int i : aFCdList)
		{
			zvl.put("toMasterCd", i);
			dao.deleteMasterForMigration(zvl);
			dao.deleteQuestionForMigration(zvl);
			dao.deleteQuestion2ForMigration(zvl);
		}
		List<Integer> cdList = dao.selectMasterCdForMigration(zvl);
		for(int i : cdList)
		{
			int masterCd = dao.selectMasterCdPKForMigration();
			zvl.put("fromMasterCd", i);
			zvl.put("toMasterCd", masterCd);
			dao.addMasterForMigration(zvl);
			List<Integer> qList = dao.selectQuestionCdForMigration(zvl);
			for(int j : qList)
			{
				int qCd = dao.selectQuestionCdPKForMigration();
				zvl.put("fromQuestionCd", j);
				zvl.put("toQuestionCd", qCd);
				dao.addQuestionForMigration(zvl);
				dao.addQuestion2ForMigration(zvl);
			}
		}
	}

//	public static void main(String[] args) {
//		String[] aa = new String[]{"2010310001","2010310002","2010310003","2010310004","2010310005","2010310006","2010310007","2010310008","2010310009","2010310010","2010310011","2010310012","2010310013","2010310014","2010310015","2010310016","2010310017","2010310018","2010310019","2010310020","2010310021","2010310022","2010310023","2010310024","2010310025","2010310026","2010310027","2010310028","2010310029","2010310030","2010310031","2010310032","2010310033","2010310034","2010310035","2010310036","2010310037","2010310038","2010310039","2010310040"};
//		int i = 1;
//		for (String string : aa) {
//			System.out.println(string.substring(0,4)+"31"+String.format("%04d", i));
//			i++;
//		}
//	}
}
