package egovframework.kr.go.geumcheon.health.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;

import egovframework.kr.go.geumcheon.health.dao.PollDAO;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Answer;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.Question;
import egovframework.kr.go.geumcheon.health.vo.Question2;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("pollService")
public class PollService {

	public static final String POLL_YEAR_CD = "000000";

	@Resource(name="pollDAO")
	private PollDAO dao;

	@Resource(name="pageUtil")
	private PageUtil PageUtil;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	public HashMap<String, Object> selectAllMasterList(ZValue zvl) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Master> ongoingResultList = dao.selectOngoingMasterList(POLL_YEAR_CD);
		
		zvl.put("yearCd", POLL_YEAR_CD);
		List<Master> finishedResultList = dao.selectFinishedMasterList(zvl);
		int finishedCnt = dao.selectFinishedMasterListCnt(POLL_YEAR_CD);
	
		resultMap.put("ongoingResultList", ongoingResultList);
		resultMap.put("finishedResultList", finishedResultList);
		resultMap.put("finishedCnt", finishedCnt);
		
		return resultMap;
	}

	public List<HashMap> selectCheckformList(ModelMap model) {
		List<HashMap> resultMany = null;
		resultMany = dao.selectCheckformList(POLL_YEAR_CD);
		model.addAttribute("resultList", resultMany);
		return resultMany;
	}

	public void insertCheckform(Master bean, ModelMap model, Map<String, MultipartFile> files) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
