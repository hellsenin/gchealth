<%@page contentType="text/html;charset=utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/portal/open_content/system/js/miya_validator.js"></script>

<!-- 향정신성의약품 취급 현황 -->

<script>

function setNum(obj) {
    var val=obj.value;
    var re=/[^0-9]/gi;
    obj.value=val.replace(re,"");
};

function addItem() {
	fm.view_state.value='add';
};

function delItem(i) {
	fm.view_state.value='del';


	if(!fm.arr_status.length & i == 1) {
		if(fm.arr_status.value == 'Y') {
			fm.arr_status.value = 'N';
		} else if(fm.arr_status.value == 'N') {
			fm.arr_status.value = 'Y';
		}
	} else {
		if(fm.arr_status[i-1].value == 'Y') {
			fm.arr_status[i-1].value = 'N';
		} else if(fm.arr_status[i-1].value == 'N') {
			fm.arr_status[i-1].value = 'Y';
		}
	}
};

function save() {
	fm.view_state.value='save';
};

function modify() {
	fm.view_state.value='modify';
};

function checkAndSubmit(f) {
	if(fm.view_state.value=='save') {
		var v = new MiyaValidator(f);
		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		} else {
			if (confirm('등록하시겠습니까?')) {
				return true;
			} else {
				return false;
			}
		}
	}
	return true;
};
</script>

<h4>향정신성의약품 취급 현황</h4>


