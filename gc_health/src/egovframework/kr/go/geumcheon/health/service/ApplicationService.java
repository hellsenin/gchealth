package egovframework.kr.go.geumcheon.health.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.kr.go.geumcheon.health.dao.ApplyDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("applicationService")
public class ApplicationService{

    Logger log = Logger.getLogger(this.getClass());

	public static int RELY_CIVIL_WISH = 1; 					//구청장에바란다
	public static int RELY_DISCOMPORT_LIFE = 2;				//생활불편신고
	public static int RELY_ENV = 3;   							//환경신문고
	public static int RELY_ABSURDITY = 5;		 				//부조리신고
	public static int RELY_UNSANITARY_FOOD = 8;		 		//불량식품
	public static int RELY_HARMFUL_BIZ = 9;		 			//청소년 유해업소 신고
	public static int RELY_ADMINISTRATION_REGULATION = 10;		//행정규제개혁신고
	public static int RELY_LAMP = 11;							//보안등가로등고장신고
	public static int RELY_PROCESSING_SEAWARTER = 12;   		//유출지하수/해수처리	
	public static int RELY_BUDGET = 13;   						//예산낭비신고
	public static int RELY_THROW_AWAY = 14;   					//무단투기
	public static int RELY_HEALTH_COUNSEL = 15;   				//보건상담
	public static int RELY_ATTEND_CONFERENCE = 40;   			//방청/참관 신청하기
	public static int RELY_DONG_WISH = 91;       				//동장에바란다
    
    //민원신고 상태값
	public static int RECEIPT_WAITING = 1; 	//접수중
	public static int RECEIPT = 2;			 	//접수
	public static int ASSIGNED_DEPT = 3;   	//부서지정
	public static int OFFICER_PROCESSING = 4;	//담당자지정처리
	public static int ANSWERING = 5;		 	//답변중
	public static int COMPLETE_ANSWER = 6;   	//답변완료
	public static int COMPLETION = 7;       	//처리완료
	public static int DELETION = 8;       		//삭제
	public static int TRANSFER = 9;       		//이관

	public static int ANSWER_ASSIGNED_DEPT = 1; 		//부서지정
	public static int ANSWER_OFFICER_PROCESSING = 2;	//담당자지정처리
	public static int ANSWER_ANSWERING = 3;     		//답변중
	public static int ANSWER_COMPLETION = 4;    		//답변완료 
	public static int ANSWER_DEPT_RETURN = 5;        			//부서지정 반려
	public static int ANSWER_OFFICER_INSPECTOR_RETURN = 6;     //담당자지정 감사담당관 반려
	public static int ANSWER_OFFICER_DEPT_RETURN = 7;     //담당자지정 부서장 반려
	
	//결제 구분
	public static String CARD_PAYMENT = "SC0010";     //카드결제
	public static String BANK_PAYMENT = "SC0030";     //계좌이체
	public static String ELEC_PAYMENT = "SC0040";     //가상계좌
	public static String VISIT_PAYMENT = "VISIT";    //방문이체
	public static String OFFLINE_PAYMENT = "OFFLINE";  //오프라인

	//결제 상태값
	public static int NO_PAYMENT_STATUS = 1;     	//미결제
	public static int PROCESSING_STATUS = 2;     	//처리중
	public static int FINISH_PROCESSING_STATUS = 3;  //처리완료
	public static int ALL_REFUND_STATUS = 4;     			//전체환불
	public static int PART_REFUND_STATUS = 5;    			//부분환불
	
