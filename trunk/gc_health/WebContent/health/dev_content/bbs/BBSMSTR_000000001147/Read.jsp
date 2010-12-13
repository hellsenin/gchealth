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
<form name="frm" method="post" action="/health/bbs/deleteBoardArticle.do?&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}&amp;optionCnd2=${param.optionCnd2}&amp;optionWrd2=${param.optionWrd2}" onsubmit="return fn_egov_delete_notice();">
<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
<input type="hidden" name="categoryId" value="<c:out value='${param.categoryId}'/>" />

<table summary="제목,작성자,등록일자,연락처,내용,첨부파일 제공" class="default_view">
    <caption>
    게시물제목
    </caption>
    <tr>
        <th width="10%" class="title_1	" scope="row">제목</th>
        <td colspan="3" class="title_td"><p><c:out value="${result.nttSj}" /></p></td>
    </tr>
    <tr>
        <th scope="row">등록일</th>
        <td colspan="3"><p><c:out value="${result.frstRegisterPnttm}"/></p></td>
    </tr>
	<tr>
        <th scope="row">소재지</th>
        <td colspan="3"><c:out value="${result.option3}"/></td>
    </tr>
	<tr>
        <th scope="row">전화번호</th>
        <td colspan="3"><c:out value="${result.option4}"/></td>
    </tr>
</table>

<div class="board_btn_set mt13">
	<span class="btn_list"><a href="/health/bbs/selectBoardList.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}&amp;optionCnd2=${param.optionCnd2}&amp;optionWrd2=${param.optionWrd2}">목록보기</a></span>
</div>

</form>
</div>
