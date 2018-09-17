<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
	function send() {
		if ($("#members").val() == "") {
			alert('받는 사람이 없습니다.');
			$(this).focus();
			return false;
		}
		
		if ($("#content").val() == "") {
			alert('내용이 없습니다.');
			$(this).focus();
			return false;
		}
		
		document.msgWriteForm.submit();
	}
</script>
<div id="msgWrite" style="width:100%; height: 600px;">
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-send" style="font-size: 28px; margin-left: 10px;" ></span>
		<span style="font-size: 30px;">&nbsp;쪽지 쓰기</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	<form name="msgWriteForm" method="post" action="<%=cp%>/message/msgWrite" >
		<table style="width:100%; border-top: 2px solid #a1c9e4;">
			<tr>
				<td style="border-bottom: 1px dotted #dfdfdf; padding:5px; background: #f7f7f7; color: #595959; text-align:center; width: 15%;">제목</td>
				<td style="background: #fff; width: 85%;"><input type="text" id="subject" name="subject" style="width: 80%; border: 1px solid #d7d7d7;"></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px dotted #dfdfdf; padding:5px; background: #f7f7f7; color: #595959; text-align:center; width: 15%;">받는이</td>
				<td style="background: #fff; width: 85%;">
					<span><input type="text" id="toMember" name="toMember" style="background: #fff; color: #333; width: 80%; border: 1px solid #d7d7d7;"></span>
					<span><input type="button" id="" value="&nbsp;조직도&nbsp;"></span>
				</td>
			</tr>
			<tr>
				<td colspan="2"><div style="padding-top: 5px;"><textarea id="content" name="content" rows="15" cols="45" style="width: 99%;"></textarea></div></td>
			</tr>
		</table>
		<span><input type="button" value="&nbsp;전송&nbsp;" onclick="send();"></span>
	</form>
</div>
