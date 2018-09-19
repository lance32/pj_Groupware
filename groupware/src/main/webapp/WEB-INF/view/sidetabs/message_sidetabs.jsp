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
		url:"<%=cp%>/message/getMessageCount",
		dataType:"json", 
		success:function(data) {
			$("#receive").text("받은 쪽지(" + data.unread + "/" + data.receive + ")");
			$("#send").text("보낸 쪽지(" + data.send + ")");
			$("#keep").text("보관 쪽지(" + data.keep + ")");
		},
		error:function(jqXHR) {
			console.log(jqXHR.responseText);
		}
	});
});
</script>

<table class="tabs">
	<tr>
    	<th>쪽지</th>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgWrite">쪽지 쓰기</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgReceive" id="receive">받은 쪽지</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgSend" id="send">보낸 쪽지</a></td>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/message/msgKeep" id="keep">보관 쪽지</a></td>
    </tr>
</table>