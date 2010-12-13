package egovframework.kr.go.geumcheon.health.vo;

import java.util.Date;

public class Discussion {

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 첫페이지 인덱스 */
    private int firstIndex = 1;

    /** 마지막페이지 인덱스 */
    private int lastIndex = 1;

    /** 페이지당 레코드 개수 */
    private int recordCountPerPage = 10;

	private int disseq = 0;
	
	private String distitle = "";
	
	private String discont = "";
	
	private Date dissdate;
	
	private Date disedate;
	
	private String dept = "";
	
	private String name = "";
	
	private String ipaddress = "";
	
	private String gubun = "";
	
	private Date rdate;
	
	private String delcode = "0";
	
	private int hit;

	private String memberId = "";
	
	private String pinno = "";
	
	
	
	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPinno() {
		return pinno;
	}

	public void setPinno(String pinno) {
		this.pinno = pinno;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public int getDisseq() {
		return disseq;
	}

	public void setDisseq(int disseq) {
		this.disseq = disseq;
	}

	public String getDistitle() {
		return distitle;
	}

	public void setDistitle(String distitle) {
		this.distitle = distitle;
	}

	public String getDiscont() {
		return discont;
	}

	public void setDiscont(String discont) {
		this.discont = discont;
	}

	public Date getDissdate() {
		return dissdate;
	}

	public void setDissdate(Date dissdate) {
		this.dissdate = dissdate;
	}

	public Date getDisedate() {
		return disedate;
	}

	public void setDisedate(Date disedate) {
		this.disedate = disedate;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIpaddress() {
		return ipaddress;
	}

	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
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

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}
	
	
}
