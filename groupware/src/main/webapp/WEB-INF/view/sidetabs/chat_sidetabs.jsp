<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<table class="tabs">
	<tr>
    	<th>커뮤니티</th>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/chat/chatList">채팅</a></td>
    </tr>
    <tr>
    	<td><a href="#">설문</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/clubList/clubList">동호회</a></td>
    </tr>
</table>