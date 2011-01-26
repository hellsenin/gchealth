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

<h2 style="padding:15px 0 15px 0;">약국간 의약품 나눔센터</h2>
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
        <th scope="row" width="20%" class="title_1"><label for="sr_title">약국명</label> </th>
        <td colspan="3" class="title_td"><input type="text" id="sr_title" name="nttSj" value="${result.nttSj}" /></td>
    </tr>
    <tr>
        <th scope="row"><label for="option2">약품명</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option2" name="option2" style="width:300px;" value="${result.option2}" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="option5">성분</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option5" name="option5" style="width:300px;" value="${result.option5}" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="option3">회사명</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option3" name="option3" value="${result.option3}" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="option4">함량</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option4" name="option4" style="width:100px;" value="${result.option4}" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="option6">유통기한</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option6" name="option6" value="${result.option6}" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="option7">재고량</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option7" name="option7" style="width:100px;" value="${result.option7}" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="option8">판매된 수량</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option8" name="option8" style="width:100px;" value="${result.option8}" /> ※ 판매 후에 입력해 주세요. </td>
    </tr>
	<tr>
        <th scope="row"><label for="option9">연락처(약국)</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option9" name="option9" style="width:100px;" value="${result.option9}" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="option10">연락처(핸드폰)</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option10" name="option10" style="width:100px;" value="${result.option10}" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="sr_contents">판매여부</label> </th>
        <td colspan="3" class="title_data">
			<select name="option1" id="option1">
				<option value="" <c:if test="${result.option1 == '' }">selected="selected"</c:if>>--선택--</option>
				<option value="1" <c:if test="${result.option1 == '1' }">selected="selected"</c:if>>판매완료</option>
				<option value="2" <c:if test="${result.option1 == '2' }">selected="selected"</c:if>>판매취소</option>
				<option value="3" <c:if test="${result.option1 == '3' }">selected="selected"</c:if>>판매중</option>
			</select>
		</td>
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