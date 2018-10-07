<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.textLabel {
	border-bottom: 1px dotted #dfdfdf;
	padding:5px;
	background: #f7f7f7;
	color: #595959; 
	text-align:center; 
	width: 15%;
}
.tdInput {
	background: #fff; 
	width: 85%;
}
.textInput {
	width: 80%; 
	border: 1px solid #d7d7d7;
}
</style>

<div id="mailWrite" style="width:100%; height: 600px;">
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-edit" style="font-size: 28px; margin-left: 10px;" ></span>
		<span style="font-size: 30px;">&nbsp;메일 서버 설정</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	<form name="mailWriteForm" method="post" action="<%=cp%>/mail/mailServerConfig" >
		<table style="width:100%; border-top: 2px solid #a1c9e4;" id="formTable">
			<tr>
				<td class="textLabel">메일 서버 주소</td>
				<td class="tdInput"><input type="text" id="cc" name="cc" class="textInput" value="${mail.cc}"></td>
			</tr>
			<tr>
				<td class="textLabel">메일 계정</td>
				<td class="tdInput"><input type="text" id="bcc" name="bcc" class="textInput" value="${mail.bcc}"></td>
			</tr>				
			<tr>
				<td class="textLabel">메일 계정 비밀번호</td>
				<td class="tdInput"><input type="password" id="pwd" name="pwd" class="textInput" value="${mail.subject}"></td>
			</tr>
			<tr>
				<td class="textLabel"></td>
				<td class="tdInput">
					<span><input type="file" name="upload" style="background: #fff; color: #333; width: 80%; border: 1px solid #d7d7d7;"></span>
				</td>
			</tr>
		</table>
		<table style="width:100%;">
			<tr>
				<td colspan="2"><div style="padding-top: 5px;"><textarea id="content" name="content" rows="15" cols="45" style="width: 83%;">${mail.content}</textarea></div></td>
			</tr>
		</table>
		<input type="hidden" name="sendMail" id="sendMail">
		<input type="hidden" name="memberNum" value="${sessionScope.member.userId}">
		<input type="hidden" name="state" id="state" value="0">
		<span><input type="button" value="&nbsp;메일 보내기&nbsp;" onclick="send();"></span>
		<c:if test="${mailType != 'tempBox'}">
			<span><input type="button" value="&nbsp;임시 보관&nbsp;" onclick="toTemp();"></span>
			<input type="hidden" name="index" value="-1">
		</c:if>
		<c:if test="${mailType == 'tempBox'}">
			<span><input type="button" value="&nbsp;취소&nbsp;" onclick="javascript:location.href='<%=cp%>/mail/mailTempBox'"></span>
			<input type="hidden" name="index" value="${mail.index}">
		</c:if>
	</form>
</div>