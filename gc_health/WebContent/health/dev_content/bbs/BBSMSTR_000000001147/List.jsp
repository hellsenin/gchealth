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

<form name="frm" action="/health/bbs/selectBoardList.do?bbsId=${param.bbsId}&amp;categoryId=${param.categoryId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}&amp;optionCnd2=${param.optionCnd2}&amp;optionWrd2=${param.optionWrd2}" method="post" onsubmit="return fn_bbs_search_check();">
<div class="board_top clearfix">
    <div class="fl_l"> <span>${resultCnt}건 [${searchVO.pageIndex} / ${totalPage} Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
        <select name="searchCnd" title="구분선택">
            <option value="" <c:if test="${searchVO.searchCnd == ''}">selected="selected"</c:if> >선택</option>
			<option value="NTT_SJ" <c:if test="${searchVO.searchCnd == 'NTT_SJ'}">selected="selected"</c:if> >시설명</option>
			<option value="OPTION3" <c:if test="${searchVO.searchCnd == 'OPTION3'}">selected="selected"</c:if> >소재지(동별)</option>
			<option value="OPTION4" <c:if test="${searchVO.searchCnd == 'OPTION4'}">selected="selected"</c:if> >전화번호</option>
        </select>
        <input type="text" title="검색어" class="text" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' />
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<table class="default_list" summary="의료기관 게시판으로 번호, 시설명, 소재지, 전화번호, 지도로 구성">
    <caption>
    의료기관 게시판
    </caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="30%" scope="col">시설명</th>
            <th width="40%" scope="col">소재지</th>
            <th width="16%" scope="col">전화번호</th>
            <th width="7%" scope="col">지도</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach var="result" items="${resultList}" varStatus="status">
        <tr>
            <td><c:out value="${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}"/></td>
            <td class="tal"><a href="/health/bbs/selectBoardArticle.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;nttId=${result.nttId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}&amp;optionCnd2=${param.optionCnd2}&amp;optionWrd2=${param.optionWrd2}"><c:out value="${result.nttSj}" /></a></td>
            <td class="tal"><c:out value="${result.option3}" /></td>
			<td><c:out value="${result.option4}"/></td>
            <td><a href="#">지도</a></td>
        </tr>
        <c:set var="resultCnt" value="${resultCnt-1}" />
        </c:forEach>
    </tbody>
</table>

<ol class="paging">
    <!-- 이미지들어간곳은 붙여서 코딩하기 바람 -->
    ${pageNav}
</ol>

</div>
