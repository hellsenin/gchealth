<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%pageContext.setAttribute("crlf", "\r\n");%>

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
	
	function fn_egov_delete_notice() {
		
		if (confirm('삭제하시겠습니까?')) {
			return true;
		}
		return false;
	}
	
</script>

<script type="text/javascript" src="/health/open_content/system/js/common_ui.js"></script>
</head>

<body style="background:none;padding:10px;">

<h2 style="padding:15px 0 15px 0;">
	<c:choose>
		<c:when test="${param.optionWrd2 == '1'}">의료기관(병원)</c:when>
		<c:when test="${param.optionWrd2 == '2'}">의료기관(의원)</c:when>
		<c:when test="${param.optionWrd2 == '3'}">의료기관(치과의원)</c:when>
		<c:when test="${param.optionWrd2 == '4'}">의료기관(한의원)</c:when>
		<c:when test="${param.optionWrd2 == '5'}">의료기관(약국)</c:when>
		<c:when test="${param.optionWrd2 == '6'}">의료기관(의료기기판매업소)</c:when>
		<c:when test="${param.optionWrd2 == '7'}">의료기관(안경원)</c:when>
	</c:choose>
</h2>
<p class="title_deco"></p>
<div class="body">
<form name="frm" method="post" action="/admin/bbs/deleteBoardArticle.do" onsubmit="return fn_egov_delete_notice();">
<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
<input type="hidden" name="categoryId" value="<c:out value='${param.categoryId}'/>" />
<input type="hidden" name="${param.optionCnd}" value="${param.optionWrd}" />
<input type="hidden" name="${param.optionCnd2}" value="${param.optionWrd2}" />
<input type="hidden" name="optionCnd" value="${param.optionCnd}" />
<input type="hidden" name="optionCnd2" value="${param.optionCnd2}" />
<input type="hidden" name="optionWrd" value="${param.optionWrd}" />
<input type="hidden" name="optionWrd2" value="${param.optionWrd2}" />

<table summary="제목,작성자,등록일자,연락처,내용,첨부파일 제공" class="default_view">
    <caption>
    게시물제목
    </caption>
    <tr>
        <th width="10%" class="title_1	" scope="row">시설명</th>
        <td colspan="3" class="title_td"><p><c:out value="${result.nttSj}" /></p></td>
    </tr>
    <tr>
        <th scope="row">등록일</th>
        <td><p><c:out value="${result.frstRegisterPnttm}"/></p></td>
    </tr>
	<tr>
        <th scope="row">소재지</th>
        <td colspan="3"><p><c:out value="${result.option3}" /></p></td>
    </tr>
	<tr>
        <th scope="row">전화번호</th>
        <td colspan="3"><p><c:out value="${result.option4}" /></p></td>
    </tr>
	<tr>
        <th scope="row">좌표</th>
        <td colspan="3">X: <c:out value="${result.option5}" /> Y: <c:out value="${result.option6}" /></td>
    </tr>
</table>

<div class="board_btn_set mt13">
	<span class="btn_del"><a href="/admin/bbs/forUpdateBoardArticle.do?bbsId=${param.bbsId}&amp;nttId=${result.nttId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}&amp;optionCnd2=${param.optionCnd2}&amp;optionWrd2=${param.optionWrd2}">수정하기</a></span>
	<span class="btn_del"><input type="submit" value="삭제하기" /></span>
    <span class="btn_list"><a href="/admin/bbs/selectBoardList.do?bbsId=${param.bbsId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}&amp;optionCnd2=${param.optionCnd2}&amp;optionWrd2=${param.optionWrd2}">목록보기</a></span>
</div>

</form>
</div>

</body>
</html>
