package egovframework.com.cop.bbs.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 게시물 관리를 위한 VO 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@SuppressWarnings("serial")
public class BoardVO extends Board implements Serializable {

    /** 검색시작일 */
    private String searchBgnDe = "";
    
    /** 검색조건 */
    private String searchCnd = "";
    
    /** 검색종료일 */
    private String searchEndDe = "";
    
    /** 검색단어 */
    private String searchWrd = "";
    
    /** 정렬순서(DESC,ASC) */
    private long sortOrdr = 0L;

    /** 검색사용여부 */
    private String searchUseYn = "";

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

    /** 레코드 번호 */
    private int rowNo = 0;

    /** 최초 등록자명 */
    private String frstRegisterNm = "";

    /** 최종 수정자명 */
    private String lastUpdusrNm = "";

    /** 유효여부 */
    private String isExpired = "N";

    /** 상위 정렬 순서 */
    private String parntsSortOrdr = "";

    /** 상위 답변 위치 */
    private String parntsReplyLc = "";

    /** 게시판 유형코드 */
    private String bbsTyCode = "";
    
    /** 게시판 속성코드 */
    private String bbsAttrbCode = "";

    /** 게시판 명 */
    private String bbsNm = "";

    /** 파일첨부가능여부 */
    private String fileAtchPosblAt = "";
    
    /** 첨부가능파일숫자 */
    private int posblAtchFileNumber = 0;
    
    /** 답장가능여부 */
    private String replyPosblAt = "";
    
    /** 댓글가능여부 */
    private String commentPosblAt = "";
    
    /** 조회 수 증가 여부 */
    private boolean plusCount = false;
    
    /** 삭제코드 */
    private String delCode = "";     
    
    /** 비밀글여부 */
    private String secret = "";         

    /** 업로드 */
	private List file = new ArrayList();				
	
	/** 파일 수 */
	private int fileCount = 0;								
	
	/** 삭제파일 번호 */
	private String delFileIdx = "";							
	
	/** 업로드 파일정보 */
	private String fileInfo = "";	
	
    /** 보건소 */
    private String health = "";
    
	/**
	 * 옵션1
	 */
	private String option1 = "";    	

	/**
	 * 옵션2
	 */
	private String option2 = "";
	
	/**
	 * 옵션3
	 */
	private String option3 = "";
	
	/**
	 * 옵션4
	 */
	private String option4 = "";
	
	/**
	 * 옵션5
	 */
	private String option5 = "";
	
	/**
	 * 옵션6
	 */
	private String option6 = "";
	
	/**
	 * 옵션7
	 */
	private String option7 = "";
	
	/**
	 * 옵션8
	 */
	private String option8 = "";
	
	/**
	 * 옵션9
	 */
	private String option9 = "";
	
	/**
	 * 옵션10
	 */
	private String option10 = "";
	
	/**
	 * 옵션11
	 */
	private String option11 = "";    	

	/**
	 * 옵션12
	 */
	private String option12 = "";
	
	/**
	 * 옵션13
	 */
	private String option13 = "";
	
	/**
	 * 옵션14
	 */
	private String option14 = "";
	
	/**
	 * 옵션15
	 */
	private String option15 = "";
	
	/**
	 * 옵션16
	 */
	private String option16 = "";
	
	/**
	 * 옵션17
	 */
	private String option17 = "";
	
	/**
	 * 옵션18
	 */
	private String option18 = "";
	
	/**
	 * 옵션19
	 */
	private String option19 = "";
	
	/**
	 * 옵션20
	 */
	private String option20 = "";	
	
	/**
	 * 부서코드
	 */
	private String dept = "";	

	/**
	 * 동주민센터코드
	 */
	private String dong = "";
	
	/**
	 * 첨부파일명
	 */
	private String fileNm = "";
	
	private int fileSeq = 0;

	private String optionCnd = "";
	
	private String optionWrd = "";
	
	private String optionCnd2 = "";
	
	private String optionWrd2 = "";	
	
	private String optionCndLike = "";
	
	private String optionWrdLike = "";
	
	private String menuId = "";
	
	private String type = "9";
	
	private String categoryId = "";
	
	private int commentCnt = 0;
	
	
	
    public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getOptionCnd() {
		return optionCnd;
	}

	public void setOptionCnd(String optionCnd) {
		this.optionCnd = optionCnd;
	}

