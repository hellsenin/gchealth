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
public class EBookGroupVO extends Board implements Serializable {

    private int pgSeq;					//일련번호
    private String pgTitle = "";		//분야별명
    private String pgDate = "";			//등록일
    
    public int getPgSeq() {
		return pgSeq;
	}

	public void setPgSeq(int pgSeq) {
		this.pgSeq = pgSeq;
	}

	public String getPgTitle() {
		return pgTitle;
	}

	public void setPgTitle(String pgTitle) {
		this.pgTitle = pgTitle;
	}

	public String getPgDate() {
		return pgDate;
	}

	public void setPgDate(String pgDate) {
		this.pgDate = pgDate;
	}


	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
}
