package egovframework.kr.go.geumcheon.health.service;


import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ResourceBundle;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.property.EgovPropertyService;

@Service("FileDownloadService")
public class FileDownloadService {

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	private ResourceBundle property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
	
	
	private String filterFilename(String filename) {
		filename = filename.replaceAll("../", "");
		filename = filename.replaceAll("./", "");
		filename = filename.replaceAll("..%2F", "");
		filename = filename.replaceAll(".%2F", "");
		filename = filename.replaceAll(";", "");
		filename = filename.replaceAll("<", "");
		filename = filename.replaceAll(">", "");
		filename = filename.replaceAll("&", "");
		filename = filename.replaceAll("\t", "");
		
		return filename;
	}

	public void download(HttpServletRequest request, HttpServletResponse response, String key, String filename) throws Exception {
//		printKoreanEncoding(filename);
		if("AIX".equals(System.getProperty("os.name").toString())) {
			filename = new String(filename.getBytes("euc-kr"), "iso-8859-1");
		} else {
			filename = new String(filename.getBytes("utf-8"), "utf-8");
		}
		
		
		File file = null;
		if("AIX".equals(System.getProperty("os.name").toString())) {
			file = new File(propertyService.getString(key+".fileStorePath")+filename);
		} else {
			file = new File(propertyService.getString(key+".fileStorePath")+filename);
		}
		
		filename = filterFilename(filename);
		
		settingHttpResponse(response, filename);
		
		byte buf[] = new byte[1024*1024*10];
		BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
		ServletOutputStream outs = response.getOutputStream();
		
		int read = 0;
		while ((read = fin.read(buf)) != -1) {
			outs.write(buf, 0, read);
		}
		outs.flush();
		outs.close();
	}
	
	
	public void downloadXls(HttpServletResponse response, String key, String xlsFilename) throws Exception {
//		printKoreanEncoding(xlsFilename);
		property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
		if("AIX".equals(System.getProperty("os.name").toString())) {
			xlsFilename = new String(xlsFilename.getBytes("euc-kr"), "iso-8859-1");
		} else {
			xlsFilename = new String(xlsFilename.getBytes("utf-8"), "utf-8");
		}
		File file = null;
		

		if("AIX".equals(System.getProperty("os.name").toString())) {
			file = new File(property.getString(key+".xls.download")+xlsFilename);
		} else {
			file = new File(property.getString(key+".xls.download"+".test")+xlsFilename);
		}
		
		try {
			
		} catch (Exception e) {
		}
		 
		settingHttpResponse(response, xlsFilename);
		byte buf[] = new byte[1024*4];
		BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
		ServletOutputStream outs = response.getOutputStream();
		
		int read = 0;
		while ((read = fin.read(buf)) != -1) {
			outs.write(buf, 0, read);
		}
		outs.flush();
		outs.close();
	}
	
	public void remove(String filename) {
		File file = new File(filename);
		if(file.exists()) {
			file.delete();
		}
	}
	
	private String encodeFilename(String filename) throws Exception {
		return new String(filename.getBytes(), "8859_1");
	}
	
	private void settingHttpResponse(HttpServletResponse response, String filename) throws Exception {
		filename = encodeFilename(filename);
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=" + filename);
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		
		
	}
	
	// 파라메터로 넘어온 파일명을 어떻게 디코딩할것인지 볼때..
	public void printKoreanEncoding(String filename) throws Exception {

		System.out.println(new String(filename.getBytes("utf-8")));
		System.out.println(new String(filename.getBytes("utf-8"), "iso-8859-1"));
		System.out.println(new String(filename.getBytes("utf-8"), "utf-8"));
		System.out.println(new String(filename.getBytes("utf-8"), "euc-kr"));
		
		System.out.println(new String(filename.getBytes("euc-kr")));
		System.out.println(new String(filename.getBytes("euc-kr"), "iso-8859-1"));
		System.out.println(new String(filename.getBytes("euc-kr"), "utf-8"));
		System.out.println(new String(filename.getBytes("euc-kr"), "euc-kr"));
		
		System.out.println(new String(filename.getBytes("iso-8859-1")));
		System.out.println(new String(filename.getBytes("iso-8859-1"), "iso-8859-1"));
		System.out.println(new String(filename.getBytes("iso-8859-1"), "utf-8"));
		System.out.println(new String(filename.getBytes("iso-8859-1"), "euc-kr"));
	}
}
