package egovframework.kr.go.geumcheon.health.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;

import egovframework.kr.go.geumcheon.health.service.CommentService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller 
public class CommentController {

	@Resource(name = "CommentService")
    private CommentService commentService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name="webFactory")
    protected WebFactory WebFactory;

    @Autowired
    private DefaultBeanValidator beanValidator;

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
     * 댓글에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/comment/selectCommentList.do")
    public String selectCommentList(
    		HttpServletRequest request, 
    		HttpServletResponse response, 
    		ModelMap model) throws Exception {
    	
    	UsersVO user = WebFactory.getUserInfo(request);
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	Map<String, Object> map = commentService.selectCommentList(zvl);
    	//int totCnt = Integer.parseInt((String)map.get("resultCnt"));

    	model.addAttribute("resultList", map.get("resultList"));
    	model.addAttribute("resultCnt", map.get("resultCnt"));
	
		return "health/dev_content/com/Comment/CommentList";
	}
    
    /**
     * 댓글에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/comment/insertCommentArticle.do")
    public void insertCommentArticle(
    		HttpServletRequest request, 
    		HttpServletResponse response, 
    		ModelMap model) throws Exception {
    	
    	Company company = WebFactory.getCompanyInfo(request);
    	
    	if(company == null){			  
			String backwardPage = "/health/freecheck/loginPage.do?categoryId=2583";
			if(company == null){
				WebFactory.printHtml(response, (String)model.get("message"), backwardPage);
				return;
			}
    	}

    	ZValue zvl = WebFactory.getAttributes(request);
    	zvl.put("id",company.getId());
    	zvl.put("name",company.getCompany());
    	log.debug(">>>>>>>>>>>>>>>>..zvl : " + zvl);
    	boolean boo = false;
    	if(boo != true){
    		boo = commentService.insertCommentArticle(zvl);
    	}
   		
   		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", 
   				"/health/bbs/selectBoardArticle.do?categoryId="+zvl.getString("categoryId")+
   				"&amp;bbsId="+zvl.getString("bbsId")+"&amp;nttId="+zvl.getString("nttId"));   
	}    

    /**
     * 해당 댓글을 삭제한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/health/comment/deleteCommentArticle.do")
    public void deleteCommentArticle(
    		HttpServletRequest request, 
    		HttpServletResponse response,
    		ModelMap model) throws Exception {

    	Company company = WebFactory.getCompanyInfo(request);
    	if(company == null){			  
			String backwardPage = "/health/freecheck/loginPage.do?categoryId=2583";
			if(company == null){
				WebFactory.printHtml(response, (String)model.get("message"), backwardPage);
				return;
			}
    	}
    	ZValue zvl = WebFactory.getAttributes(request);
    	zvl.put("id",company.getId());
   		commentService.deleteCommentArticle(zvl);

   		WebFactory.printHtml(response, "성공적으로 삭제되었습니다.", 
   				"/health/bbs/selectBoardArticle.do?categoryId="+zvl.getString("categoryId")+
   				"&amp;bbsId="+zvl.getString("bbsId")+"&amp;nttId="+zvl.getString("nttId"));   
	}
    
}
