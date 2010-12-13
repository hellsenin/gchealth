package egovframework.com.cmm.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.EBookFileVO;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.utl.fcc.service.EgovStringUtil;

/**
 * @Class Name : EgovImageProcessController.java
 * @Description : 
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 4. 2.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 4. 2.
 * @version
 * @see
 *
 * Copyright (c) 2008 by MOPAS  All right reserved
 */
@SuppressWarnings("serial")
@Controller
public class EgovImageProcessController extends HttpServlet {

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;
    
    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;   

    Logger log = Logger.getLogger(this.getClass());

    /**
     * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
     * 
     * @param atchFileId
     * @param fileSn
     * @param sessionVO
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/getImage.do")
    public void getImageInf(ModelMap model, Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

	//@RequestParam("atchFileId") String atchFileId,
	//@RequestParam("fileSn") String fileSn,
	String atchFileId = (String)commandMap.get("atchFileId");
	String fileSn = (String)commandMap.get("fileSn");

	FileVO vo = new FileVO();

	vo.setAtchFileId(atchFileId);
	vo.setFileSn(fileSn);

	FileVO fvo = fileService.selectFileInf(vo);

	//String fileLoaction = fvo.getFileStreCours() + fvo.getStreFileNm();

	File file = new File(fvo.getFileStreCours().replaceAll(" ", ""), fvo.getStreFileNm());
	FileInputStream fis = new FileInputStream(file);

	BufferedInputStream in = new BufferedInputStream(fis);
	ByteArrayOutputStream bStream = new ByteArrayOutputStream();

	int imgByte;
	while ((imgByte = in.read()) != -1) {
	    bStream.write(imgByte);
	}
	in.close();

	String type = "";

	if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
	    if ("jpg".equals(EgovStringUtil.lowerCase(fvo.getFileExtsn()))) {
		type = "image/jpeg"; //TODO 정말 이런걸까?
	    } else {
		type = "image/" + EgovStringUtil.lowerCase(fvo.getFileExtsn());
	    }
	    type = "image/" + EgovStringUtil.lowerCase(fvo.getFileExtsn());

	} else {
	    //log.debug("Image fileType is null.");
	}

	response.setHeader("Content-Type", type);
	response.setContentLength(bStream.size());
	
	bStream.writeTo(response.getOutputStream());
	
	response.getOutputStream().flush();
	response.getOutputStream().close();

    }
    
    /**
     * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
     * 
     * @param atchFileId
     * @param fileSn
     * @param sessionVO
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/getEBookImage.do")
    public void getEBookImageInf(ModelMap model, Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

	String atchFileId = (String)commandMap.get("piSeq");

	EBookFileVO vo = new EBookFileVO();

	vo.setPfPiSeq(Integer.parseInt(atchFileId));

	EBookFileVO fvo = bbsMngService.selectEBookFileArticle(vo);

	//String fileLoaction = fvo.getFileStreCours() + fvo.getStreFileNm();

	File file = new File(fvo.getPfPath(), fvo.getPfStreName());
	FileInputStream fis = new FileInputStream(file);

	BufferedInputStream in = new BufferedInputStream(fis);
	ByteArrayOutputStream bStream = new ByteArrayOutputStream();

	int imgByte;
	while ((imgByte = in.read()) != -1) {
	    bStream.write(imgByte);
	}
	in.close();

	String type = "";

	if (fvo.getPfExtsn() != null && !"".equals(fvo.getPfExtsn())) {
	    if ("jpg".equals(EgovStringUtil.lowerCase(fvo.getPfExtsn()))) {
		type = "image/jpeg"; //TODO 정말 이런걸까?
	    } else {
		type = "image/" + EgovStringUtil.lowerCase(fvo.getPfExtsn());
	    }
	    type = "image/" + EgovStringUtil.lowerCase(fvo.getPfExtsn());

	} else {
	    //log.debug("Image fileType is null.");
	}

	response.setHeader("Content-Type", type);
	response.setContentLength(bStream.size());
	
	bStream.writeTo(response.getOutputStream());
	
	response.getOutputStream().flush();
	response.getOutputStream().close();

    }
}