	public String getOptionWrd() {
		return optionWrd;
	}

	public void setOptionWrd(String optionWrd) {
		this.optionWrd = optionWrd;
	}
	
    public String getOptionCnd2() {
		return optionCnd2;
	}

	public void setOptionCnd2(String optionCnd2) {
		this.optionCnd2 = optionCnd2;
	}

	public String getOptionWrd2() {
		return optionWrd2;
	}

	public void setOptionWrd2(String optionWrd2) {
		this.optionWrd2 = optionWrd2;
	}	
	
    public String getOptionCndLike() {
		return optionCndLike;
	}

	public void setOptionCndLike(String optionCndLike) {
		this.optionCndLike = optionCndLike;
	}

	public String getOptionWrdLike() {
		return optionWrdLike;
	}

	public void setOptionWrdLike(String optionWrdLike) {
		this.optionWrdLike = optionWrdLike;
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

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	
	public String getHealth() {
		return health;
	}

	public void setHealth(String health) {
		this.health = health;
	}

	/**
     * searchBgnDe attribute를 리턴한다.
     * 
     * @return the searchBgnDe
     */
    public String getSearchBgnDe() {
	return searchBgnDe;
    }

    /**
     * searchBgnDe attribute 값을 설정한다.
     * 
     * @param searchBgnDe
     *            the searchBgnDe to set
     */
    public void setSearchBgnDe(String searchBgnDe) {
	this.searchBgnDe = searchBgnDe;
    }

    /**
     * searchCnd attribute를 리턴한다.
     * 
     * @return the searchCnd
     */
    public String getSearchCnd() {
	return searchCnd;
    }

    /**
     * searchCnd attribute 값을 설정한다.
     * 
     * @param searchCnd
     *            the searchCnd to set
     */
    public void setSearchCnd(String searchCnd) {
	this.searchCnd = searchCnd;
    }

    /**
     * searchEndDe attribute를 리턴한다.
     * 
     * @return the searchEndDe
     */
    public String getSearchEndDe() {
	return searchEndDe;
    }

    /**
     * searchEndDe attribute 값을 설정한다.
     * 
     * @param searchEndDe
     *            the searchEndDe to set
     */
    public void setSearchEndDe(String searchEndDe) {
	this.searchEndDe = searchEndDe;
    }

    /**
     * searchWrd attribute를 리턴한다.
     * 
     * @return the searchWrd
     */
    public String getSearchWrd() {
	return searchWrd;
    }

    /**
     * searchWrd attribute 값을 설정한다.
     * 
     * @param searchWrd
     *            the searchWrd to set
     */
    public void setSearchWrd(String searchWrd) {
	this.searchWrd = searchWrd;
    }

    /**
     * sortOrdr attribute를 리턴한다.
     * 
     * @return the sortOrdr
     */
    public long getSortOrdr() {
	return sortOrdr;
    }

    /**
     * sortOrdr attribute 값을 설정한다.
     * 
     * @param sortOrdr
     *            the sortOrdr to set
     */
    public void setSortOrdr(long sortOrdr) {
	this.sortOrdr = sortOrdr;
    }

    /**
     * searchUseYn attribute를 리턴한다.
     * 
     * @return the searchUseYn
     */
    public String getSearchUseYn() {
	return searchUseYn;
    }

    /**
     * searchUseYn attribute 값을 설정한다.
     * 
     * @param searchUseYn
     *            the searchUseYn to set
     */
    public void setSearchUseYn(String searchUseYn) {
	this.searchUseYn = searchUseYn;
    }

    /**
     * pageIndex attribute를 리턴한다.
     * 
     * @return the pageIndex
     */
    public int getPageIndex() {
	return pageIndex;
    }

    /**
     * pageIndex attribute 값을 설정한다.
     * 
     * @param pageIndex
     *            the pageIndex to set
     */
    public void setPageIndex(int pageIndex) {
	this.pageIndex = pageIndex;
    }

    /**
     * pageUnit attribute를 리턴한다.
     * 
     * @return the pageUnit
     */
    public int getPageUnit() {
	return pageUnit;
    }

    /**
     * pageUnit attribute 값을 설정한다.
     * 
     * @param pageUnit
     *            the pageUnit to set
     */
    public void setPageUnit(int pageUnit) {
	this.pageUnit = pageUnit;
    }

    /**
     * pageSize attribute를 리턴한다.
     * 
     * @return the pageSize
     */
    public int getPageSize() {
	return pageSize;
    }

    /**
     * pageSize attribute 값을 설정한다.
     * 
     * @param pageSize
     *            the pageSize to set
     */
    public void setPageSize(int pageSize) {
	this.pageSize = pageSize;
    }

    /**
     * firstIndex attribute를 리턴한다.
     * 
     * @return the firstIndex
     */
    public int getFirstIndex() {
	return firstIndex;
    }

    /**
     * firstIndex attribute 값을 설정한다.
     * 
     * @param firstIndex
     *            the firstIndex to set
     */
    public void setFirstIndex(int firstIndex) {
	this.firstIndex = firstIndex;
    }

    /**
     * lastIndex attribute를 리턴한다.
     * 
     * @return the lastIndex
     */
    public int getLastIndex() {
	return lastIndex;
    }

    /**
     * lastIndex attribute 값을 설정한다.
     * 
     * @param lastIndex
     *            the lastIndex to set
     */
    public void setLastIndex(int lastIndex) {
	this.lastIndex = lastIndex;
    }

    /**
     * recordCountPerPage attribute를 리턴한다.
     * 
     * @return the recordCountPerPage
     */
    public int getRecordCountPerPage() {
	return recordCountPerPage;
    }

    /**
     * recordCountPerPage attribute 값을 설정한다.
     * 
     * @param recordCountPerPage
     *            the recordCountPerPage to set
     */
    public void setRecordCountPerPage(int recordCountPerPage) {
	this.recordCountPerPage = recordCountPerPage;
    }

    /**
     * rowNo attribute를 리턴한다.
     * 
     * @return the rowNo
     */
    public int getRowNo() {
	return rowNo;
    }

    /**
     * rowNo attribute 값을 설정한다.
     * 
     * @param rowNo
     *            the rowNo to set
     */
    public void setRowNo(int rowNo) {
	this.rowNo = rowNo;
    }

    /**
     * frstRegisterNm attribute를 리턴한다.
     * 
     * @return the frstRegisterNm
     */
    public String getFrstRegisterNm() {
	return frstRegisterNm;
    }

    /**
     * frstRegisterNm attribute 값을 설정한다.
     * 
     * @param frstRegisterNm
     *            the frstRegisterNm to set
     */
    public void setFrstRegisterNm(String frstRegisterNm) {
	this.frstRegisterNm = frstRegisterNm;
    }

    /**
     * lastUpdusrNm attribute를 리턴한다.
     * 
     * @return the lastUpdusrNm
     */
    public String getLastUpdusrNm() {
	return lastUpdusrNm;
    }

    /**
     * lastUpdusrNm attribute 값을 설정한다.
     * 
     * @param lastUpdusrNm
     *            the lastUpdusrNm to set
     */
    public void setLastUpdusrNm(String lastUpdusrNm) {
	this.lastUpdusrNm = lastUpdusrNm;
    }

    /**
     * isExpired attribute를 리턴한다.
     * 
     * @return the isExpired
     */
    public String getIsExpired() {
	return isExpired;
    }

    /**
     * isExpired attribute 값을 설정한다.
     * 
     * @param isExpired
     *            the isExpired to set
     */
    public void setIsExpired(String isExpired) {
	this.isExpired = isExpired;
    }

    /**
     * parntsSortOrdr attribute를 리턴한다.
     * 
     * @return the parntsSortOrdr
     */
    public String getParntsSortOrdr() {
	return parntsSortOrdr;
    }

    /**
     * parntsSortOrdr attribute 값을 설정한다.
     * 
     * @param parntsSortOrdr
     *            the parntsSortOrdr to set
     */
    public void setParntsSortOrdr(String parntsSortOrdr) {
	this.parntsSortOrdr = parntsSortOrdr;
    }

    /**
     * parntsReplyLc attribute를 리턴한다.
     * 
     * @return the parntsReplyLc
     */
    public String getParntsReplyLc() {
	return parntsReplyLc;
    }

    /**
     * parntsReplyLc attribute 값을 설정한다.
     * 
     * @param parntsReplyLc
     *            the parntsReplyLc to set
     */
    public void setParntsReplyLc(String parntsReplyLc) {
	this.parntsReplyLc = parntsReplyLc;
    }

    /**
     * bbsTyCode attribute를 리턴한다.
     * 
     * @return the bbsTyCode
     */
    public String getBbsTyCode() {
	return bbsTyCode;
    }

    /**
     * bbsTyCode attribute 값을 설정한다.
     * 
     * @param bbsTyCode
     *            the bbsTyCode to set
     */
    public void setBbsTyCode(String bbsTyCode) {
	this.bbsTyCode = bbsTyCode;
    }

    /**
     * bbsAttrbCode attribute를 리턴한다.
     * 
     * @return the bbsAttrbCode
     */
    public String getBbsAttrbCode() {
	return bbsAttrbCode;
    }

    /**
     * bbsAttrbCode attribute 값을 설정한다.
     * 
     * @param bbsAttrbCode
     *            the bbsAttrbCode to set
     */
    public void setBbsAttrbCode(String bbsAttrbCode) {
	this.bbsAttrbCode = bbsAttrbCode;
    }

    /**
     * bbsNm attribute를 리턴한다.
     * 
     * @return the bbsNm
     */
    public String getBbsNm() {
	return bbsNm;
    }

    /**
     * bbsNm attribute 값을 설정한다.
     * 
     * @param bbsNm
     *            the bbsNm to set
     */
    public void setBbsNm(String bbsNm) {
	this.bbsNm = bbsNm;
    }

    /**
     * fileAtchPosblAt attribute를 리턴한다.
     * 
     * @return the fileAtchPosblAt
     */
    public String getFileAtchPosblAt() {
	return fileAtchPosblAt;
    }

    /**
     * fileAtchPosblAt attribute 값을 설정한다.
     * 
     * @param fileAtchPosblAt
     *            the fileAtchPosblAt to set
     */
    public void setFileAtchPosblAt(String fileAtchPosblAt) {
	this.fileAtchPosblAt = fileAtchPosblAt;
    }

    /**
     * posblAtchFileNumber attribute를 리턴한다.
     * 
     * @return the posblAtchFileNumber
     */
    public int getPosblAtchFileNumber() {
	return posblAtchFileNumber;
    }

    /**
     * posblAtchFileNumber attribute 값을 설정한다.
     * 
     * @param posblAtchFileNumber
     *            the posblAtchFileNumber to set
     */
    public void setPosblAtchFileNumber(int posblAtchFileNumber) {
	this.posblAtchFileNumber = posblAtchFileNumber;
    }

    /**
     * replyPosblAt attribute를 리턴한다.
     * 
     * @return the replyPosblAt
     */
    public String getReplyPosblAt() {
	return replyPosblAt;
    }

    /**
     * replyPosblAt attribute 값을 설정한다.
     * 
     * @param replyPosblAt
     *            the replyPosblAt to set
     */
    public void setReplyPosblAt(String replyPosblAt) {
	this.replyPosblAt = replyPosblAt;
    }

    /**
     * commentPosblAt attribute를 리턴한다.
     * 
     * @return the commentPosblAt
     */
    public String getCommentPosblAt() {
	return commentPosblAt;
    }       
    
    /**
     * commentPosblAt attribute 값을 설정한다.
     * 
     * @param commentPosblAt
     *            the commentPosblAt to set
     */
    public void setCommentPosblAt(String commentPosblAt) {
	this.commentPosblAt = commentPosblAt;
    }    
    
    /**
     * plusCount attribute를 리턴한다.
     * @return the plusCount
     */
    public boolean isPlusCount() {
        return plusCount;
    }

    /**
     * plusCount attribute 값을 설정한다.
     * @param plusCount the plusCount to set
     */
    public void setPlusCount(boolean plusCount) {
        this.plusCount = plusCount;
    }

    /**
     * delCode attribute를 리턴한다.
     * 
     * @return the delCode
     */
    public String getDelCode() {
	return delCode;
    }

    /**
     * delCode attribute 값을 설정한다.
     * 
     * @param delCode
     *            the delCode to set
     */
    public void setDelCode(String delCode) {
	this.delCode = delCode;
    }
    
    /**
     * secret attribute를 리턴한다.
     * 
     * @return the secret
     */
    public String getSecret() {
	return secret;
    }

    /**
     * secret attribute 값을 설정한다.
     * 
     * @param secret
     *            the secret to set
     */
    public void setSecret(String secret) {
	this.secret = secret;
    }  
    
    /**
     * file attribute를 리턴한다.
     * 
     * @return the file
     */
	public List getFile() {
		return file;
	}
	
    /**
     * file attribute 값을 설정한다.
     * 
     * @param file
     *            the file to set
     */
	public void setFile(List file) {
		this.file = file;
	}
	
    /**
     * delFileIdx attribute를 리턴한다.
     * 
     * @return the delFileIdx
     */
	public String getDelFileIdx() {
		return delFileIdx;
	}
	
    /**
     * delFileIdx attribute 값을 설정한다.
     * 
     * @param delFileIdx
     *            the delFileIdx to set
     */
	public void setDelFileIdx(String delFileIdx) {
		this.delFileIdx = delFileIdx;
	}
	
    /**
     * fileInfo attribute를 리턴한다.
     * 
     * @return the fileInfo
     */
	public String getFileInfo() {
		return fileInfo;
	}
	
    /**
     * fileInfo attribute 값을 설정한다.
     * 
     * @param fileInfo
     *            the fileInfo to set
     */
	public void setFileInfo(String fileInfo) {
		this.fileInfo = fileInfo;
	}
	
    /**
     * fileCount attribute를 리턴한다.
     * 
     * @return the fileCount
     */
	public int getFileCount() {
		return fileCount;
	}
	
    /**
     * fileCount attribute 값을 설정한다.
     * 
     * @param fileCount
     *            the fileCount to set
     */
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	} 
	
