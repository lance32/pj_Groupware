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
function searchMember(){
	var f=document.memberSearchForm;
	f.submit();
};

function chkvalue(){
	var checkedValue = $("#chk_status").val();
};


</script>


<div id="test" style="width:100%; height:600px; ">
	<%-- 상단 대표글씨 --%>
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-th-list" style="font-size: 25px; margin-left: 10px;"></span>
		<span style="font-size: 25px;">&nbsp;
			<c:if test="${sessionScope.member.userId=='admin'}">
				사원 관리
			</c:if>
			
			
			<c:if test="${sessionScope.member.userId!='admin'}">
				사원 조회
			</c:if>
		</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	<div style="width:100%; text-align:right;">
		
		<form id="chkstatus" name="chkstatus" onchange="chkvalue()" method="post">
			<input type="radio" id="chk_status" name="chk_status" value="all">전체
			<input type="radio" id="chk_status" name="chk_status" value="1">재직
			<input type="radio" id="chk_status" name="chk_status" value="2">휴직
			<input type="radio" id="chk_status" name="chk_status" value="3">정직
			<input type="radio" id="chk_status" name="chk_status" value="0">퇴사
		</form>
	
	<form name="memberSearchForm" action="<%=cp%>/member/main" method="post">
	
			
			<select class="selectBox" name="searchKey">				<%-- 선택박스  --%>
				<option value="name">이름</option>
				<option value="department">부서</option>
				<option value="position">직위</option>
				<option value="phone">휴대전화</option>
				<option value="created">입사일</option>	
			</select>
			
			<input type="text" class="searchBox" name="searchValue">		<%-- 입력창 --%>
			<button type="button" class="btn" onclick="searchMember();">검색</button>		<%-- 버튼 --%>
		</form>
	</div>
	<%-- --%>
	<form name="thismember" method="post">
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
			<td width="150">입사일</td>
			<td width="190">이름</td>
			<td width="150">이메일</td>
			<td width="150">휴대전화</td>
			<td width="150">집 전화</td>
		</tr>
		
		<c:forEach var="list" items="${list}">
		<c:if test="${list.memberNum!='admin'}">
		<tr class="tr">
			<td>${list.listmemberNum}</td>
			<td style="text-align: center;">${list.departmentName}</td>
			<td>${list.positionName }</td>
			<td>${list.created }</td>
			<td>
				<a href="${articleUrl}&memberNum=${list.memberNum}">${list.name}</a>
			</td>
			<td>${list.email}</td>
			<td>${list.phone}</td>
			<td>${list.tel}</td>
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
			<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/member/main';" >새로고침</button>
			</td>
			<c:if test="${sessionScope.member.userId=='admin'}">
				<td style="text-align: right;">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/member/member';">사원추가</button>
				</td>
			</c:if>
		</tr>
	</table>

</div>
