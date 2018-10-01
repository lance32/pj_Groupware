<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<table class="tabs">
	<tr>
    	<th>업무지원</th>
    </tr>
    <tr>
    	<td>
	    	<a href="<%=cp%>/member/main">근태조회</a>
    	</td>
    </tr>
    
    <tr>
    	<td><a href="#">연차 사용 내역 조회</a></td>
    </tr>
    <tr>
    	<td><a href="#">급여 조회</a></td>
    </tr>
    <tr>
    	<td><a href="#">증명서 발급</a></td>
    </tr>
    
   

</table>