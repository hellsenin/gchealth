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
	
	function fn_egov_regist_notice() {
				
		if (document.board.nttSj.value==""){
				alert("\회수제품명을 입력하세요.");
				return false;
		} 
		
		if (confirm('등록하시겠습니까?')) {
			return true;
		}
		return false;
	}
	
</script>

<script type="text/javascript" src="/health/open_content/system/js/common_ui.js"></script>
</head>

<body style="background:none;padding:10px;">

<h2 style="padding:15px 0 15px 0;">부적합 식품</h2>
<p class="title_deco"></p>
<div class="body">
<form id="board" name="board" action="/admin/bbs/insertBoardArticle.do" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_regist_notice();">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="bbsId" value="<c:out value='${param.bbsId}'/>" />
<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
<input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />
<input type="hidden" name="secret" value="N" />
<input type="hidden" name="ntcrNm" value="${user.webMemId}" />			

<table summary="제목,작성자,등록일자,연락처,내용,첨부파일 제공" class="default_write">
    <caption>
    게시물제목
    </caption>
    <tr>
        <th scope="row" width="20%" class="title_1"><label for="sr_title">회수제품명</label> </th>
        <td colspan="3" class="title_td"><input type="text" id="sr_title" name="nttSj" /></td>
    </tr>
    <tr>
        <th scope="row" class="title"><label for="sr_name">작성자</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="sr_name" name="ntcrNm" value="${user.webMemId}" /></td>
    </tr>
    <tr>
        <th scope="row" class="title"><label for="option1">제조일자 및 유통기한</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option1" name="option1" /></td>
    </tr>
    <tr>
        <th scope="row" class="title"><label for="option2">회수사유</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option2" name="option2" /></td>
    </tr>
    <tr>
        <th scope="row" class="title"><label for="option3">회수방법</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option3" name="option3" /></td>
    </tr>
    <tr>
        <th scope="row" class="title"><label for="option4">회수영업자</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option4" name="option4" /></td>
    </tr>
    <tr>
        <th scope="row" class="title"><label for="option5">영업자주소</label> </th>
        <td class="title_data"><input type="text" id="option5" name="option5" /></td>
		<th scope="row" class="title"><label for="option6">연락처</label> </th>
        <td class="title_data"><input type="text" id="option6" name="option6" /></td>
    </tr>
    <tr>
        <th scope="row"><label for="sr_contents">기타</label> </th>
        <td colspan="3"><textarea rows="5" cols="50" id="sr_contents" name="nttCn"></textarea></td>
    </tr>
    <tr>
        <th scope="row"><label for="file_1">첨부파일 </label></th>
        <td colspan="3"><input type="file" name="file_1" id="file_1" value="첨부파일" /></td>
    </tr>
</table>

<div class="board_btn_set mt13">
    <span class="btn_del"><input type="submit" value="등록하기" /></span>
    <!-- >span class="btn_del"><a href="#">삭제하기</a></span-->
    <span class="btn_list"><a href="/admin/bbs/selectBoardList.do?bbsId=${param.bbsId}">목록보기</a></span>
</div>
</form>

</div>

</body>
</html>