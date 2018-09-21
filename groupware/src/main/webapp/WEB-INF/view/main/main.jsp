<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp=request.getContextPath();
%>
<%-- 
main
현재 시각
공지사항
일정
쪽지
메시지
미확인 결재
<br>
<br>
 --%>
 <h1>메인화면 입니다.</h1>
&gt;<a href="<%=cp%>/template/template"> 목록,버튼 견본 </a>&lt;