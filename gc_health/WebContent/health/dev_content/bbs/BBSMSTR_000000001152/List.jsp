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

<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_geumcheon.gif) 470px top no-repeat;">
    <ul class="list">
        <li class="tit"><img src="/health/open_content/images/comment/comment_tit_0107010201.gif" alt="금천구 소식지 The Geumcheon-Gu News" /></li>
        <li>금천구 소식 파일(PDF)이 열리지 않을 경우 아크로뱃 리더를 설치하세요.</li>
		<li class="no"><a href="http://get.adobe.com/kr/reader/"><img src="/health/open_content/images/btn/btn_s3_pdfdown.gif" alt="PDF 다운받기" /></a>        </li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>

<form name="frm" action="/health/bbs/selectBoardList.do?bbsId=${param.bbsId}&amp;categoryId=${param.categoryId}" method="post" onsubmit="return fn_bbs_search_check();">
<div class="board_top clearfix">
    <div class="fl_l"> <span>${resultCnt}건 [${searchVO.pageIndex} / ${totalPage} Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
		<label for="searchCnd" class="blind">구분선택</label>
        <select name="searchCnd" id="searchCnd">
            <option value="" <c:if test="${searchVO.searchCnd == ''}">selected="selected"</c:if> >선택</option>
			<option value="NTT_SJ" <c:if test="${searchVO.searchCnd == 'NTT_SJ'}">selected="selected"</c:if> >제목</option>
			<option value="NTT_CN" <c:if test="${searchVO.searchCnd == 'NTT_CN'}">selected="selected"</c:if> >내용</option>
        </select>
		<label for="searchWrd" class="blind">검색어</label>
        <input type="text" id="searchWrd" class="text" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' />
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>


<table class="gallery_list" summary="금천구소식지 이미지, 발행월호, 업데이트 날짜">
    <caption>보건소식지</caption>
    <tbody>
        <tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:if test="${status.count == 6}"></tr><tr></c:if>
			<td>
				<dl>
					<dt>
						<a href="/health/bbs/selectBoardArticle.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;nttId=${result.nttId}&amp;fileSn=<c:out value='${result.fileSeq}'/>"><img src="<c:url value='/cmm/fms/getImage.do'/>?atchFileId=<c:out value='${result.atchFileId}'/>&fileSn=0"  width="100" height="120" alt="${result.nttSj} 사진" /></a>
					</dt>
					<dd class="tit"><a href="/health/bbs/selectBoardArticle.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;nttId=${result.nttId}"><c:out value="${result.nttSj}" /></a></dd>
					<dd class="date"><c:out value="${result.frstRegisterPnttm}"/></dd>
				</dl>
			</td>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
        </tr>
    </tbody>
</table>

<ol class="paging">
    <!-- 이미지들어간곳은 붙여서 코딩하기 바람 -->
    ${pageNav}
</ol>


