<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript">
	//<![CDATA[
	function fn_egov_regist_notice(form)
	{			
			var v = new MiyaValidator(form);
		    v.add("option2", {
		        required: true
		    });
		    v.add("option7", {
		        option: "number"
		    });
		    v.add("option8", {
		        option: "number"
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

<div class="body">
<form id="board" name="board" action="/health/bbs/insertBoardArticle.do" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_regist_notice(this);">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="bbsId" value="<c:out value='${param.bbsId}'/>" />
<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
<input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />
<input type="hidden" name="secret" value="N" />
<input type="hidden" name="categoryId" value="${param.categoryId}" />
			
<table summary="제목,작성자,등록일자,연락처,내용,첨부파일 제공" class="default_write">
	<caption>
    게시물제목
    </caption>
    <tr>
        <th scope="row" width="20%" class="title_1"><label for="sr_title">약국명</label> </th>
        <td colspan="3" class="title_td"><input type="hidden" id="sr_title" name="nttSj" value="${company.company}" />${company.company}</td>
    </tr>
    <tr>
        <th scope="row"><label for="option2">약품명</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option2" name="option2" style="width:300px;"/></td>
    </tr>
	<tr>
        <th scope="row"><label for="option5">성분</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option5" name="option5" style="width:300px;"/></td>
    </tr>
	<tr>
        <th scope="row"><label for="option3">회사명</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option3" name="option3" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="option4">함량</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option4" name="option4" style="width:100px;"/></td>
    </tr>
	<tr>
        <th scope="row"><label for="option6">유통기한</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option6" name="option6" /></td>
    </tr>
	<tr>
        <th scope="row"><label for="option7">재고량</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option7" name="option7" style="width:100px;"/></td>
    </tr>
	<tr>
        <th scope="row"><label for="option8">판매된 수량</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option8" name="option8" style="width:100px;"/> ※ 판매 후에 입력해 주세요. </td>
    </tr>
	<tr>
        <th scope="row"><label for="option9">연락처(약국)</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option9" name="option9" style="width:100px;"/></td>
    </tr>
	<tr>
        <th scope="row"><label for="option10">연락처(핸드폰)</label> </th>
        <td colspan="3" class="title_data"><input type="text" id="option10" name="option10" style="width:100px;"/></td>
    </tr>
	<tr>
        <th scope="row"><label for="sr_contents">판매여부</label> </th>
        <td colspan="3" class="title_data">
			<select name="option1" id="option1">
				<option value="">--선택--</option>
				<option value="1">판매완료</option>
				<option value="2">판매취소</option>
				<option value="3">판매중</option>
			</select>
		</td>
    </tr>
</table>

<div class="board_btn_set mt13">
    <span class="btn_del"><input type="submit" value="등록하기" /></span>
    <!-- >span class="btn_del"><a href="#">삭제하기</a></span-->
    <span class="btn_list"><a href="/health/bbs/selectBoardList.do?categoryId=${param.categoryId}&amp;bbsId=${param.bbsId}&amp;optionCnd=${param.optionCnd}&amp;optionWrd=${param.optionWrd}">목록보기</a></span>
</div>
</form>

</div>