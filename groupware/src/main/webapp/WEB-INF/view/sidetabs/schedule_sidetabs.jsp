<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>

</style>

<table class="tabs">
	<tr>
    	<th>일 정</th>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/schedule/main">일 정 관 리</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/schedule/list">일 정 검 색</a></td>
    </tr>
</table>