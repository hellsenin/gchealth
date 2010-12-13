package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("onlineApplyDAO")
public class OnlineApplyDAO  extends EgovAbstractDAO{
	
	public List<ZValue> selectOnlineApplyList(ZValue zvl) throws Exception
	{
		return list("onlineApplyDAO.selectOnlineApplyList", zvl);
	}	

	public List<ZValue> selectAllApplicantList(ZValue zvl) throws Exception
	{
		return list("onlineApplyDAO.selectAllApplicantList", zvl);
	}	

	public List<ZValue> excelApplicantList(ZValue zvl) throws Exception
	{
		return list("onlineApplyDAO.excelApplicantList", zvl);
	}	
	
	public ZValue selectOnlineApply(ZValue zvl) throws Exception
	{
		return (ZValue)selectByPk("onlineApplyDAO.selectOnlineApply", zvl);
	}	
	
	public int selectOnlineApplyCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("onlineApplyDAO.selectOnlineApplyCnt", zvl);
	}	

	public void registOnlineApply(ZValue zvl) throws Exception
	{
		insert("onlineApplyDAO.registOnlineApply", zvl);
	}	

	public void modifyOnlineApply(ZValue zvl) throws Exception
	{
		update("onlineApplyDAO.modifyOnlineApply", zvl);
	}	

	public void delOnlineApply(ZValue zvl) throws Exception
	{
		delete("onlineApplyDAO.delOnlineApply", zvl);
	}

	public void delOnlineApplicant(ZValue zvl) throws Exception
	{
		delete("onlineApplyDAO.delOnlineApplicant", zvl);
	}

	public List<ZValue> selectApplicantList(ZValue zvl) throws Exception
	{
		return list("onlineApplyDAO.selectApplicantList", zvl);
	}	
	
	public int selectApplicantListCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("onlineApplyDAO.selectApplicantListCnt", zvl);
	}	

	public void updateApplicantStatus(ZValue zvl) throws Exception
	{
		update("onlineApplyDAO.updateApplicantStatus", zvl);
	}	

	public void updateApplicantStatusByApplyId(ZValue zvl) throws Exception
	{
		update("onlineApplyDAO.updateApplicantStatusByApplyId", zvl);
	}	

	public void lineUpOnlineApply(ZValue zvl) throws Exception
	{
		update("onlineApplyDAO.lineUpOnlineApply", zvl);
	}	

	public void lotteryOnlineApply(ZValue zvl) throws Exception
	{
		update("onlineApplyDAO.lotteryOnlineApply", zvl);
	}	

	public List<ZValue> selectMyOnlineApplyList(ZValue zvl) throws Exception
	{
		return list("onlineApplyDAO.selectMyOnlineApplyList", zvl);
	}	

	public int selectMyOnlineApplyListCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("onlineApplyDAO.selectMyOnlineApplyListCnt", zvl);
	}	

	public ZValue getInwon(ZValue zvl) throws Exception
	{
		return (ZValue)selectByPk("onlineApplyDAO.getInwon", zvl);
	}

	public ZValue selectRecentOnlineApply(String applyCode) throws Exception
	{
		return (ZValue)selectByPk("onlineApplyDAO.selectRecentOnlineApply", applyCode);
	}	

	public List<ZValue> selectOnlineApplyListByDate(ZValue zvl) throws Exception
	{
		return list("onlineApplyDAO.selectOnlineApplyListByDate", zvl);
	}	

	public List<ZValue> selectEventListByDate(ZValue zvl) throws Exception
	{
		return list("onlineApplyDAO.selectEventListByDate", zvl);
	}	

}
