package egovframework.kr.go.geumcheon.health.util;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

public class FileUtil {
	
    private Logger log = Logger.getLogger(this.getClass());
    
    private FtpClientUtil ftpClient = new FtpClientUtil();
    

    public CommonResult uploadFtp(Map<String, MultipartFile> files, String filename) {
    	CommonResult result = new CommonResult();
    	try {
			Iterator<Entry<String, MultipartFile>> iter = files.entrySet().iterator();
			MultipartFile file;
			
			while (iter.hasNext()) {
			    Entry<String, MultipartFile> entry = iter.next();
		
			    file = entry.getValue();
			    String orginFileName = file.getOriginalFilename();
			    
			    if (!"".equals(orginFileName)) {
					result = ftpClient.uploadFile(filename, file.getInputStream());
			    }
			}
    	} catch (Exception e) {
    		result.success = false;
    		result.message += "첨부파일을 처리하는데 오류가 발생했습니다 : [" + e.getMessage() +"]";
		}
    	
		return result;
    }
    

    public CommonResult deleteFtp(String filename) {
    	CommonResult result = new CommonResult();
    	try {
    		result = ftpClient.deleteRemoteFile(filename);
    	} catch (Exception e) {
    		result.success = false;
    		result.message += "첨부파일을 삭제하는데 오류가 발생했습니다 : [" + e.getMessage() +"]";
		}
    	
		return result;
    }
    

//  public static void main(String[] args) throws Exception {
//  	FtpClientUtil ftpClient = FtpClientUtil.getInstance();
//  	CommonResult result = ftpClient.upload(new File("c:/dir.txt"));
//  	System.out.println(result);
//	}
      
}
