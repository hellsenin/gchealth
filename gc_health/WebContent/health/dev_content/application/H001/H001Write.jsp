<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<c:set var="action" value="/health/application/apply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/health/application/modify.do" />
</c:if>	

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
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
	    v.add("etc1", {
	        required: true
	    });
	    v.add("etc2", {
	        required: true
	    });
	    v.add("etc3_U", {
	        required: true,
	        span: 2,
            glue: "-",
	        option: "jumin"
	    });
	    v.add("etc5_U", {
	        required: true,
            span: 3,
            glue: "-",
	        option: "phone"
	    });
	    v.add("etc6_U", {
	        required: true,
            span: 2,
            glue: "-",
	        option: "zipcode"
	    });
	    v.add("etc7", {
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

<!-- 
<table summary="신청,신고 게시판 바로가기" class="data_list">
    <caption>
    신청,신고 게시판 목록
    </caption>
    <tr>
        <th width="30%">신청,신고 게시판 바로가기</th>
        <td>
          <select name="select" id="select">
            <option>선택하세요</option>
          </select>
          <a href="#"><img src="/health/open_content/images/btn/btn_m_go.gif" alt="이동" align="absmiddle" /></a>
        </td>
        <td class="tar">
          <a href="#"><img src="/health/open_content/images/btn/btn_m_list.gif" alt="목록보기" align="absmiddle" /></a>
          <a href="#"><img src="/health/open_content/images/btn/btn_m_inquire.gif" alt="신청,신고 조회" align="absmiddle" /></a>
      </td>
    </tr>
</table>
 -->

<form id="frm" name="frm" method="post" onsubmit="return checkForm(this);" action="${action}">
	<input type="hidden" name="applyCode" value="${param.applyCode}" />
	<input type="hidden" name="applyId" value="${param.applyId}" />
	<input type="hidden" name="categoryId" value="${param.categoryId}" />
	<input type="hidden" name="memberId" value="${user.webMemId}" />
	<input type="hidden" name="pinno" value="${user.pin}" />
<h4>신청인정보</h4>	
<jsp:include page="/health/dev_content/application/userInfoWrite.jsp" flush="true" />

<br />
<h4>신청내용</h4>
<table summary="모범업소 지정 신청페이지로 업소 및 기관명, 대표자명, 대표자 주민번호, 영업형태, 전화번호, 업소 소재지, 음식물종류, 처리결과 회신" class="default_write">
    <caption>모범업소 지정 신청하기</caption>
	<tbody>    
		<tr>
		  <th width="25%" scope="row"><label for="etc1">업소 및 기관명(*)</label></th>
		  <td width="75%" colspan="3"><input type="text" id="etc1" name="etc1" value="${result.etc1}" style="width:400px" class="txt" /></td>
		</tr>
		<tr>
		  <th scope="row"><label for="etc2">대표자명(*)</label></th>
		  <td colspan="3"><input type="text" id="etc2" name="etc2" value="${result.etc2}" style="width:200px" class="txt" /></td>
		</tr>
		<tr>
		  <th scope="row"><label for="etc3_1">대표자 주민번호(*)</label></th>
		  <td colspan="3">
			<c:set var="_etc3" value="${fn:split(result.etc3, '-')}"/>
		  <input type="text" id="etc3_1" name="etc3_U" value="${_etc3[0]}" style="width:50px" class="txt" maxlength="6"/> - 
		  <label for="etc3_2" class="blind">대표자 주민번호 뒷자리</label>
		  <input type="password" id="etc3_2" name="etc3_U" value="${_etc3[1]}" style="width:50px" class="txt"  maxlength="7"/></td>
		</tr>
		<tr>
		  <th scope="row"><label for="etc4">영업형태</label></th>
		  <td colspan="3">
			<input type="text" id="etc4" name="etc4" value="${result.etc4}" style="width:200px" class="txt" />
		  </td>
		</tr>
		<tr>
		  <th scope="row">전화번호(*)</th>
		  <td colspan="3">
			<c:set var="_etc5" value="${fn:split(result.etc5, '-')}"/>
			<label for="etc5_1" class="blind">전화번호(지역번호)</label>
			<input type="text" id="etc5_1" name="etc5_U" value="${_etc5[0]}" style="width:30px" class="txt" maxlength="4"/> - 
			<label for="etc5_2" class="blind">전화번호(국번)</label>
			<input type="text" id="etc5_2" name="etc5_U" value="${_etc5[1]}" style="width:30px" class="txt" maxlength="4"/> - 
			<label for="etc5_3" class="blind">전화번호(뒷자리)</label>
			<input type="text" id="etc5_3" name="etc5_U" value="${_etc5[2]}" style="width:27px" class="txt" maxlength="4">   
		  </td>
		</tr>
		
		<tr>
		  <th rowspan="2" scope="row">업소 소재지(*)</th>
		  <td colspan="3">
			<a href="/health/dev_content/zipcode/GC_member_zipcode.jsp?code1=etc6_1&amp;code2=etc6_2&amp;code3=etc7" onclick="window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes');return false;" onkeypress="if(event.keyCode==13) {this.onclick(); return false;}" title="우편번호검색 팝업"><img src="/health/open_content/images/btn/btn_s_zipcode.gif" alt="우편번호" align="absmiddle" /></a>			
			<c:set var="_etc6" value="${fn:split(result.etc6, '-')}"/>
			<label for="etc6_1" class="blind">업소 소재지 우편번호 앞자리</label>
			<input type="text" id="etc6_1" name="etc6_U" value="${_etc6[0]}" style="width:50px" class="txt" maxlength="3"/> -
			<label for="etc6_2" class="blind">업소 소재지 우편번호 뒷자리</label>
			<input type="text" id="etc6_2" name="etc6_U" value="${_etc6[1]}" style="width:50px" class="txt" maxlength="3" />
		  </td>
		</tr>
		<tr>
		  <td colspan="3">
			<label for="etc7" class="blind">업소 소재지 주소(시,도,군,구,읍,면,동)</label>		  
		  <input type="text" id="etc7" name="etc7" value="${result.etc7}" style="width:200px" class="txt"/> 
			<label for="etc8" class="blind">업소 소재지 주소(번지, 나머지 주소)</label>		
		  <input type="text" id="etc8" name="etc8" value="${result.etc8}" style="width:200px" class="txt"/>
		  </td>
		</tr>
		<tr>
		  <th scope="row"><label for="etc9">음식물 종류</label></th>
		  <td colspan="3"><input type="text" id="etc9" name="etc9" value="${result.etc9}" style="width:500px" class="txt"/></td>
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
    <span class="btn_del"><input type="submit" value="${empty result ? '등록하기' : '수정하기'}" /></span>
    <span class="btn_del"><a href="/health/main/contents.do?categoryId=2929">취소하기</a></span>
</div>
</form>

