package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("satisfactionDAO")
public class SatisfactionDAO extends EgovAbstractDAO{

	public void saveSatisfaction(ZValue zvl) throws Exception
	{	
		insert("satisfactionDAO.saveSatisfaction", zvl);
	}
	
	public int existsUserIp(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("satisfactionDAO.existsUserIp", zvl);
	}

	public int selectSatisfactionCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("satisfactionDAO.selectSatisfactionCnt", zvl);
	}

	public List<ZValue> selectSatisfactionList(ZValue zvl) throws Exception
	{
		return list("satisfactionDAO.selectSatisfactionList", zvl);
	}
}
