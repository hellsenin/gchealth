<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%pageContext.setAttribute("crlf", "\r\n");%>

<script type="text/javascript"> 
	
	function fn_egov_delete_notice() {
		
		if (confirm('삭제하시겠습니까?')) {
			return true;
		}
		return false;
	}
	
</script>

<div class="body">
<form name="frm" method="post" action="/health/bbs/deleteBoardArticle.do" onsubmit="return fn_egov_delete_notice();">
<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
<input type="hidden" name="categoryId" value="<c:out value='${param.categoryId}'/>" />

<table summary="제목,작성자,등록일자,연락처,내용,첨부파일 제공" class="default_view">
    <caption>
    게시물제목
    </caption>
    <tr>
        <th width="20%" class="title_1	" scope="row">약국명</th>
        <td colspan="3" class="title_td"><p><c:out value="${result.nttSj}" /></p></td>
    </tr>
    <tr>
        <th scope="row">약품명 </th>
        <td colspan="3"><c:out value="${result.option2}" /></td>
    </tr>
    <tr>
        <th scope="row">성분 </th>
        <td colspan="3"><c:out value="${result.option5}" /></td>
    </tr>
	<tr>
        <th scope="row">회사명 </th>
        <td colspan="3"><c:out value="${result.option3}" /></td>
    </tr>
	<tr>
        <th scope="row">함량 </th>
        <td colspan="3"><c:out value="${result.option4}" /></td>
    </tr>
	<tr>
        <th scope="row">유통기한 </th>
        <td colspan="3"><c:out value="${result.option6}" /></td>
    </tr>
	<tr>
        <th scope="row">재고량 </th>
        <td colspan="3"><c:out value="${result.option7}" /></td>
    </tr>
	<tr>
        <th scope="row">판매된 수량 </th>
        <td colspan="3"><c:out value="${result.option8}" /> &nbsp;</td>
    </tr>
	<tr>
        <th scope="row">연락처(약국) </th>
        <td colspan="3"><c:out value="${result.option9}" /></td>
    </tr>
	<tr>
        <th scope="row">연락처(핸드폰) </th>
        <td colspan="3"><c:out value="${result.option10}" /></td>
    </tr>
	<tr>
        <th scope="row">판매여부 </th>
        <td colspan="3">
			<c:choose>
				<c:when test="${result.option1 == '1'}">판매완료</c:when>
				<c:when test="${result.option1 == '2'}">판매취소</c:when>
				<c:when test="${result.option1 == '3'}">판매중</c:when>
			</c:choose>
		</td>
    </tr>
</table>

<div class="board_btn_set mt13">
	<c:if test="${result.frstRegisterId == company.id}">
	<span class="btn_del"><a href="/health/bbs/forUpdateBoardArticle.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;nttId=${result.nttId}">수정하기</a></span>
	<span class="btn_del"><input type="submit" value="삭제하기" /></span>
	</c:if>
    <span class="btn_list"><a href="/health/bbs/selectBoardList.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}">목록보기</a></span>
</div>

</form>
</div>
