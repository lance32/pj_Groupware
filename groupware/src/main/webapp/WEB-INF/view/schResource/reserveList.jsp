<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script>
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

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
<div style="text-align: center;">
	<form name="searchForm" action="<%=cp%>/scheduler/list" method="post">
		${paging }
		<br>
		<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/scheduler/list';">새 로 고 침</button>
   		<select name="searchKey" class="selectBox" style="margin-bottom: 5px;">
          	<option value="title">제 목</option>
           	<option value="writer">작 성 자</option>
          	<option value="rName">항 목</option>
      	</select>
    	<input type="text" name="searchValue" class="searchBox">
   		<button type="button" class="butn" onclick="searchList()">검색</button>
   	</form>

</div>
