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
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>

<script type="text/javascript"> 
	
	function fn_egov_update_notice() {
				
		if (document.board.nttSj.value==""){
				alert("\제목을 입력하세요.");
				return false;
		} 
		if (document.board.nttCn.value==""){
				alert("\내용을 입력하세요.");
				return false;
		} 
		
		if (confirm('수정하시겠습니까?')) {
			return true;
		}
		return false;
	}
	
</script>

<script type="text/javascript" src="/health/open_content/system/js/common_ui.js"></script>
</head>

<body style="background:none;padding:10px;">

<h2 style="padding:15px 0 15px 0;">건강식단 정보</h2>
<p class="title_deco"></p>
<div class="body">
<form name="board" action="/admin/bbs/updateBoardArticle.do" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_update_notice();">
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
<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
<input type="hidden" name="categoryId" value="${param.categoryId}" />
			
<table summary="제목,작성자,등록일자,연락처,내용,첨부파일 제공" class="default_write">
    <caption>
    게시물제목
    </caption>
    <tr>
        <th scope="row" class="title_1"><label for="sr_title">제목</label> </th>
        <td colspan="3" class="title_td"><input type="text" id="sr_title" name="nttSj" value="${result.nttSj}" /></td>
    </tr>
	<tr>
        <th scope="row" class="title"><label for="option2">식단 등록일</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option2" name="option2" value="${result.option2}" /><a href="javascript:Calendar_D(board.option2)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a></td>
    </tr>
    <tr>
        <th scope="row" rowspan="6" class="title">아침 </th>
		<th scope="row" class="title"><label for="option3">밥</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option3" name="option3" value="${result.option3}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option4">국</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option4" name="option4" value="${result.option4}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option5">반찬1</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option5" name="option5" value="${result.option5}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option6">반찬2</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option6" name="option6" value="${result.option6}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option7">반찬3</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option7" name="option7" value="${result.option7}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option8">반찬4</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option8" name="option8" value="${result.option8}" /></td>
    </tr>
	<tr>
        <th scope="row" rowspan="6" class="title">점심 </th>
		<th scope="row" class="title"><label for="option9">밥</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option9" name="option9" value="${result.option9}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option10">국</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option10" name="option10" value="${result.option10}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option11">반찬1</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option11" name="option11" value="${result.option11}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option12">반찬2</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option12" name="option12" value="${result.option12}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option13">반찬3</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option13" name="option13" value="${result.option13}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option14">반찬4</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option14" name="option14" value="${result.option14}" /></td>
    </tr>
	<tr>
        <th scope="row" rowspan="6" class="title">저녁 </th>
		<th scope="row" class="title"><label for="option15">밥</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option15" name="option15" value="${result.option15}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option16">국</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option16" name="option16" value="${result.option16}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option17">반찬1</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option17" name="option17" value="${result.option17}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option18">반찬2</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option18" name="option18" value="${result.option18}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option19">반찬3</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option19" name="option19" value="${result.option19}" /></td>
    </tr>
	<tr>
		<th scope="row" class="title"><label for="option20">반찬4</label> </th>
        <td colspan="2" class="title_data"><input type="text" id="option20" name="option20" value="${result.option20}" /></td>
    </tr>
</table>

<div class="board_btn_set mt13">
    <span class="btn_del"><input type="submit" value="수정하기" /></span>
    <span class="btn_list"><a href="/admin/bbs/selectBoardList.do?bbsId=${param.bbsId}">목록보기</a></span>
</div>
</form>

</div>

</body>
</html>