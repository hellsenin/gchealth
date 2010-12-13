package egovframework.kr.go.geumcheon.health.vo;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;


public class MinwonFileVO implements Serializable {

	private long fileId = 0L;
	
	private long applyId = 0L;
	
	private long answerId = 0L;
	
	private String filePath = "";

	private String fileName = "";

	private String orgFileName = "";

	private String fileExt = "";

	private int fileSize;
	
	private String applyCode = "";

	private String fileFieldName = "";
	
	

	public String getFileFieldName() {
		return fileFieldName;
	}



	public void setFileFieldName(String fileFieldName) {
		this.fileFieldName = fileFieldName;
	}



	public String getApplyCode() {
		return applyCode;
	}



	public void setApplyCode(String applyCode) {
		this.applyCode = applyCode;
	}



	public long getFileId() {
		return fileId;
	}



	public void setFileId(long fileId) {
		this.fileId = fileId;
	}



	public long getApplyId() {
		return applyId;
	}



	public void setApplyId(long applyId) {
		this.applyId = applyId;
	}



	public long getAnswerId() {
		return answerId;
	}



	public void setAnswerId(long answerId) {
		this.answerId = answerId;
	}



	public String getFilePath() {
		return filePath;
	}



	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}



	public String getFileName() {
		return fileName;
	}



	public void setFileName(String fileName) {
		this.fileName = fileName;
	}



	public String getOrgFileName() {
		return orgFileName;
	}



	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}



	public String getFileExt() {
		return fileExt;
	}



	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}



	public int getFileSize() {
		return fileSize;
	}



	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}



	public String toString()
	{
		return ToStringBuilder.reflectionToString(this);
	}
}
