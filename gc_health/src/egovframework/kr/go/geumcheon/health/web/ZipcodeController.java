package egovframework.kr.go.geumcheon.health.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.service.ZipcodeService;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Controller
public class ZipcodeController
{    
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name="zipcodeService")
	private ZipcodeService zipcodeService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@RequestMapping("/health/zipcode/selectAddrList.do")
	public void selectDongList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl" + zvl);

    	List<ZValue> list = zipcodeService.selectAddrList(zvl);
		String jsonValue = ZValue.getArrayJSONValue(list);
		log.debug("jsonValue" + jsonValue);
		
		response.setContentType("application/x-json; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(jsonValue);
				
	}

	@RequestMapping("/health/zipcode/selectDongList.do")
	public void saveSatisfaction(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
		log.debug("zvl" + zvl);

    	List<ZValue> list = zipcodeService.selectDongList(zvl);
		String jsonValue = ZValue.getArrayJSONValue(list);
		log.debug("jsonValue" + jsonValue);
		
		response.setContentType("application/x-json; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(jsonValue);
				
	}
}
