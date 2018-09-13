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
});
</script>

<div class="container">
	<form name="noticeForm" method="post">
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label for="name">작성자</label>
					<input type="text" class="form-control" name="name" disabled="disabled" value="${sessionScope.member.userName}">
				</div>
			</div>

			<div class="col-md-6">
				<div class="form-group">
					<label for="pass">공지여부</label><br>
					<fieldset>
						<input type="radio" name="emergency" value="0">
						<span style="font-size: 20px;">일반공지</span> &nbsp;&nbsp;&nbsp; 
						<input type="radio" name="emergency" value="1">
						<span style="font-size: 20px;">긴급공지</span>
					</fieldset>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label for="subject">제 목</label>
			<input type="text" class="form-control" name="subject" placeholder="제목을 입력하세요.">
		</div>


		<div class="form-group">
			<label for="content">내 용</label>
			<textarea class="form-control" rows="20" name="content" style="resize: none;"></textarea>

		</div>

		<div class="form-group">
			<label for="File">파 일 첨 부</label> <input type="file" name="upload">
		</div>

		<div class="center-block" style='width: 200px'>
			<button type="button" class="btn" id="btnSend">작 성 하 기</button>
			<button type="reset" class="btn">다 시 쓰 기</button>
			<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list';">뒤 로 가 기</button>
		</div>
	</form>
</div>
