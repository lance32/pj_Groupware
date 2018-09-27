<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script>
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-bullhorn"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;공 지 사 항</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
<table id="tb" style="width: 85%;">
	<tr>
		<td id="count" colspan="2">${dataCount }개(${page }/${total_page } 페이지)</td>
		<td></td>
		<td></td>
	</tr>

	<tr class="cf">
		<td width="150">번호</td>
		<td width="500" style="text-align: center;">제목</td>
		<td width="190">작성자</td>
		<td width="350">작성일</td>
		<td width="100">조회수</td>
	</tr>
	<c:forEach var="dto" items="${list}">
		<tr class="tr">
			<c:if test="${dto.notice == 1}">
				<td><span style="background-color: #ff0000;border-radius: 3px;color:#fff;padding: 2px;">긴 급 공 지</span></td>
			</c:if>
			<c:if test="${dto.notice == 0}">
				<td>${dto.num }</td>
			</c:if>
			<td style="text-align: center;"><a href="${articleUrl}&num=${dto.num}">${dto.subject}</a></td>
			<td>${dto.name }</td>
			<td>${dto.created }</td>
			<td>${dto.hitCount }</td>
		</tr>
	</c:forEach>
</table>
<br>
<div style="text-align: center;">
	<form name="searchForm" action="<%=cp%>/notice/list" method="post">
		${paging }
		<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list';">새 로 고 침</button>
   		<select name="searchKey" class="selectBox" style="margin-bottom: 5px;">
          	<option value="subject">제 목</option>
           	<option value="name">작 성 자</option>
          	<option value="content">내 용</option>
          	<option value="created">등 록 일</option>
      	</select>
    	<input type="text" name="searchValue" class="searchBox">
    
   		<button type="button" class="btn" onclick="searchList()">검색</button>
   		<c:if test="${sessionScope.member.userId=='admin'}">
   		<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/created';">글 쓰 기</button>
   		</c:if>
   	</form>
</div>