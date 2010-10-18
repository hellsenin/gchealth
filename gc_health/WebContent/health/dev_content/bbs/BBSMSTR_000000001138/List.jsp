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

<!--p class="title_deco"></p-->
<div class="body">

<form name="frm" action="/health/bbs/selectBoardList.do?bbsId=${param.bbsId}&amp;categoryId=${param.categoryId}" method="post" onsubmit="return fn_bbs_search_check();">
<div class="board_top clearfix">
    <div class="fl_l"> <span>${resultCnt}건 [${searchVO.pageIndex} / ${totalPage} Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
		<label for="searchCnd" class="blind">구분선택</label>
        <select name="searchCnd" id="searchCnd">
            <option value="" <c:if test="${searchVO.searchCnd == ''}">selected="selected"</c:if> >선택</option>
            <option value="OPTION1" <c:if test="${searchVO.searchCnd == 'OPTION1'}">selected="selected"</c:if> >업종 검색</option>
            <option value="NTT_SJ" <c:if test="${searchVO.searchCnd == 'NTT_SJ'}">selected="selected"</c:if> >상호명 검색</option>
			<option value="OPTION2" <c:if test="${searchVO.searchCnd == 'OPTION2'}">selected="selected"</c:if> >주소 검색</option>
        </select>
		<label for="searchWrd" class="blind">검색어</label>
        <input type="text" id="searchWrd" class="text" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' />
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<table class="default_list" summary="모범음식점 게시판으로 번호, 업종, 상호명, 주소, 연락처, 지도로 구성">
    <caption>모범음식점 게시판</caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="7%" scope="col">업종</th>
            <th width="25%" scope="col">상호명</th>
            <th width="*" scope="col">주소</th>
            <th width="15%" scope="col">연락처</th>
            <th width="10%" scope="col">지도</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach var="result" items="${resultList}" varStatus="status">
        <tr>
            <td><c:out value="${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}"/></td>
			<td>${result.option1}</td>
            <td class="tal"><c:out value="${result.nttSj}" /></td>
			<td class="tal"><c:out value="${result.option2}"/></td>
            <td><c:out value="${result.option3}"/></td>
            <td><a href="http://gis.seoul.go.kr/SeoulGis/LifeMap_gu.jsp?Mode=4&OfficeName=금천구&SisulName=&RetSisulX=${result.option5}&RetSisulY=${result.option6}" target="_blank"><img src="/health/open_content/images/btn/btn_s_mapview.gif" alt="${result.nttSj} 지도보기" /></a></td>
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
