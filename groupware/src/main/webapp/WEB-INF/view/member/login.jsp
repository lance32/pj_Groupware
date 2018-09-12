<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Hi+Melody&amp;subset=korean" rel="stylesheet">

<link href="https://fonts.googleapis.com/css?family=Allerta" rel="stylesheet">
<style type="text/css">
*{
	margin :0px;
	padding: 0px;
	font-family: 'Allerta', sans-serif;
}

.loginmain{
	width: 100%;
	min-height: 300px;
	height: 300px;
	margin-top: 15%;
	margin-bottom: 10%;
	background-image: url('<%=cp%>/resource/images/SUBBG.png');
	background-repeat: no-repeat;
    background-size: cover;
}

.loginfont{
	color: white;
	font-size: 70px;
	font-weight:bold;
	transform:translate(490%, 20%);
	text-shadow: 1px 1px 0px #ffffff, 3px 3px 2px black;
}

.loginmain input{
	width:200px;
    height:30px;
    font-size: 20px;
    border-radius: 7px;
    margin:7px auto;
    transform:translate(510%, 20%);
}

.loginmain button{
	width:205px;
    height:40px;
    background-color:white;
    color:#464646;
    font-size:23px;
    margin:5px auto;
    transform:translate(508%, 20%);
}



</style>

<script type="text/javascript">
function sendOk(){
	var f=document.loginForm;
	var str=f.memberNum.value;
	
	if(!str){
		alert("사번를 입력하세요")
		f.memberNum.focus();
		return;
		
	}
	
	str=f.pwd.value;
	if(!str){
		alert("비밀번호를 입력하세요")
		f.pwd.focus();
		return;
		
	}
	
	f.action="<%=cp%>/member/login_check";
	f.submit();
	
	
}
</script>
</head>
<body>

<div class="loginmain" style="position: absolute">
	<form name="loginForm" method="post">
		<table class = "loginstyle">
		<tr>
		<td class="loginfont">LOGIN</td>
		</tr>
			<tr>
				<td><input type="text" id="memberNum" name="memberNum" placeholder="ID"></td>
			</tr>
			<tr>
				<td><input type="password" id="pwd" name="pwd" placeholder="PassWord"></td>
			</tr>
			<tr>
				<td><button type="button" onclick="sendOk()">LOGIN</button></td>
			</tr>
         </table>
	</form>
</div>
	
</body>
</html>