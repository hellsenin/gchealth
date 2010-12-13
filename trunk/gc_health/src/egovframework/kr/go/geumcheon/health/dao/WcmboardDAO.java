package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("wcmboardDAO")
public class WcmboardDAO extends EgovAbstractDAO{

	public ZValue selectWcmboard(ZValue zvl) throws Exception
	{
		return (ZValue)selectByPk("wcmboardDAO.selectWcmboard", zvl);
	}

	public List<ZValue> selectWcmboardList(ZValue zvl) throws Exception
	{
		return list("wcmboardDAO.selectWcmboardList", zvl);
	}

	public int selectWcmboardListCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("wcmboardDAO.selectWcmboardListCnt", zvl);
	}

	public List<ZValue> selectWcmboardFileListByBoardId(ZValue zvl) throws Exception
	{
		return list("wcmboardDAO.selectWcmboardFileListByBoardId", zvl);
	}

	public List<ZValue> selectWcmboardFileList(ZValue zvl) throws Exception
	{
		return list("wcmboardDAO.selectWcmboardFileList", zvl);
	}

	public void updateB0048(ZValue zvl) throws Exception
	{
		update("wcmboardDAO.updateB0048", zvl);
	}

}
