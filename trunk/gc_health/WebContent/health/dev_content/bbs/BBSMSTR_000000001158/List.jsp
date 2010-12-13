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
			<option value="NTT_SJ" <c:if test="${searchVO.searchCnd == 'NTT_SJ'}">selected="selected"</c:if> >약품명</option>
			<option value="OPTION5" <c:if test="${searchVO.searchCnd == 'OPTION5'}">selected="selected"</c:if> >성분</option>
        </select>
        <input type="text" title="검색어" class="text" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' />
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<table class="default_list" summary="약국간 의약품 나눔센터 게시판으로 번호, 판매여부, 약국명, 약품명, 회사명, 함량, 등록일로 구성">
    <caption>
    약국간 의약품 나눔센터 게시판
    </caption>
    <thead>
        <tr>
            <th width="10%" scope="col">번호</th>
            <th width="10%" scope="col">판매여부</th>
            <th width="20%" scope="col">약국명</th>
            <th width="20%" scope="col">약품명</th>
            <th width="20%" scope="col">회사명</th>
            <th width="10%" scope="col">함량</th>
			<th width="10%" scope="col">등록일</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach var="result" items="${resultList}" varStatus="status">
        <tr>
            <td><c:out value="${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}"/></td>
            <td>
				<c:choose>
					<c:when test="${result.option1 == '1'}">판매완료</c:when>
					<c:when test="${result.option1 == '2'}">판매취소</c:when>
					<c:when test="${result.option1 == '3'}">판매중</c:when>
				</c:choose>
			</td>
            <td><a href="/health/bbs/selectBoardArticle.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;nttId=${result.nttId}"><c:out value="${result.nttSj}" /></a></td>
			<td><c:out value="${result.option2}" /></td>
            <td><c:out value="${result.option3}" /></td>
            <td><c:out value="${result.option4}" /></td>
			<td><c:out value="${result.frstRegisterPnttm}"/></td>
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
