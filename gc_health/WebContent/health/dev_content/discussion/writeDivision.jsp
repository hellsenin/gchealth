<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="action" value="/health/discussion/writeDivision.do" />
<c:if test="${not empty division}" >
	<c:set var="action" value="/health/discussion/modifyDivision.do" />
</c:if>	
<%pageContext.setAttribute("crlf", "\n"); %> 

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript">
	function checkForm(form)
	{	
		var v = new MiyaValidator(form);
	    v.add("divcont", {
	        required: true
	    });
	    var result = v.validate();
	    if (!result) {
	        alert(v.getErrorMessage());
	        //v.getErrorElement().focus();
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
			<input type="hidden" name="disseq" value="${param.disseq}" />
		<c:if test="${not empty division}" >
			<input type="hidden" name="divseq" value="${param.divseq}" />
		</c:if>
			<input type="hidden" name="pinno" value="${user.pin}" />
			<input type="hidden" name="memberId" value="${user.webMemId}" />
				
				<h4>토론 내용</h4>
				<table summary="선택하신 토론내용을 확인할 수 있습니다" class="default_view">
					<caption>토론 내용보기</caption>
					<colgroup>
						<col width="20%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">토론주제</th>
							<td colspan="3" class="output">${result.distitle}</td>
						</tr>
						<tr>
							<td colspan="3" class="output">${fn:replace(result.discont, crlf, "<br/>")}</td>
						</tr>
						<tr>
							<th scope="row">등록일</th>
							<td colspan="3" class="output">	
							<fmt:parseDate value='${result.rdate}' var='rdate' pattern='yyyy-mm-dd'/>
							<fmt:formatDate value='${rdate}' pattern="yyyy년mm월dd일"/>
							</td>
						</tr>
						
					</tbody>
				</table>
	<br/>
	<h4>의견 쓰기</h4>
	<table summary="토론의견 내용을 입력합니다" class="default_write">
		<caption>의견쓰기</caption>
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">작성자</th>
				<td class="output">
					${user.memNm}<input type="hidden" name="name" value="${user.memNm}" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="contents">내용</label></th>
				<td class="output">								
					<textarea name="divcont" id="contents" cols="50" rows="5" style="width:80%;" onkeydown="textCounter(this.form.divcont,this.form.remLen,800);" onkeyup="textCounter(this.form.divcont,this.form.remLen,800);" onmousedown="this.onkeydown();" onmouseup="this.onkeyup();">${division.divcont}</textarea><br/>
					<input type="text" name="remLen" id="remLen" value="800" class="board1 vamb" style="width:30px;" readonly="readonly" /> 자남음
				</td>
			</tr>
			
		</tbody>
	</table>
	

<div class="board_btn_set mt13">

	<span class="btn_del"><input type="submit" value="${empty division ? '등록' : '수정'}하기" /></span>

	<span class="btn_del"><a href="/health/discussion/selectDiscussion.do?disseq=${param.disseq}&amp;categoryId=${param.categoryId}">취소하기</a></span>

	<span class="btn_list"><a href="/health/discussion/selectDiscussion.do?disseq=${param.disseq}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>
				
</form><!-- write form end -->

<div class="cboth mgb37">&nbsp;</div>