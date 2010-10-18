package egovframework.kr.go.geumcheon.health.service;

import java.io.File;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import net.sf.jxls.transformer.XLSTransformer;

import org.springframework.stereotype.Service;

@Service("XlsCreateService")
public class XlsCreateService {
	
	

	private ResourceBundle property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
	
	
	public void createXls(String key, String typeNo, List list, String filename) {
		property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
		try {
//			printKoreanEncoding(filename);
			if("AIX".equals(System.getProperty("os.name").toString())) {
				filename = new String(filename.getBytes("euc-kr"), "iso-8859-1");
			} else {
				filename = new String(filename.getBytes("utf-8"), "utf-8");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		final String templateFilename = getTemplateFilename(key, typeNo);
		final String downloadFilename= getDownloadFilename(key, filename);
		Map<String, List> beans = new Hashtable<String, List>();
		beans.put("record", list);
		XLSTransformer transformer = new XLSTransformer();
		try {
			transformer.transformXLS(templateFilename, beans, downloadFilename);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	private String getTemplateFilename(String key, String typeNo) {
		property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
		String filename = "";
		if("AIX".equals(System.getProperty("os.name").toString())) {
			filename = property.getString(key+".xls.template_type"+typeNo);
		} else {
			filename = property.getString(key+".xls.template_type"+typeNo+".test");
		}

		try {
			if("AIX".equals(System.getProperty("os.name").toString())) {
				filename = new String(filename.getBytes("euc-kr"), "iso-8859-1");
			} else {
				filename = new String(filename.getBytes("utf-8"), "utf-8");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		File file = null;
		try {
			if("AIX".equals(System.getProperty("os.name").toString())) {
				file = new File(property.getString(key+".xls.template_type"+typeNo));
			} else {
				file = new File(property.getString(key+".xls.template_type"+typeNo+".test"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return filename;
	}
	
	private String getDownloadFilename(String key, String filenm) {
		property = ResourceBundle.getBundle("egovframework.egovProps.conf.attachfile");
		String filename = "";
		
		if("AIX".equals(System.getProperty("os.name").toString())) {
			filename = property.getString(key+".xls.download")+filenm;
		} else {
			filename = property.getString(key+".xls.download"+".test")+filenm;
		}
		return filename;
	}
	
	
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
