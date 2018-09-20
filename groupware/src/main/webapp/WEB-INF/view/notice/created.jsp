<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script>
$(function(){
	$("#btnSend").click(function(){
		var radioVal = $('input[type=radio]:checked').val();
		var subVal = $('input[name=subject]').val();
		var contentVal = $('textarea').val();
		
		if(!radioVal || !subVal || !contentVal){
			alert("입력하지 않은 영역이 있습니다.");
			return;
		}
        $("form[name=noticeForm]").attr("action","<%=cp%>/notice/${mode}");
        $("form[name=noticeForm]").submit();
	});
	
	$("#chkDelete").click(function(){
		var num = "${dto.num}";
		var page = "${page}";
		var query = "num="+num+"&page="+page;
		var url = "<%=cp%>/notice/deleteFile?"+query;
		
		if(confirm("정말 파일을 삭제 하시겠습니까? 수정을 취소하더라도 삭제 된 파일은 복구되지 않습니다.")){
			location.href = url;
		}
	});
});
</script>
<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-bullhorn"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;공 지 사 항</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>

<div class="container">
	<form name="noticeForm" method="post" enctype="multipart/form-data">
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label for="name">작성자</label>
					<input type="text" class="form-control" name="name" readonly="readonly" value="${sessionScope.member.userName}">
				</div>
			</div>

			<div class="col-md-6">
				<div class="form-group">
					<label for="pass">공지여부</label><br>
					<fieldset>
						<input type="radio" name="notice" value="0" ${dto.notice == '0'?"checked='checked'":""}>
						<span style="font-size: 20px;">일반공지</span> &nbsp;&nbsp;&nbsp; 
						<input type="radio" name="notice" value="1" ${dto.notice == '1'?"checked='checked'":""}>
						<span style="font-size: 20px;">긴급공지</span>
					</fieldset>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label for="subject">제 목</label>
			<input type="text" class="form-control" name="subject" placeholder="제목을 입력하세요." value="${dto.subject}">
		</div>


		<div class="form-group">
			<label for="content">내 용</label>
			<textarea class="form-control" rows="20" name="content" style="resize: none;">${dto.content }</textarea>

		</div>

		<div class="form-group">
			<label for="File">파 일 첨 부</label> <input type="file" name="upload">
		</div>
		
		<c:if test="${mode=='update'}">
				  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
				      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
				      <td style="padding-left:10px;"> 
				          ${dto.originalFilename}
				          <c:if test="${not empty dto.saveFilename}">
				          		| <a id="chkDelete">파일삭제</a>
				          </c:if>
				       </td>
				  </tr>
		</c:if>

		<div class="center-block" style='width: 300px'>
			<button type="button" class="btn" id="btnSend">${mode=='update'?'수 정 완 료':'등 록 하 기'}</button>
			<button type="reset" class="btn">다 시 쓰 기</button>
			<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list';">${mode=='update'?'수 정 취 소':'뒤 로 가 기'}</button>
		</div>
		
		<c:if test="${mode=='update'}">
			<input type="hidden" name="num" value="${dto.num}">		
			<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
			<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
			<input type="hidden" name="page" value="${page}">
		</c:if>
	</form>
</div>
