package egovframework.kr.go.geumcheon.health.vo;


public class PageBean {

    private int pageIndex = 1;				// 현재페이지
    private int pageUnit = 10;				// 페이지갯수
    private int pageSize = 10;				// 페이지사이즈
    private int firstIndex = 1;				// 첫페이지 인덱스
    private int lastIndex = 1;				// 마지막페이지 인덱스
    private int recordCountPerPage = 10;	// 페이지당 레코드 개수
    private String searchCondition = "1";	// 검색 분류
    private String searchKeyword = "";		// 검색 키워드
    
    private String view_state = "";
    
    private String menuId = "0602010101";

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

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getView_state() {
		return view_state;
	}

	public void setView_state(String view_state) {
		this.view_state = view_state;
	}
	
    
    
    
}