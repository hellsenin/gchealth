package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Company extends PageBean {
	
	private int company_cd = 0;
	private String id = "";
	private String passwd = "";
	private String company = "";
	private String sa_no = "";
	private String ceo_name = "";
	private String jumin = "";
	private String pharmacist_no = "";
	private String tel = "";
	private String fax = "";
	private String hp = "";
	private String post = "";
	private String addr1 = "";
	private String addr2 = "";
	private String email = "";
	private int industry_cd = 0;
	private String type_cd_01_yn = "N";
	private String type_cd_02_yn = "N";
	private String type_cd_03_yn = "N";
	private String type_cd_04_yn = "N";
	private String type_cd_05_yn = "N";
	private String type_cd_06_yn = "N";
	private String type_cd_07_yn = "N";
	private String type_cd_08_yn = "N";
	private String type_cd_09_yn = "N";
	private String type_cd_10_yn = "N";
	private String type_cd_11_yn = "N";
	private Date insert_dt = null;
	private String grade_cd = "00";
	private String grade_cd_name = "";
	private String industry_name = "";
	private int anser_cnt = 0;
	private String type_cd = "";

	private String zipcode = "";
	private String zipcode1 = "";
	private String zipcode2 = "";
	private String status = "";
	private String insert_ip = "";
	private String insert_id = "";
	private Date update_dt = null;
	private String update_ip = "";
	private String update_id = "";
	private String blog_url = "";
	
	private String year_cd = "";
	
	
	private String insert_name = "";
	private String update_name = "";
	
	private String find_type_cd = "";
	private int master_cd = 0;
	
	private String company_id = "";

	private String forLogin = "N";
	
	private String masterCdData = "";
	
	private String divide_cd = "";
	
	
	
	public String getDivide_cd() {
		return divide_cd;
	}

	public void setDivide_cd(String divide_cd) {
		this.divide_cd = divide_cd;
	}

	public String getZipcode() {
		return zipcode1 + "-" + zipcode2;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getMasterCdData() {
		return masterCdData;
	}

	public void setMasterCdData(String masterCdData) {
		this.masterCdData = masterCdData;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public String getForLogin() {
		return forLogin;
	}

	public void setForLogin(String forLogin) {
		this.forLogin = forLogin;
	}

	public int getCompany_cd() {
		return company_cd;
	}
	public void setCompany_cd(int company_cd) {
		this.company_cd = company_cd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getSa_no() {
		return sa_no;
	}
	public void setSa_no(String sa_no) {
		this.sa_no = sa_no;
	}
	public String getCeo_name() {
		return ceo_name;
	}
	public void setCeo_name(String ceo_name) {
		this.ceo_name = ceo_name;
	}
	public String getJumin() {
		return jumin;
	}
	public void setJumin(String jumin) {
		this.jumin = jumin;
	}
	public String getPharmacist_no() {
		return pharmacist_no;
	}
	public void setPharmacist_no(String pharmacist_no) {
		this.pharmacist_no = pharmacist_no;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getIndustry_cd() {
		return industry_cd;
	}
	public void setIndustry_cd(int industry_cd) {
		this.industry_cd = industry_cd;
	}
	public String getType_cd_01_yn() {
		return type_cd_01_yn;
	}
	public void setType_cd_01_yn(String type_cd_01_yn) {
		this.type_cd_01_yn = type_cd_01_yn;
	}
	public String getType_cd_02_yn() {
		return type_cd_02_yn;
	}
	public void setType_cd_02_yn(String type_cd_02_yn) {
		this.type_cd_02_yn = type_cd_02_yn;
	}
	public String getType_cd_03_yn() {
		return type_cd_03_yn;
	}
	public void setType_cd_03_yn(String type_cd_03_yn) {
		this.type_cd_03_yn = type_cd_03_yn;
	}
	public String getType_cd_04_yn() {
		return type_cd_04_yn;
	}
	public void setType_cd_04_yn(String type_cd_04_yn) {
		this.type_cd_04_yn = type_cd_04_yn;
	}
	public String getType_cd_05_yn() {
		return type_cd_05_yn;
	}
	public void setType_cd_05_yn(String type_cd_05_yn) {
		this.type_cd_05_yn = type_cd_05_yn;
	}
	public String getType_cd_06_yn() {
		return type_cd_06_yn;
	}
	public void setType_cd_06_yn(String type_cd_06_yn) {
		this.type_cd_06_yn = type_cd_06_yn;
	}
	public String getType_cd_07_yn() {
		return type_cd_07_yn;
	}
	public void setType_cd_07_yn(String type_cd_07_yn) {
		this.type_cd_07_yn = type_cd_07_yn;
	}
	public String getType_cd_08_yn() {
		return type_cd_08_yn;
	}
	public void setType_cd_08_yn(String type_cd_08_yn) {
		this.type_cd_08_yn = type_cd_08_yn;
	}
	public String getType_cd_09_yn() {
		return type_cd_09_yn;
	}
	public void setType_cd_09_yn(String type_cd_09_yn) {
		this.type_cd_09_yn = type_cd_09_yn;
	}
	public String getType_cd_10_yn() {
		return type_cd_10_yn;
	}
	public void setType_cd_10_yn(String type_cd_10_yn) {
		this.type_cd_10_yn = type_cd_10_yn;
	}
	public String getType_cd_11_yn() {
		return type_cd_11_yn;
	}
	public void setType_cd_11_yn(String type_cd_11_yn) {
		this.type_cd_11_yn = type_cd_11_yn;
	}
	public Date getInsert_dt() {
		return insert_dt;
	}
	public void setInsert_dt(Date insert_dt) {
		this.insert_dt = insert_dt;
	}
	public String getGrade_cd() {
		return grade_cd;
	}
	public void setGrade_cd(String grade_cd) {
		this.grade_cd = grade_cd;
	}
	public String getGrade_cd_name() {
		return grade_cd_name;
	}
	public void setGrade_cd_name(String grade_cd_name) {
		this.grade_cd_name = grade_cd_name;
	}
	public String getIndustry_name() {
		return industry_name;
	}
	public void setIndustry_name(String industry_name) {
		this.industry_name = industry_name;
	}
	public int getAnser_cnt() {
		return anser_cnt;
	}
	public void setAnser_cnt(int anser_cnt) {
		this.anser_cnt = anser_cnt;
	}
	public String getYear_cd() {
		return year_cd;
	}
	public void setYear_cd(String year_cd) {
		this.year_cd = year_cd;
	}
	public String getType_cd() {
		return type_cd;
	}
	public void setType_cd(String type_cd) {
		this.type_cd = type_cd;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getInsert_ip() {
		return insert_ip;
	}
	public void setInsert_ip(String insert_ip) {
		this.insert_ip = insert_ip;
	}
	public String getInsert_id() {
		return insert_id;
	}
	public void setInsert_id(String insert_id) {
		this.insert_id = insert_id;
	}
	public Date getUpdate_dt() {
		return update_dt;
	}
	public void setUpdate_dt(Date update_dt) {
		this.update_dt = update_dt;
	}
	public String getUpdate_ip() {
		return update_ip;
	}
	public void setUpdate_ip(String update_ip) {
		this.update_ip = update_ip;
	}
	public String getUpdate_id() {
		return update_id;
	}
	public void setUpdate_id(String update_id) {
		this.update_id = update_id;
	}
	public String getBlog_url() {
		return blog_url;
	}
	public void setBlog_url(String blog_url) {
		this.blog_url = blog_url;
	}

	public String getInsert_name() {
		return insert_name;
	}

	public void setInsert_name(String insert_name) {
		this.insert_name = insert_name;
	}

	public String getUpdate_name() {
		return update_name;
	}

	public void setUpdate_name(String update_name) {
		this.update_name = update_name;
	}
	
	public String getFind_type_cd() {
		return this.find_type_cd;
	}

	public void setFind_type_cd(String find_type_cd) {
		this.find_type_cd = find_type_cd;
	}
	
	public void make_find_type_cd() {
		String val = "";
		if("Y".equals(type_cd_01_yn)) {
			val = "'01'";
		} 
		if("Y".equals(type_cd_02_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'02'";
		} 
		if("Y".equals(type_cd_03_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'03'";
		} 
		if("Y".equals(type_cd_04_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'04'";
		} 
		if("Y".equals(type_cd_05_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'05'";
		} 
		if("Y".equals(type_cd_06_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'06'";
		} 
		if("Y".equals(type_cd_07_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'07'";
		} 
		if("Y".equals(type_cd_08_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'08'";
		} 
		if("Y".equals(type_cd_09_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'09'";
		} 
		if("Y".equals(type_cd_10_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'10'";
		} 
		if("Y".equals(type_cd_11_yn)) {
			if(!val.endsWith(",")) { val += ",";}
			val += "'11'";
		} 
		if(val.startsWith(",")) {
			val = val.substring(1);
		}
		if(val.length() == 0) {
			val = "'00'";
		}
		find_type_cd = val;
	}
	
	public int getMaster_cd() {
		return master_cd;
	}
	
	public void setMaster_cd(int master_cd) {
		this.master_cd = master_cd;
	}

	public String getCompany_id() {
		return company_id;
	}

	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}
	
}
