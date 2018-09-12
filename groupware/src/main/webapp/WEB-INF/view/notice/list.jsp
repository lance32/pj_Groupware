<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
	<table id="tb" style="width: 1000px;"><%-- 테이블 길이 수정 가능 --%>
		<tr>
			<td id="count" colspan="2">
				3개(1/1 페이지)
			</td>
			<td></td><td></td>
		</tr>
		
		<tr class="cf">
			<%-- 구분 폭 수정 가능 --%>
			<td width="150">번호</td>
			<td width="700" style="text-align: center;">제목</td>
			<td width="190">작성자</td>
			<td width="150">작성일</td>
			<td width="100">조회수</td>
		</tr>
		
		<tr class="tr">
			<td>항목1</td>
			<td style="text-align: center;">1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
		</tr>
		<tr class="tr">
			<td>항목2</td>
			<td style="text-align: center;">1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
		</tr>
		<tr class="tr">
			<td>항목3</td>
			<td style="text-align: center;">1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
		</tr>
	</table>
	
	<button type="button" class="btn" style="float: right;" 
	onclick="javascript:location.href='<%=cp%>/notice/created';">글쓰기</button>