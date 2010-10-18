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
	function checkForm(form)
	{			
		var v = new MiyaValidator(form);
	    v.add("title", {
	        required: true
	    });
	    v.add("contents", {
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
		
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
        <li>소비자 식품 감시원입니다</li>
        <li>게시글 내용에는 개인정보를 기재하지 않습니다.</li>
        <li>저속한 표현이나, 타인의 명예훼손, 비방, 반사회적인 글, 영리목적의 광고글 및 홈페이지 운영 목적에 부적합 내용등은
    사전 양해 없이 관리자에 의해 삭제될 수 있습니다.
</li>
        <li>파일을 첨부하실 경우 첨부파일명은 영문으로 올려주시기 바라며, 용량은 5MB 이하로 등록하여 주시기 바랍니다.
</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>

<form id="frm" name="frm" method="post" onsubmit="return checkForm(this);" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="applyCode" value="${param.applyCode}" />
	<input type="hidden" name="applyId" value="${param.applyId}" />
	<input type="hidden" name="categoryId" value="${param.categoryId}" />
	<input type="hidden" name="memberId" value="${user.webMemId}" />
	<input type="hidden" name="pinno" value="${user.pin}" />

<jsp:include page="/health/dev_content/application/userInfoWrite.jsp" flush="true" />

<br />
<h4>내용</h4>
<table summary="업소 및 기관명, 대표자명, 대표자 주민번호, 영업형태, 전화번호, 업소 소재지, 음식물종류, 처리결과 회신" class="default_write">
    <caption>
    소비자 식품 감시원
    </caption>
    
    <tr>
      <th width="20%" scope="row"><label for="title">제목</label></th>
      <td width="85%" colspan="3"><input type="text" id="title" name="title" value="${result.title}" style="width:500px" class="txt" /></td>
    </tr>
    <tr>
      <th scope="row"><label for="contents">내용</label></th>
      <td colspan="3">
      	<textarea rows="10" cols="50" id="contents" name="contents" style="width:500px">${result.contents}</textarea>
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="file1">첨부파일</label></th>
      <td colspan="3">
		<c:forEach var="file" items="${fileList}" varStatus="status">
			<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><label for="${file.fileId}">
				<input name="fileId_A" type="checkbox" value="${file.fileId}" id="${file.fileId}" />삭제하기</label><br/>
		</c:forEach>
      	<input type="file" name="file1" /><br/>
      	<input type="file" name="file2" /><br/>
      	<input type="file" name="file3" /><br/>
      	※ 첨부파일은 이미지 및 문서 파일만 등록하세요 (최대용량 5MB / 최대 3개까지 등록 가능)
      </td>
    </tr>
</table>

<div class="board_btn_set mt13">
    <span class="btn_del"><input type="submit" value="등록하기" /></span>
    <span class="btn_del"><a href="/health/application/selectApplyList.do?applyCode=${param.applyCode}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>
</form>
