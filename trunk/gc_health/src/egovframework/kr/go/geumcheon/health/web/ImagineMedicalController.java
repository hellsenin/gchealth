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
public class ImagineMedicalController {

    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;


	@Resource(name = "webFactory")
	protected WebFactory WebFactory;


	@RequestMapping("/health/imagene/selectImagineMedical.do")
	public String selectOnlineApplyCalendar(
			HttpServletRequest request,
			HttpServletResponse response,	
			ModelMap model) throws Exception
	{		
    	ZValue zvl = WebFactory.getAttributes(request);  
		
    	int tot1 = zvl.getInt("intIssue") + zvl.getInt("etcAntiissue") + zvl.getInt("intPri")
    		+ zvl.getInt("phyPri") + zvl.getInt("phyThe") + zvl.getInt("phyIssue")
    		+ zvl.getInt("denIssue") + zvl.getInt("denHan") + zvl.getInt("denChi")
    		+ zvl.getInt("babyHc") + zvl.getInt("babyVac") + zvl.getInt("etcHep")
    		+ zvl.getInt("etcAnti") + zvl.getInt("etcXfilm") + zvl.getInt("etcX");
    	
    	int tot2 = zvl.getInt("tempEnc3") + zvl.getInt("tempEnc") + zvl.getInt("tempHeb")
		+ zvl.getInt("tempHebc") + zvl.getInt("tempEpi") + zvl.getInt("tempTyp")
		+ zvl.getInt("tempTyp2") + zvl.getInt("tempInf") + zvl.getInt("phySheet")
		+ zvl.getInt("foreSheet") + zvl.getInt("phyNote") + zvl.getInt("healthPro")
		+ zvl.getInt("strExa") + zvl.getInt("checkup") + zvl.getInt("chnSt")
		+ zvl.getInt("chnMed");

    	
    	model.addAttribute("zvl", zvl); 
    	model.addAttribute("tot1", tot1);
    	model.addAttribute("tot2", tot2);
    	model.addAttribute("tot3", tot1+tot2);
		String includePage = "/health/dev_content/imagineMedical/result.jsp";
		model.addAttribute("includePage", includePage);
		return Globals.HEALTH_MAIN_PAGE;
	}

}
