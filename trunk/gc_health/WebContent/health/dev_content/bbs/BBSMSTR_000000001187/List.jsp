<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

	function fn_bbs_search_check() {

	var searchCnd = document.frm.searchCnd.value;
	var searchWrd = document.frm.searchWrd.value;
	
		if(searchCnd == "" || searchCnd == null){
			
			alert("검색조건을 선택하세요");
			return false;
		
		} else if(searchWrd == "" || searchWrd == null){
			
			alert("검색어를 입력하세요");
			return false;
		
		} else {
			
			document.frm.searchWrd.value = searchString;
			return true;
		}
	
	}

</script>


<div class="body">

<form name="frm" action="/health/bbs/selectBoardList.do?bbsId=${param.bbsId}&amp;categoryId=${param.categoryId}" method="post" onsubmit="return fn_bbs_search_check();">
<div class="board_top clearfix">
    <div class="fl_l"> <span>${resultCnt}건 [${searchVO.pageIndex} / ${totalPage} Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
		<label for="searchCnd" class="blind">구분선택</label>
        <select id="searchCnd" name="searchCnd">
            <option value="" <c:if test="${searchVO.searchCnd == ''}">selected="selected"</c:if> >선택</option>
			<option value="NTT_SJ" <c:if test="${searchVO.searchCnd == 'NTT_SJ'}">selected="selected"</c:if> >제목</option>
			<option value="NTT_CN" <c:if test="${searchVO.searchCnd == 'NTT_CN'}">selected="selected"</c:if> >내용</option>
        </select>
		<label for="searchWrd" class="blind">검색어입력</label>
        <input type="text" id="searchWrd" class="text" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' />
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<table class="default_list" summary="번호, 제목, 작성자, 등록일, 조회수로 구성">
    <caption>방역게시판</caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="40%" scope="col">제목</th>
            <th width="17%" scope="col">작성자</th>
            <th width="16%" scope="col">등록일</th>
            <th width="10%" scope="col">조회수</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach var="result" items="${resultList}" varStatus="status">
        <tr>
            <td><c:out value="${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}"/></td>
            <td class="tal"><a href="/health/bbs/selectBoardArticle.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;nttId=${result.nttId}"><c:out value="${result.nttSj}" /></a></td>
            <td><c:out value="${result.frstRegisterNm}" /></td>
			<td><c:out value="${result.frstRegisterPnttm}"/></td>
            <td><c:out value="${result.inqireCo}"/></td>
        </tr>
        <c:set var="resultCnt" value="${resultCnt-1}" />
        </c:forEach>
    </tbody>
</table>

<ol class="paging">
    <!-- 이미지들어간곳은 붙여서 코딩하기 바람 -->
    ${pageNav}
</ol>

<div class="board_btn_set send_mg"> 
	<span class="register">
		<a href="/health/bbs/addBoardArticle.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}">등록하기</a>
	</span>
</div>

</div>
