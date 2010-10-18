package egovframework.kr.go.geumcheon.health.dao;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("metabolicSyndromeDAO")
public class MetabolicSyndromeDAO extends EgovAbstractDAO{

	public ZValue read(String regno) throws Exception
	{
		return (ZValue)selectByPk("metabolicSyndromeDAO.read", regno);
	}

}
