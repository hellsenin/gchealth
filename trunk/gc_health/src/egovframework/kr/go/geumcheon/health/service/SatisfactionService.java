package egovframework.kr.go.geumcheon.health.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kr.go.geumcheon.health.dao.SatisfactionDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("satisfactionService")
public class SatisfactionService {

	@Resource(name="satisfactionDAO")
	private SatisfactionDAO satisfactionDAO; 
	
	public void saveSatisfaction(ZValue zvl) throws Exception {
		satisfactionDAO.saveSatisfaction(zvl);
	}
	
	public int existsUserIp(ZValue zvl) throws Exception {
		return satisfactionDAO.existsUserIp(zvl);
	}

	public Map<String, Object> selectSatisfactionList(ZValue zvl) throws Exception{
		
		List<ZValue> resultList = satisfactionDAO.selectSatisfactionList(zvl);
		int cnt = satisfactionDAO.selectSatisfactionCnt(zvl);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", resultList);
		map.put("resultCnt", Integer.toString(cnt));
		return map;
	}

}
