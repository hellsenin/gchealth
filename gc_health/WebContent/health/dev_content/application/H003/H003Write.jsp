<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<c:set var="action" value="/health/application/multiApply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/health/application/multiModify.do" />
</c:if>	

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript">
	//<![CDATA[
	function checkForm(form)
	{			
		var v = new MiyaValidator(form);
	    v.add("email_E", {
	        required: true,
	        span: 2,
            glue: "@",
			option: "email"
	    });
	    v.add("tel_U", {
	        span: 3,
            glue: "-",
	        option: "phone"
	    });
	    v.add("cellPhone_U", {
	        required: true,
	        span: 3,
            glue: "-",
	        option: "handphone"
	    });
	    v.add("zipcode_U", {
	        required: true,
            span: 2,
            glue: "-",
	        option: "zip"
	    });
	    v.add("addr1", {
	        required: true
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
			
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
        <li>신청.신고 내용은 본인만 확인이 가능합니다.</li>
        <li>저속한 표현이나, 타인의 명예훼손, 비방, 반사회적인 글, 영리목적의 광고글 및 홈페이지 운영 목적에 <br />부적합 내용등은 사전 양해 없이 관리자에 의해 삭제될 수 있습니다.</li>
        <li>파일을 첨부하실 경우 첨부파일명은 영문으로 올려주시기 바라며, 용량은 5MB 이하로 등록하여 주시기<br /> 바랍니다.</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>

<form id="frm" name="frm" method="post" onsubmit="return checkForm(this);" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="applyCode" value="${param.applyCode}" />
	<input type="hidden" name="applyId" value="${param.applyId}" />
	<input type="hidden" name="categoryId" value="${param.categoryId}" />
	<input type="hidden" name="memberId" value="${user.webMemId}" />
	<input type="hidden" name="pinno" value="${user.pin}" />

<h4>신고인정보</h4>	
<jsp:include page="/health/dev_content/application/userInfoWrite.jsp" flush="true" />

<br />
<h5>신고내용</h5>
<table summary="전염병신고 페이지로 신고인, 신고내용, 첨부파일, 전화번호,  주소, 처리결과 회신으로 구성" class="default_write">
    <caption>전염병신고</caption>
   <tbody> 
    <tr>
      <th width="20%" scope="row"><label for="etc1">신고인</label></th>
      <td width="80%" colspan="3"><input type="text" id="etc1" name="etc1" value="${result.etc1}" style="width:400px" class="txt" /></td>
    </tr>
    <tr>
      <th scope="row"><label for="sr_contents">신고내용</label></th>
      <td colspan="3">
      	<textarea rows="5" cols="50" id="sr_contents" name="etcContents1" onkeydown="textCounter(this.form.etcContents1,this.form.remLen,800);" onkeyup="textCounter(this.form.etcContents1,this.form.remLen,800);" onmousedown="this.onkeydown();" onmouseup="this.onkeyup();">${result.etcContents1}</textarea>
      	<input type="text" name="remLen" id="remLen" value="800" class="board1 vamb" style="width:30px;" readonly="readonly" /> 자남음
      </td>
    </tr>
    <tr>
      <th scope="row">첨부파일</th>
      <td colspan="3">
		<c:forEach var="file" items="${fileList}" varStatus="status">
			<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><label for="${file.fileId}">
				<input name="fileId_A" type="checkbox" value="${file.fileId}" id="${file.fileId}" />삭제하기</label><br/>
		</c:forEach>
		<label for="file1" class="blind">첨부파일1</label>
      	<input type="file" name="file1" id="file1" /><br/>
		<label for="file2" class="blind">첨부파일2</label>
      	<input type="file" name="file2" id="file2" /><br/>
		<label for="file3" class="blind">첨부파일3</label>
      	<input type="file" name="file3" id="file3" /><br/>
      	※ 첨부파일은 이미지 및 문서 파일만 등록하세요 (최대용량 5MB / 최대 3개까지 등록 가능)
      </td>
    </tr>
    <tr>
      <th scope="row">전화번호</th>
      <td colspan="3">
		<c:set var="_etc2" value="${fn:split(result.etc2, '-')}"/>
		<label for="etc2_1" class="blind">전화번호(지역번호)</label>
        <input type="text" id="etc2_1" name="etc2_U" value="${_etc2[0]}" style="width:30px" class="txt"/> - 
		<label for="etc2_2" class="blind">전화번호(국번)</label>		
		<input type="text" id="etc2_2" name="etc2_U" value="${_etc2[1]}" style="width:30px" class="txt"/> - 
		<label for="etc2_3" class="blind">전화번호(뒷자리)</label>
		<input type="text" id="etc2_3" name="etc2_U" value="${_etc2[2]}" style="width:27px" class="txt">   
      </td>
    </tr>
    
    <tr>
      <th rowspan="2" scope="row">주소</th>
      <td colspan="3">
		<a href="/health/dev_content/zipcode/GC_member_zipcode.jsp?code1=etc3_1&amp;code2=etc3_2&amp;code3=etc4" onclick="window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes');return false;" onkeypress="if(event.keyCode==13) {this.onclick(); return false;}" title="우편번호검색 팝업"><img src="/health/open_content/images/btn/btn_s_zipcode.gif" alt="우편번호" align="absmiddle" /></a>
		<c:set var="_etc3" value="${fn:split(result.etc3, '-')}"/>
		<label for="etc3_1" class="blind">우편번호 앞자리</label>
        <input type="text" id="etc3_1" name="etc3_U" value="${_etc3[0]}" style="width:50px" class="txt" /> - 
		<label for="etc3_2" class="blind">우편번호 뒷자리</label>		
		<input type="text" id="etc3_2" name="etc3_U" value="${_etc3[1]}" style="width:50px" class="txt" />
</td>
    </tr>
    <tr>
      <td colspan="3">
	  <label for="etc4" class="blind">주소(시,도,군,구,읍,면,동)</label>			  
	  <input type="text" id="etc4" name="etc4" value="${result.etc4}" style="width:200px" class="txt"/>
      <label for="etc5" class="blind">주소(번지, 나머지 주소)</label>	
      <input type="text" id="etc5" name="etc5" value="${result.etc5}" style="width:200px" class="txt"/></td>
    </tr>
    <tr>
      <th scope="row"><label for="smsFlag">처리결과 회신</label></th>
      <td colspan="3">
      민원 처리결과 핸드폰 회신 동의 <input type="checkbox" name="smsFlag" id="smsFlag" value="Y" <c:if test="${result.smsFlag == 'Y'}">checked</c:if> />
     </td>
    </tr>
</tbody>
</table>

<div class="board_btn_set mt13">
    <span class="btn_del"><input type="submit" value="등록하기" /></span>
    <span class="btn_del"><a href="/health/main/contents.do?categoryId=2426">취소하기</a></span>
</div>
</form>
