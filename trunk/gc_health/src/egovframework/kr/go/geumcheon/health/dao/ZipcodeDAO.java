package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("zipcodeDAO")
public class ZipcodeDAO extends EgovAbstractDAO{

	public List<ZValue> selectAddrList(ZValue zvl) throws Exception
	{
		return list("zipcodeDAO.selectAddrList", zvl);
	}

	public List<ZValue> selectDongList(ZValue zvl) throws Exception
	{
		return list("zipcodeDAO.selectDongList", zvl);
	}
}
