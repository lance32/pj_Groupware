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
		<c:if test="${mailType == 'receive'}">
			<span class="glyphicon glyphicon-save" style="font-size: 28px; margin-left: 10px;"></span>
			<span style="font-size: 30px;">&nbsp;받은  메일함</span><br>
		</c:if>
		<c:if test="${mailType == 'send'}">
			<span class="glyphicon glyphicon-open" style="font-size: 28px; margin-left: 10px;"></span>
			<span style="font-size: 30px;">&nbsp;보낸 메일함</span><br>
		</c:if>
		<c:if test="${mailType == 'tempBox'}">
			<span class="glyphicon glyphicon-exclamation-sign" style="font-size: 28px; margin-left: 10px;"></span>
			<span style="font-size: 30px;">&nbsp;임시 보관함</span><br>
		</c:if>
		<c:if test="${mailType == 'trashbox'}">
			<span class="glyphicon glyphicon-trash" style="font-size: 28px; margin-left: 10px;"></span>
			<span style="font-size: 30px;">&nbsp;휴지통</span><br>
		</c:if>					
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	<%-- 목록 --%>
	<table id="tb" style="width: 100%;"><%-- 테이블 길이 수정 가능 --%>
		<tr>
			<td id="count" colspan="2">
				${dataCount}개(${page}/${totalPage} 페이지)
			</td>
			<td></td><td></td>
		</tr>
		
		<tr class="cf">
			<%-- 구분 폭 수정 가능 --%>
			<td width="50">&nbsp;</td>
			<td width="200" align="left">받는 사람</td>
			<td width="auto" align="left">제목</td>
			<td width="200">날짜</td>
			<td width="200">첨부파일</td>
		</tr>
		<c:forEach var="dto" items="${list}">
			<tr class="tr">
				<td><input type="checkbox" name="chk" data-msg-num="${dto.index}"></td>
				<td style="text-align: left;">${dto.receiveMail}</td>
				<td style="text-align: left;"><a href="${mailUrl}&index=${dto.index}">${dto.subject}</a></td>
				<td>${dto.getFormatSendTime()}</td>
				<td>&nbsp;</td>
			</tr>
		</c:forEach>
	</table>
	<div style="padding:5px 5px 5px 5px;">
		<button type="button" id="keepBtn">&nbsp;보관&nbsp;</button>&nbsp;
		<button type="button" id="deleteBtn">&nbsp;삭제&nbsp;</button>
	</div>
	<br>
	<div id='paginate'>
		${paging}
	</div>
	
	<div style="text-align:center;">
		<form name="searchForm" method="post">
			<input type="hidden" name="page" value="${page}">
			<select class="selectBox" name="searchKey">
				<option value="all">제목+내용</option>
				<option value="subject">제목</option>
				<option value="content">내용</option>
				<option value="receiveMail">받는 사람(이메일)</option>
			</select>
			<input type="text" id="searchValue" name="searchValue" class="searchBox">
			<button type="button" id="searchBtn" class="btn">검색</button>
		</form>
	</div>
</div>