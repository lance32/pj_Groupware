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
	padding-top: 15px;
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

#sideCategory *{
	text-overflow: ellipsis; white-space: nowrap; overflow: hidden;
}

</style>
<script type="text/javascript">
jQuery(function(){
	//카테고리
	<c:forEach var="dto" items="${clubCategoryItem}">
		jQuery("#category${dto.categoryParent}").append("<li class='li-items'><a style='text-decoration: none; display: block; color: #424242;' href='<%=cp%>/clubBoard/list?clubNum=${clubInfo.clubNum}&categoryNum=${dto.categoryNum}'>${dto.categoryName}</a></li>");
	</c:forEach>
	
	jQuery("#manageClubButn").click(function(){
		location.href="<%=cp%>/club/alterClubInfo?clubNum=${clubInfo.clubNum}";
		return;
	});
	
	jQuery("#joinClubButn").click(function(){
		if(! confirm("동호회에 가입하시겠습니까?")){
			return;
		}
		location.href="<%=cp%>/club/joinClub?clubNum=${clubInfo.clubNum}";
		alert("동호회에 가입되었습니다.");
		return;
	});
	
	jQuery("#leaveClubA").click(function(){
		if(! confirm("동호회를 탈퇴하시겠습니까?")){
			return;
		}
		location.href="<%=cp%>/club/leaveClub?clubNum=${clubInfo.clubNum}";
		return;
	});
	
	jQuery("#sideClubImg").click(function(){
		location.href="<%=cp%>/club/main?clubNum=${clubInfo.clubNum}";
		return;
	});
});

</script>

<div style="width: 250px; height: 290px; border-radius: 5px; border: 1.2px solid #A4A4A4; margin-bottom: 20px;">
	<div id="sideClubImg" style="width: 230px; height: 180px; margin: 10px auto; line-height: 170px; text-align: center; border: 1.5px solid #D8D8D8; background: #FAFAFA; cursor: pointer;">
		<img class="representimg" src="<%=cp%>/uploads/club/${clubInfo.memberNum}/${clubInfo.clubImg}">
	</div>
	<div style="width: 100%; height: 75px; padding:0px 15px;">
		<div style="width:100%; height:25px; padding-left:5px; margin-bottom: 5px; font-size: 17px; font-weight: 600; overflow: hidden; background:#F2F2F2; border-left: 5px solid #BDBDBD;">${clubInfo.clubName}</div>
		<span style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">${clubInfo.clubIntro}</span>
	</div>
	
</div>

<c:if test="${empty isMember}">
	<div class="tabsTop"><button class="clubSideButn" id="joinClubButn">동호회 가입</button></div>
</c:if>
<c:if test="${clubInfo.memberNum == sessionScope.member.userId}">
	<div class="tabsTop"><button class="clubSideButn" id="manageClubButn">동호회 관리</button></div>
</c:if>

<div id="sideCategory" style="width: 250px; height: auto; border-radius: 5px; border: 1px solid #A4A4A4; padding: 15px 15px 30px 15px; margin-bottom: 10px;">
	<c:forEach var="dto" items="${clubCategory}">
		<div style="text-align: left;">
			<ul id="category${dto.categoryNum}" class="ul-list">
				<li class="li-separate">${dto.categoryName}</li>
			</ul>
		</div>
	</c:forEach>
</div>
<div style="width: 250px; padding: 0px 10px; margin-bottom: 30px;">
	<c:if test="${not empty isMember}">
	<a id="leaveClubA" style="color: #8A0808; cursor: pointer; font-size: 13px;">동호회 탈퇴</a>
	</c:if>
</div>



