package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;

public class Division {
	
	private int divseq;
	
	private int disseq;
	
	private String divtitle = "";
	
	private String divcont = "";
	
	private String name = "";
	
	private String pinno = "";
	
	private Date rdate;
	
	private String delcode = "0";
	
	private String memberId = "";

	public int getDivseq() {
		return divseq;
	}

	public void setDivseq(int divseq) {
		this.divseq = divseq;
	}

	public int getDisseq() {
		return disseq;
	}

	public void setDisseq(int disseq) {
		this.disseq = disseq;
	}

	public String getDivtitle() {
		return divtitle;
	}

	public void setDivtitle(String divtitle) {
		this.divtitle = divtitle;
	}

	public String getDivcont() {
		return divcont;
	}

	public void setDivcont(String divcont) {
		this.divcont = divcont;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPinno() {
		return pinno;
	}

	public void setPinno(String pinno) {
		this.pinno = pinno;
	}

	public Date getRdate() {
		return rdate;
	}

	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}

	public String getDelcode() {
		return delcode;
	}

	public void setDelcode(String delcode) {
		this.delcode = delcode;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	
}
