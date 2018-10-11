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

<script type="text/javascript">
function changeYear(year){
	var searchKey=year;
	var query = "searchKey="+searchKey+"&page="+${page};
	var url = "<%=cp%>/pay/main?"+query;
	location.href=url;
	alert(year);
}

</script>

	<div id="test" style="width:100%; height:600px; ">
	<%-- 상단 대표글씨 --%>
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-th-list" style="font-size: 25px; margin-left: 10px;"></span>
		<span style="font-size: 25px;">&nbsp;급여조회</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>


	<%-- 목록 --%>
	<table id="tb" style="width: 100%;"><%-- 테이블 길이 수정 가능 --%>
		<tr>
			<td id="count" colspan="2">
				${dataCount}개(${page}/${total_page} 페이지)
			</td>
			<td></td>
			<td align="right">
			<select class="selectBox" name="searchKey" onchange="changeYear(this.value);">				<%-- 선택박스  --%>
				<option value="all" selected="selected">전체</option>
				<c:forEach var="yearList" items="${payYearList}">
				<option value="${yearList.YEAR}">${yearList.YEAR}년도</option>
				</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr class="cf">
			<%-- 구분 폭 수정 가능 --%>
			<td width="50">번호</td>
			<td width="100" style="text-align: center;">이름</td>
			<td width="100">날짜</td>
			<td width="900">제목</td>
		</tr>
		<c:forEach var="list" items="${paymemberlist}">
		<tr class="tr">
			<td>${list.listNum }</td>
			<td width="100" style="text-align: center;">${list.name}</td>
			<td width="100">${list.year}-&nbsp;${list.month}-&nbsp;${list.day}</td>
			<td width="750">
				<a href="${articleUrl}&memberNum=${list.memberNum}&year=${list.year}&month=${list.month}">
				${list.year}년 ${list.month}월 ${list.name}님의 급여 입니다.
				</a>
			</td>
		</tr>
		</c:forEach>
	</table>
	<br>
	<div id='paginate'>	<%-- MyUtil.java 안에 있음. ${paging}으로 써야됨. --%>
		${paging}
	</div>
	<table id="tb" style="width: 100%;">
		<tr>
			<td align="left">
				<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/pay/main';" >새로고침</button>
			</td>
		</tr>
	</table>
	
</div>

