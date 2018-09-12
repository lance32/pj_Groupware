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

<style type="text/css">
body {
    background-color: lightblue;
}

.loginstlye{
  position:absolute;
  top:50%;
  left:50%;
  transform:translate(-50%, -50%)
}

.loginstlye input{
	width:300px;
    height:30px;
    font-size:20px;
    font-family: 'Hi Melody', cursive;
    border-radius: 5px;
    margin:2px 2px 0px 0px;
}

.loginstlye button{
	width:304px;
    height:40px;
    font-size:25px;
    color:tomato;
    border-radius: 5px;
    background:white;
    margin:5px auto;
    font-family: 'Hi Melody', cursive;
}

.loginstlye img{
	width:304px;
    height:254px;
}

</style>

<script type="text/javascript">
function sendOk(){
	var f=document.loginForm;
	var str=f.userId.value;
	
	if(!str){
		alert("아이디를 입력하세요")
		f.userId.focus();
		return;
		
	}
	
	str=f.userPwd.value;
	if(!str){
		alert("비밀번호를 입력하세요")
		f.userPwd.focus();
		return;
		
	}
	
	f.action="<%=cp%>/member/login_check";
	f.submit();
	
	
}

</script>
</head>
<body>
side
</body>
</html>