<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
jQuery(function(){
	jQuery(".replyAnswerDiv").hide();
});
</script>
				
	<c:forEach var="listReply" items="${listReply}">
	<%-- 댓글 목록 --%>
	<div style="width: 100%; clear: both; border-bottom: 1px solid #D8D8D8;">
		<div style="width: 100%; height: 20px; clear: both;">
			<span style="font-size: 15px;">${listReply.memberName}</span>
				<span style="color: #6E6E6E; font-size: 13px;">&nbsp; | ${listReply.replyCreated}</span>
			</div>
		<div style="width: 100%; clear: both; padding: 10px; color: #6E6E6E;">
			${listReply.replyContent}
		</div>
		<div style="clear: both; width: 100%; height: 40px;">
			<button class="showReplyAnswerButn">답글 (${listReply.answerCount})</button>
		</div>
	</div>
						
	<div class="replyAnswerDiv">
		<%-- 답글 input --%>
		<div style="clear: both; width: 100%; padding: 10px 20px; background: #FCFCFC; border-bottom: 1px solid #D8D8D8;">
			<span style="width: 3%; vertical-align: top; font-size: 18px;">└</span>
			<textarea style="max-width: 97%; min-width:97%; min-height: 80px; border: 1.2px solid #A4A4A4; padding-left: 5px;"></textarea>
			<div style="clear: both; width: 100%; height: 30px; padding-right: 5px;">
				<button class="clubButn" style="float: right;">답글달기</button>
			</div>
		</div>
						
		<%-- 답글 목록 --%>
		<div style="clear: both; width: 100%; padding: 10px 20px; background: #FAFAFA; border-bottom: 1px solid #D8D8D8;">
			<span style="width: 3%; vertical-align: top; font-size: 18px;">└</span>
			<span style="font-size: 15px;">테스트3</span>
			<span style="color: #6E6E6E; font-size: 13px;">&nbsp; | 2018-10-02 15:35</span>
			<div style="clear: both; width: 100%; padding: 5px 20px;">
				답글
			</div>
		</div>
	</div>
	</c:forEach>
	<div style="width: 100%; clear: both; height: 40px; text-align: center; line-height: 40px;">${paging}</div>	
					
					
					