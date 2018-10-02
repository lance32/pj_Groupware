<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-calendar"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;자 원 예 약 목 록</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
<table id="tb" style="width: 85%;">
	<tr>
		<td id="count" colspan="2">${dataCount}개(${page}/${total_page} 페이지)</td>
		<td></td>
		<td></td>
	</tr>

	<tr class="cf">
		<td width="190">항 목</td>
		<td width="250" style="text-align: center;">제 목</td>
		<td width="250">시작일</td>
		<td width="250">종료일</td>
		<td width="190">작성자</td>
		<td width="190">예약인원</td>
		<td width="300">작성일</td>
	</tr>
	<c:forEach var="dto" items="${list}">
		<tr class="tr">
			<td>${dto.resourceName }</td>
			<td>${dto.title }</td>
			<td>${dto.startDay }</td>
			<td>${dto.endDay }</td>
			<td>${dto.name }</td>
			<td>${dto.inwon }</td>
			<td>${dto.created }</td>
		</tr>
	</c:forEach>
</table>
<br>
${paging }
