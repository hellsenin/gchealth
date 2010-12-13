package egovframework.kr.go.geumcheon.health.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.kr.go.geumcheon.health.dao.FreecheckAdminDAO;
import egovframework.kr.go.geumcheon.health.dao.FreecheckUserDAO;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Answer;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Handleitem;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.Question2;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("FreecheckUserService")
public class FreecheckUserService {
	
	@Resource(name="FreecheckUserDAO")
	private FreecheckUserDAO dao = null;
	
	@Resource(name="FreecheckAdminDAO")
	private FreecheckAdminDAO adminDAO = null;

	@Resource(name="pageUtil")
	private PageUtil PageUtil;
	
	
	public boolean loginFreecheck(Company bean, ModelMap model) throws Exception {
		
		boolean condition = false;
		Company result = dao.loginFreecheck(bean);
		String message = "로그인에 실패하였습니다";
		if(result != null)
		{
			String grade_cd = result.getGrade_cd();
			if(grade_cd.equals("02")) {
				//result.make_find_type_cd();
				List<ZValue> masterList = dao.selectMasterCdDataByCompany(bean.getId());
				String masterCdData = null;
				if(masterList != null && masterList.size() > 0)
				{
					masterCdData = "";
					for(int i=0; i<masterList.size(); i++)
					{
						ZValue zvl = masterList.get(i);
						String masterCd = zvl.getString("masterCd");
						if(i == masterList.size()-1) masterCdData += masterCd;
						else masterCdData += masterCd + ",";
					}
				}
				else
				{
					masterCdData = "-1";
				}
				result.setMasterCdData(masterCdData);
		        model.addAttribute("company", result);
		        condition = true;
			} else if(grade_cd.equals("00")) {
				message = "로그인에 실패하였습니다";
			} else if(grade_cd.equals("01")) {
				message = "휴업중인 회원이십니다";
			} else if(grade_cd.equals("03")) {
				message = "페업 신고된 아이디 입니다";
			} else {
				message = "회원님의 아이디는 관리자의 승인을 기다리고 있습니다";
			}
			
		}
        model.addAttribute("message", message);
        return condition;
	}
	
	public String selectCompanyTypeInfo(Company param) {
		return dao.selectCompanyTypeInfo(param);
	}
	
	
	public void selectCheckStateList(Company bean, ModelMap model) throws Exception {
		
		String year_cd = bean.getYear_cd();
		if(year_cd == null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
//			SimpleDateFormat dateFormat = new SimpleDateFormat("2009");
			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		bean.setPageUnit(100);
		bean.setPageSize(100);
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		bean.make_find_type_cd();
		
		List<HashMap> resultMany = new ArrayList<HashMap>();
		int totCnt = 0;
		
		resultMany = dao.selectCheckStateList(bean);
		totCnt = dao.selectCheckStateListTotCnt(bean);
		
		model.addAttribute("resultListSize", totCnt);
		model.addAttribute("resultList", resultMany);

		String url = "/health/freecheck/list.do";
		url += "?company_cd="+bean.getCompany_cd();
		url += "&year_cd="+bean.getYear_cd();
		url += "&find_type_cd="+bean.getFind_type_cd();
		url += "&type_cd="+bean.getType_cd();
		
		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, totCnt, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);
		model.addAttribute("Bean", bean);
	}
	
	public Company selectNextFreecheck(Company bean, ModelMap model) {
		List<HashMap> resultMany = dao.selectNextFreecheck(bean);
		
		for (HashMap hashMap : resultMany) {
			int master_cd = Integer.parseInt(hashMap.get("MASTER_CD").toString());
			
			if(bean.getMaster_cd() != master_cd) {
				bean.setMaster_cd(master_cd);
				String type_cd = hashMap.get("TYPE_CD").toString();
				bean.setType_cd(type_cd);
				
				int answer_cnt = Integer.parseInt(hashMap.get("ANSWER_CNT").toString());
				int answer2_cnt = Integer.parseInt(hashMap.get("ANSWER2_CNT").toString());
				int question_cnt = Integer.parseInt(hashMap.get("QUESTION_CNT").toString());
				
				String article9_yn = hashMap.get("ARTICLE9_YN").toString();
				
				if(answer_cnt == 0) {
					bean.setView_state("writable");
				} else if(answer2_cnt == question_cnt || ("N".equals(article9_yn) && "11".equals(type_cd) && answer_cnt == 1)) {
					bean.setView_state("readonly");
				} else if(answer_cnt == 1 && answer2_cnt < question_cnt) {
					bean.setView_state("forUpdate");
				}
				
				bean.setType_cd(type_cd);
				String message = "";
				message = "["+hashMap.get("TITLE").toString() + "]을 작성해주세요.";
				model.addAttribute("message", message);
			}
		}
		return bean;
	}

