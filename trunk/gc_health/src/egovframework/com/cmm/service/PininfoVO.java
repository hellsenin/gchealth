package egovframework.com.cmm.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name  : PininfoVO.java
 * @Description : 실명인증정보
 * @Modification Information
 * 
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.03.06       이삼섭                  최초 생성
 *
 * @author 실명인증정보 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see 
 * 
 *  Copyright (C) 2008 by MOPAS  All right reserved.
 */
@SuppressWarnings("serial")
public class PininfoVO implements Serializable {

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
	 * 등록일
	 */
	private String regDate = "";

	/**
	 * 주소
	 */
	private String pinAddr = "";
	
	/**
	 * 주소2
	 */
	private String pinAddr2 = "";
	
	/**
	 * 우편번호
	 */
	private String zipcode = "";
	
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
	 * @return the zipcode
	 */
	public String getZipcode() {
		return zipcode;
	}

	/**
	 * @param zipcode the zipcode to set
	 */
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
