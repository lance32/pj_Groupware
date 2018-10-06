<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

	<c:forEach var="listReplyAnswer" items="${listReplyAnswer}">
	<%-- 답글 목록 --%>
	<div style="clear: both; width: 100%; padding: 10px 20px; background: #FAFAFA; border-bottom: 1px solid #D8D8D8;">
		<span style="width: 3%; vertical-align: top; font-size: 18px;">└</span>
		<span style="font-size: 15px;">${listReplyAnswer.memberName}</span>
		<span style="color: #6E6E6E; font-size: 13px;">&nbsp; | ${listReplyAnswer.replyCreated}</span>
		<div style="clear: both; width: 100%; padding: 5px 20px;">
			${listReplyAnswer.replyContent}
		</div>
	</div>
	</c:forEach>				