//		bean.setInsert_id(user.getId());

		bean.setYear_cd(POLL_YEAR_CD);
		try {
			Iterator<Entry<String, MultipartFile>> iter = files.entrySet().iterator();
			MultipartFile file;
			
			while (iter.hasNext()) {
			    Entry<String, MultipartFile> entry = iter.next();
		
			    file = entry.getValue();
			    String orginFileName = file.getOriginalFilename();
			    
			    if (!"".equals(orginFileName)) {
			    	//String filename = new String((propertyService.getString("poll.fileStorePath")+orginFileName).getBytes("euc-kr"), "iso-8859-1");
			    	String filename = propertyService.getString("poll.fileStorePath")+orginFileName;
					file.transferTo(new File(filename));
					bean.setAttachfile1(orginFileName);
			    }
			}
    	} catch (Exception e) {
    		e.printStackTrace();
		}
		
		
		dao.insertCheckform(bean);
	}

	public List<HashMap> selectCheckformList(Master bean, ModelMap model) {
		List<HashMap> resultMany = null;
		String master_cd = bean.getYear_cd();
		resultMany = dao.selectCheckformList(master_cd);
		
		if(resultMany != null) {
			model.addAttribute("resultList", resultMany);
		}
		return resultMany;
	}

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

	public Master forUpdateCheckform(Master bean, ModelMap model) {
		int master_cd = bean.getMaster_cd();
		Master result = dao.selectCheckform(master_cd);
		if(result != null) {
			model.addAttribute("result", result);
		}
		return result;
	}

	public void updateCheckform(Master bean, ModelMap model, Map<String, MultipartFile> files) {
		
		try {
			Iterator<Entry<String, MultipartFile>> iter = files.entrySet().iterator();
			MultipartFile file;
			
			while (iter.hasNext()) {
			    Entry<String, MultipartFile> entry = iter.next();
		
			    file = entry.getValue();
			    String orginFileName = file.getOriginalFilename();
			    if (!"".equals(orginFileName)) {
			    	//String filename = new String((propertyService.getString("poll.fileStorePath")+orginFileName).getBytes("euc-kr"), "iso-8859-1");
			    	String filename = propertyService.getString("poll.fileStorePath")+orginFileName;
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
		bean.setYear_cd(POLL_YEAR_CD);
		
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

	public List<HashMap> selectTestQuestionList(Master bean, ModelMap model) {

		
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
		bean.setYear_cd(POLL_YEAR_CD);
		
		// 쿼리 수행
		checkformInfo = dao.selectCheckform(master_cd);
		resultMany = dao.selectTestQuestionList(bean);
		List<HashMap> resultManyAnswerStatistics = null;
		for (HashMap question : resultMany) {
			int question_cd = Integer.parseInt(question.get("QUESTION_CD").toString());
			bean.setQuestion_cd(question_cd);
			resultManyAnswerStatistics = new ArrayList<HashMap>();				// 임시 결과 (답변 통계 리스트)
			resultManyAnswerStatistics = dao.selectTestAnswerStatisticsList(bean); 	// 임시 결과 (답변 통계 불러오기)
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

	public void insertQuestion(Question bean, ModelMap model) {
				
		dao.insertQuestion(bean);
	}

	public Map forUpdateQuestion(Question bean, ModelMap model) {
		/* 질문 정보 가져오기 */
		Map result = null;

		// 쿼리 수행
		result = dao.selectQuestion(bean);

		// 결과
		if(result != null) {
			model.addAttribute("result", result);
		}
		

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

	public void updateQuestion(Question bean, ModelMap model) {
		dao.updateQuestion(bean);
	}

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
					String status = bean.getArr_status()[i];
					int orderby = Integer.parseInt(bean.getArr_orderby()[i]);
					String question2 = bean.getArr_question2()[i];
					int question2_cd = Integer.parseInt(bean.getArr_question2_cd()[i]);
					
					
					if(status.equals("Y") && question2_cd == 0) {
					} else {
						resultItem = new Question2();
						
						resultItem.setQuestion2_cd(question2_cd);
						resultItem.setStatus(status);
						resultItem.setOrderby(orderby);
						resultItem.setQuestion2(question2);
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

	public void selectCheckStateView(Company bean, ModelMap model) throws Exception {
		Master result = dao.selectMaster(bean);
		if(result != null) {
			result.setContents(result.getContents().replace("\n", "<br/>"));
			model.addAttribute("result", result);
		}
		
	}

	public void selectCompanyInfo(Company bean, ModelMap model) throws Exception {
		
		/* 질문 리스트 조회 (HETB_CK_QUESTION) */
		List<HashMap> questionList = new ArrayList<HashMap>();
		int master_cd = bean.getMaster_cd();
		questionList = dao.selectQuestionU(bean);
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

		/*
		int pollId = dao.selectTempPollId(); //임시용 아이디
		bean.setCompany_id(String.valueOf(pollId));
		model.addAttribute("companyInfo", bean);
		*/
		
	}

	public void selectCompanyInfoA(Company bean, ModelMap model) throws Exception {
		
		/* 질문 리스트 조회 (HETB_CK_QUESTION) */
		List<HashMap> questionList = new ArrayList<HashMap>();
		int master_cd = bean.getMaster_cd();
		questionList = dao.selectQuestionA(bean);
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
	}

	public void check(Answer bean, List<Answer> answerList, ModelMap model) throws Exception {

		for (Answer a2 : answerList) {
			dao.checkQuestion2(a2);
		}
	}

	public void checkUpdate(Company bean, List<Answer> answerList, ModelMap model) throws Exception {

		dao.deleteAnswer2ForCompanyId(bean);
		for (Answer a2 : answerList) {
			dao.checkQuestion2(a2);
		}
	}

	public void selectAnswerAndResponse(Company bean, ModelMap model) throws Exception {
		
		/* 질문 리스트 조회 (HETB_CK_QUESTION) */
		List<HashMap> questionList = new ArrayList<HashMap>();
		int master_cd = bean.getMaster_cd();
		questionList = dao.selectQuestionU(bean);
		model.addAttribute("questionList", questionList);
		
		
		/* 해당 질문의 답변 리스트 조회 (HETB_CK_QUESTION2) */
		List<HashMap> answerList = new ArrayList<HashMap>();
		Question2 param = new Question2();
		param.setMaster_cd(master_cd);
		for(HashMap question : questionList) {
			param.setQuestion_cd(Integer.parseInt(question.get("QUESTION_CD").toString()));
			answerList = dao.selectAnswerAndResponse(param);
			question.put("answerList", answerList);
		}
		model.addAttribute("companyInfo", bean);
		
	}
	
	public List<ZValue> selectOtherList(ZValue zvl) throws Exception {
		return dao.selectOtherList(zvl);
		
	}

	public List<ZValue> selectEssayList(ZValue zvl) throws Exception {
		return dao.selectEssayList(zvl);
		
	}

	public void updateQuestionForDelete(Question bean, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
		dao.updateQuestionForDelete(bean);
	}

	public int selectTempPollId() throws Exception {
		return dao.selectTempPollId();
		
	}

	public List<HashMap> selectCheckedList(Master bean, ModelMap model) {
		// 결과 
		Master checkformInfo = new Master();
		List<HashMap> resultMany = new ArrayList<HashMap>();
		int totCnt = 0;
		
		// 파라메터 
		bean.setYear_cd(POLL_YEAR_CD);
		int master_cd = bean.getMaster_cd();
		
		// 쿼리 수행
		checkformInfo = dao.selectCheckform(master_cd);
		resultMany = dao.selectCheckedList(bean);
		totCnt = dao.selectCheckedListTotCnt(bean);
		
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

	public void deleteAnswerForCompanyId(Company bean) 
	{
		dao.deleteAnswer2ForCompanyId(bean);
	}

	public void delete(int masterCd) 
	{
		dao.delete(masterCd);
	}

	public ZValue selectRescentPoll() {
		return dao.selectRescentPoll();
	}

	public HashMap<String, List<ZValue>> selectPollExceptSatisfaction() throws Exception {
		HashMap<String, List<ZValue>> map = new HashMap<String, List<ZValue>>();
		List<ZValue> tempList = null;
		List<ZValue> list = dao.selectPollExceptSatisfaction();
		for(ZValue zvl : list)
		{
			String companyId = zvl.getString("companyId");
			tempList = map.get(companyId);
			if(tempList == null)
			{
				tempList = new ArrayList<ZValue>();
				tempList.add(zvl);
			}
			else
			{
				tempList.add(zvl);
			}
			map.put(companyId, tempList);
		}
		
		return map;
	}

	public List<Answer> getZvl(ZValue zvl) {
		List<Answer> list = new ArrayList<Answer>();
		int size = zvl.getInt("questionListSize");
		
		int masterCd = zvl.getInt("masterCd");
		String companyId = zvl.getString("companyId");
		int companyCd = zvl.getInt("companyCd");
		
		for(int i=1; i<=size; i++) {

			int questionCd = zvl.getInt("questionCd"+i);
			
			String multi_check_yn = zvl.getString("multiCheckYn"+i);
			
			int question2Cd = 0;
			
			String other = "";
			String otherYn = zvl.getString("otherYn"+i);
			String question2CdObj = zvl.getString("question2Cd"+i);
			
			if(!"".equals(multi_check_yn)) {

				if("Y".equals(multi_check_yn)) {
					
					//기타사용하고 체크박스값 체크되어있을경우에만 추가
					if("Y".equals(otherYn)) 
					{
						
						if("9999".equals(question2CdObj))
						{
							other = zvl.getString("other"+i);
	
							Answer item = new Answer();
							item.setQuestion2_cd(9999);
							item.setQuestion_cd(questionCd);
							item.setOther(other);
							item.setMaster_cd(masterCd);
							item.setCompany_cd(companyCd);
							item.setCompany_id(companyId);
							
							list.add(item);
						}
					}
					
					other = "";
					
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

				} else if("N".equals(multi_check_yn)) {

					if(question2CdObj.length() != 0) {;

						question2Cd = Integer.parseInt(question2CdObj);
						if(question2Cd == 9999) {
							other = zvl.getString("other"+i);
						}
	
						Answer item = new Answer();
						item.setQuestion2_cd(question2Cd);
						item.setQuestion_cd(questionCd);
						item.setOther(other);
						item.setMaster_cd(masterCd);
						item.setCompany_cd(companyCd);
						item.setCompany_id(companyId);
						
						list.add(item);
					}
				}else{

					if(question2CdObj.length() != 0) {;
						question2Cd = Integer.parseInt(question2CdObj);
	
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

}
