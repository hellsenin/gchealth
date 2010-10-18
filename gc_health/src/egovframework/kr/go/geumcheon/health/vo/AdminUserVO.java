package egovframework.kr.go.geumcheon.health.vo;

import org.apache.commons.lang.builder.ToStringBuilder;

public class AdminUserVO {

	private String userId = "";

	private String loginId = "";
	
	private String password = "";
	
	private String name = "";

	private String email = "";

	private String phone = "";

	private String mobile = "";

	private String department = "";
	
	private String departmentCode = "";

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}



	public String getLoginId() {
		return loginId;
	}



	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getPhone() {
		return phone;
	}



	public void setPhone(String phone) {
		this.phone = phone;
	}



	public String getMobile() {
		return mobile;
	}



	public void setMobile(String mobile) {
		this.mobile = mobile;
	}



	public String getDepartment() {
		return department;
	}



	public void setDepartment(String department) {
		this.department = department;
	}



	public String getDepartmentCode() {
		return departmentCode;
	}



	public void setDepartmentCode(String departmentCode) {
		this.departmentCode = departmentCode;
	}



	@Override
	public String toString()
	{
		return ToStringBuilder.reflectionToString(this);
	}

}
