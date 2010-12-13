package egovframework.com.cop.bbs.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name  : Board.java
 * @Description : 게시물에 대한 데이터 처리 모델
 * @Modification Information
 * 
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.03.06       이삼섭                  최초 생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see 
 * 
 *  Copyright (C) 2008 by MOPAS  All right reserved.
 */
@SuppressWarnings("serial")
public class Board implements Serializable {

	/**
	 * 게시물 첨부파일 아이디
	 */
	private String atchFileId = "";
	/**
	 * 게시판 아이디
	 */
	private String bbsId = "";
	/**
	 * 최초등록자 아이디
	 */
	private String frstRegisterId = "";
	/**
	 * 최초등록시점
	 */
	private String frstRegisterPnttm = "";
	/**
	 * 최종수정자 아이디
	 */
	private String lastUpdusrId = "";
	/**
	 * 최종수정시점
	 */
	private String lastUpdusrPnttm = "";
	/**
	 * 게시시작일
	 */
	private String ntceBgnde = "";
	/**
	 * 게시종료일
	 */
	private String ntceEndde = "";
	/**
	 * 게시자 아이디
	 */
	private String ntcrId = "";
	/**
	 * 게시자명
	 */
	private String ntcrNm = "";
	/**
	 * 게시물 내용
	 */
	private String nttCn = "";
	/**
	 * 게시물 아이디
	 */
	private long nttId = 0L;
	/**
	 * 게시물 번호
	 */
	private long nttNo = 0L;
	/**
	 * 게시물 제목
	 */
	private String nttSj = "";
	/**
	 * 부모글번호
	 */
	private String parnts = "0";
	/**
	 * 패스워드
	 */
	private String password = "";
	/**
	 * 조회수
	 */
	private int inqireCo = 0;
	/**
	 * 답장여부
	 */
	private String replyAt = "";
	/**
	 * 답장위치
	 */
	private String replyLc = "0";
	/**
	 * 정렬순서
	 */
	private long sortOrdr = 0L;
	/**
	 * 사용여부
	 */
	private String useAt = "";
	/**
	 * 게시 종료일
	 */
	private String ntceEnddeView = ""; 
	/**
	 * 게시 시작일
	 */
	private String ntceBgndeView = "";
	
    /** 삭제코드 */
    private String delCode = "";
    
    /** 비밀글여부 */
    private String secret = "";    
    
    /** 업로드 */
	private List file = new ArrayList();				
	
	/** 파일 수 */
	private int fileCount = 0;								
	
	/** 삭제파일 번호 */
	private String delFileIdx = "";							
	
	/** 업로드 파일정보 */
	private String fileInfo = "";									
	
	/**
	 * 실명인증 중복키 값
	 */
	private String pinNo = "";
	/**
	 * 성명
	 */
	private String pinName = "";
	/**
	 * 이메일
	 */
	private String pinEmail = "";
	/**
	 * 전화번호
	 */
	private String telePhone = "";
	/**
	 * 핸드폰
	 */
	private String cellPhone = "";
	
	/**
	 * 주소
	 */
	private String pinAddr = "";
	
	/**
	 * 주소2
	 */
	private String pinAddr2 = "";
	
	/**
	 * 등록일
	 */
	private String regDate = "";
	
	/**
	 * 옵션1
	 */
	private String option1 = "";    	

	/**
	 * 옵션2
	 */
	private String option2 = "";
	
	/**
	 * 옵션3
	 */
	private String option3 = "";
	
	/**
	 * 옵션4
	 */
	private String option4 = "";
	
	/**
	 * 옵션5
	 */
	private String option5 = "";
	
	/**
	 * 옵션6
	 */
	private String option6 = "";
	
	/**
	 * 옵션7
	 */
	private String option7 = "";
	
	/**
	 * 옵션8
	 */
	private String option8 = "";
	
	/**
	 * 옵션9
	 */
	private String option9 = "";
	
	/**
	 * 옵션10
	 */
	private String option10 = "";	
	
	/**
	 * 옵션11
	 */
	private String option11 = "";    	

