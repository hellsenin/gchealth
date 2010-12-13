package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;

public class MemberVO {

	private String groupId = "";

	private String id = "";
	
	private String name = "";

	private String pwd = "";

	private String pwdHint = "";

	private String pwdHintAnswer = "";

	private String birthday = "";
	
	private String birthday1 = "";

	private String birthday2 = "";

	private String birthday3 = "";

	private String sex = "";

	private String tel = "";
	
	private String tel1 = "";

	private String tel2 = "";

	private String tel3 = "";

	private String cellPhone = "";
	
	private String cellPhone1 = "";

	private String cellPhone2 = "";

	private String cellPhone3 = "";

	private String email = "";

	private String zipcode = "";
	
	private String zipcode1 = "";

	private String zipcode2 = "";

	private String addr1 = "";

	private String addr2 = "";

	private String smsFlag = "N";

	private String jongnoNewsFlag = "N";

	private String personalInfoUseFlag = "N";

	private String newsFlag = "N";

	private String webmailFlag = "N";

	private String webzineFlag = "N";

	private String status = "";
	
	private String withdrawReason = "";
	
		
	
	public String getWithdrawReason() {
		return withdrawReason;
	}

	public void setWithdrawReason(String withdrawReason) {
		this.withdrawReason = withdrawReason;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getWebzineFlag() {
		return webzineFlag;
	}

	public void setWebzineFlag(String webzineFlag) {
		this.webzineFlag = webzineFlag;
	}

	public String getWebmailFlag() {
		return webmailFlag;
	}

	public void setWebmailFlag(String webmailFlag) {
		this.webmailFlag = webmailFlag;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getBirthday() {
		return birthday1 + "-" + birthday2 + "-" + birthday3;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getTel() {
		return tel1 + "-" + tel2 + "-" + tel3;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getCellPhone() {
		return cellPhone1 + "-" + cellPhone2 + "-" + cellPhone3;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getZipcode() {
		return zipcode1 + "-" + zipcode2;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getPwdHint() {
		return pwdHint;
	}

	public void setPwdHint(String pwdHint) {
		this.pwdHint = pwdHint;
	}

	public String getPwdHintAnswer() {
		return pwdHintAnswer;
	}

	public void setPwdHintAnswer(String pwdHintAnswer) {
		this.pwdHintAnswer = pwdHintAnswer;
	}

	public String getBirthday1() {
		return birthday1;
	}

	public void setBirthday1(String birthday1) {
		this.birthday1 = birthday1;
	}

	public String getBirthday2() {
		return birthday2;
	}

	public void setBirthday2(String birthday2) {
		this.birthday2 = birthday2;
	}

	public String getBirthday3() {
		return birthday3;
	}

	public void setBirthday3(String birthday3) {
		this.birthday3 = birthday3;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getCellPhone1() {
		return cellPhone1;
	}

	public void setCellPhone1(String cellPhone1) {
		this.cellPhone1 = cellPhone1;
	}

	public String getCellPhone2() {
		return cellPhone2;
	}

	public void setCellPhone2(String cellPhone2) {
		this.cellPhone2 = cellPhone2;
	}

	public String getCellPhone3() {
		return cellPhone3;
	}

	public void setCellPhone3(String cellPhone3) {
		this.cellPhone3 = cellPhone3;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getZipcode1() {
		return zipcode1;
	}

	public void setZipcode1(String zipcode1) {
		this.zipcode1 = zipcode1;
	}

	public String getZipcode2() {
		return zipcode2;
	}

	public void setZipcode2(String zipcode2) {
		this.zipcode2 = zipcode2;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getSmsFlag() {
		return smsFlag;
	}

	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}

	public String getJongnoNewsFlag() {
		return jongnoNewsFlag;
	}

	public void setJongnoNewsFlag(String jongnoNewsFlag) {
		this.jongnoNewsFlag = jongnoNewsFlag;
	}

	public String getPersonalInfoUseFlag() {
		return personalInfoUseFlag;
	}

	public void setPersonalInfoUseFlag(String personalInfoUseFlag) {
		this.personalInfoUseFlag = personalInfoUseFlag;
	}

	public String getNewsFlag() {
		return newsFlag;
	}

	public void setNewsFlag(String newsFlag) {
		this.newsFlag = newsFlag;
	}

	public String toString()
	{
		StringBuffer result = new StringBuffer();
		result.append("(id:" + id + ")");
		result.append("(pwd:" + pwd + ")");
		result.append("(pwdHint:" + pwdHint + ")");
		result.append("(pwdHintAnswer:" + pwdHintAnswer + ")");
		result.append("(birthday1:" + birthday1 + ")");
		result.append("(birthday2:" + birthday2 + ")");
		result.append("(birthday3:" + birthday3 + ")");
		result.append("(sex:" + sex + ")");
		result.append("(tel1:" + tel1 + ")");
		result.append("(tel2:" + tel2 + ")");
		result.append("(tel3:" + tel3 + ")");
		result.append("(cellPhone1:" + cellPhone1 + ")");
		result.append("(cellPhone2:" + cellPhone2 + ")");
		result.append("(cellPhone3:" + cellPhone3 + ")");
		result.append("(email:" + email + ")");
		result.append("(zipcode1:" + zipcode1 + ")");
		result.append("(zipcode2:" + zipcode2 + ")");
		result.append("(addr1:" + addr1 + ")");
		result.append("(addr2:" + addr2 + ")");
		result.append("(smsFlag:" + smsFlag + ")");
		result.append("(jongnoNewsFlag:" + jongnoNewsFlag + ")");
		result.append("(personalInfoUseFlag:" + personalInfoUseFlag + ")");
		result.append("(newsFlag:" + newsFlag + ")");
		
		return result.toString();
	}
}
