<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-list-alt"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;게 시 판 관 리</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>

<table id="tb" style="width: 85%;">
	<tr>
		<td id="count" colspan="2"><button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/boardManage/created';">게 시 판 생 성</button></td>
		<td></td>
		<td></td>
	</tr>

	<tr class="cf">
		<td width="70">번호</td>
		<td width="300" style="text-align: center;">게시판 제목</td>
		<td width="250">게시판 주소</td>
		<td width="300">테이블명</td>
		<td width="200">글쓰기권한</td>
		<td width="100">메뉴위치</td>
	</tr>

	<c:forEach var="dto" items="${list}">
		<tr class="tr">
			<td>${dto.boardNum }</td>
			<td style="text-align: center;">${dto.boardName }</td>
			<td>/${dto.tableName}/list</td>
			<td>${dto.tableName}</td>
			<td>${dto.writePermit==0?"관리자":"회원"}</td>
			<td>${dto.subMenu }</td>
		</tr>
	</c:forEach>

</table>