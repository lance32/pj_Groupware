<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<div class="tabsTop"><button class="sideBtn">채팅방 개설</button></div>

<table class="tabs">
	<tr>
    	<th>커뮤니티</th>
    </tr>
    <tr>
    	<td><a href="#">채팅</a></td>
    </tr>
    <tr>
    	<td><a href="#">설문</a></td>
    </tr>
    <tr>
    	<td><a href="#">동호회</a></td>
    </tr>
</table>