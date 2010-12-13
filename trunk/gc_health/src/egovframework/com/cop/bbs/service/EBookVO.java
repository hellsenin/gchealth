package egovframework.com.cop.bbs.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * EBOOK 관리를 위한 VO 클래스
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
public class EBookVO extends EBookFileVO implements Serializable {

    private int piSeq;						//일련번호
    private int piPgSeq;					//분야 일련번호
    private int piNttId;					//게시물 번호
    
    private String piTitle = "";			//제목
    private String piEBookLink = "";		//ebook링크
    private String piDate = "";				//등록일
    private String piDelcode = "";			//삭제코드
    private String searchWrd = "";			//검색단어
    
    
    public int getPiSeq() {
		return piSeq;
	}

    public void setPiSeq(int piSeq) {
		this.piSeq = piSeq;
	}

	public int getPiPgSeq() {
		return piPgSeq;
	}

	public void setPiPgSeq(int piPgSeq) {
		this.piPgSeq = piPgSeq;
	}

	public int getPiNttId() {
		return piNttId;
	}

	public void setPiNttId(int piNttId) {
		this.piNttId = piNttId;
	}

	public String getPiTitle() {
		return piTitle;
	}

	public void setPiTitle(String piTitle) {
		this.piTitle = piTitle;
	}

	public String getPiEBookLink() {
		return piEBookLink;
	}

	public void setPiEBookLink(String piEBookLink) {
		this.piEBookLink = piEBookLink;
	}

	public String getPiDate() {
		return piDate;
	}

	public void setPiDate(String piDate) {
		this.piDate = piDate;
	}
	
	public String getPiDelcode() {
		return piDelcode;
	}

	public void setPiDelcode(String piDelcode) {
		this.piDelcode = piDelcode;
	}

	public String getSearchWrd() {
		return searchWrd;
	}

	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}
	

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
}
