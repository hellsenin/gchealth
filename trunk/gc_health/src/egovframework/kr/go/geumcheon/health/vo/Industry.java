package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;


public class Industry extends PageBean {
	
	private int industry_cd = 0;
	private String divide_cd = "";
	private String divide_cd_name = "";
	private String name = "";
	private String use_yn = "";
	private String use_yn_name = "";
	
	private String insert_id = "";
	private String insert_name = "";	// 
	
	private String update_id = "";
	private String update_name = "";	// 
	
	private String status = "N";		// 삭제 여부
	
	private Date insert_dt = null;
	private Date update_dt = null;
	private String industry_cnt = "";
	private String year_cd = "";
	
	
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public int getIndustry_cd() {
		return industry_cd;
	}

	public void setIndustry_cd(int industry_cd) {
		this.industry_cd = industry_cd;
	}

	public String getDivide_cd() {
		return divide_cd;
	}
	public void setDivide_cd(String divide_cd) {
		this.divide_cd = divide_cd;
	}
	public String getDivide_cd_name() {
		return divide_cd_name;
	}
	public void setDivide_cd_name(String divide_cd_name) {
		this.divide_cd_name = divide_cd_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getUse_yn_name() {
		return use_yn_name;
	}
	public void setUse_yn_name(String use_yn_name) {
		this.use_yn_name = use_yn_name;
	}
	public String getIndustry_cnt() {
		return industry_cnt;
	}
	public void setIndustry_cnt(String industry_cnt) {
		this.industry_cnt = industry_cnt;
	}
	public Date getInsert_dt() {
		return insert_dt;
	}
	public void setInsert_dt(Date insert_dt) {
		this.insert_dt = insert_dt;
	}
	public String getYear_cd() {
		return year_cd;
	}
	public void setYear_cd(String year_cd) {
		this.year_cd = year_cd;
	}
	public String getInsert_id() {
		return insert_id;
	}
	public void setInsert_id(String insert_id) {
		this.insert_id = insert_id;
	}
	public String getInsert_name() {
		return insert_name;
	}
	public void setInsert_name(String insert_name) {
		this.insert_name = insert_name;
	}
	public String getUpdate_id() {
		return update_id;
	}
	public void setUpdate_id(String update_id) {
		this.update_id = update_id;
	}
	public String getUpdate_name() {
		return update_name;
	}
	public void setUpdate_name(String update_name) {
		this.update_name = update_name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getUpdate_dt() {
		return update_dt;
	}
	public void setUpdate_dt(Date update_dt) {
		this.update_dt = update_dt;
	}
	
	
}
