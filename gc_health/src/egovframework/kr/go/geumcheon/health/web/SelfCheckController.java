package egovframework.kr.go.geumcheon.health.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class SelfCheckController {

	Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name = "webFactory")
	protected WebFactory WebFactory;
	
	@RequestMapping(value="/health/selfCheck/checkList.do")
	public String requestForCheckList(
			HttpServletRequest request, 
    		HttpServletResponse response, 
			ModelMap model) {
		
		model.addAttribute("includePage", "/health/dev_content/selfCheck/checkList.jsp");
		
		return Globals.HEALTH_MAIN_PAGE;
	}
	
	@RequestMapping(value="/health/selfCheck/checkResult.do")
	public String requestForCheckResult(
			HttpServletRequest request, 
    		HttpServletResponse response, 
    		ModelMap model) {
		
		ZValue zvl = WebFactory.getAttributes(request);  
		
		String resultTxt = "";
		String resultTxt2 = "";
		
		double d2 = zvl.getInt("q2");
		double d3 = zvl.getInt("q3");

		double sum = 0;
		sum = (d2 * 10000) / (d3 * d3);
		sum = Math.round(sum*10)/10.0;

		if(sum < 18.5){
			resultTxt = "저체중";
			resultTxt2 = "건강상 위험할 수 있으니, 체중을 늘리시기 바랍니다.";
		}else if(18.5 <= sum &&  sum <= 22.9){
			resultTxt = "정상";
			resultTxt2 = "";
		}else if(23 <= sum &&  sum <= 24.9){
			resultTxt = "과체중";
			resultTxt2 = "더 이상 체중증가 시 건강상 위험할 수 있으며 주의하시기 바랍니다.";
		}else if(25 <= sum &&  sum <= 29.9){
			resultTxt = "비만";
			resultTxt2 = "건강상 위험한 수준입니다. 주의하시기 바랍니다.";
		}else if(sum >= 30){
			resultTxt = "고도 비만";
			resultTxt2 = "건강상태가 매우 위험한 수준입니다. 주의하시기 바립니다.";
		}
		
		model.addAttribute("includePage", "/health/dev_content/selfCheck/checkResult.jsp");

		model.addAttribute("resultTxt", resultTxt);
		model.addAttribute("resultTxt2", resultTxt2);
		model.addAttribute("sum", sum);
		
		return Globals.HEALTH_MAIN_PAGE;
	}
}
