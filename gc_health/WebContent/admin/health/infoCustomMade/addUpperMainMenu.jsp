<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" type="text/css" href="/admin/common/css/common_style.css">
<link rel="stylesheet" type="text/css" href="/admin/common/css/board.css">
<c:set var="action" value="/admin/portal/apply/placard/addBannerDong.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/admin/portal/apply/placard/modifyBannerDong.do" />
</c:if>		
<script type="text/javascript" src="/portal/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/portal/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/portal/open_content/system/js/util.js"></script>
<script type="text/javascript" src="/js/egovframework/cmm/sym/zip/EgovZipPopup.js" ></script>
<script type="text/javascript">
	function addBannerDong()
	{			
		var form = document.frm;
		var v = new MiyaValidator(form);
	    v.add("dongNameV", {
	        required: true
	    });
	    v.add("dongDetailV", {
	        required: true
	    });
	    v.add("dongXpointV", {
	        required: true,
	        option: "number" 
	    });
	    v.add("dongYpointV", {
	        required: true,
	        option: "number" 
	    });
		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		} 
		else
		{
			form.submit();
		}
	}

</script>

			<h3 class="tit_03">현수막 지정게시대</h3>
			
			<!-- text_area start -->
			<div class="text_area">
				<!-- write form start -->
							
			<form name="frm" method="post" action="${action}">
			<c:if test="${not empty result.dongCodeC}">
				<input type="hidden" name="dongCodeC" value="${result.dongCodeC}" />
			</c:if>
			<fieldset>
			
				<!-- 현수막 지정 신청	 -->
				<div  class="board_view mgb20">
				<table summary="글 내용을 등록합니다. 내용을 쓰신 후 저장버튼을 클릭해주세요." class="view_type01">
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
					<tr>
						<th scope="row"><label for="placeaddr">메뉴이름(*)</label></th>
						<td colspan="3" class="output">
							<input type="text" name="cstmMenuNm" value="${result.cstmMenuNm}" id="placeaddr" class="board1" style="width:100px" /></td>
					</tr>
					</tbody>
				</table>
				</div>

				<div id="btn_area">
					<div class="btn_right_fl">
					<c:choose>
					<c:when test="${empty result}" >
						<a href="javascript:addBannerDong();"><img src="/portal/open_content/images/common/btn/btn_regist.gif" alt="등록" /></a>
					</c:when>
					<c:otherwise>
						<a href="javascript:addBannerDong();"><img src="/portal/open_content/images/common/btn/btn_modify.gif" alt="수정" /></a>
					</c:otherwise>
					</c:choose>
					</div>
					<div class="btn_right_fr">
						<a href="/admin/portal/apply/placard/selectBannerDongList.do"><img src="/portal/open_content/images/common/btn/btn_list.gif" alt="목록" /></a>
					</div>
					
					
				</div><!-- btn end -->
				</fieldset>
				</form><!-- write form end -->
				</div>

