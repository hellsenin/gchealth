/**
 * 
 * 
 * @author 김명구
 * @since 2010. 1. 21.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      	수정자      	수정내용
 *  -------    		--------    --------------------------
 *   2010. 1. 21.  김명구      	최초 생성
 *
 * Copyright (C) 2010 by MOPAS  All right reserved.
 * </pre>
 */


package egovframework.kr.go.geumcheon.health.vo;


public class Banner extends BannerCommonField {

	public static int PORTAL_DISPLAY_CNT = 4; 
	public static int HEALTH_DISPLAY_CNT = 6; 
	public static int COUNCIL_DISPLAY_CNT = 3; 
	public static int DONG_DISPLAY_CNT = 100000; 
	public static int DEPT_DISPLAY_CNT = 3; 

	public static int ENGLISH_DISPLAY_CNT = 8; 
	public static int CHINA_DISPLAY_CNT = 8; 
	public static int JAPAN_DISPLAY_CNT = 8; 
	
	
	private int bnr_cd = 0;
	private String bnr_nm = "";
	private String bnr_url = "http://";
	private String bnr_img_path = "";
	private String publish = "Y"; 
	private String dept = "";
	private String dong = "";
	private String bnr_img_org_nm = "";
	private String bnr_img_nm = "";
	
	public int visible_cnt = 1;
	
	
	
	public String getBnr_img_org_nm() {
		return bnr_img_org_nm;
	}
	public void setBnr_img_org_nm(String bnr_img_org_nm) {
		this.bnr_img_org_nm = bnr_img_org_nm;
	}
	public String getBnr_img_nm() {
		return bnr_img_nm;
	}
	public void setBnr_img_nm(String bnr_img_nm) {
		this.bnr_img_nm = bnr_img_nm;
	}
	public int getBnr_cd() {
		return bnr_cd;
	}
	public void setBnr_cd(int bnr_cd) {
		this.bnr_cd = bnr_cd;
	}
	public String getBnr_nm() {
		return bnr_nm;
	}
	public void setBnr_nm(String bnr_nm) {
		this.bnr_nm = bnr_nm;
	}
	public String getBnr_url() {
		return bnr_url;
	}
	public void setBnr_url(String bnr_url) {
		this.bnr_url = bnr_url;
	}
	public String getPublish() {
		return publish;
	}
	public void setPublish(String publish) {
		this.publish = publish;
	}
	public String getBnr_img_path() {
		return bnr_img_path;
	}
	public void setBnr_img_path(String bnr_img_path) {
		this.bnr_img_path = bnr_img_path;
	}

	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public int getVisible_cnt() {
		return visible_cnt;
	}
	public void setVisible_cnt(int visible_cnt) {
		this.visible_cnt = visible_cnt;
	}	
	
}
