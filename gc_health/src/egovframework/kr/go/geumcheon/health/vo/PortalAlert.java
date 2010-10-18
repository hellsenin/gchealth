package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;


public class PortalAlert extends PortalAlertCommonField {
	
	private int alert_cd = 0;
	private String alert_nm = "";
	private String alert_url = "http://";
	private String popup = "Y";
	private String alert_img_path = "";
	private String publish = "Y";

	private Date pub_sdate = null;
	private Date pub_edate = null;
	private int priority = 0;
	private String category = "";
	
	private String img_org_nm = "";
	private String img_nm = "";
	
	
	public String getImg_org_nm() {
		return img_org_nm;
	}
	public void setImg_org_nm(String img_org_nm) {
		this.img_org_nm = img_org_nm;
	}
	public String getImg_nm() {
		return img_nm;
	}
	public void setImg_nm(String img_nm) {
		this.img_nm = img_nm;
	}
	public int getAlert_cd() {
		return alert_cd;
	}
	public void setAlert_cd(int alert_cd) {
		this.alert_cd = alert_cd;
	}
	public String getAlert_nm() {
		return alert_nm;
	}
	public void setAlert_nm(String alert_nm) {
		this.alert_nm = alert_nm;
	}
	public String getAlert_url() {
		return alert_url;
	}
	public void setAlert_url(String alert_url) {
		this.alert_url = alert_url;
	}
	public String getPopup() {
		return popup;
	}
	public void setPopup(String popup) {
		this.popup = popup;
	}
	public String getAlert_img_path() {
		return alert_img_path;
	}
	public void setAlert_img_path(String alert_img_path) {
		this.alert_img_path = alert_img_path;
	}
	public String getPublish() {
		return publish;
	}
	public void setPublish(String publish) {
		this.publish = publish;
	}
	public Date getPub_sdate() {
		return pub_sdate;
	}
	public void setPub_sdate(Date pub_sdate) {
		this.pub_sdate = pub_sdate;
	}
	public Date getPub_edate() {
		return pub_edate;
	}
	public void setPub_edate(Date pub_edate) {
		this.pub_edate = pub_edate;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	
	
	
}