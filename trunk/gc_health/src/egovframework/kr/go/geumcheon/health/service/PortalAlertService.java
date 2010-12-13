package egovframework.kr.go.geumcheon.health.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.kr.go.geumcheon.health.dao.PortalAlertDAO;
import egovframework.kr.go.geumcheon.health.vo.PortalAlert;

@Service("PortalAlertService")
public class PortalAlertService {
	
	@Resource(name="PortalAlertDAO")
	private PortalAlertDAO portalAlertDAO;

    @Resource(name = "EgovFileMngUtil")
    protected EgovFileMngUtil fileUtil;
	
	private ResourceBundle property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
	
	public List<PortalAlert> selectList(PortalAlert bean, ModelMap model) {
    	List<PortalAlert> resultMany = new ArrayList<PortalAlert>();
    	int totCnt = 0;
    	try {
    		resultMany = portalAlertDAO.selectList(bean);
    		totCnt = portalAlertDAO.selectListTotCnt(bean);

    		if(resultMany != null) {
        		model.addAttribute("resultList", resultMany);
        		model.addAttribute("resultListSize", totCnt);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}
	
	public List<PortalAlert> selectPublishList(String category) {
		List<PortalAlert> resultMany = new ArrayList<PortalAlert>();
		PortalAlert bean = new PortalAlert();
		bean.setCategory(category);
		
    	try {
    		resultMany = portalAlertDAO.selectPublishList(bean);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}

	
	
    public PortalAlert select(PortalAlert bean, ModelMap model) {
    	PortalAlert resultOne = null;
    	try {
    		resultOne = portalAlertDAO.select(bean, model);

		    String alert_url = EgovStringUtil.replace(resultOne.getAlert_url(), "&amp;", "&");
		    resultOne.setAlert_url(alert_url);
		    			
    		
    		if(resultOne != null) {
    			model.addAttribute("result", resultOne);
    		}
    	} catch (Exception e) {
			e.printStackTrace();
		}
    	return resultOne;
	}
    
    
    public static void main(String[] args) {
    	String[] pattern = new String[] {".*(\\.\\p{Alnum}*)$"
    	};
    	String[] src = new String[] {"aa.java"
    	};
    	int curr_test_idx = 0;
		for (String string : src) {
			Pattern p = Pattern.compile(pattern[curr_test_idx]);
			Matcher m = p.matcher(string);
			if(m.find()) {
				String _match1 = m.group(1);
				String _replace = "";
				switch(curr_test_idx) {
				case 0:
					_replace = string.replace(_match1, ".gif");
				case 1:
					
				}
				System.out.println(_replace);
			} else {
				System.out.println("not found");
			}
		}
		
		System.out.println(new File("../").list()[1]);
	}
    
    public static final String FILE_EXT_REGEX = ".*(\\.\\p{Alnum}*)$";
    
    private String getFileExt(String filename) {
    	Pattern p = Pattern.compile(FILE_EXT_REGEX);
		Matcher m = p.matcher(filename);
		String _match1 = "";
		if(m.find()) {
			_match1 = m.group(1);
			System.out.println(_match1);
		}
		return _match1;
    }
    
	public void insert(PortalAlert bean, Map<String, MultipartFile> files) {
		try {
			int bnr_cd = portalAlertDAO.selectPortalAlertPK();
			bean.setAlert_cd(bnr_cd);

			FileVO fileVo = new FileVO();
		    if (!files.isEmpty()) {
		    	List<FileVO> result = fileUtil.parseFileInf(files, "B_", 0, "", "alert.fileStorePath");
		    	fileVo = result.get(0);
		    }

		    bean.setImg_org_nm(fileVo.getOrignlFileNm());
		    bean.setImg_nm(fileVo.getStreFileNm());
		    
		    String alert_url = EgovStringUtil.replace(bean.getAlert_url(), "&", "&amp;");
		    bean.setAlert_url(alert_url);
		    			
			portalAlertDAO.insert(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void update(PortalAlert bean, Map<String, MultipartFile> files) {
		try {

			FileVO fileVo = new FileVO();
		    if (!files.isEmpty()) {
		    	List<FileVO> result = fileUtil.parseFileInf(files, "B_", 0, "", "alert.fileStorePath");
		    	fileVo = result.get(0);
		    }

		    bean.setImg_org_nm(fileVo.getOrignlFileNm());
		    bean.setImg_nm(fileVo.getStreFileNm());

		    String alert_url = EgovStringUtil.replace(bean.getAlert_url(), "&", "&amp;");
		    bean.setAlert_url(alert_url);
		    			
			portalAlertDAO.update(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void delete(PortalAlert bean) {
		try {
			portalAlertDAO.delete(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
