<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.butn{
	width: auto;
	height: auto;
	padding: 5px 10px;
	border-radius: 5px;
	background: #337ab7;
	color: #E3E5E6;
	border:none;
	outline: 0;
	font-size: 15px;
}
.butn:hover{
	background: #0A68B0;
	color: #ffffff;
	cursor: pointer;
}
</style>
<script type="text/javascript">
function goToMain(){
	location.href="<%=cp%>/main";
	return;
}
</script>

<div style="width: 100%; padding-top: 150px;">
	<div style="position:absolute ; left: 35%; width: 600px; height: 250px; border: 3px solid #A4A4A4; border-radius: 10px; background: #FFFFFF;">
		<div style="clear: both; height: 160px; font-size: 19px; text-align: center; padding-top: 20px;">
			에러가 발생했습니다. <br>에러가 지속될시 관리자에게 문의하세요.<br><br>
			에러 메시지 : ${message}
		</div>
		<div style="clear: both; width: 99%; text-align: center;">
			<button class="butn" style="width: 80%; height: 60px; font-size: 27px;" onclick="goToMain();">메인화면으로 돌아가기</button> 
		</div>
	</div>
</div>
