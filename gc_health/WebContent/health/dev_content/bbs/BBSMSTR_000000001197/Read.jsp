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

<table summary="건강식단정보 게시물의 내용페이지로 아침, 점심, 저녁의 밥, 국, 반찬으로 구성" class="default_view">
    <caption>건강식단정보 내용보기</caption>
     <tbody>
	 <tr>
        <th width="15%" class="title_1	" scope="row">제목</th>
        <td colspan="3" class="title_td"><p><c:out value="${result.nttSj}" /></p></td>
    </tr>
    <tr>
        <th scope="row">식단 등록일</th>
        <td><p><c:out value="${result.option2}"/></p></td>
        <th scope="row">조회수 </th>
        <td><c:out value="${result.inqireCo}"/></td>
    </tr>
	<tr>
        <th scope="row" rowspan="6" class="title">아침 </th>
		<th scope="row">밥 </th>
        <td colspan="2"><c:out value="${result.option3}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">국 </th>
        <td colspan="2"><c:out value="${result.option4}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬1 </th>
        <td colspan="2"><c:out value="${result.option5}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬2 </th>
        <td colspan="2"><c:out value="${result.option6}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬3</label> </th>
        <td colspan="2"><c:out value="${result.option7}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬4 </th>
        <td colspan="2"><c:out value="${result.option8}"/></td>
    </tr>
	<tr>
        <th scope="row" rowspan="6" class="title">점심 </th>
		<th scope="row">밥 </th>
        <td colspan="2"><c:out value="${result.option9}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">국 </th>
        <td colspan="2"><c:out value="${result.option10}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬1 </th>
        <td colspan="2"><c:out value="${result.option11}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬2 </th>
        <td colspan="2"><c:out value="${result.option12}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬3</label> </th>
        <td colspan="2"><c:out value="${result.option13}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬4 </th>
        <td colspan="2"><c:out value="${result.option14}"/></td>
    </tr>
	<tr>
        <th scope="row" rowspan="6" class="title">저녁 </th>
		<th scope="row">밥 </th>
        <td colspan="2"><c:out value="${result.option15}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">국 </th>
        <td colspan="2"><c:out value="${result.option16}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬1 </th>
        <td colspan="2"><c:out value="${result.option17}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬2 </th>
        <td colspan="2"><c:out value="${result.option18}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬3</label> </th>
        <td colspan="2"><c:out value="${result.option19}"/></td>
    </tr>
	<tr>
		<th scope="row" class="title">반찬4 </th>
        <td colspan="2"><c:out value="${result.option20}"/></td>
    </tr>
	</tbody>
</table>

<div class="board_btn_set mt13">
    <span class="btn_list"><a href="/health/onlineApply/selectEventCalendar.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}">목록보기</a></span>
</div>

</form>
</div>