<form name="fm" action="/health/freecheck/checkHandleitem.do?menuId=0602010101" method="post" onsubmit="return checkAndSubmit(this);">
	<input type="hidden" name="find_type_cd" value="${Bean.find_type_cd}"/>
	
	<input type="hidden" name="type_cd_01_yn" value="${Bean.type_cd_01_yn}"/>
	<input type="hidden" name="type_cd_02_yn" value="${Bean.type_cd_02_yn}"/>
	<input type="hidden" name="type_cd_03_yn" value="${Bean.type_cd_03_yn}"/>
	<input type="hidden" name="type_cd_04_yn" value="${Bean.type_cd_04_yn}"/>
	<input type="hidden" name="type_cd_05_yn" value="${Bean.type_cd_05_yn}"/>
	<input type="hidden" name="type_cd_06_yn" value="${Bean.type_cd_06_yn}"/>
	<input type="hidden" name="type_cd_07_yn" value="${Bean.type_cd_07_yn}"/>
	<input type="hidden" name="type_cd_08_yn" value="${Bean.type_cd_08_yn}"/>
	<input type="hidden" name="type_cd_09_yn" value="${Bean.type_cd_09_yn}"/>
	<input type="hidden" name="type_cd_10_yn" value="${Bean.type_cd_10_yn}"/>
	<input type="hidden" name="type_cd_11_yn" value="${Bean.type_cd_11_yn}"/>
	<input type="hidden" name="type_cd" value="${Bean.type_cd}"/>
	
	<input type="hidden" name="company_cd" value="${Bean.company_cd}">
	<input type="hidden" name="id" value="${Bean.company_id}"/>
	<input type="hidden" name="company_id" value="${Bean.company_id}"/>
	<input type="hidden" name="year_cd" value="${Bean.year_cd}">
	<input type="hidden" name="master_cd" value="${Bean.master_cd}">
	<input type="hidden" id="view_state" name="view_state" value="${Bean.view_state}">
	
	
	<div id="btn_area" style="margin-bottom: 3px;">
		<div class="btn_right_fr">
			<input type="image" src="/portal/open_content/images/common/btn/btn_add2.gif" onclick="addItem();" alt="추가"/>
		</div>
	</div>
	
		
	<table summary="등록정보 테이블로 허가내용을 알 수 있습니다" class="default_list">
		<caption>등록정보</caption>
		<colgroup>
			<col width="8%" />
			<col width="*" />
			<col width="10%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="17%" />
			<col width="7%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="fir">번호</th>
				<th scope="col">품명</th>
				<th scope="col">규격및단위</th>
				<th scope="col">2008년도<br/>이월량</th>
				<th scope="col">2009년도<br/>구입량</th>
				<th scope="col">2009년도<br/>판매(사용)량</th>
				<th scope="col">2009년12월31일<br/>재고량</th>
				<th scope="col">삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${resultList}" var="item" varStatus="status">
				<tr>
					<td>
						${status.count}
						<input type="hidden" name="arr_handle_cd" value="${item.handle_cd}">
						<input type="hidden" name="arr_order_no" value="${status.count}">
					</td>
					<td>
						<input type="hidden" name="arr_status" value="${item.status}"/>
						
						<c:if test="${item.status == 'Y'}">
							<label for="item_name_${status.count}"><input type="text" id="item_name_${status.count}" name="arr_item_name" value="${item.item_name}" style="width:150px;" class="t_text" title="품명" disabled="disabled"/></label>
							<input type="hidden" name="arr_item_name" value="${item.item_name}"/>
						</c:if>
						<c:if test="${item.status == 'N'}">
							<label for="item_name_${status.count}"><input type="text" id="item_name_${status.count}" name="arr_item_name" value="${item.item_name}" style="width:150px;" class="t_text" title="품명" /></label>
						</c:if>
					</td>
					<td>
						<c:if test="${item.status == 'Y'}">
							<label for="unit_${status.count}"><input type="text" id="unit_${status.count}" name="arr_unit" value="${item.unit}" maxlength="9" style="text-align: center; padding-left: 0px; width:80px;" class="t_text" title="규격 및 단위" disabled='disabled'/></label>
							<input type="hidden" name="arr_unit" value="${item.unit}"/>
						</c:if>
						<c:if test="${item.status == 'N'}">
							<label for="unit_${status.count}"><input type="text" id="unit_${status.count}" name="arr_unit" value="${item.unit}" maxlength="9" style="text-align: center; padding-left: 0px; width:80px;" class="t_text" title="규격 및 단위"/></label>
						</c:if>
					</td>
					<td>
						<c:if test="${item.status == 'Y'}">
							<label for="field1_${status.count}"><input type="text" id="field1_${status.count}" name="arr_field1" value="${item.field1}" maxlength="9" style="text-align: center; padding-left: 0px; width: 75px;" class="t_text" title="2008년도 이월량" disabled='disabled'/></label>
							<input type="hidden" name="arr_field1" value="${item.field1}"/>
						</c:if>
						<c:if test="${item.status == 'N'}">
							<label for="field1_${status.count}"><input type="text" id="field1_${status.count}" name="arr_field1" value="${item.field1}" maxlength="9" style="text-align: center; padding-left: 0px; width: 75px;" class="t_text" title="2008년도 이월량"/></label>
						</c:if>
					</td>
					<td>
						<c:if test="${item.status == 'Y'}">
							<label for="field2_${status.count}"><input type="text" id="field2_${status.count}" name="arr_field2" value="${item.field2}" maxlength="9" style="text-align: center; padding-left: 0px; width: 75px;" class="t_text" title="2009년도 구입량" disabled='disabled'/></label>
							<input type="hidden" name="arr_field2" value="${item.field2}"/>
						</c:if>
						<c:if test="${item.status == 'N'}">
							<label for="field2_${status.count}"><input type="text" id="field2_${status.count}" name="arr_field2" value="${item.field2}" maxlength="9" style="text-align: center; padding-left: 0px; width: 75px;" class="t_text" title="2009년도 구입량"/></label>
						</c:if>
					</td>
					<td>
						<c:if test="${item.status == 'Y'}">
							<label for="field3_${status.count}"><input type="text" id="field3_${status.count}" name="arr_field3" value="${item.field3}" maxlength="9" style="text-align: center; padding-left: 0px; width: 75px;" class="t_text" title="2009년도 판매(사용)량" disabled='disabled'/></label>
							<input type="hidden" name="arr_field3" value="${item.field3}"/>
						</c:if>
						<c:if test="${item.status == 'N'}">
							<label for="field3_${status.count}"><input type="text" id="field3_${status.count}" name="arr_field3" value="${item.field3}" maxlength="9" style="text-align: center; padding-left: 0px; width: 75px;" class="t_text" title="2009년도 판매(사용)량"/></label>
						</c:if>
					</td>
					<td>
						<c:if test="${item.status == 'Y'}">
							<label for="field4_${status.count}"><input type="text" id="field4_${status.count}" name="arr_field4" value="${item.field4}" maxlength="9" style="text-align: center; padding-left: 0px; width: 75px;" class="t_text" title="2009년12월31일 재고량" disabled='disabled'/></label>
							<input type="hidden" name="arr_field4" value="${item.field4}"/>
						</c:if>
						<c:if test="${item.status == 'N'}">
							<label for="field4_${status.count}"><input type="text" id="field4_${status.count}" name="arr_field4" value="${item.field4}" maxlength="9" style="text-align: center; padding-left: 0px; width: 75px;" class="t_text" title="2009년12월31일 재고량"/></label>
						</c:if>
					</td>
					<td>
						<label for="del_check_${status.count}"><input type="checkbox" id="del_check_${status.count}" onclick="delItem(${status.count}); submit();" <c:if test="${item.status == 'Y'}">checked="checked"</c:if>/></label>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	
	<div id="btn_area">
		<div class="btn_right_fr" style="margin-right: 3px;">
			<input type="image" src="/health/open_content/images/btn/btn_bbs_register.gif" alt="저장" onclick="save();"/>	
		</div>
	</div>
	
</form>
