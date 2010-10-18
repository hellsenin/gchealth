package egovframework.kr.go.geumcheon.health.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.DateUtil;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller 
public class BabyScheduleController {

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name="webFactory")
    protected WebFactory WebFactory;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
    Logger log = Logger.getLogger(this.getClass());
    
    /**
     * XSS 방지 처리.
     * 
     * @param data
     * @return
     */
    protected String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }
        
        String ret = data;
        
        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
        
        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
        
        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
        
        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        
        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

        return ret;
    }

    /**
     * 
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/schedule/selectBabySchedule.do")
    public String selectBabySchedule(
    		HttpServletRequest request, 
    		HttpServletResponse response, 
			ModelMap model) throws Exception {
		
    	model.addAttribute("todayYear", DateUtil.getYear());
    	model.addAttribute("todayMonth", DateUtil.getMonth());
    	model.addAttribute("todayDay", DateUtil.getDay());
		model.addAttribute("includePage", "/health/dev_content/babySchedule/List.jsp");
		
		return Globals.HEALTH_MAIN_PAGE;
    }
    
    @RequestMapping("/health/schedule/selectArticleBabySchedule.do")
    public String selectArticleBabySchedule(
    		HttpServletRequest request, 
    		HttpServletResponse response, 
			ModelMap model) throws Exception {
    	
    	String selMonth = request.getParameter("selMonth");
    	if(Integer.parseInt(request.getParameter("selMonth")) < 10 ){
    		selMonth = "0"+request.getParameter("selMonth");
    	}
    	String selDay = request.getParameter("selDay");
    	if(Integer.parseInt(request.getParameter("selDay")) < 10 ){
    		selDay = "0"+request.getParameter("selDay");
    	}
    	
    	String selDate = request.getParameter("selYear")+selMonth+selDay;
    	
    	model.addAttribute("chYear", request.getParameter("selYear"));
    	model.addAttribute("chMonth", request.getParameter("selMonth"));
    	model.addAttribute("chDay", request.getParameter("selDay"));
    	
    	model.addAttribute("tub1", EgovDateUtil.formatDate(selDate,"."));
    	model.addAttribute("tub2", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,1,0),"."));
    	
    	model.addAttribute("heB1", EgovDateUtil.formatDate(selDate,"."));
    	model.addAttribute("heB2", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,1,0),"."));
    	model.addAttribute("heB3", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,6,0),"."));
    	
    	model.addAttribute("dta1", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,2,0),"."));
    	model.addAttribute("dta2", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,4,0),"."));
    	model.addAttribute("dta3", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,6,0),"."));
    	model.addAttribute("dta4", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,15,0),"."));
    	model.addAttribute("dta5", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,19,0),"."));
    	model.addAttribute("dta6", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,4,0,0),"."));
    	model.addAttribute("dta7", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,7,0,0),"."));
    	model.addAttribute("td1", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,11,0,0),"."));
    	model.addAttribute("td2", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,13,0,0),"."));
    	
    	model.addAttribute("pol1", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,4,0),"."));
    	model.addAttribute("pol2", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,5,0),"."));
    	model.addAttribute("pol3", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,6,0),"."));
    	model.addAttribute("pol4", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,4,0,0),"."));
    	model.addAttribute("pol5", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,7,0,0),"."));
    	
    	model.addAttribute("mmr1", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,12,0),"."));
    	model.addAttribute("mmr2", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,16,0),"."));
    	model.addAttribute("mmr3", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,4,0,0),"."));
    	model.addAttribute("mmr4", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,7,0,0),"."));
    	
    	model.addAttribute("jap1", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,12,0),"."));
    	model.addAttribute("jap2", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,36,0),"."));
    	model.addAttribute("jap3", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,37,0),"."));
    	model.addAttribute("jap4", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,6,0,0),"."));
    	model.addAttribute("jap5", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,12,0,0),"."));
    	
    	model.addAttribute("ch1", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,12,0),"."));
    	model.addAttribute("ch2", EgovDateUtil.formatDate(EgovDateUtil.addYearMonthDay(selDate,0,16,0),"."));
    	
    	model.addAttribute("selDate", selDate);
    	model.addAttribute("todayYear", DateUtil.getYear());
		model.addAttribute("includePage", "/health/dev_content/babySchedule/Result.jsp");
		
		return Globals.HEALTH_MAIN_PAGE;
    }

}
