<%@ page language="java" errorPage="/error.jsp" %>
<%@ page import="egovframework.kr.go.geumcheon.health.service.ApplicationService"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="RECEIPT_WAITING" value="<%=ApplicationService.RECEIPT_WAITING %>" />
<c:set var="RECEIPT" value="<%=ApplicationService.RECEIPT %>" />
<c:set var="ASSIGNED_DEPT" value="<%=ApplicationService.ASSIGNED_DEPT %>" />
<c:set var="OFFICER_PROCESSING" value="<%=ApplicationService.OFFICER_PROCESSING %>" />
<c:set var="ANSWERING" value="<%=ApplicationService.ANSWERING %>" />
<c:set var="COMPLETE_ANSWER" value="<%=ApplicationService.COMPLETE_ANSWER %>" />
<c:set var="COMPLETION" value="<%=ApplicationService.COMPLETION %>" />
<c:set var="DELETION" value="<%=ApplicationService.DELETION %>" />
<c:set var="TRANSFER" value="<%=ApplicationService.TRANSFER %>" />

<c:set var="ANSWER_ASSIGNED_DEPT" value="<%=ApplicationService.ANSWER_ASSIGNED_DEPT %>" />
<c:set var="ANSWER_OFFICER_PROCESSING" value="<%=ApplicationService.ANSWER_OFFICER_PROCESSING %>" />
<c:set var="ANSWER_ANSWERING" value="<%=ApplicationService.ANSWER_ANSWERING %>" />
<c:set var="ANSWER_COMPLETION" value="<%=ApplicationService.ANSWER_COMPLETION %>" />
<c:set var="ANSWER_DEPT_RETURN" value="<%=ApplicationService.ANSWER_DEPT_RETURN %>" />
<c:set var="ANSWER_OFFICER_INSPECTOR_RETURN" value="<%=ApplicationService.ANSWER_OFFICER_INSPECTOR_RETURN %>" />
<c:set var="ANSWER_OFFICER_DEPT_RETURN" value="<%=ApplicationService.ANSWER_OFFICER_DEPT_RETURN %>" />
