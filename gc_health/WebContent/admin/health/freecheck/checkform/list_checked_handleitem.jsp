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
	
		<base target="_self">
		<title>${companyInfo.company} - 취급현황</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

</head>
	
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		의약업소 자율점검 (점검표관리)
</h2>
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
							<th scope="row">업소명</th>
							<td class="output">
								${companyInfo.company}
							</td>
							<th scope="row">대표자명</th>
							<td class="output">
								${companyInfo.ceo_name}
							</td>
						</tr>
						
						<tr>
							<th scope="row">업종</th>
							<td class="output">
								${companyInfo.industry_name}
							</td>
							<th scope="row">점검 분류</th>
							<td class="output">
								<c:if test="${Bean.year_cd == '200801' or Bean.year_cd == '200901'}">
									<c:if test="${companyInfo.type_cd_01_yn == 'Y'}"><strong>약국</strong></c:if>
									<c:if test="${companyInfo.type_cd_02_yn == 'Y'}"><strong>약업</strong></c:if>
									<c:if test="${companyInfo.type_cd_03_yn == 'Y'}"><strong>도매</strong></c:if>
									<c:if test="${companyInfo.type_cd_04_yn == 'Y'}"><strong>한약업</strong></c:if>
									<c:if test="${companyInfo.type_cd_05_yn == 'Y'}"><strong>기기</strong></c:if>
									<c:if test="${companyInfo.type_cd_06_yn == 'Y'}"><strong>기관(병/의원)</strong></c:if>
									<c:if test="${companyInfo.type_cd_07_yn == 'Y'}"><strong>치과기공</strong></c:if>
									<c:if test="${companyInfo.type_cd_08_yn == 'Y'}"><strong>기관(치과병/의원)</strong></c:if>
									<c:if test="${companyInfo.type_cd_09_yn == 'Y'}"><strong>기관(한방병/의원)</strong></c:if>
									<c:if test="${companyInfo.type_cd_10_yn == 'Y'}"><strong>안경</strong></c:if>
									<c:if test="${companyInfo.type_cd_11_yn == 'Y'}"><strong>마약</strong></c:if>
								</c:if>
								<c:if test="${Bean.year_cd == '201001'}">
									<c:if test="${companyInfo.type_cd_01_yn == 'Y'}"><strong>[약국]</strong></c:if>
									<c:if test="${companyInfo.type_cd_02_yn == 'Y'}"><strong>[약업사]</strong></c:if>
									<c:if test="${companyInfo.type_cd_03_yn == 'Y'}"><strong>[의약품도매상]</strong></c:if>
									<c:if test="${companyInfo.type_cd_04_yn == 'Y'}"><strong>[한약업사]</strong></c:if>
									<c:if test="${companyInfo.type_cd_05_yn == 'Y'}"><strong>[의료기기판매]</strong></c:if>
									<c:if test="${companyInfo.type_cd_07_yn == 'Y'}"><strong>[치과기공소]</strong></c:if>
									<c:if test="${companyInfo.type_cd_08_yn == 'Y'}"><strong>[병원]</strong></c:if>
									<c:if test="${companyInfo.type_cd_09_yn == 'Y'}"><strong>[의료기관]</strong></c:if>
									<c:if test="${companyInfo.type_cd_10_yn == 'Y'}"><strong>[안경업소]</strong></c:if>
									<c:if test="${companyInfo.type_cd_11_yn == 'Y'}"><strong>[마약류]</strong></c:if>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			
			
			<div style="float: right; height: 30px; margin-right: 10px;">
				<strong>리스트 : ${fn:length(resultList)} 건 / 전체 : ${resultListSize} 건</strong>
			</div>
		
			
			<table class="default_list" summary="의약업소 자율점검 (점검표관리) 목록 테이블입니다">
				<caption>의약업소 자율점검 (점검표관리) 목록</caption>
				<colgroup>
					<col width="8%" />
					<col width="*" />
					<col width="10%" />
					<col width="14%" />
					<col width="14%" />
					<col width="14%" />
					<col width="17%" />
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
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(resultList) != 0}">
						<c:forEach items="${resultList}" var="item" varStatus="status">
							<tr>
								<td>
									${status.count}
								</td>
								<td class="tal">
									${item.item_name}
								</td>
								<td>
									${item.unit}
								</td>
								<td>
									${item.field1}
								</td>
								<td>
									${item.field2}
								</td>
								<td>
									${item.field3}
								</td>
								<td>
									${item.field4}
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="8">검색된 리스트가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			
<div id="btn_area" class="board_btn_set mt13">
	<span class="btn_list"><a href=" href="#btn_area" onclick="window.close();"">닫기</a></span>
</div>
		
</div>
</body>
</html>