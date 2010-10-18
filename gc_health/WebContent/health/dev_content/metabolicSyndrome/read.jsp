<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("crlf", "\r\n"); %>	
				
<script type="text/javascript">
	function checkForm()
	{		
		if (confirm("정말로 신청취소 하시겠습니까?")) {
			return true;
		} 
		else
		{
			return false;
		}
	}

</script>				
				<h4>기본정보</h4>	
						<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">등록번호</th>
									<td colspan="3" class="output">${result.etc1}</td>
								</tr>
								<tr>
									<th scope="row">검진일자</th>
									<td colspan="3" class="output">${result.etc7}</td>
								</tr>
								<tr>
									<th scope="row">이름</th>
									<td colspan="3" class="output">${result.name}</td>
								</tr>
								<tr>
									<th scope="row">주민번호</th>
									<td colspan="3" class="output">${result.etc2}</td>
								</tr>
								<tr>
									<th scope="row">전화번호</th>
									<td colspan="3" class="output">${result.tel}</td>
								</tr>
								<tr>
									<th scope="row">주소</th>
									<td colspan="3" class="output">${result.addr1}</td>
								</tr>
							</tbody>
						</table>
								
<br/>
<br/>
				<h4>등록정보</h4>	
						<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">관리센터</th>
									<td colspan="3" class="output">${result.etc3}</td>
								</tr>
								<tr>
									<th scope="row">등록일자</th>
									<td colspan="3" class="output">${result.etc4}</td>
								</tr>
								<tr>
									<th scope="row">내소동기</th>
									<td colspan="3" class="output">${result.etc5}</td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>복부비만</h4>	
						<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">허리둘레</th>
									<td colspan="3" class="output">${result.etc8}</td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>고지혈증</h4>	
						<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">중성지방</th>
									<td colspan="3" class="output">${result.etc9}</td>
								</tr>
								<tr>
									<th scope="row">HDL</th>
									<td colspan="3" class="output">${result.etc10}</td>
								</tr>
								<tr>
									<th scope="row">약복용</th>
									<td colspan="3" class="output">${result.etc11}</td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>고혈압</h4>	
						<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">혈압</th>
									<td colspan="3" class="output">${result.etc12}</td>
								</tr>
								<tr>
									<th scope="row">약복용</th>
									<td colspan="3" class="output">${result.etc13}</td>
								</tr>
								<tr>
									<th scope="row">공복혈당</th>
									<td colspan="3" class="output">${result.etc14}</td>
								</tr>
								<tr>
									<th scope="row">약복용</th>
									<td colspan="3" class="output">${result.etc15}</td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>대사증후군</h4>	
						<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">판정일자</th>
									<td colspan="3" class="output">${result.etc16}</td>
								</tr>
								<tr>
									<th scope="row">진단기준</th>
									<td colspan="3" class="output">${result.etc17}</td>
								</tr>
								<tr>
									<th scope="row">행동stage</th>
									<td colspan="3" class="output">${result.etc18}</td>
								</tr>
								<tr>
									<th scope="row">복부둘레</th>
									<td colspan="3" class="output">${result.etc19}</td>
								</tr>
								<tr>
									<th scope="row">혈압</th>
									<td colspan="3" class="output">${result.etc20}</td>
								</tr>
								<tr>
									<th scope="row">혈당</th>
									<td colspan="3" class="output">${result.etc21}</td>
								</tr>
								<tr>
									<th scope="row">HDL</th>
									<td colspan="3" class="output">${result.etc22}</td>
								</tr>
								<tr>
									<th scope="row">TG</th>
									<td colspan="3" class="output">${result.etc23}</td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>검사방법</h4>	
						<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">검사장비</th>
									<td colspan="3" class="output">${result.etc24}</td>
								</tr>
								<tr>
									<th scope="row">검사기관명</th>
									<td colspan="3" class="output">${result.etc25}</td>
								</tr>
							</tbody>
						</table>
			
