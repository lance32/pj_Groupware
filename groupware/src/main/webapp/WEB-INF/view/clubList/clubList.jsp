<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.listItem {
	width: 250px;
	height: 300px;
	float: left;
	margin: 0px 20px 40px 0px;
	border: 1px solid #A4A4A4;
	background: #ffffff;
	border-radius: 3px;
}
	.listItem:hover {
		cursor: pointer;
	}

.listItem_img {
	width: 100%;
	height: 220px;
	border-bottom: 1px solid #848484;
	text-align: center;
	line-height: 210px;
	background: #FAFAFA;
}
.clubImg{
    height: auto;
    max-width: 100%;
	max-height:100%;
}
.listItem_intro{
	width: 100%;
	text-align: center;
}
</style>

<script>

jQuery(function(){
	jQuery(".listItem").click(function(){
		var clubNum=jQuery(this).children(".clubNum").val();
		location.href="<%=cp%>/club/main?clubNum="+clubNum;
		return;
	});
});


</script>

<div style="clear: both; margin: 10px 0px 40px 10px;">
	<span class="glyphicon glyphicon-th-large" style="font-size: 28px; margin-left: 10px;"></span> 
	<span style="font-size: 30px;">&nbsp;동호회</span><br>
	<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>

<div style="clear: both; width: 1390px; margin-left: 50px; height: 670px; overflow-y: scroll; background: #FAFAFA; padding: 10px;">

	<c:forEach var="dto" items="${list}">
		<div class="listItem">
			<div class="listItem_img">
				<img class="clubImg" src="<%=cp%>/uploads/club/${dto.memberNum}/${dto.clubImg}">
			</div>
			<div class="listItem_intro">
				<p style="font-weight: 700;">${dto.clubName}</p>
				<span>${dto.clubIntro}</span>
			</div>
			<input type="hidden" class="clubNum" value="${dto.clubNum}">
		</div>
	</c:forEach>

</div>