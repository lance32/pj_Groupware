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
function searchPayMember(){
	var f=document.payMemberSearchForm;
	f.submit();
}
</script>

<div id="test" style="width:100%; height:600px; ">
	<%-- 상단 대표글씨 --%>
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-th-list" style="font-size: 25px; margin-left: 10px;"></span>
		<span style="font-size: 25px;">&nbsp;급여관리</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	<div style="width:100%; text-align:right;">
		<form name="payMemberSearchForm" action="<%=cp%>/pay/adminMain" method="post">
			<select class="selectBox" name="searchKey">				<%-- 선택박스  --%>
				<option value="name">이름</option>
				<option value="department">부서</option>
				<option value="position">직위</option>
			</select>
			
			<input type="text" class="searchBox" name="searchValue">		<%-- 입력창 --%>
			<button type="button" class="btn" onclick="searchPayMember();">검색</button>		<%-- 버튼 --%>
		</form>
	</div>
	
	<%-- --%>
	<form name="paymember" method="post">
	<table id="tb" style="width: 100%;"><%-- 테이블 길이 수정 가능 --%>
		<tr>
			<td id="count" colspan="2">
				${dataCount}개(${page}/${total_page} 페이지)
			</td>
			<td></td><td></td>
		</tr>

		
		<tr class="cf">
			<%-- 구분 폭 수정 가능 --%>
			<td width="50">번호</td>
			<td width="100">부서</td>
			<td width="150">직위</td>
			<td width="150">이름</td>
			<td width="150">기본급</td>
		</tr>
		<c:forEach var="list" items="${paylist}">
			<c:if test="${list.name!='admin'}">
			<tr class="tr">
				<td>${list.listNum}</td>
				<td>${list.departmentName}</td>
				<td>${list.positionName}</td>
				<td>${list.name}</td>
				<td>${list.basicpay}</td>
			</tr>
			</c:if>
		</c:forEach>
	</table>
	<br>
	<div id=''>	<%-- MyUtil.java 안에 있음. ${paging}으로 써야됨. --%>
		${paging}
	</div>
	</form>
	
	<table id="tb" style="width: 100%; padding-top: 10px;">
		<tr>
			<td>
			<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/pay/adminMain';" >새로고침</button>
			</td>
		
			<td align="right">
				<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/pay/insertpay';">급여 입력</button>
				<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/pay/insertTax';">세율 수정</button>
			</td>
		</tr>
	</table>
</div>
