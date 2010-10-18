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
public class EBookFileVO extends Board implements Serializable {

    private int pfSeq;						//일련번호
    private int pfPiSeq;					//게시물 번호
    private int pfNttId;					//게시판 게시물번호
    
    private String pfPath = "";				//파일경로
    private String pfOrignlName = "";		//등록시 파일명
    private String pfStreName = "";			//실제파일명
    private String pfSize = "";				//파일 사이즈
    private String pfExtsn = "";			//파일 확장자
    private String pfDate = "";				//등록일
    
    
    public int getPfSeq() {
		return pfSeq;
	}

	public void setPfSeq(int pfSeq) {
		this.pfSeq = pfSeq;
	}

	public int getPfNttId() {
		return pfNttId;
	}

	public void setPfNttId(int pfNttId) {
		this.pfNttId = pfNttId;
	}

	public int getPfPiSeq() {
		return pfPiSeq;
	}

	public void setPfPiSeq(int pfPiSeq) {
		this.pfPiSeq = pfPiSeq;
	}

	public String getPfPath() {
		return pfPath;
	}

	public void setPfPath(String pfPath) {
		this.pfPath = pfPath;
	}

	public String getPfOrignlName() {
		return pfOrignlName;
	}

	public void setPfOrignlName(String pfOrignlName) {
		this.pfOrignlName = pfOrignlName;
	}

	public String getPfStreName() {
		return pfStreName;
	}

	public void setPfStreName(String pfStreName) {
		this.pfStreName = pfStreName;
	}
	
	public String getPfSize() {
		return pfSize;
	}

	public void setPfSize(String pfSize) {
		this.pfSize = pfSize;
	}

	public String getPfExtsn() {
		return pfExtsn;
	}

	public void setPfExtsn(String pfExtsn) {
		this.pfExtsn = pfExtsn;
	}

	public String getPfDate() {
		return pfDate;
	}

	public void setPfDate(String pfDate) {
		this.pfDate = pfDate;
	}

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
}
