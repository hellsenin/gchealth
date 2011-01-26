<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<c:set var="path" value="${fn:split(currMenu.fullPath, '/')}" />
    <c:set var="title" value=""/>
	<c:forEach var="x" begin="0" end="${fn:length(path)-1}">
		<c:set var="title" value="${path[x]}&lt;${title}"/>
	</c:forEach>
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

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

<script type="text/javascript" src="/health/open_content/system/js/common_ui.js"></script>
</head>

<body style="background:none;padding:10px;">

<h2 style="padding:15px 0 15px 0;">
	<c:choose>
		<c:when test="${param.optionWrd == '1'}">
			<c:choose>
				<c:when test="${param.optionWrd2 == '1'}">의료기관(병원)</c:when>
				<c:when test="${param.optionWrd2 == '2'}">의료기관(의원)</c:when>
				<c:when test="${param.optionWrd2 == '3'}">의료기관(치과의원)</c:when>
				<c:when test="${param.optionWrd2 == '4'}">의료기관(한의원)</c:when>
				<c:when test="${param.optionWrd2 == '5'}">의료기관(약국)</c:when>
				<c:when test="${param.optionWrd2 == '6'}">의료기관(의료기기판매업소)</c:when>
				<c:when test="${param.optionWrd2 == '7'}">의료기관(안경원)</c:when>
			</c:choose>
		</c:when>
		<c:when test="${param.optionWrd == '2'}">야간 진료기관</c:when>
		<c:when test="${param.optionWrd == '3'}">
			<c:choose>
				<c:when test="${param.optionWrd2 == '1'}">휴일진료기관(병원)</c:when>
				<c:when test="${param.optionWrd2 == '2'}">휴일진료기관(의원)</c:when>
				<c:when test="${param.optionWrd2 == '3'}">휴일진료기관(치과의원)</c:when>
				<c:when test="${param.optionWrd2 == '4'}">휴일진료기관(한의원)</c:when>
			</c:choose>
		</c:when>
		<c:when test="${param.optionWrd == '4'}">외국인 진료기관</c:when>
		<c:when test="${param.optionWrd == '5'}">가정간호 의료기관</c:when>
		<c:when test="${param.optionWrd == '6'}">당번약국</c:when>
	</c:choose>
</h2>
<p class="title_deco"></p>
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

<form name="frm" action="/admin/bbs/selectBoardList.do?bbsId=${param.bbsId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}&amp;optionCnd2=${param.optionCnd2}&amp;optionWrd2=${param.optionWrd2}" method="post" onSubmit="return fn_bbs_search_check();">
<div class="board_top clearfix">
    <div class="fl_l"> <span>${resultCnt}건 [${searchVO.pageIndex} / 1 Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
        <select name="searchCnd" title="구분선택">
            <option value="" <c:if test="${searchVO.searchCnd == ''}">selected="selected"</c:if> >선택</option>
			<option value="NTT_SJ" <c:if test="${searchVO.searchCnd == 'NTT_SJ'}">selected="selected"</c:if> >시설명</option>
			<option value="OPTION3" <c:if test="${searchVO.searchCnd == 'OPTION3'}">selected="selected"</c:if> >소재지(동별)</option>
			<option value="OPTION4" <c:if test="${searchVO.searchCnd == 'OPTION4'}">selected="selected"</c:if> >전화번호</option>
        </select>
        <input type="text" title="검색어" class="text" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' />
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<table class="default_list" summary="번호,제목, 작성자, 등록일, 첨부파일 구성">
    <caption>
    게시물리스트
    </caption>
    <thead>
        <tr>
            <th width="10%" scope="col">번호</th>
            <th width="30%" scope="col">시설명</th>
            <th width="30%" scope="col">소재지</th>
            <th width="20%" scope="col">전화번호</th>
            <th width="10%" scope="col">지도</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach var="result" items="${resultList}" varStatus="status">
        <tr>
            <td><c:out value="${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}"/></td>
            <td class="tal"><a href="/admin/bbs/selectBoardArticle.do?bbsId=${param.bbsId}&amp;nttId=${result.nttId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}&amp;optionCnd2=${param.optionCnd2}&amp;optionWrd2=${param.optionWrd2}"><c:out value="${result.nttSj}" /></a></td>
            <td class="tal"><c:out value="${result.option3}" /></td>
			<td><c:out value="${result.option4}"/></td>
            <td>지도</td>
        </tr>
        <c:set var="resultCnt" value="${resultCnt-1}" />
        </c:forEach>
    </tbody>
</table>

<ol class="paging">
    <!-- 이미지들어간곳은 붙여서 코딩하기 바람 -->
    ${pageNav}
</ol>

<div class="board_btn_set send_mg" style="padding-top:15px;"> 
	<span class="register">
		<a href="/admin/bbs/addBoardArticle.do?bbsId=${param.bbsId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}&amp;optionCnd2=${param.optionCnd2}&amp;optionWrd2=${param.optionWrd2}">등록하기</a>
	</span>
</div>

</div>

</body>
</html>
