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

<script type="text/javascript">
	function save() {
		var f = document.mailServerConfigForm;
		console.log(f);
		f.action = "<%=cp%>/mail/mailServerConfig";
		f.submit();
	}
</script>

<div id="mailServerConfig" style="width:100%; height: 600px;">
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-edit" style="font-size: 28px; margin-left: 10px;" ></span>
		<span style="font-size: 30px;">&nbsp;메일 서버 설정</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	<form name="mailServerConfigForm" method="post">
		<table style="width:100%; border-top: 2px solid #a1c9e4;" id="formTable">
			<tr>
				<td class="textLabel">메일 서버 주소</td>
				<td class="tdInput"><input type="text" id="mailSmtpHost" name="mailSmtpHost" class="textInput" value="${MailServerInfo.mailSmtpHost}"></td>
			</tr>
			<tr>
				<td class="textLabel">메일 서버 Port</td>
				<td class="tdInput"><input type="text" id="mailSmtpPort" name="mailSmtpPort" class="textInput" value="${MailServerInfo.mailSmtpPort}"></td>
			</tr>			
			<tr>
				<td class="textLabel">메일 계정</td>
				<td class="tdInput"><input type="text" id="mailSmtpUser" name="mailSmtpUser" class="textInput" value="${MailServerInfo.mailSmtpUser}"></td>
			</tr>				
			<tr>
				<td class="textLabel">메일 인증</td>
				<td class="tdInput"><input type="text" id="smtpAuthenticatorName" name="smtpAuthenticatorName" class="textInput" value="${MailServerInfo.smtpAuthenticatorName}"></td>
			</tr>
			<tr>
				<td class="textLabel">메일 인증 비밀번호</td>
				<td class="tdInput"><input type="password" id="smtpAuthenticatorPwd" name="smtpAuthenticatorPwd" class="textInput" value="${MailServerInfo.smtpAuthenticatorPwd}"></td>
			</tr>
		</table>
		<input type="hidden" name="type" value="${MailServerInfo.type}">
		<span><input type="button" class="butn" value="&nbsp;저 장&nbsp;" onclick="save();"></span>
	</form>
</div>