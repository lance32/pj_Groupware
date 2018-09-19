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
<title>주소록</title>
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css?ver=12443" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css?ver=1" type="text/css">
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
jQuery(function(){
	//추가 버튼 클릭시
	jQuery("#addAdressBtn").click(function(){
		location.href="<%=cp%>/addressBook/created";
		return;
	});
	
	
});
</script>
</head>
<body>

<button id="addAdressBtn" type="button" class="btn">추가</button>

</body>
</html>