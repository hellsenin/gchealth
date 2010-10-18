package egovframework.kr.go.geumcheon.health.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.kr.go.geumcheon.health.dao.MedicalTeamDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("MedicalTeamService")
public class MedicalTeamService {

    Logger log = Logger.getLogger(this.getClass());
    
	@Resource(name="MedicalTeamDAO")
	private MedicalTeamDAO MedicalTeamDAO; 

    @Resource(name = "EgovFileMngUtil")
    protected EgovFileMngUtil fileUtil;
    
	public List<ZValue> selectMedicalTeamList() throws Exception
	{
		return MedicalTeamDAO.selectMedicalTeamList(null);
	}

	public List<ZValue> selectMedicalTeamList(ZValue zvl) throws Exception
	{
		return MedicalTeamDAO.selectMedicalTeamList(zvl);
	}

	public ZValue selectMedicalTeam(int no) throws Exception
	{
		return MedicalTeamDAO.selectMedicalTeam(no);
	}
	
	public void addMedicalTeam(ZValue zvl, Map<String, MultipartFile> files) throws Exception
	{	
		FileVO fileVo = new FileVO();
	    if (!files.isEmpty()) {
			List<FileVO> fileList = fileUtil.parseFileInf(files, "M_", 0, "", "medicalTeam.fileStorePath");
			if(fileList.size() == 1)
				fileVo = fileList.get(0);
	    }
	    
	    String orgImgNm = fileVo.getOrignlFileNm();
	    String imgNm = fileVo.getStreFileNm();
	    
	    zvl.put("orgImgNm", orgImgNm);
	    zvl.put("imgNm", imgNm);
	    	    
	    log.debug(">>>>>>>>>>>zvl : " + zvl);
	    
		MedicalTeamDAO.addMedicalTeam(zvl);
	}
	
	public void updateMedicalTeam(ZValue zvl, Map<String, MultipartFile> files) throws Exception
	{
		FileVO fileVo = new FileVO();
	    if (!files.isEmpty()) {
			List<FileVO> fileList = fileUtil.parseFileInf(files, "M_", 0, "", "medicalTeam.fileStorePath");
			if(fileList.size() == 1)
				fileVo = fileList.get(0);
	    }
	    String orgImgNm = fileVo.getOrignlFileNm();
	    String imgNm = fileVo.getStreFileNm();
	    
	    zvl.put("orgImgNm", orgImgNm);
	    zvl.put("imgNm", imgNm);
	    
		MedicalTeamDAO.updateMedicalTeam(zvl);
	}

	public void deleteMedicalTeam(int no) throws Exception
	{
		MedicalTeamDAO.deleteMedicalTeam(no);
	}


}
