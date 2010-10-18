<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript"> 
	
	function fn_egov_regist_notice() {
				
		if (document.board.nttSj.value==""){
				alert("\제목을 입력하세요.");
				return false;
		} 
		if (document.board.nttCn.value==""){
				alert("\내용을 입력하세요.");
				return false;
		} 
		
		if (confirm('등록하시겠습니까?')) {
			return true;
		}
		return false;
	}
	
</script>

<div class="body">

<form id="board" name="board" action="/health/bbs/insertBoardArticle.do" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_regist_notice();">
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
<input type="hidden" name="categoryId" value="${param.categoryId}" />	
			
<table summary="제목, 작성자, 내용, 첨부파일로 구성" class="default_write">
    <caption>방역게시물 등록</caption>
    <tr>
        <th scope="row" class="title_1"><label for="sr_title">제목</label> </th>
        <td colspan="3" class="title_td"><input type="text" id="sr_title" name="nttSj" /></td>
    </tr>
    <tr>
        <th scope="row" class="title"><label for="sr_name">작성자</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="sr_name" name="ntcrNm" value="${user.memNm}" /></td>
    </tr>
    <tr>
        <th scope="row"><label for="sr_contents">내용</label> </th>
        <td colspan="3"><textarea rows="5" cols="50" id="sr_contents" name="nttCn"></textarea></td>
    </tr>
    <tr>
        <th scope="row"><label for="file_1">첨부파일 </label></th>
        <td colspan="5"><input type="file" name="file_1" id="file_1" value="첨부파일" /></td>
    </tr>
</table>

<div class="board_btn_set mt13">
    <span class="btn_del"><input type="submit" value="등록하기" /></span>
    <!-- >span class="btn_del"><a href="#">삭제하기</a></span-->
    <span class="btn_list"><a href="/health/bbs/selectBoardList.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}">목록보기</a></span>
</div>
</form>

</div>