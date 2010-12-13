package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("applyMstDAO")
public class ApplyMstDAO extends EgovAbstractDAO{

	public void addApplyMst(ZValue zvl) throws Exception
	{
		insert("applyMstDAO.addApplyMst", zvl);
	}

	public void modifyApplyMst(ZValue zvl) throws Exception
	{
		update("applyMstDAO.modifyApplyMst", zvl);
	}

	public ZValue selectApplyMst(String applyCode) throws Exception
	{
		return (ZValue)selectByPk("applyMstDAO.selectApplyMst", applyCode);
	}

	public int selectApplyMstListCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("applyMstDAO.selectApplyMstListCnt", zvl);
	}

	public List<ZValue> selectApplyMstList(ZValue zvl) throws Exception
	{
		return list("applyMstDAO.selectApplyMstList", zvl);
	}

}
