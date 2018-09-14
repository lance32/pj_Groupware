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
    	<td><a href="<%=cp%>/message/msgWrite">쪽지 쓰기</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgReceive">받은 쪽지(0/10)</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgSend">보낸 쪽지 10</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgKeep">보관 쪽지 1</a></td>
    </tr>
</table>