	public void selectCheckStateView(Company bean, ModelMap model) throws Exception {
		Master result = dao.selectMaster(bean);
		if(result != null) {
			result.setContents(result.getContents().replace("\n", "<br/>"));
			model.addAttribute("result", result);
		}
		
	}
	

	/**
	 * 점검 대상(HETB_CK_MASTER)에 대한 업체 기본 정보(HETB_CK_ANSWER) (질문 불러오기 1/4) : 점검 대상(HETB_CK_ANSWER) 불러오기
	 * @param bean
	 * @return
	 */
	public void selectCompanyInfo(Company bean, ModelMap model) throws Exception {
		/* 저장된 업소 정보 조회 (HETB_CK_ANSWER, HETB_CK_COMPANY) */
		HashMap answer = null;
		if("writable".equals(bean.getView_state())) {
			answer = dao.selectCompanyInfo(bean);
			if(answer != null) {
				model.addAttribute("answer", answer);
			}
		} else if("readonly".equals(bean.getView_state()) || "forUpdate".equals(bean.getView_state())) {
			answer = dao.selectCompanyInfoAnswer(bean);
			if(answer != null) {
				model.addAttribute("answer", answer);
			}
		}
		
		if(answer != null)
		{
			answer.put("DIVIDE_CD", bean.getDivide_cd());
		}
		
		/* 질문 리스트 조회 (HETB_CK_QUESTION) */
		List<HashMap> questionList = new ArrayList<HashMap>();
		int master_cd = bean.getMaster_cd();
		questionList = dao.selectQuestion(bean);
		model.addAttribute("questionList", questionList);
		
		
		/* 해당 질문의 답변 리스트 조회 (HETB_CK_QUESTION2) */
		List<HashMap> answerList = new ArrayList<HashMap>();
		Question2 param = new Question2();
		param.setMaster_cd(master_cd);
		for(HashMap question : questionList) {
			param.setQuestion_cd(Integer.parseInt(question.get("QUESTION_CD").toString()));
			answerList = dao.selectAnswer(param);
			question.put("answerList", answerList);
		}
		
		List<ZValue> itemList = dao.selectItemListForCheck(master_cd);
		model.addAttribute("itemList", itemList);
		
		model.addAttribute("companyInfo", bean);
		
	}
	
	
	public void check(Answer bean, List<Answer> answerList, ModelMap model) throws Exception {
		if("forUpdate".equals(bean.getView_state())) {
			Company param = new Company();
			param.setCompany_cd(bean.getCompany_cd());
			param.setFind_type_cd(bean.getFind_type_cd());
			param.setYear_cd(bean.getYear_cd());
			param.setId(bean.getCompany_id());
			param.setMaster_cd(bean.getMaster_cd());
			param.setType_cd(bean.getType_cd());
			
			selectCompanyInfo(param, model);
		} else if("writable".equals(bean.getView_state())) {
			dao.checkQuestion(bean);
			for (Answer a2 : answerList) {
				dao.checkQuestion2(a2);
			}
		} else if("update".equals(bean.getView_state())) {
			dao.checkUpdateQuestion(bean);
			dao.deleteCheckedQuestion2(bean);
			for (Answer a2 : answerList) {
				dao.checkQuestion2(a2);
			}
		}
		
	}
	
	
	public List<HashMap> selectFreecheckInfoList(Company bean, ModelMap model) {
		String year_cd = bean.getYear_cd();
		if(year_cd == null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
//			SimpleDateFormat dateFormat = new SimpleDateFormat("200901");
			bean.setYear_cd(dateFormat.format(Calendar.getInstance().getTime()));
		}
		List<HashMap> resultMany = new ArrayList<HashMap>();
		String master_cd = bean.getYear_cd();
		resultMany = adminDAO.selectCheckformList(master_cd);
		if(resultMany != null) {
			model.addAttribute("resultList", resultMany);
		}
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return resultMany;
	}
	

	public Master selectFreecheckInfo(Master bean, ModelMap model) {
		Master checkformInfo = new Master();

		// 파라메터 
		int master_cd = bean.getMaster_cd();
		
		// 쿼리 수행
		checkformInfo = adminDAO.selectCheckform(master_cd);

		// 결과
		String contents = checkformInfo.getContents();
		if(contents != null) {
			checkformInfo.setContents(contents.replace("\n", "<br/>"));
		}
		model.addAttribute("result", checkformInfo);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		
		return checkformInfo;
	}
	

