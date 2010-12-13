package egovframework.kr.go.geumcheon.health.dao;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("vistorLogDAO")
public class VistorLogDAO  extends EgovAbstractDAO{

	public void insertVisitorLog(ZValue zvl) throws Exception
	{
        insert("visitorLogDAO.insertVisitorLog", zvl);
	}	
	
	public ZValue selectLogCount(ZValue zvl) throws Exception
	{
		return (ZValue)getSqlMapClientTemplate().queryForObject("visitorLogDAO.selectLogCount", zvl);
	}

	public void addLogCount(ZValue zvl) throws Exception
	{
        update("visitorLogDAO.addLogCount", zvl);
	}	
}
