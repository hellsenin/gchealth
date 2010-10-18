<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

		<div class="board_write">	
				<table summary="글 내용을 등록합니다. 내용을 쓰신 후 저장버튼을 클릭해주세요." cellspacing="1" cellpadding="0">
					<caption>신청인정보</caption>
					<col />
					<col style="width:85%;" />
					<tbody>
					<tr>
						<th scope="row">이름</th>
						<td class="subject">${result.name}</td>
					</tr>
					<tr>
						<th scope="row"><label for="email">이메일</label></th>
						<td class="subject" ><input type="text" id="email" name="email" class="intext" value="${result.email}" /></td>
					</tr>
					<tr>
						<c:set var="_tel" value="${fn:split(result.tel, '-')}"/>
						<th scope="row"><label for="phone1">전화번호</label></th>
						<td class="subject" ><input type="text" id="phone1" name="tel:U" class="intext" style="width:95px;" value="${_tel[0]}" /> - <input type="text" id="phone3" name="tel:U" class="intext" style="width:95px;" value="${_tel[1]}" /> - <input type="text" id="phone5" name="tel:U" class="intext" style="width:95px;" value="${_tel[2]}" /></td>
						
					</tr>
					<tr>
						<c:set var="_cellPhone" value="${fn:split(result.cellPhone, '-')}"/>
						<th  scope="row" class="lastborder"><label for="phone2">휴대폰</label></th>
						<td class="subject"><input type="text" id="phone2" name="cellPhone:U"  class="intext"  style="width:95px;" value="${_cellPhone[0]}" /> - <input type="text" id="phone4" name="cellPhone:U" class="intext"  style="width:95px;"  title="전화번호 가운데자리" value="${_cellPhone[1]}" /> - <input type="text" id="phone6"  name="cellPhone:U" class="intext"  style="width:95px;"  title="전화번호 뒷자리" value="${_cellPhone[2]}" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="address">주소</label></th>
						<td class="subject">
						<c:set var="_zipcode" value="${fn:split(result.zipcode, '-')}"/>
							<input type="text" id="zipcode1" name="zipcode:U" class="intext" style="width:63px;" value="${_zipcode[0]}"/>
							<input type="text" id="zipcode2" name="zipcode:U" class="intext" title="우편번호 뒷자리" style="width:63px;" value="${_zipcode[1]}" />
							<a href="/cms/dev_content/0005_member/GC_member_zipcode.jsp?code=" onclick="window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes');return false;"
								onkeypress="if(event.keyCode==13) {window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes'); return false;}"><img src="/skin/photo/images/btn_addr.gif" alt="우편번호검색" /></a>
							<input type="text" id="address1" name="addr1" title="주소" class="intext2" style="width:459px;" value="${result.addr1}" /> 
							<input type="text" id="address1" name="addr2" title="주소" class="intext2" style="width:459px;" value="${result.addr2}" />
						
						</td>
					</tr>
					</tbody>
				</table>
			</div>