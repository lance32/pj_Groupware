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
		<span class="glyphicon glyphicon-th-list" style="font-size: 25px; margin-left: 10px;"></span>
		<span style="font-size: 25px;">&nbsp;
				급여조회
		</span><br>
		
	<form name="thismember" method="post">
	<table id="tb" style="width: 100%;"><%-- 테이블 길이 수정 가능 --%>
		<tr>
			<td id="count" colspan="2">
				10개(1/4 페이지)
			</td>
		</tr>

		
		<tr class="cf">
			<%-- 구분 폭 수정 가능 --%>
			<td width="50">번호</td>
			<td width="1040">제목</td>
			
		</tr>
		
		
		<tr class="tr">
			<td>1</td>
			<td>
				<a href="${articleUrl}&memberNum=${list.memberNum}">
				2018년 10월 ooo님의 급여 입니다.
				</a>
			</td>
		</tr>
		

	</table>
	<br>
	<div id='paginate'>	<%-- MyUtil.java 안에 있음. ${paging}으로 써야됨. --%>
		페이징
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
