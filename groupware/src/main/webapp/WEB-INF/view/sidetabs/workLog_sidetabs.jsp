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
    	<th>업 무 일 지</th>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/workLog/list">업무 일지함</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/workLog/created">업무일지 쓰기</a></td>
    </tr>
</table>