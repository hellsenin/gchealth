package egovframework.kr.go.geumcheon.health.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.kr.go.geumcheon.health.dao.ApplyDAO;
import egovframework.kr.go.geumcheon.health.dao.OnlineApplyDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("onlineApplyService")
public class OnlineApplyService
{
    Logger log = Logger.getLogger(this.getClass());
    
    public static int WAITING_STATUS = 1;
    public static int FINISHED_STATUS = 2;
    
	@Resource(name="applyDAO")
	private ApplyDAO applyDAO;

	@Resource(name="onlineApplyDAO")
	private OnlineApplyDAO onlineApplyDAO;

	public Map<String, Object> selectOnlineApplyList(ZValue zvl) throws Exception{
		
		List result = onlineApplyDAO.selectOnlineApplyList(zvl);
		int cnt = onlineApplyDAO.selectOnlineApplyCnt(zvl);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		return map;
	}

	public Map<String, Object> selectApplicantList(ZValue zvl) throws Exception{
		
		List result = onlineApplyDAO.selectApplicantList(zvl);
		int cnt = onlineApplyDAO.selectApplicantListCnt(zvl);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", cnt);
		return map;
	}
	
	public List<ZValue> selectAllApplicantList(ZValue zvl) throws Exception{
		return onlineApplyDAO.selectAllApplicantList(zvl);
	}
		
	public List<ZValue> excelApplicantList(ZValue zvl) throws Exception{
		return onlineApplyDAO.excelApplicantList(zvl);
	}
	
	public ZValue selectOnlineApply(ZValue zvl) throws Exception{
		return onlineApplyDAO.selectOnlineApply(zvl);
	}
	
	public void registOnlineApply(ZValue zvl) throws Exception
	{
		ArrayList<String> weekOfMonthData = zvl.getArrayList("weekOfMonthData");
		String weekOfMonth = "";
		for(int i=0; i<weekOfMonthData.size(); i++)
		{
			if(i == weekOfMonthData.size()-1)
				weekOfMonth += weekOfMonthData.get(i);
			else
				weekOfMonth += weekOfMonthData.get(i) + "|";
		}
		zvl.put("weekOfMonth", weekOfMonth);
		ArrayList<String> dayOfWeekData = zvl.getArrayList("dayOfWeekData");
		String dayOfWeek = "";
		for(int i=0; i<dayOfWeekData.size(); i++)
		{
			if(i == dayOfWeekData.size()-1)
				dayOfWeek += dayOfWeekData.get(i);
			else
				dayOfWeek += dayOfWeekData.get(i) + "|";
		}
		zvl.put("dayOfWeek", dayOfWeek);
		onlineApplyDAO.registOnlineApply(zvl);
	}

	public void modifyOnlineApply(ZValue zvl) throws Exception
	{
		ArrayList<String> weekOfMonthData = zvl.getArrayList("weekOfMonthData");
		String weekOfMonth = "";
		for(int i=0; i<weekOfMonthData.size(); i++)
		{
			if(i == weekOfMonthData.size()-1)
				weekOfMonth += weekOfMonthData.get(i);
			else
				weekOfMonth += weekOfMonthData.get(i) + "|";
		}
		zvl.put("weekOfMonth", weekOfMonth);
		ArrayList<String> dayOfWeekData = zvl.getArrayList("dayOfWeekData");
		String dayOfWeek = "";
		for(int i=0; i<dayOfWeekData.size(); i++)
		{
			if(i == dayOfWeekData.size()-1)
				dayOfWeek += dayOfWeekData.get(i);
			else
				dayOfWeek += dayOfWeekData.get(i) + "|";
		}
		zvl.put("dayOfWeek", dayOfWeek);
		log.debug(">>>>>>>>>zvl : " + zvl);
		onlineApplyDAO.modifyOnlineApply(zvl);
	}

	public void delOnlineApply(ZValue zvl) throws Exception
	{
		onlineApplyDAO.delOnlineApply(zvl);
		onlineApplyDAO.delOnlineApplicant(zvl);
	}

	public void confirmApplicant(ZValue zvl) throws Exception
	{
		zvl.put("status", OnlineApplyService.FINISHED_STATUS);
		ArrayList<String> applyIdData = zvl.getArrayList("applyIdData");
		for(String applyId : applyIdData)
		{
			zvl.put("applyId", applyId);
			onlineApplyDAO.updateApplicantStatusByApplyId(zvl);
		}
	}

	public void lotteryOnlineApply(ZValue zvl) throws Exception
	{
		zvl.put("status", OnlineApplyService.WAITING_STATUS);
		onlineApplyDAO.updateApplicantStatus(zvl); //초기화
		
		int degree = zvl.getInt("degree");
		if(degree == 1) //선착순
			onlineApplyDAO.lineUpOnlineApply(zvl);
		else if(degree == 2) //무작위
			onlineApplyDAO.lotteryOnlineApply(zvl);
	}

	public Map<String, Object> selectMyOnlineApplyList(ZValue zvl) throws Exception{
		
		List result = onlineApplyDAO.selectMyOnlineApplyList(zvl);
		int cnt = onlineApplyDAO.selectMyOnlineApplyListCnt(zvl);

		zvl.put("totCnt", cnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		return map;
	}

	public void cancelOnlineApply(ZValue zvl) throws Exception
	{
		String applyCode = zvl.getString("applyCode");
		ArrayList<String> applyIdData = zvl.getArrayList("applyIdData");
		for(int i=0; i<applyIdData.size(); i++)
		{
			ZValue paramZvl = new ZValue();
			paramZvl.put("applyId", applyIdData.get(i));
			paramZvl.put("applyCode", applyCode);
			applyDAO.deleteApplyByApplyId(zvl);
		}
	}

	public ZValue getInwon(ZValue zvl) throws Exception{
		return onlineApplyDAO.getInwon(zvl);
	}

	public ZValue selectRecentOnlineApply(String applyCode) throws Exception{
		return onlineApplyDAO.selectRecentOnlineApply(applyCode);
	}
	
}
