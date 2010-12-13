package egovframework.kr.go.geumcheon.health.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ResourceBundle;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

public class FtpClientUtil {

	private String ip = "118.220.42.31";
	private int port = 22;
	private String user = "health_web";
	private String passwd = "health_web";
	private String remoteDir = "/usr/local/health_web/health/open_contents/images/banner";
	private FTPClient client = null;


	private CommonResult loadFtpProperties() {
		final CommonResult result = new CommonResult();

		ResourceBundle resource = ResourceBundle.getBundle("egovframework.egovProps.conf.ftp");
		ip = resource.getString("ip");

		user = resource.getString("user");
		passwd = resource.getString("passwd");
		try {
			port = Integer.parseInt(resource.getString("port"));
		} catch (Exception e) {
			e.printStackTrace();
			result.success = false;
			result.message += "ftp.properties 파일에서 포트번호를 숫자로 읽어오는데 실패했습니다.";
		}
		return result;
	}

	private CommonResult connect() {
//		CommonResult result = new CommonResult();
		CommonResult result = loadFtpProperties();
		if (result.success) {
			try {
				client = new FTPClient();
				client.connect(ip, port);
				client.login(user, passwd);
			} catch (Exception e) {
				e.printStackTrace();
				result.success = false;
				result.message = "서버에 접속하는데 오류가 발생했습니다. : [" + e.getMessage() + "]";
			}
		}
		return result;
	}

	public CommonResult upload(File file) {
		CommonResult result = connect();
		
		try {
			InputStream fis = new FileInputStream(file);
			client.setFileType(FTP.BINARY_FILE_TYPE);
			if(client.storeFile(file.getName(), fis) == true) {
				client.logout();
			} else {
				
			}
		} catch (Exception e) {
			// 일반적인 에러처리나 원하는 내용...
		}
		return result;
	}

	public CommonResult uploadFile(String filename, InputStream in) {
		CommonResult result = connect();

		try {
			
			if(!client.changeWorkingDirectory(remoteDir)) {
				client.makeDirectory(remoteDir);
				client.changeWorkingDirectory(remoteDir);
			}
			
			client.setFileType(FTP.BINARY_FILE_TYPE);
			if(client.storeFile(filename, in)) {
				client.logout();
//				client.disconnect();
			} else {
				
			}
		} catch (Exception e) {
			// 일반적인 에러처리나 원하는 내용...
		}
		return result;
	}
	

	public CommonResult deleteRemoteFile(String fileName) {
		CommonResult result = connect();

		try {
			
			if(!client.changeWorkingDirectory(remoteDir)) {
				client.makeDirectory(remoteDir);
				client.changeWorkingDirectory(remoteDir);
			}
			
			client.setFileType(FTP.BINARY_FILE_TYPE);
			
			if(client.deleteFile(fileName)) {
				client.logout();
//				client.disconnect();
			} else {
				
			}
		} catch (Exception e) {
			// 일반적인 에러처리나 원하는 내용...
		}
		return result;
	}
}
