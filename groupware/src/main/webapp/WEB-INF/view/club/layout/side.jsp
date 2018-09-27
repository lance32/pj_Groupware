<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.body{
	width: 78%;
}
.side{
	max-width: none;
}

.representimg{
    height: auto;
    max-width: 100%;
	max-height:176px;
	margin: auto;
}

.clubSideButn{
	width: 100%;
	height: 45px;
	border-radius: 5px;
	background: #848484;
	color: #FAFAFA;
	border: 1px solid #BDBDBD;
	outline: 0;
	margin-bottom: 10px;
	font-size: 20px;
	overflow: hidden;
}
.clubSideButn:hover{
	background: #6E6E6E;
	color: #ffffff;
}

.ul-list{
	padding: 0px;
	list-style: none;
}
.li-separate{
	font-weight: 600;
	background: #424242;
	color: #FAFAFA;
	padding-left: 10px;
}
.li-items{
	padding-left: 20px;
	cursor: pointer;
}
.li-items:hover{
	background: #E6E6E6;
}
</style>
<script type="text/javascript">
jQuery(function(){
	jQuery("#manageClubButn").click(function(){
		location.href="<%=cp%>/club/alterClubInfo?clubNum="+${clubInfo.clubNum};
		return;
	});
	
	
});

</script>

<div style="width: 250px; height: 280px; border-radius: 5px; border: 1.2px solid #A4A4A4; margin-bottom: 20px;">
	<div style="width: 230px; height: 180px; margin: 10px auto; line-height: 170px; text-align: center;  border: 1.5px solid #D8D8D8; background: #FAFAFA;">
		<img class="representimg" src="<%=cp%>/uploads/club/${clubInfo.memberNum}/${clubInfo.clubImg}">
	</div>
	<div style="width: 100%; height: 75px; padding-left: 20px;">
		<p>${clubInfo.clubName}</p>
		<span>${clubInfo.clubIntro}</span>
	</div>

</div>

<c:if test="${empty isMember}">
	<div class="tabsTop"><button class="clubSideButn" id="joinClubButn">동호회 가입</button></div>
</c:if>
<c:if test="${clubInfo.memberNum == sessionScope.member.userId}">
	<div class="tabsTop"><button class="clubSideButn" id="manageClubButn">동호회 관리</button></div>
</c:if>

<div style="width: 250px; height: auto; border-radius: 5px; border: 1px solid #A4A4A4; padding: 15px 15px 30px 15px; margin-bottom: 30px;">
	<div style="text-align: left;">
		<ul class="ul-list">
			<li class="li-separate">테스트</li>
			<li class="li-items">테스트1</li>
			<li class="li-items">테스트2</li>
		</ul>
	</div>
	<div style="text-align: left;">
		<ul class="ul-list">
			<li class="li-separate">테스트</li>
			<li class="li-items">테스트1</li>
			<li class="li-items">테스트2</li>
		</ul>
	</div>
</div>