    @Resource(name = "EgovFileMngUtil")
    protected EgovFileMngUtil fileUtil;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name="applyDAO")
	protected ApplyDAO applyDAO;

    @Resource(name = "applicationFactory")
    protected ApplicationFactory applicationFactory;

    @Resource(name = "webFactory")
    protected WebFactory WebFactory;

	public boolean isAccessable(ZValue result, UsersVO user)
	{
		boolean condition = false;
		if(user != null)
		{
	    	String orgMemberId = result.getString("memberId");
	    	String orgPinno = result.getString("pinno");
	    	String memberId = user.getWebMemId();
	    	String pinno = user.getPin();
	    	
	    	condition = (!"".equals(orgMemberId) && orgMemberId.equals(memberId)) || (!"".equals(orgPinno) && orgPinno.equals(pinno));
		}
   	
		return condition;
	}
							
	public int selectApplyId(String applyKey) throws Exception{
		return applyDAO.selectApplyId(applyKey);
	}
	
	public void apply(ZValue zvl, Map<String, MultipartFile> files) throws Exception 
	{
		String applyCode = zvl.getString("applyCode");

		int applyId = applyDAO.selectApplyId(applyCode);
		
		zvl.put("applyId", applyId);
		applyDAO.apply(zvl);
		
	    List<FileVO> result = null;
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "M_", 0, "", "apply.fileStorePath");
			applyDAO.addFile(result, zvl);
	    }
		
	}

	public void apply(ZValue zvl) throws Exception 
	{
		String applyCode = zvl.getString("applyCode");

		int applyId = applyDAO.selectApplyId(applyCode);
		
		zvl.put("applyId", applyId);
		applyDAO.apply(zvl);
	}
	
	@SuppressWarnings("unchecked")
	public void addFile(List fileList, ZValue zvl) throws Exception{
		applyDAO.addFile(fileList, zvl);
	}

	public Map<String, Object> selectApplyListById(ZValue zvl) throws Exception{
		
		List result = applyDAO.selectApplyListById(zvl);
		int cnt = applyDAO.selectApplyListCntById(zvl);

		zvl.put("totCnt", cnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		return map;
	}

	public Map<String, Object> selectApplyList(ZValue zvl) throws Exception{
		
		List result = applyDAO.selectApplyList(zvl);
		int cnt = applyDAO.selectApplyListCnt(zvl);

		zvl.put("totCnt", cnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		return map;
	}

	public Map<String, Object> selectApplyListA(ZValue zvl) throws Exception{
		
		List result = applyDAO.selectApplyListA(zvl);
		int cnt = applyDAO.selectApplyListCntA(zvl);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		return map;
	}
	
	public List excelSelectApplyListA(ZValue zvl) throws Exception
	{
		return applyDAO.excelSelectApplyListA(zvl);
	}
	
	public ZValue selectFileByFileId(String fileId) throws Exception
	{
		return applyDAO.selectFileByFileId(fileId);
	}

	public List selectFileListById(ZValue zvl) throws Exception{
		return applyDAO.selectFileListById(zvl);
	}
	
	public ZValue selectApplyView(ZValue zvl) throws Exception
	{
		return applyDAO.selectApplyView(zvl);
	}

	public ZValue selectApplyViewByApplyId(ZValue zvl) throws Exception
	{
		return applyDAO.selectApplyViewByApplyId(zvl);
	}

	public void updateApplyByApplyId(ZValue zvl) throws Exception
	{
		applyDAO.updateApplyByApplyId(zvl);
	}

	public void deleteApplyByApplyId(ZValue zvl) throws Exception
	{
		applyDAO.deleteApplyByApplyId(zvl);
	}
	
	public void cancelApply(ZValue zvl) throws Exception
	{
		applyDAO.cancelApply(zvl);
	}

	public void cancelApplyA(ZValue zvl) throws Exception
	{
		ArrayList<String> applyIdData = zvl.getArrayList("applyIdData");
		for(String applyId : applyIdData)
		{
			zvl.put("applyId", applyId);
			applyDAO.cancelApply(zvl);
		}
	}

	public void modifyApply(ZValue zvl) throws Exception
	{
		applyDAO.updateApplyByApplyId(zvl);
	}

	public void modifyApply(ZValue zvl, Map<String, MultipartFile> files) throws Exception
	{
		applyDAO.updateApplyByApplyId(zvl);
		
		ArrayList<String> fileIdData = zvl.getArrayList("fileId");
		for(int i=0; i<fileIdData.size(); i++)
		{
			applyDAO.delFile(fileIdData.get(i));
		}
	    List<FileVO> result = null;
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "M_", 0, "", "apply.fileStorePath");
			applyDAO.addFile(result, zvl);
	    }
	}

	public List selectAnswerList(ZValue zvl) throws Exception
	{
        return applyDAO.selectAnswerList(zvl);
	}

	public ZValue selectUserAnswer(ZValue zvl) throws Exception
	{
        return applyDAO.selectUserAnswer(zvl);
	}

	public ZValue selectAnswer(String answerId) throws Exception
	{
        return applyDAO.selectAnswer(answerId);
	}

	public List selectAssignedDeptList(ZValue zvl) throws Exception
	{
        return applyDAO.selectAssignedDeptList(zvl);
	}
	
	public void addAnswer(ZValue zvl) throws Exception
	{
		applyDAO.addAnswer(zvl);
		zvl.put("status", ApplicationService.COMPLETION);
		applyDAO.changeStatus(zvl);
	}

	public void txAddAnswer(ZValue zvl, Map<String, MultipartFile> files) throws Exception
	{
	    List<FileVO> result = null;
		applyDAO.addAnswer(zvl);
		zvl.put("status", ApplicationService.COMPLETION);
		applyDAO.changeStatus(zvl);
    	if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "M_", 0, "", "Minwon.fileStorePath");
			applyDAO.addFile(result, zvl);
	    }
	}
	
	public void updateAnswer(ZValue zvl) throws Exception
	{
		applyDAO.updateAnswer(zvl);
	}

	public void updateAssignedDeptAnswer(ZValue zvl) throws Exception
	{
		applyDAO.updateAssignedDeptAnswer(zvl);
	}

	public void txUpdateAnswer(ZValue zvl, Map<String, MultipartFile> files) throws Exception
	{
		applyDAO.updateAnswer(zvl);
	    List<FileVO> result = null;
	    if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "M_", 0, "", "Minwon.fileStorePath");
			applyDAO.addFile(result, zvl);
	    }
	    //zvl.put("status", OFFICER_PROCESSING); //담당자지정처리
    	//applyDAO.updateStatus(zvl);
	}

	public ZValue selectApplyStatus(ZValue zvl) throws Exception
	{
        return applyDAO.selectApplyStatus(zvl);
	}

	public void assignDept(ZValue zvl) throws Exception
	{
		applyDAO.assignDept(zvl);
	}

	public void deleteAssignedDept(ZValue zvl) throws Exception
	{
		applyDAO.deleteAssignedDept(zvl);
	}

	public void updateDeadline(ZValue zvl) throws Exception
	{
		applyDAO.updateDeadline(zvl);
	}

	public void updateStatus(ZValue zvl) throws Exception
	{
		applyDAO.updateStatus(zvl);
	}

	public void updateAnswerStatus(ZValue zvl) throws Exception
	{
		applyDAO.updateAnswerStatus(zvl);
	}
	
	public void changeStatus(ZValue zvl) throws Exception
	{
		applyDAO.changeStatus(zvl);
	}

	public void exceptApplicant(ZValue zvl) throws Exception
	{
		ArrayList applyIdData = zvl.getArrayList("applyIdData");
		ZValue param = null;
		for(int i=0; i<applyIdData.size(); i++)
		{
			param = new ZValue();
			param.put("applyCode", zvl.getString("applyCode"));
			param.put("applyId", applyIdData.get(i));
			applyDAO.exceptApplicant(param);
		}
	}
	
	public void addHit(ZValue zvl) throws Exception
	{
		applyDAO.addHit(zvl);
	}
	
	public void returnAssignedStatus(ZValue zvl) throws Exception
	{
		applyDAO.changeAnswerStatus(zvl);
	}

	public void changeAnswerStatus(ZValue zvl) throws Exception
	{
		applyDAO.changeAnswerStatus(zvl);
	}

	public ZValue selectPetitionView(ZValue zvl) throws Exception
	{
		return applyDAO.selectPetitionView(zvl);
	}

	public int selectAnswerStatusByUserIdAndApplyId(ZValue zvl) throws Exception
	{
		return applyDAO.selectAnswerStatusByUserIdAndApplyId(zvl);
	}

	public int selectOnlineApplyCnt(ZValue zvl) throws Exception
	{
		return applyDAO.selectOnlineApplyCnt(zvl);
	}

	public int getByteSize(String str)
	{
        
        byte[] bytes = str.getBytes();
        return bytes.length;
	}
	
	public String getCalcStr(String str, int sLoc, int eLoc) 
	{
        byte[] bystStr;
        String rltStr = "";
        try
        {
            bystStr = str.getBytes();
            rltStr = new String(bystStr, sLoc, eLoc - sLoc);
        }
        catch(Exception e)
        {
            return "";
        }
       return rltStr;
    }
	

}
