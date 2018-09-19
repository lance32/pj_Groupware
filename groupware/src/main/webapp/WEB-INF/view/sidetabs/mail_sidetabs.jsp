<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<table class="tabs">
	<tr>
    	<th>메일</th>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgWrite">메일 쓰기</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgReceive" id="receive">받은 메일함</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgSend" id="send">보낸 메일함</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgKeep" id="keep">임시 보관함</a></td>
    </tr>
      <tr>
    	<td><a href="<%=cp%>/message/msgKeep" id="keep">휴지통</a></td>
    </tr> 
</table>