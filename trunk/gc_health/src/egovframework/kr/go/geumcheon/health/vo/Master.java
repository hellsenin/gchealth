package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;

public class Master extends PageBean {
	
	
	private int master_cd = 0;
	private String type_cd = "";
	private String title = "";
	private Date start_dt = null;
	private Date end_dt = null;
	private String attachfile1 = "";
	private String attachfileorg1 = "";
	private String attachtype1 = "";
	private Date insert_dt = null;
	private String insert_ip = "";
	private String insert_id = "";
	private Date update_dt = null;
	private String update_ip = "";
	private String update_id = "";
	private String question_cnt = "";
	private String gigan_open_yn = "";
	private String contents = "";
	
	private int company_cd = 0;
	
	private String year_cd = "";

	private String insert_name = "";
	private String update_name = "";
	
	public int question_cd = 0;
	
	
	private String find_type_cd = "";
	
	
	public int getMaster_cd() {
		return master_cd;
	}
	public void setMaster_cd(int master_cd) {
		this.master_cd = master_cd;
	}
	public String getType_cd() {
		return type_cd;
	}
	public void setType_cd(String type_cd) {
		this.type_cd = type_cd;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getStart_dt() {
		return start_dt;
	}
	public void setStart_dt(Date start_dt) {
		this.start_dt = start_dt;
	}
	public Date getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(Date end_dt) {
		this.end_dt = end_dt;
	}
	public String getAttachfile1() {
		return attachfile1;
	}
	public void setAttachfile1(String attachfile1) {
		this.attachfile1 = attachfile1;
	}
	public String getAttachfileorg1() {
		return attachfileorg1;
	}
	public void setAttachfileorg1(String attachfileorg1) {
		this.attachfileorg1 = attachfileorg1;
	}
	public String getAttachtype1() {
		return attachtype1;
	}
	public void setAttachtype1(String attachtype1) {
		this.attachtype1 = attachtype1;
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
	public String getQuestion_cnt() {
		return question_cnt;
	}
	public void setQuestion_cnt(String question_cnt) {
		this.question_cnt = question_cnt;
	}
	public String getGigan_open_yn() {
		return gigan_open_yn;
	}
	public void setGigan_open_yn(String gigan_open_yn) {
		this.gigan_open_yn = gigan_open_yn;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getCompany_cd() {
		return company_cd;
	}
	public void setCompany_cd(int company_cd) {
		this.company_cd = company_cd;
	}
	public String getYear_cd() {
		return year_cd;
	}
	public void setYear_cd(String year_cd) {
		this.year_cd = year_cd;
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
	public int getQuestion_cd() {
		return question_cd;
	}
	public void setQuestion_cd(int question_cd) {
		this.question_cd = question_cd;
	}
	public String getFind_type_cd() {
		return find_type_cd;
	}
	public void setFind_type_cd(String find_type_cd) {
		this.find_type_cd = find_type_cd;
	}
	
	
	
}
