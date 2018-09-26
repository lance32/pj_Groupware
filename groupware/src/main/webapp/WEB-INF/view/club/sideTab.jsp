<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
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

<div class="tabsTop"><button class="clubSideButn" id="joinClubButn">동호회 가입</button></div>

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