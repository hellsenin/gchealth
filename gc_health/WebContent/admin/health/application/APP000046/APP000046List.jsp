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
<br/>
<br/>
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
            <th width="13%" scope="col">검진일자</th>
            <th width="7%" scope="col">기타</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
        <tr>
            <td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
            <td><a href="/admin/health/application/modifyPage.do?applyCode=${param.applyCode}&amp;applyId=${resultList[x].applyId}">${resultList[x].etc1}</a></td>
            <td class="tal">${resultList[x].name}</td>
            <td>${resultList[x].tel}</td>
            <td>${resultList[x].addr1}</td>
            <td>${resultList[x].etc7}</td>
            <td><a href="/admin/health/application/delApply.do?applyCode=${param.applyCode}&amp;applyId=${resultList[x].applyId}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a></td>
        </tr>
     </c:forEach>
     </c:if>
	<c:if test="${fn:length(resultList) == 0}" >
	<tr><td colspan="6">데이터가 없습니다</td></tr>
	</c:if>
    </tbody>
</table>
<ol class="paging">
<c:if test="${fn:length(resultList) > 0}" >
${pageNav}
</c:if>
</ol>

			<div class="board_btn_set mt13">
				<span class="btn_del"><a href="/admin/health/application/writePage.do?applyCode=${param.applyCode}">등록하기</a></span>
			</div>
</div>
</body>
</html>

				