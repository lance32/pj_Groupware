<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>
#paginate{clear:both;text-align:center;height:28px;white-space:nowrap;}
#paginate a {border:1px solid #ccc;height:28px;color:#000000;text-decoration:none;padding:4px 7px 4px 7px;margin-left:3px;line-height:normal;vertical-align:middle;outline:none;}
#paginate a:hover, a:active {border:1px solid #147FCC;color:#0174DF;vertical-align:middle;line-height:normal;}
#paginate .curBox{border:1px solid #424242; background: #4e4e4e; color:#ffffff; font-weight:bold;height:28px;padding:4px 8px 4px 8px;margin-left:3px;line-height:normal;vertical-align:middle;}
#paginate .numBox {border:1px solid #ccc;height:28px;text-decoration:none;padding:4px 7px 4px 7px;margin-left:3px;line-height:normal;vertical-align:middle;}
</style>

<div id="test" style="width:100%; height:600px; ">

	<%-- 상단 대표글씨 --%>
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<c:if test="${msgType == 'receive'}">
		<span class="glyphicon glyphicon-save" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;받은 쪽지</span><br>
		</c:if>
		<c:if test="${msgType == 'send'}">
		<span class="glyphicon glyphicon-open" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;보낸 쪽지</span><br>
		</c:if>
		<c:if test="${msgType == 'keep'}">
		<span class="glyphicon glyphicon-saved" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;보관 쪽지</span><br>
		</c:if>				
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	<%-- 목록 --%>
	<table id="tb" style="width: 100%;"><%-- 테이블 길이 수정 가능 --%>
		<tr>
			<td id="count" colspan="2">
				3개(1/1 페이지)
			</td>
			<td></td><td></td>
		</tr>
		
		<tr class="cf">
			<%-- 구분 폭 수정 가능 --%>
			<td width="50">&nbsp;</td>
			<td width="200">보낸 사람</td>
			<td width="auto" style="text-align: center;">내용</td>
			<td width="200">발송시간</td>
			<td width="200">확인시간</td>
		</tr>
		<c:forEach var="dto" items="${list}">
			<tr class="tr">
				<td><input type="checkbox" id=""></td>
				<c:if test="${msgType == 'send'}">
					<td style="text-align: left;">${dto.toMemberName}</td>
				</c:if>
				<c:if test="${msgType != 'send'}">
					<td style="text-align: left;">${dto.sendMemberName}</td>
				</c:if>
				<td style="text-align: left;">${dto.content}</td>
				<td>${dto.sendTime}</td>
				<td>${dto.readTime}</td>
			</tr>
		</c:forEach>
	</table>
	<br>
	<div id='paginate'>	<%-- MyUtil.java 안에 있음. ${paging}으로 써야됨. --%>
		<a href="#">처음</a>
		<span class="curBox">1</span>
		<a href="#" class="numBox">2</a>
		<a href="#" class="numBox">3</a>
		<a href="#">다음</a>
	</div>
	
	<div style="text-align:center;">
	
		<select class="selectBox">				<%-- 선택박스  --%>
			<option>테스트 옵션1</option>
			<option>테스트 옵션2</option>
		</select>
		
		<input type="text" class="searchBox">		<%-- 입력창 --%>
		
		<button type="button" class="btn">검색</button>		<%-- 버튼 --%>
		<br>
		<button type="button" class="btn">테스트12</button>		<%-- 버튼 --%>
	</div>
	
</div>
