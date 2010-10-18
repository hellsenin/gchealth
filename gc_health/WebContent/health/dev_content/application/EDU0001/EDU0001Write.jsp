<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="action" value="/health/application/apply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/health/application/modify.do" />
</c:if>	

<%pageContext.setAttribute("crlf", "\n"); %>

<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript" src="/admin/common/js/apply.js"></script>
<script type="text/javascript">
	//<![CDATA[
	function checkForm(form)
	{			
			var v = new MiyaValidator(form);
		    v.add("cellPhone_U", {
		        required: true,
	            span: 3,
	            glue: "-",
		        option: "handphone"     
		    });
			result = v.validate();
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
	//]]>
</script>
<!--		
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
-->		
		<form name="frm" method="post" action="${action}" onsubmit="return checkForm(this);">
			<input type="hidden" name="categoryId" value="${param.categoryId}" />
			<input type="hidden" name="applyCode" value="${param.applyCode}" />
			<input type="hidden" name="applyId" value="${param.applyId}" />
			<input type="hidden" name="memberId" value="${user.webMemId}" />
			<input type="hidden" name="pinno" value="${user.pin}" />	
			<input type="hidden" name="onlineId" value="${param.onlineId}" />	
			
				<h4>교육신청정보</h4>	
						<table class="default_view" summary="선택하신 건강교실 교육신청정보로 제목, 기간, 모집인원, 교육일, 교육시간, 상세내용으로 구성">
							<caption>교육신청</caption>
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
				<!-- 신청인 정보 -->
<h4>신청인정보</h4>	
<jsp:include page="/health/dev_content/application/userInfoWrite.jsp" flush="true" />

<br/>
<br/>
				<h4>신청인추가정보</h4>	
				<!-- board write start -->
						<table class="default_write" summary="신청인 추가정보로 성별로 구성">
							<caption>신청인 추가정보</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:80%;"/>
							</colgroup>
							<tbody>
								<tr class="fir">
									<th scope="row">성별</th>
									<td>
										<label for="etc1_1"><input id="etc1_1" type="radio" name="etc1" value="1" <c:if test="${result.etc1 == '1'}">checked</c:if>/> 남</label>
										<label for="etc1_2"><input id="etc1_2" type="radio" name="etc1" value="2" <c:if test="${result.etc1 == '2'}">checked</c:if>/> 여</label>
									</td>
								</tr>
							</tbody>
						</table>
			
						
<div class="board_btn_set mt13">

	<span class="btn_del"><input type="submit" value="${empty result ? '등록' : '수정'}하기" /></span>

	<span class="btn_list"><a href="/health/onlineApply/listOnlineApply.do?applyCode=${param.applyCode}&categoryId=${param.categoryId}">목록보기</a></span>
</div>
		
		</form>
