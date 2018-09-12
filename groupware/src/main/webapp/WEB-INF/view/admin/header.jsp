<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<div class="logo">
	<a href="#"><img src="<%=cp%>/resource/images/home.png"/></a>
</div>

<div class="menu">
	<ul class="nav">
		<li><a href="#">전자 결재</a></li>
		<li><a href="#">업무일지</a></li>
		<li><a href="#">커뮤니티</a>
			<ul class="sub_menu">
				<li><a href="#">채팅</a></li>
				<li><a href="#">설문</a></li>
				<li><a href="#">동호회</a></li>
			</ul></li>
		<li><a href="#">메일</a></li>
		<li><a href="#">쪽지</a></li>
		<li><a href="#">일정</a></li>
		<li><a href="#">자원관리</a></li>
		<li><a href="#">업무지원</a>
			<ul class="sub_menu">
				<li><a href="#">근태조회</a></li>
				<li><a href="#">연차사용 내역 조회</a></li>
				<li><a href="#">급여조회</a></li>
				<li><a href="#">증명서 발급</a></li>
			</ul></li>
		<li><a href="#">게시판</a></li>
		<li><a href="#">전사 정보</a>
			<ul class="sub_menu">
				<li><a href="#">사원조회</a></li>
			</ul></li>
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
</script>
