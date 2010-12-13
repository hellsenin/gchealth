<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<c:url var="del_action" value="/admin/freecheck/company/delete.do">
			<c:param name="company_cd" value="${result.company_cd}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="industry_cd" value="${Bean.industry_cd}"/>
			<c:param name="type_cd" value="${Bean.type_cd}"/>
			<c:param name="company" value="${Bean.company}"/>
			<c:param name="ceo_name" value="${Bean.ceo_name}"/>
			<c:param name="id" value="${Bean.id}"/>
			<c:param name="grade_cd" value="${Bean.grade_cd}"/>
			<c:param name="year_cd" value="${Bean.year_cd}"/>
		</c:url>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/Calendar.js" ></script>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>

<script>

function del() {
	
	if (confirm('삭제하시겠습니까?')) 
	{
		location.href = "${del_action}";
	}
};
</script>
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
의약업소 자율점검 (업소관리)
</h2>

<p class="title_deco"></p>
<div class="body">
<table summary="의약업소 자율점검 (업소관리) 페이지" class="default_view">
	<caption>의약업소 자율점검 (업소관리)</caption>
	<colgroup>
		<col width="20%" />
		<col width="30%" />
		<col width="20%" />
		<col width="30%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">아이디</th>
			<td class="output">
				${result.id}
			</td>
			<th scope="row">비밀번호</th>
			<td class="output">
				${result.passwd}
			</td>
		</tr>
		<tr>
			<th scope="row">업종</th>
			<td class="output">
				${result.industry_name}
			</td>
			<th scope="row">업체명</th>
			<td class="output">
				${result.company}
			</td>
		</tr>
		<tr>
			<th scope="row">대표자</th>
			<td class="output" colspan="3">
				${result.ceo_name}
			</td>
			<!-- 
			<th scope="row">대표자주민번호</th>
			<td class="output">
				${result.jumin}
			</td>
			 -->
		</tr>
		<tr>
			<th scope="row">허가(등록·신고)번호 </th>
			<td class="output">
				${result.sa_no}
			</td>
			<th scope="row">면허번호</th>
			<td class="output">
				${result.pharmacist_no}
			</td>
		</tr>
		<tr>
			<th scope="row">전화번호 </th>
			<td class="output">
				${result.tel}
			</td>
			<th scope="row">팩스번호</th>
			<td class="output">
				${result.fax}
			</td>
		</tr>
		<tr>
			<th scope="row">휴대폰  </th>
			<td class="output">
				${result.hp}
			</td>
			<th scope="row">e메일</th>
			<td class="output">
				${result.email}
			</td>
		</tr>
		<tr>
			<th scope="row" style="vertical-align: middle;">주소</th>
			<td class="output" colspan="3">
				우) ${result.post}<br/>
				${result.addr1} ${result.addr2} 
			</td>
		</tr>
		
		<tr>
			<th scope="row">영업형태</th>
			<td class="output" colspan="3">
				<c:choose>
					<c:when test="${result.grade_cd == '01'}">휴업</c:when>
					<c:when test="${result.grade_cd == '02'}">영업</c:when>
					<c:when test="${result.grade_cd == '03'}">폐업</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th scope="row">등록자</th>
			<td class="output">
				${result.insert_name}
			</td>
			<th scope="row">등록일자</th>
			<td class="output">
				<fmt:formatDate value="${result.insert_dt}" pattern="yyyy년MM월dd일"/>
			</td>
		</tr>
		
		<tr>
			<th scope="row"><label for="regUserName">수정자</label></th>
			<td class="output">
				${result.update_name}
			</td>
			<th scope="row"><label for="renew_date">수정일자</label></th>
			<td class="output">
				<fmt:formatDate value="${result.update_dt}" pattern="yyyy년MM월dd일"/>
			</td>
		</tr>
	</tbody>
</table>

	<form action="/admin/freecheck/company/forUpdate.do" method="post">
			<input type="hidden" name="company_cd" value="${result.company_cd}"/>
			<input type="hidden" name="pageIndex" value="${Bean.pageIndex}"/>
			<input type="hidden" name="searchCondition" value="${Bean.searchCondition}"/>
			<input type="hidden" name="industry_cd" value="${Bean.industry_cd}"/>
			<input type="hidden" name="type_cd" value="${Bean.type_cd}"/>
			<input type="hidden" name="company" value="${Bean.company}"/>
			<input type="hidden" name="ceo_name" value="${Bean.ceo_name}"/>
			<input type="hidden" name="id" value="${Bean.id}"/>
			<input type="hidden" name="grade_cd" value="${Bean.grade_cd}"/>
			<input type="hidden" name="year_cd" value="${result.year_cd}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="수정하기" /></span>
	
	<span class="btn_del"><a href="javascript:del();">삭제하기</a></span>
	
		<c:url var="list_action" value="/admin/freecheck/company/list.do">
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="industry_cd" value="${Bean.industry_cd}"/>
			<c:param name="type_cd" value="${Bean.type_cd}"/>
			<c:param name="company" value="${Bean.company}"/>
			<c:param name="ceo_name" value="${Bean.ceo_name}"/>
			<c:param name="id" value="${Bean.id}"/>
			<c:param name="grade_cd" value="${Bean.grade_cd}"/>
			<c:param name="year_cd" value="${Bean.year_cd}"/>
		</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>
</form>
	
</div>
</body>
</html>
	