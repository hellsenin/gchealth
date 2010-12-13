<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<c:set var="action" value="/health/application/multiApply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/health/application/multiModify.do" />
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
<script type="text/javascript">
	function checkForm(form)
	{			
		var v = new MiyaValidator(form);
	    v.add("email:E", {
	        required: true,
	        span: 2,
            glue: "@",
			option: "email"
	    });
	    v.add("tel_U", {
	        span: 3,
            glue: "-",
	        option: "phone"
	    });
	    v.add("cellPhone_U", {
	        required: true,
	        span: 3,
            glue: "-",
	        option: "handphone"
	    });
	    v.add("zipcode_U", {
	        required: true,
            span: 2,
            glue: "-",
	        option: "zip"
	    });
	    v.add("addr1", {
	        required: true
	    });
		result = v.validate();
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
<p class="title_deco"></p>
<div class="body">

<form id="frm" name="frm" method="post" onsubmit="return checkForm(this);" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="applyCode" value="${param.applyCode}" />
	<input type="hidden" name="petiGubun" value="${param.petiGubun}" />
	<input type="hidden" name="applyId" value="${param.applyId}" />
	<input type="hidden" name="categoryId" value="${param.categoryId}" />
	<input type="hidden" name="memberId" value="${user.webMemId}" />
	<input type="hidden" name="pinno" value="${user.pin}" />

<jsp:include page="/admin/health/application/userInfoWrite.jsp" flush="true" />

<br />
<h5>상담내용</h5>
<table summary="업소 및 기관명, 대표자명, 대표자 주민번호, 영업형태, 전화번호, 업소 소재지, 음식물종류, 처리결과 회신" class="default_write">
    <caption>
    건강상담
    </caption>
    
    <tr>
      <th width="20%" scope="row"><label for="etc1">제목</label></th>
      <td width="85%" colspan="3"><input type="text" id="title" name="title" value="${result.title}" style="width:400px" class="txt" /></td>
    </tr>
    <tr>
      <th scope="row"><label for="smsFlag">공개여부</label></th>
      <td colspan="3">
          <input type="radio" name="openFlag" id="openFlag1" value="Y" <c:if test="${result.openFlag == 'Y'}">checked</c:if> /> 공개
          <input type="radio" name="openFlag" id="openFlag2" value="N" <c:if test="${result.openFlag == 'N'}">checked</c:if> /> 비공개
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="sr_contents">상담내용</label></th>
      <td colspan="3">
      	<textarea rows="5" cols="50" id="sr_contents" name="contents"  >${result.contents}</textarea>
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="file1">첨부파일</label></th>
      <td colspan="3">
		<c:forEach var="file" items="${fileList}" varStatus="status">
			<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><label for="${file.fileId}"><input name="fileId" type="checkbox" value="${file.fileId}" id="${file.fileId}" />삭제하기</label><br/>
		</c:forEach>
      	<input type="file" name="file1" /><br/>
      	<input type="file" name="file2" /><br/>
      	<input type="file" name="file3" /><br/>
      	※ 첨부파일은 이미지 및 문서 파일만 등록하세요 (최대용량 5MB / 최대 3개까지 등록 가능)
      </td>
    </tr>
</table>

<div class="board_btn_set mt13">
<c:if test="${empty result}">
    <span class="btn_del"><input type="submit" value="등록하기" /></span>
</c:if>
<c:if test="${not empty result}">
    <span class="btn_del"><input type="submit" value="수정하기" /></span>
</c:if>
    <span class="btn_del"><a href="/admin/health/application/selectApplicationList.do?applyCode=${param.applyCode}&petiGubun=${param.petiGubun}">목록보기</a></span>
</div>
</form>

</div>
<br/>
<br/>
			<jsp:include page="/admin/health/application/answerAssignedDeptApply.jsp" flush="true" />
</body>
</html>
