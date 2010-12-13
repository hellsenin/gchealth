<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/admin/common/css/common_style.css">
<link rel="stylesheet" type="text/css" href="/admin/common/css/board.css">
<script type="text/javascript" src="/portal/open_content/system/js/miya_validator.js"></script>
			<div class="text_area">	
				<div  class="board_view">
					<table class="view_type01">
						<caption>아르바이트신청</caption>
						<colgroup>
							<col width="20%" />
							<col width="0%" />
							<col width="50%" />
							<col width="30%" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">
								제목(*)
							</th>
							<td class="output" colspan="3">${result.title}</td>
						</tr>
						<tr>
							<th scope="row">
								신청기간(*)
							</th>
							<td class="output" colspan="3">
								${result.receiptSdate} ~ ${result.receiptEdate}
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="writecontents">내용</label></th>
							<td colspan="3" class="output">${result.contents}</td>
						</tr>
						</tbody>
					</table>
				</div>
				
				<div id="btn_area">
					<div class="btn_right_fl">
						<a href="/admin/portal/modifyOnlineApplyPage/listOnlineApply.do"><img src="/portal/open_content/images/common/btn/btn_modify.gif" alt="수정" /></a>
					</div>
					<div class="btn_right_fr">
						<a href="/admin/portal/onlineApply/listOnlineApply.do"><img src="/portal/open_content/images/common/btn/btn_list.gif" alt="목록" /></a>
					</div>
				</div><!-- btn end -->
			</div>