<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%pageContext.setAttribute("crlf", "\n"); %> 
<c:set var="action" value="/admin/health/discussion/insertDiscussion.do" />
<c:if test="${not empty result.disseq}" >
	<c:set var="action" value="/admin/health/discussion/modifyDiscussion.do" />
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>
<script type="text/javascript">
	function checkForm(form)
	{	
		var v = new MiyaValidator(form);
	    v.add("dataFile", {
	        required: true
	    });
	    var result = v.validate();
	    if (!result) {
	        alert(v.getErrorMessage());
	        v.getErrorElement().focus();
			return false;
	    } 
	    else
	    {
		    return true;
	    }
	}
</script>
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		대사증후군 
</h2>
<p class="title_deco"></p>
<div class="body">

<form name="form1" method="post" enctype="multipart/form-data" action="/admin/health/metabolicSyndrome/uploadExcel.do?applyCode=APP000046" onsubmit="return checkForm(this);">
<table width="100%" border="0">
<tr><td height="15"></td></tr>
<tr>
  <td><b>* 대사증후군 엑셀자료 업로드</b></td>
</tr>
<tr>
	<td><input type="file" size="30" name="dataFile"/>&nbsp;<input type="submit" value="전송" /></td>
</tr>
<tr><td height="5"></td></tr>
<tr><td><font color="red">*반드시 아래샘플과 같은 양식으로 업로드해주세요.</font></td></tr>
<tr><td height="5"></td></tr>
<tr><td><a href="/health/main/contentsDownload.do?filename=%EB%8C%80%EC%82%AC%EC%A6%9D%ED%9B%84%EA%B5%B0%EC%83%98%ED%94%8C.xls">대사증후군샘플 다운로드</a></td></tr>
</table>
</form>

<table class="default_list" summary="번호,제목,공개여부, 작성자, 등록일, 첨부파일 구성">
    <caption>
    게시물리스트
    </caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="13%" scope="col">등록번호</th>
            <th width="13%" scope="col">이름</th>
            <th width="13%" scope="col">전화번호</th>
            <th width="*" scope="col">주소</th>
            <th width="13%" scope="col">등록일자</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
        <tr>
            <td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
            <td>
				<c:if test="${resultList[x].openFlag == 'Y'}" >공개</c:if>
				<c:if test="${resultList[x].openFlag == 'N'}" >비공개</c:if>
			</td>
            <td class="tal"><a href="/admin/health/application/modifyPage.do?applyCode=${param.applyCode}&amp;applyId=${resultList[x].applyId}&amp;petiGubun=${param.petiGubun}">${resultList[x].title}</a></td>
            <td>${resultList[x].name}</td>
          <td>		
			<fmt:parseDate value='${resultList[x].applyDate}' var='applyDate' pattern='yyyy-mm-dd'/>
			<fmt:formatDate value='${applyDate}' pattern="yyyy년mm월dd일"/>	
          </td>
            <td>
				<c:if test="${empty resultList[x].status || resultList[x].status == RECEIPT_WAITING}">접수대기</c:if>
				<c:if test="${resultList[x].status == RECEIPT}">접수</c:if>
				<c:if test="${resultList[x].status == ASSIGNED_DEPT}">부서지정</c:if>
				<c:if test="${resultList[x].status == OFFICER_PROCESSING}">담당자지정/처리</c:if>
				<c:if test="${resultList[x].status == ANSWERING}">답변중</c:if>
				<c:if test="${resultList[x].status == COMPLETE_ANSWER}">답변완료</c:if>
				<c:if test="${resultList[x].status == COMPLETION}">완료</c:if>
				<c:if test="${resultList[x].status == DELETION}">신청취소</c:if>
				<c:if test="${resultList[x].status == TRANSFER}">이관</c:if>
            </td>
            <td>${resultList[x].hit}</td>
        </tr>
     </c:forEach>
     </c:if>
	<c:if test="${fn:length(resultList) == 0}" >
	<tr><td colspan="7">데이터가 없습니다</td></tr>
	</c:if>
    </tbody>
</table>
<ol class="paging">
<c:if test="${fn:length(resultList) > 0}" >
${pageNav}
</c:if>
</ol>
</div>
</body>
</html>

				