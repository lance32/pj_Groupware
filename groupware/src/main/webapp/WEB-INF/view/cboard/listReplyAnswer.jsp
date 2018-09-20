<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<c:forEach var="dto" items="${listReplyAnswer}">
    <div class='answer' style='padding: 0px 10px;'>
        <div style='clear:both; padding: 10px 0px;'>
            <div style='float: left; width: 5%;'>└</div>
            <div style='float: left; width:95%;'>
                <div style='float: left;'><b>${dto.name}</b></div>
                <div style='float: right;'>
                    <span>${dto.created}</span> |
                    <c:if test="${sessionScope.member.userId==dto.memberNum || sessionScope.member.userId=='admin'}">
                    	<span class='deleteReplyAnswer' style='cursor: pointer;' data-replyNum='${dto.replyNum}' data-answer='${dto.answer}'>삭제</span>
                    </c:if>
                </div>
            </div>
        </div>
        <div style='clear:both; padding: 5px 5px 5px 5%; border-bottom: 1px solid #ccc;'>
            ${dto.content}
        </div>
    </div>			            
</c:forEach>