<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<table class="tabs">
	<tr>
    	<th>게 시 판 목 록</th>
    </tr>
    <c:if test="${sessionScope.member.userId == 'admin'}">
	    <tr>
	    	<td><a href="<%=cp%>/boardManage/list">게시판 관리</a></td>
	    </tr>
    </c:if>
    <tr>
    	<td><a href="<%=cp%>/notice/list">공 지 사 항</a></td>
    </tr>
    <c:forEach var="dto" items="${boardList}">
	    <tr>
	    	<td><a href="<%=cp%>/${dto.tableName}/list">${dto.boardName}</a></td>
	    </tr>
    </c:forEach>


</table>