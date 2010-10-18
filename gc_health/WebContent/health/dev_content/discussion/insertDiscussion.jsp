<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%pageContext.setAttribute("crlf", "\n"); %> 
<c:set var="action" value="/health/discussion/insertDiscussion.do" />
<c:if test="${not empty result.disseq}" >
	<c:set var="action" value="/health/discussion/modifyDiscussion.do" />
</c:if>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>
<script type="text/javascript">
	function checkForm(form)
	{	
		var v = new MiyaValidator(form);
	    v.add("distitle", {
	        required: true
	    });
	    v.add("discont", {
	        required: true
	    });
	    var result = v.validate();
	    if (!result) {
	        alert(v.getErrorMessage());
	        v.getErrorElement().focus();
			return false;
	    } 
	    else
	    {
		    return true;
	    }
	}
</script>
	
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
		<li>소비자식품위생감시원토론방은 구민 여러분의 좋은 의견을 받아들이는 열린 행정창구입니다.</li>
		<li>여러분들이 제안한 좋은 의견은 추후 우리구 각종 정책시행에 귀중한 의견으로 활용될 것입니다. </li>
		<li>많은 관심과 참여를 바랍니다.</li>	
		<li>저속한 표현, 타인의 명예훼손, 근거없는 비방, 반사회적인 글, 영리목적의 광고성 글, 게시판의 운영목적에 부적합한 내용 등은 사전양해없이 삭제될 수 있습니다. </li>		
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>
			<form name="frm" method="post" action="${action}" onsubmit="return checkForm(this);">
				<input type="hidden" name="categoryId" value="${param.categoryId}" />
			<c:if test="${not empty result.disseq}" >
				<input type="hidden" name="disseq" value="${result.disseq}" />	
			</c:if>
				<input type="hidden" name="name" value="${user.memNm}" />
				<input type="hidden" name="pinno" value="${user.pin}" />	
				<input type="hidden" name="memberId" value="${user.webMemId}" />	
				
				<table summary="정책토론방글쓰기" class="default_write">
					<caption>칭찬글쓰기</caption>
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">작성자(*)</th>
							<td class="output">${user.memNm}</td>
						</tr>
						<tr>
							<th scope="row">토론주제(*)</th>
							<td class="output"><input type="text" id="distitle" name="distitle" value="${result.distitle}" style="width:90%" class="board1" /></td>
						</tr>
						<tr>
							<th scope="row">토론 내용(*)</th>
							<td class="output">		
								<textarea name="discont" id="discont" cols="50" rows="20" style="width:90%;">${result.discont}</textarea>
							</td>
						</tr>
					</tbody>
				</table>
			
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="${empty result.disseq ? '등록' : '수정'}하기" /></span>
	<span class="btn_list"><a href="/health/discussion/selectDiscussionList.do?categoryId=${param.categoryId}">목록보기</a></span>
</div>
							
				<c:if test="${fn:length(divisionList) > 0}" >
				<h5 class="tit_05">토론 참여 의견</h5>
				<table class="list_type01 mgb20" summary="토론 참여 의견 목록 테이블입니다">
						<caption>토론 참여 의견 목록</caption>
						<colgroup>
							<col width="8%" />
							<col width="*" />
							<col width="20%" />
							<col width="12%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="fir">번호</th>
								<th scope="col">의견</th>
								<th scope="col">글쓴이</th>
								<th scope="col">입력일자</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="x" begin="0" end="${fn:length(divisionList)-1}">  
							<tr>
								<td>${paginationInfo.totalRecordCount - (paginationInfo.currentPageNo-1)*paginationInfo.pageSize - x}</td>
								<td class="tal">${fn:replace(divisionList[x].divcont, crlf, "<br/>")}</td>
								<td>${divisionList[x].name}</td>
								<td><fmt:parseDate value='${divisionList[x].rdate}' var='rdate' pattern='yyyy-mm-dd'/>
							<fmt:formatDate value='${rdate}' pattern="yyyy년mm월dd일"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
		
<ol class="paging">${pageNav}</ol>

					</c:if>
				
			</form><!-- write form end -->

				