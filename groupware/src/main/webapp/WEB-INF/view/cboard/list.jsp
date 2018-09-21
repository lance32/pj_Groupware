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
	<span class="glyphicon glyphicon-comment"
		style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;${cb.boardName }</span><br>
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
			
			<td>${dto.num }</td>
			<td style="text-align: center;">
				<c:forEach var="n" begin="1" end="${dto.depth}">
		       		&nbsp;
		       	</c:forEach>
		       	<c:if test="${dto.depth!=0}">└&nbsp;</c:if>			
				<a href="${articleUrl}&num=${dto.num}">${dto.title}<c:if test="${cb.canReply=='1'}">[${dto.replyCount}]</c:if></a>
			</td>
			<td>${dto.name }</td>
			<td>${dto.created }</td>
			<td>${dto.hitCount }</td>
		</tr>
	</c:forEach>
</table>
<div style="text-align: center;">
	<form name="searchForm" action="<%=cp%>/${cb.tableName}/list" method="post">
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="center">
			        <c:if test="${dataCount==0 }">
			               	등록된 게시물이 없습니다.
			         </c:if>
			        <c:if test="${dataCount!=0 }">
			               ${paging}
			       	</c:if>
				</td>
			</tr>
		</table>
		
		<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/${cb.tableName}/list';">새 로 고 침</button>
   		<select name="searchKey" class="selectBox" style="margin-bottom: 5px;">
          	<option value="title">제 목</option>
           	<option value="name">작 성 자</option>
          	<option value="content">내 용</option>
          	<option value="created">등 록 일</option>
      	</select>
    	<input type="text" name="searchValue" class="searchBox">
    
   		<button type="button" class="btn" onclick="searchList()">검색</button>
   		<c:if test="${cb.writePermit == '1' || (cb.writePermit == '0' && sessionScope.member.userId=='admin')}">
   		<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/${cb.tableName}/created';">글 쓰 기</button>
   		</c:if>
   	</form>

</div>