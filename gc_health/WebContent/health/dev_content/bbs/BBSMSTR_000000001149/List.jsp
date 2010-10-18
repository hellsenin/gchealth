<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

	function fn_bbs_search_check() {

	var searchCnd = document.frm.searchCnd.value;
	var searchWrd = document.frm.searchWrd.value;
	
		if(searchCnd == "" || searchCnd == null){
			
			alert("검색조건을 선택하세요");
			return false;
		
		} else if(searchWrd == "" || searchWrd == null){
			
			alert("검색어를 입력하세요");
			return false;
		
		} else {
			
			document.frm.searchWrd.value = searchString;
			return true;
		}
	
	}

</script>

<div class="body">

<!-- div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_004.gif) 470px top no-repeat;">
    <ul class="list">
        <li>우리 보건소에서는 금천구민 및 보건소 홈페이지 방문자를 대상으로<strong> 합리적이고 <br />
          안전한 의약품 사용</strong>에 도움을 드리고자
의약품 관련 질문에 답변을 드립니다.</li>
        <li>마약류 및 유해약품 관련정보, 의약품 복용 및 저장방법, 일반의약품 선택 및 사용에 <br />대한 질문, 의약품 관련 정보 및 
기타 의약품 관련 문의사항 등 무엇이든 물어보세요</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div-->

<form name="frm" action="/health/bbs/selectBoardList.do?bbsId=${param.bbsId}&amp;categoryId=${param.categoryId}" method="post" onsubmit="return fn_bbs_search_check();">
<div class="board_top clearfix">
    <div class="fl_l"> <span>${resultCnt}건 [${searchVO.pageIndex} / ${totalPage} Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
		<label for="searchCnd" class="blind">구분선택</label>
        <select name="searchCnd" id="searchCnd">
            <option value="" <c:if test="${searchVO.searchCnd == ''}">selected="selected"</c:if> >선택</option>
			<option value="NTT_SJ" <c:if test="${searchVO.searchCnd == 'NTT_SJ'}">selected="selected"</c:if> >제목</option>
			<option value="NTT_CN" <c:if test="${searchVO.searchCnd == 'NTT_CN'}">selected="selected"</c:if> >내용</option>
        </select>
		<label for="searchWrd" class="blind">검색어</label>
        <input type="text" id="searchWrd" class="text" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' />
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<table class="default_list" summary="번호, 제목, 등록일, 첨부파일, 조회수로 구성">
    <caption>자료실</caption>
    <thead>
        <tr>
            <th width="10%" scope="col">번호</th>
            <th width="50%" scope="col">제목</th>
            <th width="20%" scope="col">등록일</th>
            <th width="10%" scope="col">첨부파일</th>
            <th width="10%" scope="col">조회수</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach var="result" items="${resultList}" varStatus="status">
        <tr>
            <td><c:out value="${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}"/></td>
            <td class="tal"><a href="/health/bbs/selectBoardArticle.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;nttId=${result.nttId}"><c:out value="${result.nttSj}" /></a></td>
			<td><c:out value="${result.frstRegisterPnttm}"/></td>
            <td>
            	<c:if test="${result.fileNm != null}">
					<a href="/cmm/fms/FileDown.do?atchFileId=<c:out value='${result.atchFileId}'/>&fileSn=<c:out value='${result.fileSeq}'/>"><img src="http://www.geumcheon.go.kr/open_content/images/common/icon/icon_form.gif" alt="첨부파일" /></a>
				</c:if>
            </td>
            <td><c:out value="${result.inqireCo}"/></td>
        </tr>
        <c:set var="resultCnt" value="${resultCnt-1}" />
        </c:forEach>
    </tbody>
</table>

<ol class="paging">
    <!-- 이미지들어간곳은 붙여서 코딩하기 바람 -->
    ${pageNav}
</ol>

</div>
