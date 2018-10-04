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
	$(function() {
		$("#trashboxBtn").click(function() {
			var mailIndex = [];
			var index = 0;
			$("input[name='chk']").each(function() {
				if (this.checked) {
					mailIndex[index++] = $(this).data("mailIndex");
				}
			});
			
			if (index == 0) {
				alert('선택된 메일이 없습니다.');
				return false;
			}
			
			if (confirm('메일을 휴지통으로 보내시겠습니까?'))
				location.href="<%=cp%>/mail/toMailTrashbox?page=${page}&mailType=${mailType}&searchKey=${searchKey}&searchValue=${searchValue}&mailIndex=" + mailIndex;
		});
		
		$("#deleteBtn").click(function() {
			var mailIndex = [];
			var index = 0;
			$("input[name='chk']").each(function() {
				if (this.checked) {
					mailIndex[index++] = $(this).data("mailIndex");
				}
			});
			
			if (index == 0) {
				alert('선택된 메일이 없습니다.');
				return false;
			}
			
			if (confirm('메일을 삭제 하시겠습니까?'))
				location.href="<%=cp%>/mail/mailDelete?page=${page}&mailType=${mailType}&searchKey=${searchKey}&searchValue=${searchValue}&mailIndex=" + mailIndex;
		});
	});
	
	$("#toSendMailBtn").click(function() {
		var mailIndex = [];
		var index = 0;
		$("input[name='chk']").each(function() {
			if (this.checked) {
				mailIndex[index++] = $(this).data("mailIndex");
			}
		});
		
		if (index == 0) {
			alert('선택된 메일이 없습니다.');
			return false;
		}
		
		if (confirm('메일을 복원 하시겠습니까?'))
			location.href="<%=cp%>/mail/toMailSend?page=${page}&mailType=${mailType}&searchKey=${searchKey}&searchValue=${searchValue}&mailIndex=${mail.index}";
	});
	
	function search() {
		var f = document.searchForm;
		
		if ($("#searchValue").val() == "") {
			alert('검색할 내용이 없습니다.');
			$(this).focus();
			return false;
		} 
		<c:if test="${mailType == 'send'}">
		f.action = "<%=cp%>/mail/mailSend";
		</c:if>
		<c:if test="${mailType == 'tempBox'}">
		f.action = "<%=cp%>/mail/mailTempBox";
		</c:if>
		<c:if test="${mailType == 'trashbox'}">
		f.action = "<%=cp%>/mail/mailTrashbox";
		</c:if>
		
		f.submit();
	}
</script>

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
			<td width="auto" align="center">제&nbsp;&nbsp;목</td>
			<td width="200">날&nbsp;&nbsp;짜</td>
			<td width="200">첨부파일</td>
		</tr>
		<c:forEach var="dto" items="${list}">
			<tr class="tr">
				<td><input type="checkbox" name="chk" data-mail-index="${dto.index}"></td>
				<td style="text-align: left;">${dto.receiveMail}</td>
				<td style="text-align: left;"><a href="${mailUrl}&index=${dto.index}&mailType=${mailType}">${dto.subject}</a></td>
				<td>${dto.getFormatSendTime()}</td>
				<td>&nbsp;</td>
			</tr>
		</c:forEach>
	</table>
	<div style="padding:5px 5px 5px 5px;">
		<c:if test="${mailType == 'send'}">
			<button type="button" id="trashboxBtn">&nbsp;휴&nbsp;지&nbsp;통&nbsp;</button>&nbsp;
		</c:if>
		<c:if test="${mailType == 'trashbox'}">
			<button type="button" id="toSendMailBtn">&nbsp;메일 복원&nbsp;</button>&nbsp;
		</c:if>
		<button type="button" id="deleteBtn">&nbsp;바로 삭제&nbsp;</button>
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
			<button type="button" id="searchBtn" class="btn" onclick="search();">검색</button>
		</form>
	</div>
</div>