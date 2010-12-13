package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Question2 extends PageBean {
	private int question2_cd = 0;
	private int master_cd = 0;
	private int question1_cd = 0;
	private String question2 = "";
	private int orderby = 0;
	private String status = "N";
	private Date insert_dt = null;
	private String insert_ip = "";
	private String insert_id = "";
//	private Date update_dt = Calendar.getInstance().getTime();
	private Date update_dt = null;
	private String update_ip = "";
	private String update_id = "";

	private Date add_time = new Date();
	
	private int question_cd = 0;
	private String year_cd = "";
	
	private String seq = "";
	private String del = "";
	

	private String[] arr_question2_cd = null;
	private String[] arr_question2 = null;
	private String[] arr_orderby = null;
	private Date[] arr_update_dt = null;
	private String[] arr_status = null;
	
	private String validation = "N";
	
		
	public String getValidation() {
		return validation;
	}
	public void setValidation(String validation) {
		this.validation = validation;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public int getQuestion2_cd() {
		return question2_cd;
	}
	public void setQuestion2_cd(int question2_cd) {
		this.question2_cd = question2_cd;
	}
	public int getMaster_cd() {
		return master_cd;
	}
	public void setMaster_cd(int master_cd) {
		this.master_cd = master_cd;
	}
	public int getQuestion1_cd() {
		return question1_cd;
	}
	public void setQuestion1_cd(int question1_cd) {
		this.question1_cd = question1_cd;
	}
	public String getQuestion2() {
		return question2;
	}
	public void setQuestion2(String question2) {
		this.question2 = question2;
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
	public int getQuestion_cd() {
		return question_cd;
	}
	public void setQuestion_cd(int question_cd) {
		this.question_cd = question_cd;
	}
	public String getYear_cd() {
		return year_cd;
	}
	public void setYear_cd(String year_cd) {
		this.year_cd = year_cd;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String[] getArr_question2() {
		return arr_question2;
	}
	public void setArr_question2(String[] arr_question2) {
		this.arr_question2 = arr_question2;
	}
	public String[] getArr_orderby() {
		return arr_orderby;
	}
	public void setArr_orderby(String[] arr_orderby) {
		this.arr_orderby = arr_orderby;
	}
	public Date[] getArr_update_dt() {
		return arr_update_dt;
	}
	public void setArr_update_dt(Date[] arr_update_dt) {
		this.arr_update_dt = arr_update_dt;
	}
	public String[] getArr_status() {
		return arr_status;
	}
	public void setArr_status(String[] arr_status) {
		this.arr_status = arr_status;
	}
	public String[] getArr_question2_cd() {
		return arr_question2_cd;
	}
	public void setArr_question2_cd(String[] arr_question2_cd) {
		this.arr_question2_cd = arr_question2_cd;
	}
	public Date getAdd_time() {
		return add_time;
	}
	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}
	
	
	
}