	/**
	 * 옵션12
	 */
	private String option12 = "";
	
	/**
	 * 옵션13
	 */
	private String option13 = "";
	
	/**
	 * 옵션14
	 */
	private String option14 = "";
	
	/**
	 * 옵션15
	 */
	private String option15 = "";
	
	/**
	 * 옵션16
	 */
	private String option16 = "";
	
	/**
	 * 옵션17
	 */
	private String option17 = "";
	
	/**
	 * 옵션18
	 */
	private String option18 = "";
	
	/**
	 * 옵션19
	 */
	private String option19 = "";
	
	/**
	 * 옵션20
	 */
	private String option20 = "";
	
	/**
	 * 부서코드
	 */
	private String dept = "";	

	/**
	 * 동주민센터코드
	 */
	private String dong = "";
	
	/**
	 * 첨부파일명
	 */
	private String fileNm = "";

	private String optionCnd = "";
	
	private String optionWrd = "";
	
	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}
	
	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	
	/**
	 * atchFileId attribute를 리턴한다.
	 * @return the atchFileId
	 */
	public String getAtchFileId() {
		return atchFileId;
	}

	/**
	 * atchFileId attribute 값을 설정한다.
	 * @param atchFileId the atchFileId to set
	 */
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	/**
	 * bbsId attribute를 리턴한다.
	 * @return the bbsId
	 */
	public String getBbsId() {
		return bbsId;
	}

	/**
	 * bbsId attribute 값을 설정한다.
	 * @param bbsId the bbsId to set
	 */
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}

	/**
	 * frstRegisterId attribute를 리턴한다.
	 * @return the frstRegisterId
	 */
	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	/**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId the frstRegisterId to set
	 */
	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	/**
	 * frstRegisterPnttm attribute를 리턴한다.
	 * @return the frstRegisterPnttm
	 */
	public String getFrstRegisterPnttm() {
		return frstRegisterPnttm;
	}

	/**
	 * frstRegisterPnttm attribute 값을 설정한다.
	 * @param frstRegisterPnttm the frstRegisterPnttm to set
	 */
	public void setFrstRegisterPnttm(String frstRegisterPnttm) {
		this.frstRegisterPnttm = frstRegisterPnttm;
	}

	/**
	 * lastUpdusrId attribute를 리턴한다.
	 * @return the lastUpdusrId
	 */
	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	/**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId the lastUpdusrId to set
	 */
	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	/**
	 * lastUpdusrPnttm attribute를 리턴한다.
	 * @return the lastUpdusrPnttm
	 */
	public String getLastUpdusrPnttm() {
		return lastUpdusrPnttm;
	}

	/**
	 * lastUpdusrPnttm attribute 값을 설정한다.
	 * @param lastUpdusrPnttm the lastUpdusrPnttm to set
	 */
	public void setLastUpdusrPnttm(String lastUpdusrPnttm) {
		this.lastUpdusrPnttm = lastUpdusrPnttm;
	}

	/**
	 * ntceBgnde attribute를 리턴한다.
	 * @return the ntceBgnde
	 */
	public String getNtceBgnde() {
		return ntceBgnde;
	}

	/**
	 * ntceBgnde attribute 값을 설정한다.
	 * @param ntceBgnde the ntceBgnde to set
	 */
	public void setNtceBgnde(String ntceBgnde) {
		this.ntceBgnde = ntceBgnde;
	}

	/**
	 * ntceEndde attribute를 리턴한다.
	 * @return the ntceEndde
	 */
	public String getNtceEndde() {
		return ntceEndde;
	}

	/**
	 * ntceEndde attribute 값을 설정한다.
	 * @param ntceEndde the ntceEndde to set
	 */
	public void setNtceEndde(String ntceEndde) {
		this.ntceEndde = ntceEndde;
	}

	/**
	 * ntcrId attribute를 리턴한다.
	 * @return the ntcrId
	 */
	public String getNtcrId() {
		return ntcrId;
	}

	/**
	 * ntcrId attribute 값을 설정한다.
	 * @param ntcrId the ntcrId to set
	 */
	public void setNtcrId(String ntcrId) {
		this.ntcrId = ntcrId;
	}

	/**
	 * ntcrNm attribute를 리턴한다.
	 * @return the ntcrNm
	 */
	public String getNtcrNm() {
		return ntcrNm;
	}

	/**
	 * ntcrNm attribute 값을 설정한다.
	 * @param ntcrNm the ntcrNm to set
	 */
	public void setNtcrNm(String ntcrNm) {
		this.ntcrNm = ntcrNm;
	}

	/**
	 * nttCn attribute를 리턴한다.
	 * @return the nttCn
	 */
	public String getNttCn() {
		return nttCn;
	}

	/**
	 * nttCn attribute 값을 설정한다.
	 * @param nttCn the nttCn to set
	 */
	public void setNttCn(String nttCn) {
		this.nttCn = nttCn;
	}

	/**
	 * nttId attribute를 리턴한다.
	 * @return the nttId
	 */
	public long getNttId() {
		return nttId;
	}

	/**
	 * nttId attribute 값을 설정한다.
	 * @param nttId the nttId to set
	 */
	public void setNttId(long nttId) {
		this.nttId = nttId;
	}

	/**
	 * nttNo attribute를 리턴한다.
	 * @return the nttNo
	 */
	public long getNttNo() {
		return nttNo;
	}

	/**
	 * nttNo attribute 값을 설정한다.
	 * @param nttNo the nttNo to set
	 */
	public void setNttNo(long nttNo) {
		this.nttNo = nttNo;
	}

	/**
	 * nttSj attribute를 리턴한다.
	 * @return the nttSj
	 */
	public String getNttSj() {
		return nttSj;
	}

	/**
	 * nttSj attribute 값을 설정한다.
	 * @param nttSj the nttSj to set
	 */
	public void setNttSj(String nttSj) {
		this.nttSj = nttSj;
	}

	/**
	 * parnts attribute를 리턴한다.
	 * @return the parnts
	 */
	public String getParnts() {
		return parnts;
	}

	/**
	 * parnts attribute 값을 설정한다.
	 * @param parnts the parnts to set
	 */
	public void setParnts(String parnts) {
		this.parnts = parnts;
	}

	/**
	 * password attribute를 리턴한다.
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * password attribute 값을 설정한다.
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * inqireCo attribute를 리턴한다.
	 * @return the inqireCo
	 */
	public int getInqireCo() {
		return inqireCo;
	}

	/**
	 * inqireCo attribute 값을 설정한다.
	 * @param inqireCo the inqireCo to set
	 */
	public void setInqireCo(int inqireCo) {
		this.inqireCo = inqireCo;
	}

	/**
	 * replyAt attribute를 리턴한다.
	 * @return the replyAt
	 */
	public String getReplyAt() {
		return replyAt;
	}

	/**
	 * replyAt attribute 값을 설정한다.
	 * @param replyAt the replyAt to set
	 */
	public void setReplyAt(String replyAt) {
		this.replyAt = replyAt;
	}

	/**
	 * replyLc attribute를 리턴한다.
	 * @return the replyLc
	 */
	public String getReplyLc() {
		return replyLc;
	}

	/**
	 * replyLc attribute 값을 설정한다.
	 * @param replyLc the replyLc to set
	 */
	public void setReplyLc(String replyLc) {
		this.replyLc = replyLc;
	}

	/**
	 * sortOrdr attribute를 리턴한다.
	 * @return the sortOrdr
	 */
	public long getSortOrdr() {
		return sortOrdr;
	}

	/**
	 * sortOrdr attribute 값을 설정한다.
	 * @param sortOrdr the sortOrdr to set
	 */
	public void setSortOrdr(long sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	/**
	 * useAt attribute를 리턴한다.
	 * @return the useAt
	 */
	public String getUseAt() {
		return useAt;
	}

	/**
	 * useAt attribute 값을 설정한다.
	 * @param useAt the useAt to set
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	/**
	 * ntceEnddeView attribute를 리턴한다.
	 * @return the ntceEnddeView
	 */
	public String getNtceEnddeView() {
		return ntceEnddeView;
	}

	/**
	 * ntceEnddeView attribute 값을 설정한다.
	 * @param ntceEnddeView the ntceEnddeView to set
	 */
	public void setNtceEnddeView(String ntceEnddeView) {
		this.ntceEnddeView = ntceEnddeView;
	}

	/**
	 * ntceBgndeView attribute를 리턴한다.
	 * @return the ntceBgndeView
	 */
	public String getNtceBgndeView() {
		return ntceBgndeView;
	}

	/**
	 * ntceBgndeView attribute 값을 설정한다.
	 * @param ntceBgndeView the ntceBgndeView to set
	 */
	public void setNtceBgndeView(String ntceBgndeView) {
		this.ntceBgndeView = ntceBgndeView;
	}

    /**
     * delCode attribute를 리턴한다.
     * 
     * @return the delCode
     */
    public String getDelCode() {
	return delCode;
    }

    /**
     * delCode attribute 값을 설정한다.
     * 
     * @param delCode
     *            the delCode to set
     */
    public void setDelCode(String delCode) {
	this.delCode = delCode;
    }
    
    /**
     * secret attribute를 리턴한다.
     * 
     * @return the secret
     */
    public String getSecret() {
	return secret;
    }

    /**
     * secret attribute 값을 설정한다.
     * 
     * @param secret
     *            the secret to set
     */
    public void setSecret(String secret) {
	this.secret = secret;
    }
    
    /**
     * file attribute를 리턴한다.
     * 
     * @return the file
     */
	public List getFile() {
		return file;
	}
	
    /**
     * file attribute 값을 설정한다.
     * 
     * @param file
     *            the file to set
     */
	public void setFile(List file) {
		this.file = file;
	}
	
    /**
     * delFileIdx attribute를 리턴한다.
     * 
     * @return the delFileIdx
     */
	public String getDelFileIdx() {
		return delFileIdx;
	}
	
    /**
     * delFileIdx attribute 값을 설정한다.
     * 
     * @param delFileIdx
     *            the delFileIdx to set
     */
	public void setDelFileIdx(String delFileIdx) {
		this.delFileIdx = delFileIdx;
	}
	
    /**
     * fileInfo attribute를 리턴한다.
     * 
     * @return the fileInfo
     */
	public String getFileInfo() {
		return fileInfo;
	}
	
    /**
     * fileInfo attribute 값을 설정한다.
     * 
     * @param fileInfo
     *            the fileInfo to set
     */
	public void setFileInfo(String fileInfo) {
		this.fileInfo = fileInfo;
	}
	
    /**
     * fileCount attribute를 리턴한다.
     * 
     * @return the fileCount
     */
	public int getFileCount() {
		return fileCount;
	}
	
    /**
     * fileCount attribute 값을 설정한다.
     * 
     * @param fileCount
     *            the fileCount to set
     */
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}    
    
	/**
	 * pinNo attribute를 리턴한다.
	 * @return the pinNo
	 */
	public String getPinNo() {
		return pinNo;
	}

	/**
	 * pinNo attribute 값을 설정한다.
	 * @param pinNo the pinNo to set
	 */
	public void setPinNo(String pinNo) {
		this.pinNo = pinNo;
	}

	/**
	 * pinName attribute를 리턴한다.
	 * @return the bbsId
	 */
	public String getPinName() {
		return pinName;
	}

	/**
	 * pinName attribute 값을 설정한다.
	 * @param pinName the pinName to set
	 */
	public void setPinName(String pinName) {
		this.pinName = pinName;
	}

	/**
	 * pinEmail attribute를 리턴한다.
	 * @return the pinEmail
	 */
	public String getPinEmail() {
		return pinEmail;
	}

	/**
	 * pinEmail attribute 값을 설정한다.
	 * @param pinEmail the pinEmail to set
	 */
	public void setPinEmail(String pinEmail) {
		this.pinEmail = pinEmail;
	}

	/**
	 * telePhone attribute를 리턴한다.
	 * @return the telePhone
	 */
	public String getTelePhone() {
		return telePhone;
	}

	/**
	 * telePhone attribute 값을 설정한다.
	 * @param telePhone the telePhone to set
	 */
	public void setTelePhone(String telePhone) {
		this.telePhone = telePhone;
	}

	/**
	 * cellPhone attribute를 리턴한다.
	 * @return the cellPhone
	 */
	public String getCellPhone() {
		return cellPhone;
	}

	/**
	 * cellPhone attribute 값을 설정한다.
	 * @param cellPhone the cellPhone to set
	 */
	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	/**
	 * pinAddr attribute를 리턴한다.
	 * @return the pinAddr
	 */
	public String getPinAddr() {
		return pinAddr;
	}

	/**
	 * pinAddr attribute 값을 설정한다.
	 * @param pinAddr the pinAddr to set
	 */
	public void setPinAddr(String pinAddr) {
		this.pinAddr = pinAddr;
	}
	
	/**
	 * pinAddr2 attribute를 리턴한다.
	 * @return the pinAddr2
	 */
	public String getPinAddr2() {
		return pinAddr2;
	}

	/**
	 * pinAddr2 attribute 값을 설정한다.
	 * @param pinAddr2 the pinAddr2 to set
	 */
	public void setPinAddr2(String pinAddr2) {
		this.pinAddr2 = pinAddr2;
	}
	
	/**
	 * regDate attribute를 리턴한다.
	 * @return the regDate
	 */
	public String getRegDate() {
		return regDate;
	}

	/**
	 * regDate attribute 값을 설정한다.
	 * @param regDate the regDate to set
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	/**
	 * regDate attribute를 리턴한다.
	 * @return the regDate
	 */
	public String getOption1() {
		return option1;
	}

	/**
	 * option1 attribute 값을 설정한다.
	 * @param option1 the option1 to set
	 */
	public void setOption1(String option1) {
		this.option1 = option1;
	}

	/**
	 * option1 attribute를 리턴한다.
	 * @return the option1
	 */
	public String getOption2() {
		return option2;
	}

	/**
	 * option2 attribute 값을 설정한다.
	 * @param option2 the option2 to set
	 */
	public void setOption2(String option2) {
		this.option2 = option2;
	}
	
	/**
	 * option2 attribute를 리턴한다.
	 * @return the option2
	 */
	public String getOption3() {
		return option3;
	}

	/**
	 * option3 attribute 값을 설정한다.
	 * @param option3 the option3 to set
	 */
	public void setOption3(String option3) {
		this.option3 = option3;
	}
	
	/**
	 * option3 attribute를 리턴한다.
	 * @return the option3
	 */
	public String getOption4() {
		return option4;
	}

	/**
	 * option4 attribute 값을 설정한다.
	 * @param option4 the option4 to set
	 */
	public void setOption4(String option4) {
		this.option4 = option4;
	}
	
	/**
	 * option5 attribute를 리턴한다.
	 * @return the option5
	 */
	public String getOption5() {
		return option5;
	}

	/**
	 * option5 attribute 값을 설정한다.
	 * @param option5 the option5 to set
	 */
	public void setOption5(String option5) {
		this.option5 = option5;
	}
	
	/**
	 * option6 attribute를 리턴한다.
	 * @return the option6
	 */
	public String getOption6() {
		return option6;
	}

	/**
	 * option6 attribute 값을 설정한다.
	 * @param option6 the option6 to set
	 */
	public void setOption6(String option6) {
		this.option6 = option6;
	}
	
	/**
	 * option7 attribute를 리턴한다.
	 * @return the option7
	 */
	public String getOption7() {
		return option7;
	}

	/**
	 * option7 attribute 값을 설정한다.
	 * @param option7 the option7 to set
	 */
	public void setOption7(String option7) {
		this.option7 = option7;
	}
	
	/**
	 * option8 attribute를 리턴한다.
	 * @return the option8
	 */
	public String getOption8() {
		return option8;
	}

	/**
	 * option8 attribute 값을 설정한다.
	 * @param option8 the option8 to set
	 */
	public void setOption8(String option8) {
		this.option8 = option8;
	}
	
	/**
	 * option9 attribute를 리턴한다.
	 * @return the option9
	 */
	public String getOption9() {
		return option9;
	}

	/**
	 * option9 attribute 값을 설정한다.
	 * @param option9 the option9 to set
	 */
	public void setOption9(String option9) {
		this.option9 = option9;
	}
	
	/**
	 * option10 attribute를 리턴한다.
	 * @return the option10
	 */
	public String getOption10() {
		return option10;
	}

	/**
	 * option10 attribute 값을 설정한다.
	 * @param option10 the option10 to set
	 */
	public void setOption10(String option10) {
		this.option10 = option10;
	}
	
	/**
	 * option11 attribute를 리턴한다.
	 * @return the option11
	 */
	public String getOption11() {
		return option11;
	}

	/**
	 * option11 attribute 값을 설정한다.
	 * @param option11 the option11 to set
	 */
	public void setOption11(String option11) {
		this.option11 = option11;
	}

	/**
	 * option12 attribute를 리턴한다.
	 * @return the option12
	 */
	public String getOption12() {
		return option12;
	}

	/**
	 * option12 attribute 값을 설정한다.
	 * @param option12 the option12 to set
	 */
	public void setOption12(String option12) {
		this.option12 = option12;
	}
	
	/**
	 * option13 attribute를 리턴한다.
	 * @return the option13
	 */
	public String getOption13() {
		return option13;
	}

	/**
	 * option13 attribute 값을 설정한다.
	 * @param option13 the option13 to set
	 */
	public void setOption13(String option13) {
		this.option13 = option13;
	}
	
	/**
	 * option14 attribute를 리턴한다.
	 * @return the option14
	 */
	public String getOption14() {
		return option14;
	}

	/**
	 * option14 attribute 값을 설정한다.
	 * @param option14 the option14 to set
	 */
	public void setOption14(String option14) {
		this.option14 = option14;
	}
	
	/**
	 * option15 attribute를 리턴한다.
	 * @return the option15
	 */
	public String getOption15() {
		return option15;
	}

	/**
	 * option15 attribute 값을 설정한다.
	 * @param option15 the option15 to set
	 */
	public void setOption15(String option15) {
		this.option15 = option15;
	}
	
	/**
	 * option16 attribute를 리턴한다.
	 * @return the option16
	 */
	public String getOption16() {
		return option16;
	}

	/**
	 * option16 attribute 값을 설정한다.
	 * @param option16 the option16 to set
	 */
	public void setOption16(String option16) {
		this.option16 = option16;
	}
	
	/**
	 * option17 attribute를 리턴한다.
	 * @return the option17
	 */
	public String getOption17() {
		return option17;
	}

	/**
	 * option17 attribute 값을 설정한다.
	 * @param option17 the option17 to set
	 */
	public void setOption17(String option17) {
		this.option17 = option17;
	}
	
	/**
	 * option18 attribute를 리턴한다.
	 * @return the option18
	 */
	public String getOption18() {
		return option18;
	}

	/**
	 * option18 attribute 값을 설정한다.
	 * @param option18 the option18 to set
	 */
	public void setOption18(String option18) {
		this.option18 = option18;
	}
	
	/**
	 * option19 attribute를 리턴한다.
	 * @return the option19
	 */
	public String getOption19() {
		return option19;
	}

	/**
	 * option19 attribute 값을 설정한다.
	 * @param option19 the option19 to set
	 */
	public void setOption19(String option19) {
		this.option19 = option19;
	}
	
	/**
	 * option20 attribute를 리턴한다.
	 * @return the option20
	 */
	public String getOption20() {
		return option20;
	}

	/**
	 * option20 attribute 값을 설정한다.
	 * @param option20 the option20 to set
	 */
	public void setOption20(String option20) {
		this.option20 = option20;
	}	
	
	/**
	 * fileNm attribute를 리턴한다.
	 * @return the fileNm
	 */
	public String getFileNm() {
		return fileNm; 
	}

	/**
	 * fileNm attribute 값을 설정한다.
	 * @param fileNm the fileNm to set
	 */
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	
	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
