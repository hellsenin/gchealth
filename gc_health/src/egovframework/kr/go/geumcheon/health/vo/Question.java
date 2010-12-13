package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Question extends PageBean {
	private int question_cd = 0;
	private int master_cd = 0;
	private String question = "";
	private String quest_type_cd = "";
	private String multi_check_yn = "";
	private String other_yn = "";
	private int orderby = 0;
	private String status = "";
	private Date insert_dt = null;
	private String insert_ip = "";
	private String insert_id = "";
	private Date update_dt = null;
	private String update_ip = "";
	private String update_id = "";
	
	private String year_cd = "";
	private String title = "";
	
	
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public int getQuestion_cd() {
		return question_cd;
	}
	public void setQuestion_cd(int question_cd) {
		this.question_cd = question_cd;
	}
	public int getMaster_cd() {
		return master_cd;
	}
	public void setMaster_cd(int master_cd) {
		this.master_cd = master_cd;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getQuest_type_cd() {
		return quest_type_cd;
	}
	public void setQuest_type_cd(String quest_type_cd) {
		this.quest_type_cd = quest_type_cd;
	}
	public String getMulti_check_yn() {
		return multi_check_yn;
	}
	public void setMulti_check_yn(String multi_check_yn) {
		this.multi_check_yn = multi_check_yn;
	}
	public String getOther_yn() {
		return other_yn;
	}
	public void setOther_yn(String other_yn) {
		this.other_yn = other_yn;
	}
	public int getOrderby() {
		return orderby;
	}
	public void setOrderby(int orderby) {
		this.orderby = orderby;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getInsert_dt() {
		return insert_dt;
	}
	public void setInsert_dt(Date insert_dt) {
		this.insert_dt = insert_dt;
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
	public String getYear_cd() {
		return year_cd;
	}
	public void setYear_cd(String year_cd) {
		this.year_cd = year_cd;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	
}