	/**
	 * option1 attribute를 리턴한다.
	 * @return the option1
	 */
	public String getOption1() {
		return option1;
	}

	/**
	 * option1 attribute 값을 설정한다.
	 * @param option1 the option1 to set
	 */
	public void setOption1(String option1) {
		this.option1 = option1;
	}

	/**
	 * option2 attribute를 리턴한다.
	 * @return the option2
	 */
	public String getOption2() {
		return option2;
	}

	/**
	 * option2 attribute 값을 설정한다.
	 * @param option2 the option2 to set
	 */
	public void setOption2(String option2) {
		this.option2 = option2;
	}
	
	/**
	 * option3 attribute를 리턴한다.
	 * @return the option3
	 */
	public String getOption3() {
		return option3;
	}

	/**
	 * option3 attribute 값을 설정한다.
	 * @param option3 the option3 to set
	 */
	public void setOption3(String option3) {
		this.option3 = option3;
	}
	
	/**
	 * option4 attribute를 리턴한다.
	 * @return the option4
	 */
	public String getOption4() {
		return option4;
	}

	/**
	 * option4 attribute 값을 설정한다.
	 * @param option4 the option4 to set
	 */
	public void setOption4(String option4) {
		this.option4 = option4;
	}
	
	/**
	 * option5 attribute를 리턴한다.
	 * @return the option5
	 */
	public String getOption5() {
		return option5;
	}

