<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<div class="logo">
	<a href="<%=cp%>/main"><img src="<%=cp%>/resource/images/home.png"/></a>
</div>

<div class="menu">
	<ul class="nav">
		<li><a href="<%=cp%>/approval/approval">전자 결재</a></li>
		<li><a href="<%=cp%>/workLog/list">업무일지</a></li>
		<li><a style="cursor: pointer;">커뮤니티</a>
			<ul class="sub_menu">
				<li><a href="<%=cp%>/chat/chatList">채팅</a></li>
				<li><a href="#">설문</a></li>
				<li><a href="<%=cp%>/clubList/clubList">동호회</a></li>
			</ul></li>
		<li><a href="<%=cp%>/mail/mailWrite">메일</a></li>
		<li><a href="<%=cp%>/message/msgReceive">쪽지</a></li>
		<li><a href="<%=cp%>/schedule/main">일정</a></li>
		<li><a href="<%=cp%>/scheduler/main">자원예약</a></li>
		<li><a href="<%=cp%>/workhelper/main">업무지원</a>
			<ul class="sub_menu">
				<li><a href="#">근태조회</a></li>
				<li><a href="#">연차 내역 조회</a></li>
				<li><a href="<%=cp%>/pay/main">급여조회</a></li>
				<li><a href="<%=cp%>/certificate/main">증명서 발급</a></li>
			</ul></li>
		<li><a href="<%=cp%>/notice/list">게시판</a></li>
		<li><a href="<%=cp%>/member/main">전사 정보</a>	</li>
	</ul>
</div>
<div id="blank"></div>

<script type="text/javascript">
jQuery(".sub_menu").hide();
jQuery(".menu ul li").mouseenter(function(){
	jQuery(this).find(".sub_menu").slideDown(75);
}).mouseleave(function(){
	jQuery(this).find(".sub_menu").slideUp(75);
});

//-- position fixed로 인한 가로스크롤 고장 해결
jQuery(window).scroll(function(){
	jQuery(".header").css("left",0-jQuery(this).scrollLeft());
});
</script>
