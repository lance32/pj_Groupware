<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
jQuery(function(){
	//카테고리
	<c:forEach var="dto" items="${clubCategoryItem}">
		jQuery("#alterCategory${dto.categoryParent}").append("<li class='li-items'>${dto.categoryName}</li>");
	</c:forEach>
});

</script>

<ul class="nav nav-tabs">
  <li role="presentation"><a href="<%=cp%>/club/alterClubInfo?clubNum=${clubInfo.clubNum}">동호회 정보</a></li>
  <li role="presentation" class="active"><a>게시판 카테고리 설정</a></li>
  <li role="presentation" style="float: right;"><a href="<%=cp%>/club/deleteClub?clubNum=${clubInfo.clubNum}" style="color: #B40404;">동호회 삭제</a></li>
</ul>

<div style="width:1100; height: 700px; clear: both; margin: 0px; padding: 0px; padding: 40px 0px 0px 80px; ">
	<p>&nbsp;카테고리 목록</p>
	<div style="float: left; width: 260px; height: 600px; border: 1px solid #A4A4A4; overflow-y: scroll; padding: 15px 10px;">
		<c:forEach var="dto" items="${clubCategory}">
			<div style="text-align: left;">
				<ul id="alterCategory${dto.categoryNum}" class="ul-list">
					<li class="li-separate">${dto.categoryName}</li>
				</ul>
			</div>
		</c:forEach>
	</div>
	
	<div style="float: left; width: auto; height: 600px; padding-left: 80px;">
		<div style="clear: both;">
			<span style="font-size: 19px;">카테고리 추가</span><br>
			<div style="clear: both; width: 270px; height: 1px; border-bottom: 2px solid black;"></div>
		</div>
		<div style="clear: both; padding:20px 0px 70px 10px;">&nbsp;
			<label><input type="radio" name="separate">&nbsp;1단계</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label><input type="radio" name="separate">&nbsp;2단계</label><br>
			<input type="text" style="border: none; border:1px solid #848484; border-radius: 3px; height: 28px;">
			<button class="clubButn">추가</button>
		</div>
		
		<div style="clear: both;">
			<span style="font-size: 19px;">카테고리 수정</span><br>
			<div style="clear: both; width: 270px; height: 1px; border-bottom: 2px solid black;"></div>
		</div>
		<div style="clear: both; padding:20px 0px 0px 10px;">
			<span style="font-size: 13px; color: #A4A4A4;">※ 왼쪽 목록에서 카테고리를 선택하면 밑에 정보가 표시됩니다.</span>
			<table style="border-spacing: 0px; margin:20px 0px 10px 0px;">
				<tr height="40">
					<td width="100">카테고리 이름</td>
					<td><input type="text" style="border:1px solid #848484; border-radius: 3px; height: 25px;"></td>
				</tr>
				<tr height="40">
					<td>상위 카테고리</td>
					<td><input type="text" style="border:1px solid #848484; border-radius: 3px; height: 25px;"></td>
				</tr>
				<tr height="40">
					<td colspan="2">댓글, 답변형, 좋아요 등..</td>
				</tr>
			</table>
			<button class="clubButn">삭제</button>
			<button class="clubButn" style="float: right;">수정 완료</button>
		</div>
		
		
	</div>
	
</div>