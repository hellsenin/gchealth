<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<div class="body">

<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_004.gif) 470px top no-repeat;">
    <ul class="list">
        <li>구민여러분 상호간에 자유롭게 의견을 나누는 게시판 입니다. </li>
        <li>건전하고 발전적인 게시판이 될 수 있도록 구민 여러분의 적극적인 협조를 바랍니다. </li>
		<li>저속한 표현, 타인의 명예훼손, 근거없는 비방, 반사회적인 글, 영리목적의 광고성 글, <br />게시판의 운영목적에 부적합한 내용 등은 사전양해없이 삭제될 수 있습니다. </li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>

<form name="board" action="/health/bbs/updateBoardArticle.do" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_update_notice();">
<input type="hidden" name="returnUrl" value="<c:url value='/health/bbs/forUpdateBoardArticle.do'/>"/>
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
			
<table summary="제목, 작성자, 내용, 첨부파일목록, 첨부파일 제공" class="default_write">
    <caption>자유게시판 수정</caption>
    <tr>
        <th scope="row" width="15%" class="title_1"><label for="sr_title">제목</label> </th>
        <td colspan="3" class="title_td"><input type="text" id="sr_title" name="nttSj" value="${result.nttSj}" /></td>
    </tr>
    <tr>
        <th scope="row" class="title"><label for="sr_name">작성자</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="sr_name" name="ntcrNm" value="${result.ntcrNm}" /></td>
    </tr>
    <tr>
        <th scope="row"><label for="sr_contents">내용</label> </th>
        <td colspan="3"><textarea rows="5" cols="50" id="sr_contents" name="nttCn">${result.nttCn}</textarea></td>
    </tr>
    <tr>
        <th scope="row">첨부파일 목록</th>
        <td colspan="5">
			<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
				<c:param name="param_atchFileId" value="${result.atchFileId}" />
			</c:import>
			<c:if test="${result.atchFileId == ''}">
				<input type="hidden" name="fileListCnt" value="0" />
			</c:if>
		</td>
    </tr>
    <tr>
        <th scope="row"><label for="file_1">첨부파일</label></th>
        <td colspan="5"><input type="file" name="file_1" id="file_1" value="첨부파일" /></td>
    </tr>
</table>

<div class="board_btn_set mt13">
    <span class="btn_del"><input type="submit" value="등록하기" /></span>
    <span class="btn_list"><a href="/health/bbs/selectBoardList.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}">목록보기</a></span>
</div>
</form>

</div>