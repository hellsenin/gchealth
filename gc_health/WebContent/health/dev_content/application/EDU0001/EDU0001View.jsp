<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("crlf", "\r\n"); %>	
				
<script type="text/javascript">
	function checkForm()
	{		
		if (confirm("정말로 신청취소 하시겠습니까?")) {
			return true;
		} 
		else
		{
			return false;
		}
	}

</script>				
			<div class="comment_box">
			<div class="comment_box_top"></div>
			<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
			    <ul class="list">
							<li>모든 신고내용은 본인만 확인하실 수 있습니다.  (민원내용에는 개인정보를 작성하지 않습니다)</li>
							<li>저속한 표현, 타인의 명예훼손, 근거없는 비방, 반사회적인 글, 영리목적의 광고성 글, 게시판의 운영목적에 부적합한 내용 등은 사전양해없이 삭제될 수 있습니다.</li>
							<li>첨부파일(한글파일,사진파일등)을 올리시는 경우는 영문명으로 올려주시기 바랍니다.</li>
			    </ul>
			</div>
			<div class="comment_box_bottom"></div>
			</div>
	
				<h4>교육신청정보</h4>	
						<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">제    목</th>
									<td colspan="3" class="output">${onlineResult.title}</td>
								</tr>
								<tr>
									<th scope="row">기    간</th>
									<td class="output">		
										<fmt:parseDate value='${onlineResult.receiptSdate}' var='receiptSdate' pattern='yyyy-mm-dd'/>
										<fmt:formatDate value='${receiptSdate}' pattern="yyyy년mm월dd일"/>	~						
										<fmt:parseDate value='${onlineResult.receiptEdate}' var='receiptEdate' pattern='yyyy-mm-dd'/>
										<fmt:formatDate value='${receiptEdate}' pattern="yyyy년mm월dd일"/></td>
									<th scope="row">모집인원</th>
									<td class="output">${onlineResult.appInwon}</td>
								</tr>
								<tr>
									<th scope="row">교육일</th>
									<td colspan="3" class="output">${onlineResult.eduSdate}</td>
								</tr>
								<tr>
									<th scope="row">교육시간</th>
									<td colspan="3" class="output">${onlineResult.eduStime}</td>
								</tr>
								<tr>
									<th scope="row">상세 내용</th>
									<td colspan="3" class="outputEditer">${fn:replace(onlineResult.content,crlf,"<br/>")}</td>
								</tr>
							</tbody>
						</table>
								
<br/>
<br/>
				<h4>신청인 정보</h4>	
				<!-- 신청인 정보 -->
				<jsp:include page="/health/dev_content/application/userInfoView.jsp" flush="true" />
					
<br/>
<br/>
				<h4>신청인추가정보</h4>	
				<!-- board write start -->
				<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
					<caption>기관정보 글쓰기</caption>
					<colgroup>
						<col style="width:20%;"/>
						<col style="width:80%;"/>
					</colgroup>
					<tbody>
						<tr class="fir">
							<th scope="row">성별</th>
							<td>&nbsp;
								<c:if test="${result.etc1 == '1'}">남</c:if>
								<c:if test="${result.etc1 == '2'}">여</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			
			<form name="frm" method="post" action="/health/onlineApply/cancelApply.do" onsubmit="return checkForm(this);">		
				<input type="hidden" name="categoryId" value="${param.categoryId}" />
				<input type="hidden" name="applyCode" value="${param.applyCode}" />
				<input type="hidden" name="applyId" value="${result.applyId}" />
				
<div class="board_btn_set mt13">

				<c:if test="${result.status == 1}">
	<span class="btn_del"><input type="submit" value="취소하기" /></span>
	<span class="btn_del"><a href="/health/application/modifyApplyPage.do?applyCode=${param.applyCode}&amp;applyId=${result.applyId}&amp;categoryId=${param.categoryId}">수정하기</a></span>
				</c:if>

	<span class="btn_list"><a href="/health/application/selectMyApplyList.do?applyCode=${param.applyCode}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>

			</form>

