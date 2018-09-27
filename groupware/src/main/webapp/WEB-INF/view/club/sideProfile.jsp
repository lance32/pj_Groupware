<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.representimg{
    height: auto;
    max-width: 100%;
	max-height:176px;
	margin: auto;
}

</style>

<div style="width: 250px; height: 280px; border-radius: 5px; border: 1.2px solid #A4A4A4; margin-bottom: 20px;">
	<div style="width: 230px; height: 180px; margin: 10px auto; line-height: 170px; text-align: center;  border: 1.5px solid #D8D8D8; background: #FAFAFA;">
		<img class="representimg" src="<%=cp%>/uploads/club/${clubInfo.memberNum}/${clubInfo.clubImg}">
	</div>
	<div style="width: 100%; height: 75px; padding-left: 20px;">
		<p>${clubInfo.clubName}</p>
		<span>${clubInfo.clubIntro}</span>
	</div>

</div>