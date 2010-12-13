package egovframework.kr.go.geumcheon.health.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kr.go.geumcheon.health.dao.ZipcodeDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("zipcodeService")
public class ZipcodeService {

	@Resource(name="zipcodeDAO")
	private ZipcodeDAO zipcodeDAO; 

	public List<ZValue> selectAddrList(ZValue zvl) throws Exception
	{
		return zipcodeDAO.selectAddrList(zvl);
	}

	public List<ZValue> selectDongList(ZValue zvl) throws Exception
	{
		return zipcodeDAO.selectDongList(zvl);
	}
}
