<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script type="text/javascript">
	$(function() {
		$("input[name=startDay]").datepicker();
		$("input[name=endDay]").datepicker();
	});
	
	$(function(){
		$("#schStartTime").hide();
		$("#schEndTime").hide();
		
		$("input[name=repeat]").click(function(){
			var repeatValue = $(this).val();
			if(repeatValue == '1'){
				$("#divCycle").show();
			} else {
				$("#divCycle").hide();
				$("input[name=cycle]").each(function(){
					$(this).prop("checked",false);
				});
			}
		});
		
		$("input[name=allDay]").click(function(){
			var allValue = $(this).val();
			if(allValue == '0'){
				$("#schStartTime").show();
				$("#schEndTime").show();
			} else {
				$("#schStartTime").hide();
				$("#schEndTime").hide();
			}
		});
	});
</script>

<form name="schForm" class="form-horizontal">
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">제  목</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="schtitle" name="title" placeholder="title">
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">작 성 자</label>
		<div class="col-sm-10" style="padding-top: 5px;">
			<input type="text" class="form-control" id="schName" name="name" value="${sessionScope.member.userId }" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">일정구분</label>
		<div class="col-sm-10">
			<select class="form-control selectField" name="color">
				<option value="blue">개인일정</option>
				<option value="black">가족일정</option>
			  	<option value="red">부서일정</option>
			  	<option value="green">회사일정</option>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">종일일정</label>
		<div class="col-sm-10">
			<label class="radio-inline"><input type="radio" name="allDay" id="allDay1" value="1" checked="checked"> 하루종일</label>
			<label class="radio-inline"><input type="radio" name="allDay" id="allDay2" value="0"> 시간지정</label>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">시 작 일</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="schStartDay" name="startDay" style="width: 35%; display: inline-block;">
			<select class="form-control" id="schStartTime" name="startTime" style="width: 35%; display: inline-block;">
				<option value="">선 택</option>
				<c:forEach var="h" begin="0" end="9">
					<option value="0${h}:00">0${h}:00</option>
				</c:forEach>
				<c:forEach var="h" begin="10" end="23">
					<option value="${h}:00">${h}:00</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">종 료 일</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="schEndDay" name="endDay" style="width: 35%; display: inline-block;">
			<select class="form-control" id="schEndTime" name="endTime" style="width: 35%; display: inline-block;">
				<option value="">선 택</option>
				<c:forEach var="h" begin="0" end="9">
					<option value="0${h}:00">0${h}:00</option>
				</c:forEach>
				<c:forEach var="h" begin="10" end="23">
					<option value="${h}:00">${h}:00</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">장 소</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="place" name="place" placeholder="클릭해서 장소를 선택하세요.">
		</div>
	</div>
	
	<div class="form-group">
		<label for="content" class="col-sm-2 control-label">내 용</label>
		<div class="col-sm-10">
			<textarea class="form-control" name="content" rows="3" style="resize: none;"></textarea>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">반복여부</label>
		<div class="col-sm-10">
			<label class="radio-inline"><input type="radio" name="repeat" id="repeat1" value="1"> 반복</label>
			<label class="radio-inline"><input type="radio" name="repeat" id="repeat2" value="0"> 반복안함</label>
		</div>
	</div>
	
	<div class="form-group" id="divCycle" style="display: none;">
		<label for="title" class="col-sm-2 control-label">반복주기</label>
		<div class="col-sm-10">
			<label class="radio-inline"><input type="radio" name="cycle" id="cycle1" value="0"> Week</label>
			<label class="radio-inline"><input type="radio" name="cycle" id="cycle2" value="1"> Month</label>
			<label class="radio-inline"><input type="radio" name="cycle" id="cycle2" value="2"> Year</label>
		</div>
	</div>
</form>