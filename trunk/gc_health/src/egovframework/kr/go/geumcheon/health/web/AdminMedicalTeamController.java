package egovframework.kr.go.geumcheon.health.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.kr.go.geumcheon.health.service.MedicalTeamService;
import egovframework.kr.go.geumcheon.health.service.WebFactory;
import egovframework.kr.go.geumcheon.health.util.PageUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminMedicalTeamController
{    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name="MedicalTeamService")
	private MedicalTeamService medicalTeamService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

    @Resource(name = "pageUtil")
    protected PageUtil PageUtil;

	@RequestMapping("/admin/health/medicalTeam/selectMedicalTeamList.do")
	public String selectMedicalTeamList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	model.addAttribute("resultList", medicalTeamService.selectMedicalTeamList());    	
		return "admin/health/medicalTeam/selectMedicalTeamList";
				
	}

	@RequestMapping("/admin/health/medicalTeam/selectMedicalTeam.do")
	public String selectMedicalTeam(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	model.addAttribute("result", medicalTeamService.selectMedicalTeam(zvl.getInt("no")));
    	
		return "admin/health/medicalTeam/selectMedicalTeam";
				
	}

	@RequestMapping("/admin/health/medicalTeam/addMedicalTeamPage.do")
	public String addMedicalTeamPage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
		return "admin/health/medicalTeam/addMedicalTeam";				
	}

	@RequestMapping("/admin/health/medicalTeam/addMedicalTeam.do")
	public void addMedicalTeam(
			MultipartHttpServletRequest multiRequest, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(multiRequest);

	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
    	medicalTeamService.addMedicalTeam(zvl, files);
    	
		WebFactory.printHtml(response, "성공적으로 등록되었습니다.", "/admin/health/medicalTeam/selectMedicalTeamList.do");
				
	}

	@RequestMapping("/admin/health/medicalTeam/updateMedicalTeamPage.do")
	public String updateMedicalTeamPage(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	model.addAttribute("result", medicalTeamService.selectMedicalTeam(zvl.getInt("no")));

		return "admin/health/medicalTeam/addMedicalTeam";		
				
	}

	@RequestMapping("/admin/health/medicalTeam/updateMedicalTeam.do")
	public void updateMedicalTeam(
			MultipartHttpServletRequest multiRequest, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(multiRequest);

	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
    	medicalTeamService.updateMedicalTeam(zvl, files);
    	
		WebFactory.printHtml(response, "성공적으로 수정되었습니다.", "/admin/health/medicalTeam/selectMedicalTeamList.do");
				
	}

	@RequestMapping("/admin/health/medicalTeam/delMedicalTeam.do")
	public void delMedicalTeam(
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

    	medicalTeamService.deleteMedicalTeam(zvl.getInt("no"));
    	
		WebFactory.printHtml(response, "성공적으로 삭제되었습니다.", "/admin/health/medicalTeam/selectMedicalTeamList.do");
				
	}
}
