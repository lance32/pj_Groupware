<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
	$(function() {
		$("#listBtn").click(function() {
			<c:if test="${msgType == 'send'}">
				location.href="<%=cp%>/message/msgSend";
			</c:if>
			<c:if test="${msgType == 'receive'}">
				location.href="<%=cp%>/message/msgReceive";
			</c:if>
			<c:if test="${msgType == 'keep'}">
				location.href="<%=cp%>/message/msgReceive";
			</c:if>
		});
		
		$("#keepBtn").click(function(){
			if (confirm('쪽지를 보관하시겠습니까?'))
				location.href="<%=cp%>/message/setMsgKeep?msgNum=${msgNum}";
		});
		
		$("#deleteBtn").click(function(){
			if (confirm('쪽지를 삭제하시겠습니까?'))
				location.href="<%=cp%>/message/msgDelete?msgNum=${msgNum}&msgType=${msgType}";
		});
	});
</script>

<div id="msgWrite" style="width:100%; height: 600px;">
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-ok" style="font-size: 28px; margin-left: 10px;" ></span>
		<span style="font-size: 30px;">&nbsp;쪽지 읽기</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	<table style="width:100%; border-top: 2px solid #a1c9e4; border-bottom: 2px solid #a1c9e4;">
		<tr>
			<td style="border-bottom: 1px dotted #dfdfdf; padding:5px; background: #f7f7f7; color: #595959; text-align:center; width: 15%;">제목</td>
			<td style="background: #fff; width: 85%;">${msg.subject}</td>
		</tr>
		<tr>
			<td style="border-bottom: 1px dotted #dfdfdf; padding:5px; background: #f7f7f7; color: #595959; text-align:center; width: 15%;">
				<c:if test="${msgType == 'send'}">받는이</c:if>
				<c:if test="${msgType == 'receive'}">보낸이</c:if>
			</td>
			<td style="background: #fff; width: 85%;">
				<span>
				<c:if test="${msgType == 'receive'}">
					<span style="background: #fff; color: #333; width: 80%; border: 1px solid #d7d7d7;">${msg.sendMemberName}</span>
				</c:if>
				<c:if test="${msgType == 'send'}">
					<span style="background: #fff; color: #333; width: 80%; border: 1px solid #d7d7d7;">${msg.toMemberName}</span>
				</c:if>
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div style="margin-top: 5px;"><textarea id="content" name="content" rows="15" cols="45" style="width: 99%; " readonly="readonly">${msg.content}</textarea></div>
			</td>
		</tr>
	</table>
	<div style="padding-top: 5px;">
		<button type="button" id="listBtn" class="butn">&nbsp;리스트&nbsp;</button>&nbsp;
		<button type="button" id="keepBtn" class="butn">&nbsp;보관&nbsp;</button>&nbsp;
		<button type="button" id="deleteBtn" class="butn">&nbsp;삭제&nbsp;</button>
	</div>

</div>