	public List<Handleitem> checkHandleitem(Answer bean, ModelMap model) {
		List<Handleitem> resultList = new ArrayList<Handleitem>();
		int company_cd = bean.getCompany_cd();
		String company_id = bean.getCompany_id();
		String year_cd = bean.getYear_cd();

		System.out.println("상태 : "+bean.getView_state());
		if("select".equals(bean.getView_state()) || "modify".equals(bean.getView_state())) {
			resultList = dao.selectHandleItemList(bean);
		} else {
			Handleitem resultItem = null;
			
			if(bean.getArr_status() != null) {
				for(int i=0; i<bean.getArr_status().length; i++) {
					int handle_cd = Integer.parseInt(bean.getArr_handle_cd()[i]);
					String status = bean.getArr_status()[i];
					
					if(status.equals("Y") && handle_cd == 0) {
					} else {
						String item_name = bean.getArr_item_name()[i];
						String unit = bean.getArr_unit()[i];
						int order_no = Integer.parseInt(bean.getArr_order_no()[i]);
						
						
						
						resultItem = new Handleitem();
						
						resultItem.setHandle_cd(handle_cd);
						resultItem.setItem_name(item_name);
						resultItem.setUnit(unit);
						resultItem.setField1(bean.getArr_field1()[i]);
						resultItem.setField2(bean.getArr_field2()[i]);
						resultItem.setField3(bean.getArr_field3()[i]);
						resultItem.setField4(bean.getArr_field4()[i]);
						resultItem.setOrder_no(order_no);


						resultItem.setCompany_cd(company_cd);
						resultItem.setCompany_id(company_id);
						resultItem.setYear_cd(year_cd);
						resultItem.setStatus(status);
						
						resultList.add(resultItem);
					} 
				}
			}
			
			
			if("add".equals(bean.getView_state())) {
				resultItem = new Handleitem();

				resultItem.setCompany_cd(company_cd);
				resultItem.setCompany_id(company_id);
				resultItem.setYear_cd(year_cd);
				
				resultList.add(resultItem);
			} else if("save".equals(bean.getView_state())) {
				Iterator<Handleitem> iter = resultList.iterator();
				for (Handleitem item : resultList) {
					if("Y".equals(item.getStatus()) || item.getItem_name().length() == 0) {
						dao.deleteHandleItem(item);
					} else {
						if(item.getHandle_cd() == 0) {
							dao.insertHandleItem(item);
						} else {
							dao.updateHandleItem(item);
						}	
					}
					
				}
			}
			
		} 
		
		
		
		
		if(resultList.size() == 0) {
			resultList.add(new Handleitem());
		}
		model.put("resultList", resultList);
		
		/* 자율점검 정보 가져오기 */
		Master checkformInfo = new Master();

		// 파라메터 
		int master_cd = bean.getMaster_cd();
		
		// 쿼리 수행
		checkformInfo = adminDAO.selectCheckform(master_cd);

		// 결과
//		String contents = checkformInfo.getContents();
//		if(contents != null) {
//			checkformInfo.setContents(contents.replace("\n", "<br/>"));
//		}
		model.addAttribute("checkformInfo", checkformInfo);	
		return resultList;
	}
	
	public void checkHandleitem(Company company, ZValue zvl) throws Exception
	{
		String companyCd = String.valueOf(company.getCompany_cd());
		String companyId = company.getId();
		String companyName = company.getCompany();
		String yearCd = company.getYear_cd();
		
		dao.delHandleitem(company);
		
		ArrayList<String> itemNames = zvl.getArrayList("itemName");
		ArrayList<String> units = zvl.getArrayList("unit");
		ArrayList<String> field1Data = zvl.getArrayList("field1");
		ArrayList<String> field2Data = zvl.getArrayList("field2");
		ArrayList<String> field3Data = zvl.getArrayList("field3");
		ArrayList<String> field4Data = zvl.getArrayList("field4");
		ArrayList<String> field5Data = zvl.getArrayList("field5");
		
		for(int i=0; i<itemNames.size(); i++)
		{
			ZValue param = new ZValue();
			param.put("itemName", itemNames.get(i));
			param.put("unit", units.get(i));
			param.put("companyCd", companyCd);
			param.put("companyId", companyId);
			param.put("yearCd", yearCd);
			param.put("companyName", companyName);
			param.put("field1", field1Data.get(i));
			param.put("field2", field2Data.get(i));
			param.put("field3", field3Data.get(i));
			param.put("field4", field4Data.get(i));
			param.put("field5", field5Data.get(i));
			
			dao.addHandleitem(param);
		}
		
	}
	

	public List<ZValue> selectHandleitemListU(Company company) throws Exception
	{
		return dao.selectHandleitemListU(company);
	}
	
	public ZValue actionLogin(ZValue zvl) throws Exception
	{
		return dao.actionLogin(zvl);
	}
}
