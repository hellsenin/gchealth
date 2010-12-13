/**
 * 
 * 
 * @author 김명구
 * @since 2010. 1. 21.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      	수정자      	수정내용
 *  -------    		--------    --------------------------
 *   2010. 1. 21.  김명구      	최초 생성
 *
 * Copyright (C) 2010 by MOPAS  All right reserved.
 * </pre>
 */


package egovframework.kr.go.geumcheon.health.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.kr.go.geumcheon.health.dao.BannerDAO;
import egovframework.kr.go.geumcheon.health.util.FileUtil;
import egovframework.kr.go.geumcheon.health.vo.Banner;


@Service("BannerService")
public class BannerService {
	
	@Resource(name="BannerDAO")
	private BannerDAO bannerDAO;

    @Resource(name = "EgovFileMngUtil")
    protected EgovFileMngUtil fileUtil;
    
	private FileUtil fileutil = new FileUtil();
	
	public List<Banner> selectList(Banner bean, ModelMap model) {
    	List<Banner> resultMany = new ArrayList<Banner>();
    	int totCnt = 0;
    	try {
    		resultMany = bannerDAO.selectList(bean);
    		totCnt = bannerDAO.selectListTotCnt(bean);

    		if(resultMany != null) {
        		model.addAttribute("resultList", resultMany);
        		model.addAttribute("resultListSize", totCnt);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}
	
	public List<List<Banner>> selectPublishList(Banner param) {
		List<List<Banner>> resultMany = new ArrayList<List<Banner>>();
    	
    	try {
    		List<Banner> result = bannerDAO.selectPublishList(param);
    		
    		List<Banner> cols = null;
    		for(int i=0; i<result.size(); i++) {
    			if(i % param.visible_cnt == 0) {
    				cols = new ArrayList<Banner>();
    				resultMany.add(cols);
    			}
    			cols.add(result.get(i));
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}
	
    public Banner select(Banner bean, ModelMap model) {
    	Banner resultOne = null;
    	try {
    		resultOne = bannerDAO.select(bean, model);
    		
    		if(resultOne != null) {
    			model.addAttribute("result", resultOne);
    		}
    	} catch (Exception e) {
			e.printStackTrace();
		}
    	return resultOne;
	}
    
	public void insert(Banner bean, Map<String, MultipartFile> files) {
		try {
			int bnr_cd = bannerDAO.selectBannerPK();
			bean.setBnr_cd(bnr_cd);

			FileVO fileVo = null;
		    if (!files.isEmpty()) {
		    	List<FileVO> result = fileUtil.parseFileInf(files, "B_", 0, "", "Bannser.fileStorePath");
		    	fileVo = result.get(0);
		    }
		    
		    bean.setBnr_img_org_nm(fileVo.getOrignlFileNm());
		    bean.setBnr_img_nm(fileVo.getStreFileNm());
		    
			bannerDAO.insert(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void update(Banner bean, Map<String, MultipartFile> files) {
		try {
			
			FileVO fileVo = null;
		    if (!files.isEmpty()) {
		    	List<FileVO> result = fileUtil.parseFileInf(files, "B_", 0, "", "Bannser.fileStorePath");
		    	fileVo = result.get(0);

			    bean.setBnr_img_org_nm(fileVo.getOrignlFileNm());
			    bean.setBnr_img_nm(fileVo.getStreFileNm());
		    }		    
			bannerDAO.update(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void delete(Banner bean) {
		try {
			bannerDAO.delete(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