	/**
	 * option5 attribute 값을 설정한다.
	 * @param option5 the option5 to set
	 */
	public void setOption5(String option5) {
		this.option5 = option5;
	}
	
	/**
	 * option6 attribute를 리턴한다.
	 * @return the option6
	 */
	public String getOption6() {
		return option6;
	}

	/**
	 * option6 attribute 값을 설정한다.
	 * @param option6 the option6 to set
	 */
	public void setOption6(String option6) {
		this.option6 = option6;
	}
	
	/**
	 * option7 attribute를 리턴한다.
	 * @return the option7
	 */
	public String getOption7() {
		return option7;
	}

	/**
	 * option7 attribute 값을 설정한다.
	 * @param option7 the option7 to set
	 */
	public void setOption7(String option7) {
		this.option7 = option7;
	}
	
	/**
	 * option8 attribute를 리턴한다.
	 * @return the option8
	 */
	public String getOption8() {
		return option8;
	}

	/**
	 * option8 attribute 값을 설정한다.
	 * @param option8 the option8 to set
	 */
	public void setOption8(String option8) {
		this.option8 = option8;
	}
	
	/**
	 * option9 attribute를 리턴한다.
	 * @return the option9
	 */
	public String getOption9() {
		return option9;
	}

	/**
	 * option9 attribute 값을 설정한다.
	 * @param option9 the option9 to set
	 */
	public void setOption9(String option9) {
		this.option9 = option9;
	}
	
