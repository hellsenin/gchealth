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
        <select name="searchCnd" title="구분선택">
            <option value="" <c:if test="${searchVO.searchCnd == ''}">selected="selected"</c:if> >선택</option>
			<option value="NTT_SJ" <c:if test="${searchVO.searchCnd == 'NTT_SJ'}">selected="selected"</c:if> >병/의원명</option>
			<option value="OPTION2" <c:if test="${searchVO.searchCnd == 'OPTION2'}">selected="selected"</c:if> >동별</option>
        </select>
        <input type="text" title="검색어" class="text" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' />
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<table class="default_list" summary="위탁의료기관 게시판으로 번호, 병/의원명, 전화번호, 주소, 지도로 구성">
    <caption>위탁의료기관 게시판</caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="20%" scope="col">병/의원명</th>
            <th width="13%" scope="col">전화번호</th>
            <th width="43%" scope="col">주소</th>
            <th width="10%" scope="col">지도</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach var="result" items="${resultList}" varStatus="status">
        <tr>
            <td><c:out value="${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}"/></td>
            <td class="tal"><c:out value="${result.nttSj}" /></td>
            <td><c:out value="${result.option1}" /></td>
			<td class="tal"><c:out value="${result.option2}"/></td>
            <td>
				<c:if test="${result.option3 != null}">
					<a href="http://gis.seoul.go.kr/SeoulGis/LifeMap_gu.jsp?Mode=4&OfficeName=금천구&SisulName=&RetSisulX=${result.option3}&RetSisulY=${result.option4}" target="_blank"><img src="/health/open_content/images/btn/btn_s_mapview.gif" alt="${result.nttSj} 지도보기" /></a>
				</c:if>
			</td>
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
