<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
$(function() {
	$.ajax ({
		type:"get",
		url:"<%=cp%>/mail/mailCount",
		dataType:"json", 
		success:function(data) {
			$("#send").text("보낸 메일함(" + data.send + ")");
			$("#tempBox").text("임시 보관함(" + data.tempBox + ")");
			$("#trashbox").text("휴지통(" + data.trashbox + ")");
		},
		error:function(jqXHR) {
			console.log(jqXHR.responseText);
		}
	});
});
</script>

<table class="tabs">
	<tr>
    	<th>메일</th>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/mail/mailWrite">메일 쓰기</a></td>
    </tr>
 <!-- <tr>
    	<td><a href="#" id="receive">받은 메일함</a></td>
    </tr>   -->
    <tr>
    	<td><a href="<%=cp%>/mail/mailSend" id="send">보낸 메일함</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/mail/mailTempBox" id="tempBox">임시 보관함</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/mail/mailTrashbox" id="trashbox">휴지통</a></td>
    </tr> 
    <tr>
    	<td><a href="<%=cp%>/mail/mailServerConfig" id="trashbox">메일서버 설정</a></td>
    </tr> 
</table>