	/**
	 * option10 attribute를 리턴한다.
	 * @return the option10
	 */
	public String getOption10() {
		return option10;
	}

	/**
	 * option10 attribute 값을 설정한다.
	 * @param option10 the option10 to set
	 */
	public void setOption10(String option10) {
		this.option10 = option10;
	}
	    
	/**
	 * option11 attribute를 리턴한다.
	 * @return the option11
	 */
	public String getOption11() {
		return option11;
	}

	/**
	 * option11 attribute 값을 설정한다.
	 * @param option11 the option11 to set
	 */
	public void setOption11(String option11) {
		this.option11 = option11;
	}

	/**
	 * option12 attribute를 리턴한다.
	 * @return the option12
	 */
	public String getOption12() {
		return option12;
	}

	/**
	 * option12 attribute 값을 설정한다.
	 * @param option12 the option12 to set
	 */
	public void setOption12(String option12) {
		this.option12 = option12;
	}
	
	/**
	 * option13 attribute를 리턴한다.
	 * @return the option13
	 */
	public String getOption13() {
		return option13;
	}

	/**
	 * option13 attribute 값을 설정한다.
	 * @param option13 the option13 to set
	 */
	public void setOption13(String option13) {
		this.option13 = option13;
	}
	
	/**
	 * option14 attribute를 리턴한다.
	 * @return the option14
	 */
	public String getOption14() {
		return option14;
	}

