<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<c:set var="action" value="/health/application/multiApply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/health/application/multiModify.do" />
</c:if>	

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript">
	//<![CDATA[
	function checkForm(form)
	{			
		var v = new MiyaValidator(form);
	    v.add("email_E", {
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
	//]]>
</script>
		
<div class="consult_box">
<div class="consult_box_img">
<div class="consult_box_top"></div>
<div class="consult_box_in">
	<div class="photo"><img src="/health/open_content/images/medicalTeam/${medicalTeam.imgNm}" alt="${medicalTeam.name}사진" width="65" height="75" /></div>
    <ul class="list">
        <li><strong>상담 전문의</strong> : ${medicalTeam.name}</li>
        <li><strong>진료과목</strong> : ${medicalTeam.subject}</li>
        <li><strong>의료기관</strong> : ${medicalTeam.institution}</li>
        <li><strong>전화번호</strong> : ${medicalTeam.tel}</li>
    </ul></div>
<div class="consult_box_bottom"></div>
</div>
</div>
	
<form id="frm" name="frm" method="post" onsubmit="return checkForm(this);" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="applyCode" value="${param.applyCode}" />
	<input type="hidden" name="petiGubun" value="${param.petiGubun}" />
	<input type="hidden" name="applyId" value="${param.applyId}" />
	<input type="hidden" name="categoryId" value="${param.categoryId}" />
	<input type="hidden" name="memberId" value="${user.webMemId}" />
	<input type="hidden" name="pinno" value="${user.pin}" />
<h4>신청인정보</h4>	
<jsp:include page="/health/dev_content/application/userInfoWrite.jsp" flush="true" />

<br />
<h5>상담내용</h5>
<table summary="건강상담 내용입력으로 제목, 공개여부, 상담내용, 첨부파일로 구성" class="default_write">
    <caption>건강상담</caption>
    
    <tr>
      <th width="20%" scope="row"><label for="etc1">제목</label></th>
      <td width="85%" colspan="3"><input type="text" id="title" name="title" value="${result.title}" style="width:400px" class="txt" /></td>
    </tr>
    <tr>
      <th scope="row">공개여부</th>
      <td colspan="3">
          <label for="openFlag1"><input type="radio" name="openFlag" id="openFlag1" value="Y" <c:if test="${result.openFlag == 'Y'}">checked</c:if> /> 공개</label>
          <label for="openFlag2"><input type="radio" name="openFlag" id="openFlag2" value="N" <c:if test="${result.openFlag == 'N'}">checked</c:if> /> 비공개</label>
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="sr_contents">상담내용</label></th>
      <td colspan="3">
      	<textarea rows="5" cols="50" id="sr_contents" name="contents"  >${result.contents}</textarea>
      </td>
    </tr>
    <tr>
      <th scope="row">첨부파일</th>
      <td colspan="3">
		<c:forEach var="file" items="${fileList}" varStatus="status">
			<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><label for="${file.fileId}">
			<input name="fileId_A" type="checkbox" value="${file.fileId}" id="${file.fileId}" />삭제하기</label><br/>
		</c:forEach>
		<label for="file1" class="blind">첨부파일1</label>
      	<input type="file" name="file1" id="file1" /><br/>
		<label for="file2" class="blind">첨부파일2</label>
      	<input type="file" name="file2" id="file2" /><br/>
		<label for="file3" class="blind">첨부파일3</label>
      	<input type="file" name="file3" id="file3" /><br/>
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
    <span class="btn_del"><a href="/health/medicalTeam/selectMedicalTeamList.do?categoryId=${param.categoryId}">취소하기</a></span>
</div>
</form>
