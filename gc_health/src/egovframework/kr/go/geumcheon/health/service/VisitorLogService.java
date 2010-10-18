package egovframework.kr.go.geumcheon.health.service;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.kr.go.geumcheon.health.dao.VistorLogDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.string.EgovDateUtil;

@Service("visitorLogService")
public class VisitorLogService{

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name="vistorLogDAO")
	private VistorLogDAO vistorLogDAO;
	
	public void insertVisitorLog(ZValue zvl) throws Exception {
		vistorLogDAO.insertVisitorLog(zvl);
	}	

	public ZValue selectLogCount(String siteId) throws Exception {
		String logDate = EgovDateUtil.getCurrentDateAsString();
		ZValue params = new ZValue();
		params.put("siteId", siteId);
		params.put("logDate", logDate);
		return vistorLogDAO.selectLogCount(params);
	}	

	public ZValue addLogCount(String siteId) throws Exception {
		String logDate = EgovDateUtil.getCurrentDateAsString();
		ZValue params = new ZValue();
		params.put("siteId", siteId);
		params.put("logDate", logDate);
		log.debug(params);
		ZValue zvl = vistorLogDAO.selectLogCount(params);
		int dayCount = zvl.getInt("dayCount");
		int totalCount = zvl.getInt("totalCount");
		if(dayCount == 0)
		{
			vistorLogDAO.insertVisitorLog(params);
		}
		else
		{
			vistorLogDAO.addLogCount(params);
		}
		zvl.put("dayCount", ++dayCount);
		zvl.put("totalCount", ++totalCount);
		return zvl;
	}	

}
