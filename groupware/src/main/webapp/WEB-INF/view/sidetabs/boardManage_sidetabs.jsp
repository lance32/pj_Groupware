<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<table class="tabs">
	<tr>
    	<th>메인 사이드 탭1</th>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/boardManage/list">게시판 관리</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/notice/list">공 지 사 항</a></td>
    </tr>
	<tr>
    	<th>메인 사이드 탭2</th>
    </tr>
    <c:forEach var="dto" items="${list}">
	    <tr>
	    	<td><a href="<%=cp%>/${dto.tableName}/list">${dto.boardName }</a></td>
	    </tr>
    </c:forEach>

</table>