<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GroupWare</title>

<link href="https://fonts.googleapis.com/css?family=Jua&amp;subset=korean" rel="stylesheet">

<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.css" type="text/css">

<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css?ver=1" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>

</head>
<body>

<div class="header">
    <tiles:insertAttribute name="header"/>
</div>

<div class="container">

	<div class="side">
	    <tiles:insertAttribute name="side"/>
	    <div>
		   	<tiles:insertAttribute name="sidetabs"/>
		</div>
	</div>
	
	<div class="body">
    	<tiles:insertAttribute name="body"/>
	</div>
</div>

<div class="footer">
    <tiles:insertAttribute name="footer"/>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>

</body>
</html>