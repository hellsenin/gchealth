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

<p class="title_deco"></p>
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
        <th width="10%" class="title_1	" scope="row">제목</th>
        <td colspan="3" class="title_td"><p><c:out value="${result.nttSj}" /></p></td>
    </tr>
    <tr>
        <th scope="row">구분</th>
        <td><p>건강상담 (원본 게시글 위치)</p></td>
        <th width="10%" scope="row">작성자 </th>
        <td><c:out value="${result.ntcrNm}" /></td>
    </tr>
    <tr>
        <th scope="row">등록일</th>
        <td><p><c:out value="${result.frstRegisterPnttm}"/></p></td>
        <th scope="row">조회수 </th>
        <td><c:out value="${result.inqireCo}"/></td>
    </tr>
    <tr>
        <td colspan="4" id="db_data_area"> ${fn:replace(result.nttCn, crlf, "<br />")}</td>
    </tr>
    <tr>
        <th scope="row">첨부파일 </th>
        <td colspan="3"> 
        	<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				<c:param name="param_atchFileId" value="${result.atchFileId}" />
			</c:import>
		</td>
    </tr>
</table>

<table summary="답변내용 포함" class="answer_view">
    <caption>
    답변내용
    </caption>
    <tr class="fir">
        <th scope="row">답변내용</th>
        <td>답변 준비중입니다.</td>
    </tr>
</table>

<div class="board_btn_set mt13">
	<c:if test="${result.frstRegisterId == sessionUniqId}">
	<span class="btn_del"><a href="/health/bbs/forUpdateBoardArticle.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;nttId=${result.nttId}">수정하기</a></span>
	<span class="btn_del"><input type="submit" value="삭제하기" /></span>
	</c:if>
    <span class="btn_list"><a href="/health/bbs/selectBoardList.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}">목록보기</a></span>
</div>

</form>
</div>