	/**
	 * option14 attribute 값을 설정한다.
	 * @param option14 the option14 to set
	 */
	public void setOption14(String option14) {
		this.option14 = option14;
	}
	
	/**
	 * option15 attribute를 리턴한다.
	 * @return the option15
	 */
	public String getOption15() {
		return option15;
	}

	/**
	 * option15 attribute 값을 설정한다.
	 * @param option15 the option15 to set
	 */
	public void setOption15(String option15) {
		this.option15 = option15;
	}
	
	/**
	 * option16 attribute를 리턴한다.
	 * @return the option16
	 */
	public String getOption16() {
		return option16;
	}

	/**
	 * option16 attribute 값을 설정한다.
	 * @param option16 the option16 to set
	 */
	public void setOption16(String option16) {
		this.option16 = option16;
	}
	
	/**
	 * option17 attribute를 리턴한다.
	 * @return the option17
	 */
	public String getOption17() {
		return option17;
	}

	/**
	 * option17 attribute 값을 설정한다.
	 * @param option17 the option17 to set
	 */
	public void setOption17(String option17) {
		this.option17 = option17;
	}
	
	/**
	 * option18 attribute를 리턴한다.
	 * @return the option18
	 */
	public String getOption18() {
		return option18;
	}

	/**
	 * option18 attribute 값을 설정한다.
	 * @param option18 the option18 to set
	 */
	public void setOption18(String option18) {
		this.option18 = option18;
	}
	
	/**
	 * option19 attribute를 리턴한다.
	 * @return the option19
	 */
	public String getOption19() {
		return option19;
	}

	/**
	 * option19 attribute 값을 설정한다.
	 * @param option19 the option19 to set
	 */
	public void setOption19(String option19) {
		this.option19 = option19;
	}
	
	/**
	 * option20 attribute를 리턴한다.
	 * @return the option20
	 */
	public String getOption20() {
		return option20;
	}

	/**
	 * option20 attribute 값을 설정한다.
	 * @param option20 the option20 to set
	 */
	public void setOption20(String option20) {
		this.option20 = option20;
	}
	
	/**
	 * fileNm attribute를 리턴한다.
	 * @return the fileNm
	 */
	public String getFileNm() {
		return fileNm; 
	}

	/**
	 * fileNm attribute 값을 설정한다.
	 * @param fileNm the fileNm to set
	 */
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	
	
    /**
     * pageIndex attribute를 리턴한다.
     * 
     * @return the pageIndex
     */
    public int getFileSeq() {
	return fileSeq;
    }

    /**
     * pageIndex attribute 값을 설정한다.
     * 
     * @param pageIndex
     *            the pageIndex to set
     */
    public void setFileSeq(int fileSeq) {
	this.fileSeq = fileSeq;
    }
    
    public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
}
