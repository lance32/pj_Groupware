<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<ul class="nav nav-tabs">
  <li role="presentation"><a href="<%=cp%>/club/alterClubInfo?clubNum=${clubInfo.clubNum}">동호회 정보</a></li>
  <li role="presentation" class="active"><a>게시판 카테고리 설정</a></li>
  <li role="presentation" style="float: right;"><a href="<%=cp%>/club/deleteClub?clubNum=${clubInfo.clubNum}" style="color: #B40404;">동호회 삭제</a></li>
</ul>
