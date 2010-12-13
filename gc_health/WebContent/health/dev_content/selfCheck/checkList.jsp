<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>

<script type="text/javascript">
function checkForm(form) {
	var v = new MiyaValidator(form);
    v.add("q2", {
		required: true
    });
    v.add("q3", {
		required: true
    });
    var result = v.validate();
    if (!result) {
        alert(v.getErrorMessage());
        v.getErrorElement().focus();
		return false;
    } 
    else {
	    return true;
    }
};
</script>

<h4> 건강한 다이어트 방법 </h4>

<form name="fm" method="post" enctype="multipart/form-data" action="<c:url value='/health/selfCheck/checkResult.do?categoryId=${param.categoryId}'/>" onsubmit="return checkForm(this);">
	<fieldset>
	<legend>비만도 자가진단</legend>
		<table class="data_table" summary="비만도 자가진단 해당하는 질문의 답변을 선택하세요.">
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th>1</th>
					<td class="tal">
						<dl>
							<dt class="fl_l mgr10"><label for="radio1-1">당신의 성별은?</label></dt>
							<dd>
								<input type="radio" class="vam" value="F" id="radio1-1" name="q1" style="border:none;" /><label for="radio1-1">여성</label>
								<input type="radio" class="vam" value="M" id="radio1-2" name="q1" style="border:none;" /><label for="radio1-2">남성</label>
							</dd>
						</dl>
					</td>
				</tr>
				<tr>
					<th>2</th>
					<td class="tal">
						<dl>
							<dt class="fl_l mgr10"><label for="q2">체중</label>은 얼마 입니까?</dt>
							<dd>
								<input type="text" maxlength="5" style="width: 30px; height: 11px; margin-left: 10px;" id="q2" name="q2" />  kg
							</dd>
						</dl>
					</td>
				</tr>
				<tr>
					<th>3</th>
					<td class="tal">
						<dl>
							<dt class="fl_l mgr10"><label for="q3">신장</label>은 얼마 입니까?</dt>
							<dd>
								<input type="text" maxlength="5" style="width: 30px; height: 11px; margin-left: 10px;" id="q3" name="q3" />  cm
							</dd>
						</dl>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="tar mt20">
			<img src="/health/open_content/images/sub_blue/img_hi.gif" alt="수고하셨습니다." />
			<img src="/health/open_content/images/sub_blue/img_writeText.gif" alt="작성을 완료하셨으면 결과 보기 버튼을 클릭하여 주세요" />
			<input type="image" class="vam" src="/health/open_content/images/sub_blue/btn_result_View.gif" alt="결과보기" />
			<a href="/health/selfCheck/checkList.do?categoryId=${param.categoryId}"><img class="vam" src="/health/open_content/images/sub_blue/btn_reset.gif" alt="다시하기" /></a>
		</div>
	</fieldset>
</form>