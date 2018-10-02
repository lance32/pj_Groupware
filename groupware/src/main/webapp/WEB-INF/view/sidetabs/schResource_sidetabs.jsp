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
    	<th>메 뉴</th>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/scheduler/main">자 원 예 약</a></td>
    </tr>
    
    <tr>
    	<td><a href="<%=cp%>/scheduler/list">예 약 목 록</a></td>
    </tr>
    
    <tr>
    	<td><a href="<%=cp%>/scheduler/resList">자 원 관 리</a></td>
    </tr>
</table>