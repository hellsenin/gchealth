<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script>

function checkAndSubmit() {
	
	if (confirm('삭제하시겠습니까?')) {
		return true;
	} else {
		return false;
	}
};
</script>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		설문
</h2>
<p class="title_deco"></p>
<div class="body">

		<table summary="의약업소 자율점검 (점검표관리) 페이지" class="default_view">
			<caption>의약업소 자율점검 (점검표관리)</caption>
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="20%" />
				<col width="30%" />
			</colgroup>
			<tbody>				
				<tr>
					<th scope="row">제목</th>
					<td class="output" colspan="3">
						${result.title}
					</td>
				</tr>
				
				
				<tr>
					<th scope="row">응모기간</th>
					<td class="output" colspan="3">
						<fmt:formatDate value="${result.start_dt}" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${result.end_dt}" pattern="yyyy년 MM월 dd일"/>
					</td>
				</tr>
				
				<tr>
					<th scope="row">내용</th>
					<td class="output" colspan="3">
						<c:if test="${result.contents == ''}"><font style="color: lightgray;">입력된 내용이 없습니다</font></c:if>
						<c:if test="${result.contents != ''}">${result.contents}</c:if>
					</td>
				</tr>
				
				
				
				<tr>
					<th scope="row">첨부파일</th>
					<td class="output" colspan="3">
						<c:if test="${result.attachfile1 == null}"><font style="color: lightgray;">첨부된 파일이 없습니다</font></c:if>
						<c:if test="${result.attachfile1 != null}">
							<c:url value="/health/poll/download.do" var="download_action">
								<c:param name="file" value="${result.attachfile1}" />
							</c:url>
							<a href="${download_action}"><strong style="color: gray;">${result.attachfile1}</strong></a>
						</c:if>
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
		
	
			<form action="/admin/health/poll/checkform/forUpdate.do" method="post">
				<input type="hidden" name="master_cd" value="${result.master_cd}"/>
				
				<!-- 리스트 페이지의 상태 복구에 필요한 파라메터 -->
				<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="수정하기" /></span>
	
	<c:url var="del_action" value="/admin/health/poll/checkform/delete.do">
		<c:param name="master_cd" value="${result.master_cd}"/>
		<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
	</c:url>
	<span class="btn_del"><a href="${del_action}" onclick="return confirm('문제,결과등 하위 모든데이터가 삭제됩니다.삭제하시겠습니까?');">삭제하기</a></span>

	<c:url var="list_action" value="/admin/health/poll/checkform/list.do">
		<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
	</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>
			</form>
			
</div>
</body>
</html>
			