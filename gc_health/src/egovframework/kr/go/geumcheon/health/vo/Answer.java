package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Answer {
	private int answer_cd = 0;
	private int company_cd = 0;
	private String company_id = "";
	private int master_cd = 0;
	private String sangho_name = "";
	private String number1 = "";
	private String number2 = "";
	private String number3 = "";
	private String name1 = "";
	private String jumin1 = "";
	private String name2 = "";
	private String jumin2 = "";
	private String name3 = "";
	private String jumin3 = "";
	private String addr1 = "";
	private String addr2 = "";
	private String email = "";
	private String tel = "";
	private String hp = "";
	private String fax = "";
	private String homepage = "";
	private int room_cnt = 0;
	private String work_time1 = "";
	private String work_time2 = "";
	private String work_time3 = "";
	private Integer cnt1 = 0;
	private Integer cnt2 = 0;
	private int cnt3 = 0;
	private int cnt4 = 0;
	private int cnt5 = 0;
	private int cnt6 = 0;
	private int cnt7 = 0;
	private int cnt8 = 0;
	private int cnt9 = 0;
	private String article1_yn = "";
	private String article2_yn = "";
	private String article3_yn = "";
	private String article4_yn = "";
	private String article5_yn = "";
	private String article6_yn = "";
	private String article7_yn = "";
	private String article8_yn = "";
	private String article9_yn = "";
	private String other1 = "";
	private String other2 = "";
	private String other3 = "";
	private String other4 = "";
	private String other5 = "";
	private String other6 = "";
	private String other7 = "";
	private String other8 = "";
	private String attachfile1 = "";
	private String attachfileorg1 = "";
	private String attachtype1 = "";
	private String status = "N";
	private Date insert_dt = null;
	private String insert_ip = "";
	private String insert_id = "";
	private Date update_dt = null;
	private String update_ip = "";
	private String update_id = "";
	

	private String id = "";
	private String passwd = "";
	private String company = "";
	private String sa_no = "";
	private String ceo_name = "";
	private String jumin = "";
	private String pharmacist_no = "";
	private String post = "";
	private int industry_cd = 0;
	private String type_cd_01_yn = "";
	private String type_cd_02_yn = "";
	private String type_cd_03_yn = "";
	private String type_cd_04_yn = "";
	private String type_cd_05_yn = "";
	private String type_cd_06_yn = "";
	private String type_cd_07_yn = "";
	private String type_cd_08_yn = "";
	private String type_cd_09_yn = "";
	private String type_cd_10_yn = "";
	private String type_cd_11_yn = "";
	private String grade_cd = "";
	private String year_cd = "";
	private String blog_url = "";
	
	
	private String type_cd = "";
	private String find_type_cd = "";
	
	/*private String[] arr_question_cd = null;
	private String[] arr_question2_cd = null;
	private String[] arr_other = null;*/
	
	private int question_cd = 0;
	private int question2_cd = 0;
	private String other = "";
	
	
	private String view_state = "readonly";
	

	private String[] arr_handle_cd = null;
	private String[] arr_item_name = null;
	private String[] arr_unit = null;
	private String[] arr_field1 = null;
	private String[] arr_field2 = null;
	private String[] arr_field3 = null;
	private String[] arr_field4 = null;
	private String[] arr_order_no = null;
	private String[] arr_status = null;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
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
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
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
	public String getGrade_cd() {
		return grade_cd;
	}
	public void setGrade_cd(String grade_cd) {
		this.grade_cd = grade_cd;
	}
	public String getYear_cd() {
		return year_cd;
	}
	public void setYear_cd(String year_cd) {
		this.year_cd = year_cd;
	}
	public String getBlog_url() {
		return blog_url;
	}
	public void setBlog_url(String blog_url) {
		this.blog_url = blog_url;
	}
	public int getAnswer_cd() {
		return answer_cd;
	}
	public void setAnswer_cd(int answer_cd) {
		this.answer_cd = answer_cd;
	}
	public int getCompany_cd() {
		return company_cd;
	}
	public void setCompany_cd(int company_cd) {
		this.company_cd = company_cd;
	}
	public String getCompany_id() {
		return company_id;
	}
	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}
	public int getMaster_cd() {
		return master_cd;
	}
	public void setMaster_cd(int master_cd) {
		this.master_cd = master_cd;
	}
	public String getSangho_name() {
		return sangho_name;
	}
	public void setSangho_name(String sangho_name) {
		this.sangho_name = sangho_name;
	}
	public String getNumber1() {
		return number1;
	}
	public void setNumber1(String number1) {
		this.number1 = number1;
	}
	public String getNumber2() {
		return number2;
	}
	public void setNumber2(String number2) {
		this.number2 = number2;
	}
	public String getNumber3() {
		return number3;
	}
	public void setNumber3(String number3) {
		this.number3 = number3;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public String getJumin1() {
		return jumin1;
	}
	public void setJumin1(String jumin1) {
		this.jumin1 = jumin1;
	}
	public String getName2() {
		return name2;
	}
	public void setName2(String name2) {
		this.name2 = name2;
	}
	public String getJumin2() {
		return jumin2;
	}
	public void setJumin2(String jumin2) {
		this.jumin2 = jumin2;
	}
	public String getName3() {
		return name3;
	}
	public void setName3(String name3) {
		this.name3 = name3;
	}
	public String getJumin3() {
		return jumin3;
	}
	public void setJumin3(String jumin3) {
		this.jumin3 = jumin3;
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
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public int getRoom_cnt() {
		return room_cnt;
	}
	public void setRoom_cnt(int room_cnt) {
		this.room_cnt = room_cnt;
	}
	public String getWork_time1() {
		return work_time1;
	}
	public void setWork_time1(String work_time1) {
		this.work_time1 = work_time1;
	}
	public String getWork_time2() {
		return work_time2;
	}
	public void setWork_time2(String work_time2) {
		this.work_time2 = work_time2;
	}
	public String getWork_time3() {
		return work_time3;
	}
	public void setWork_time3(String work_time3) {
		this.work_time3 = work_time3;
	}
	public Integer getCnt1() {
		return cnt1;
	}
	public void setCnt1(Integer cnt1) {
		this.cnt1 = cnt1;
	}
	public Integer getCnt2() {
		return cnt2;
	}
	public void setCnt2(Integer cnt2) {
		this.cnt2 = cnt2;
	}
	public int getCnt3() {
		return cnt3;
	}
	public void setCnt3(int cnt3) {
		this.cnt3 = cnt3;
	}
	public int getCnt4() {
		return cnt4;
	}
	public void setCnt4(int cnt4) {
		this.cnt4 = cnt4;
	}
	public int getCnt5() {
		return cnt5;
	}
	public void setCnt5(int cnt5) {
		this.cnt5 = cnt5;
	}
	public int getCnt6() {
		return cnt6;
	}
	public void setCnt6(int cnt6) {
		this.cnt6 = cnt6;
	}
	public int getCnt7() {
		return cnt7;
	}
	public void setCnt7(int cnt7) {
		this.cnt7 = cnt7;
	}
	public int getCnt8() {
		return cnt8;
	}
	public void setCnt8(int cnt8) {
		this.cnt8 = cnt8;
	}
	public int getCnt9() {
		return cnt9;
	}
	public void setCnt9(int cnt9) {
		this.cnt9 = cnt9;
	}
	public String getArticle1_yn() {
		return article1_yn;
	}
	public void setArticle1_yn(String article1_yn) {
		this.article1_yn = article1_yn;
	}
	public String getArticle2_yn() {
		return article2_yn;
	}
	public void setArticle2_yn(String article2_yn) {
		this.article2_yn = article2_yn;
	}
	public String getArticle3_yn() {
		return article3_yn;
	}
	public void setArticle3_yn(String article3_yn) {
		this.article3_yn = article3_yn;
	}
	public String getArticle4_yn() {
		return article4_yn;
	}
	public void setArticle4_yn(String article4_yn) {
		this.article4_yn = article4_yn;
	}
	public String getArticle5_yn() {
		return article5_yn;
	}
	public void setArticle5_yn(String article5_yn) {
		this.article5_yn = article5_yn;
	}
	public String getArticle6_yn() {
		return article6_yn;
	}
	public void setArticle6_yn(String article6_yn) {
		this.article6_yn = article6_yn;
	}
	public String getArticle7_yn() {
		return article7_yn;
	}
	public void setArticle7_yn(String article7_yn) {
		this.article7_yn = article7_yn;
	}
	public String getArticle8_yn() {
		return article8_yn;
	}
	public void setArticle8_yn(String article8_yn) {
		this.article8_yn = article8_yn;
	}
	public String getArticle9_yn() {
		return article9_yn;
	}
	public void setArticle9_yn(String article9_yn) {
		this.article9_yn = article9_yn;
	}
	public String getOther1() {
		return other1;
	}
	public void setOther1(String other1) {
		this.other1 = other1;
	}
	public String getOther2() {
		return other2;
	}
	public void setOther2(String other2) {
		this.other2 = other2;
	}
	public String getOther3() {
		return other3;
	}
	public void setOther3(String other3) {
		this.other3 = other3;
	}
	public String getOther4() {
		return other4;
	}
	public void setOther4(String other4) {
		this.other4 = other4;
	}
	public String getOther5() {
		return other5;
	}
	public void setOther5(String other5) {
		this.other5 = other5;
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

	public String getType_cd() {
		return type_cd;
	}

	public void setType_cd(String type_cd) {
		this.type_cd = type_cd;
	}

	public String getFind_type_cd() {
		return find_type_cd;
	}

	public void setFind_type_cd(String find_type_cd) {
		this.find_type_cd = find_type_cd;
	}

	/*public int[] getArr_question_cd() {
		return arr_question_cd;
	}

	public void setArr_question_cd(int[] arr_question_cd) {
		this.arr_question_cd = arr_question_cd;
	}

	public int[] getArr_question2_cd() {
		return arr_question2_cd;
	}

	public void setArr_question2_cd(int[] arr_question2_cd) {
		this.arr_question2_cd = arr_question2_cd;
	}

	public String[] getArr_other() {
		return arr_other;
	}

	public void setArr_other(String[] arr_other) {
		this.arr_other = arr_other;
	}*/

	public int getQuestion_cd() {
		return question_cd;
	}

	public void setQuestion_cd(int question_cd) {
		this.question_cd = question_cd;
	}

	public int getQuestion2_cd() {
		return question2_cd;
	}

	public void setQuestion2_cd(int question2_cd) {
		this.question2_cd = question2_cd;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}

	public String getView_state() {
		return view_state;
	}

	public void setView_state(String view_state) {
		this.view_state = view_state;
	}

	public String getOther6() {
		return other6;
	}

	public void setOther6(String other6) {
		this.other6 = other6;
	}

	public String getOther7() {
		return other7;
	}

	public void setOther7(String other7) {
		this.other7 = other7;
	}

	public String getOther8() {
		return other8;
	}

	public void setOther8(String other8) {
		this.other8 = other8;
	}

	public String[] getArr_handle_cd() {
		return arr_handle_cd;
	}

	public void setArr_handle_cd(String[] arr_handle_cd) {
		this.arr_handle_cd = arr_handle_cd;
	}

	public String[] getArr_item_name() {
		return arr_item_name;
	}

	public void setArr_item_name(String[] arr_item_name) {
		this.arr_item_name = arr_item_name;
	}

	public String[] getArr_unit() {
		return arr_unit;
	}

	public void setArr_unit(String[] arr_unit) {
		this.arr_unit = arr_unit;
	}

	public String[] getArr_field1() {
		return arr_field1;
	}

	public void setArr_field1(String[] arr_field1) {
		this.arr_field1 = arr_field1;
	}

	public String[] getArr_field2() {
		return arr_field2;
	}

	public void setArr_field2(String[] arr_field2) {
		this.arr_field2 = arr_field2;
	}

	public String[] getArr_field3() {
		return arr_field3;
	}

	public void setArr_field3(String[] arr_field3) {
		this.arr_field3 = arr_field3;
	}

	public String[] getArr_field4() {
		return arr_field4;
	}

	public void setArr_field4(String[] arr_field4) {
		this.arr_field4 = arr_field4;
	}

	public String[] getArr_order_no() {
		return arr_order_no;
	}

	public void setArr_order_no(String[] arr_order_no) {
		this.arr_order_no = arr_order_no;
	}

	public String[] getArr_status() {
		return arr_status;
	}

	public void setArr_status(String[] arr_status) {
		this.arr_status = arr_status;
	}
	
	
//	public static void main(String[] args) {
//		for(int i=1; i<25; i++) {
//			System.out.println(String.format("%02d:00", i));
//		}
//	}
}

