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
				$("#schStartTime").val("");
				$("#schEndTime").hide();
				$("#schEndTime").val("");
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
			<input type="text" class="form-control" id="schName" name="name" value="${sessionScope.member.userName}" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">일정구분</label>
		<div class="col-sm-10">
			<select class="form-control selectField" name="color">
				<option value="blue">개인일정</option>
				<option value="black">가족일정</option>
			  	<option value="red">부서일정</option>
			  	<c:if test="${sessionScope.member.userId == 'admin'}">
			  		<option value="green">회사일정</option>
			  	</c:if>
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
			<input type="text" class="form-control" id="schStartDay" name="startDay" style="width: 35%; display: inline-block;" readonly="readonly">
			<select class="form-control" id="schStartTime" name="startTime" style="width: 35%; display: inline-block;">
				<option value="">선 택</option>
				<c:forEach var="h" begin="0" end="9">
					<option value="0${h}:00">0${h}:00</option>
					<option value="0${h}:30">0${h}:30</option>
				</c:forEach>
				<c:forEach var="h" begin="10" end="23">
					<option value="${h}:00">${h}:00</option>
					<option value="${h}:30">${h}:30</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">종 료 일</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="schEndDay" name="endDay" style="width: 35%; display: inline-block;" readonly="readonly">
			<select class="form-control" id="schEndTime" name="endTime" style="width: 35%; display: inline-block;">
				<option value="">선 택</option>
				<c:forEach var="h" begin="0" end="9">
					<option value="0${h}:00">0${h}:00</option>
					<option value="0${h}:30">0${h}:30</option>
				</c:forEach>
				<c:forEach var="h" begin="10" end="23">
					<option value="${h}:00">${h}:00</option>
					<option value="${h}:30">${h}:30</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">장 소</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="schPlace" name="place" placeholder="클릭해서 장소를 선택하세요." readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label for="content" class="col-sm-2 control-label">내 용</label>
		<div class="col-sm-10">
			<textarea class="form-control" name="content" rows="3" style="resize: none;"></textarea>
		</div>
	</div>
	<input type="hidden" name="scheduleNum" value="0">
</form>