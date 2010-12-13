package egovframework.kr.go.geumcheon.health.vo;

import org.apache.commons.lang.builder.ToStringBuilder;

public class UsersVO {

	private String webMemId = "";

	private String passwd = "";
	
	private String memNm = "";
	
	private String birthday = "";

	private String sex = "";

	private String otherEmail = "";

	private String useGcmail = "";

	private String allowMailing = "";
	
	private String zipcode = "";

	private String address1 = "";

	private String address2 = "";

	private String address3 = "";

	private String phone = "";
	
	private String handphone = "";

	private String pin = "";
	
	private int age;
	
	private String email = "";

	private String authCode = "";

	@Override
	public String toString()
	{
		return ToStringBuilder.reflectionToString(this);
	}

	
	
	public String getAuthCode() {
		return authCode;
	}



	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public int getAge() {
		return age;
	}



	public void setAge(int age) {
		this.age = age;
	}



	public String getWebMemId() {
		return webMemId;
	}

	public void setWebMemId(String webMemId) {
		this.webMemId = webMemId;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getMemNm() {
		return memNm;
	}

	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getOtherEmail() {
		return otherEmail;
	}

	public void setOtherEmail(String otherEmail) {
		this.otherEmail = otherEmail;
	}

	public String getUseGcmail() {
		return useGcmail;
	}

	public void setUseGcmail(String useGcmail) {
		this.useGcmail = useGcmail;
	}

	public String getAllowMailing() {
		return allowMailing;
	}

	public void setAllowMailing(String allowMailing) {
		this.allowMailing = allowMailing;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getAddress3() {
		return address3;
	}

	public void setAddress3(String address3) {
		this.address3 = address3;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getHandphone() {
		return handphone;
	}

	public void setHandphone(String handphone) {
		this.handphone = handphone;
	}

	public String getPin() {
		return pin;
	}

	public void setPin(String pin) {
		this.pin = pin;
	}
	
	
}
