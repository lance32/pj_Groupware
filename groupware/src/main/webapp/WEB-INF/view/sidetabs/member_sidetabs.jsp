<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<table class="tabs">
	<tr>
    	<th>전사정보</th>
    </tr>
    <tr>
    	<td>
	    	<a href="<%=cp%>/member/main">
	    	<c:if test="${sessionScope.member.userId!='admin'}">
	    		사원 조회
	    	</c:if>
	    	<c:if test="${sessionScope.member.userId=='admin'}">
	    		사원 관리
	    	</c:if>
	    	</a>
    	</td>
    </tr>
    
    <c:if test="${sessionScope.member.userId=='admin'}">
	    <tr>
	    	<td><a href="#">조직 관리</a></td>
	    </tr>
    </c:if>

</table>