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
	$("input[name=allDay]").click(function(){
		var allValue = $(this).val();
		if(allValue == '0'){
			$("#resStartTime").show();
			$("#resEndTime").show();
		} else {
			$("#resStartTime").hide();
			$("#resStartTime").val("");
			$("#resEndTime").hide();
			$("#resEndTime").val("");
		}
	});
});

$(function(){
	$("input[name=alarm]").click(function(){
		var varAlarm = $("input[name=alarm]:checked").val();
		if(varAlarm == '1'){
			$("#alarmTime").show();
			$("#alarmToMember").show();	
		}
		else{
			$("#alarmTime").hide();
			$("#alarmToMember").hide();
			$("input[name='toMember']").val("");
			// alarmTime(radio) 값 null 처리는 어떻게 해야하나?
		}
	});
});

// ------------------ 조직도 호출 시 필요한 부분(start) --------------------------------------
// 조직도 버튼  : <input type="button" id="organizationChart" value="&nbsp;조직도&nbsp;">
// 선택된 멤버 받는 에디트 박스 : <input type="text" id="toMember" name="toMember" ..>
//                     member1;member2; .. 형식으로 들어옴. 따라서 컨트롤러쪽에서 ';' split()으로 처리 필요
// 조직도 dialog layer : <div id="organizationLayout" title="조직도"></div>
// 

// 조직도 내에서 부서 클릭시 처리
function deptCheck(deptNum) {
	if ($("#" + deptNum).is(':checked')) {
		$("." + deptNum).attr("checked", true);
	} else {
		$("." + deptNum).attr("checked", false);
	}		
}
// 조직도 버튼(button name="organizationChart") 클릭 시
$(function() {
	$("#organizationChart").click(function() {
		var dialog;
		$.ajax({
			url:"<%=cp%>/member/organizationChart",
			type:"get",
			dataType:"json",
			success:function(data) {
				var h = "<table>";
				var preDeptName = "";
				var deptClass = "";
				$.each(data, function(idx, val) {
					var ws = "";
					if (val.deptOrder == 1) {
						deptClass = "dept" + val.deptNum + " ";
					} else {
						var deptArray = deptClass.split(" ");
						deptClass = deptArray[val.deptOrder - 2] + " ";
						deptClass+= "dept" + val.deptNum + " ";
					}
					
					for (var i = 1; i < val.deptOrder; i++) {
						ws += "&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					
					if (preDeptName != val.deptName) {
						h += "<tr><td>";
						h += ws;
						h += "<input type='checkbox' id='dept" + val.deptNum + "' class='" + deptClass + "' onclick='deptCheck(\"dept"+ val.deptNum +"\");'>";
						h += val.deptName;
						h += "</td></tr>";
						preDeptName = val.deptName;
					} 

					if(val.memberName != undefined) {
						h += "<tr><td>";
						ws += "&nbsp;&nbsp;&nbsp;&nbsp;"
						h += ws;
						h += "<input type='checkbox' id='" + val.memberNum + "' class='memberChk " + deptClass + "' data-member-num='" + val.memberNum + "'>";
						h += val.memberName;
						h += "&nbsp;";
						h += val.positionName;
						h += "</td></tr>";
					}
				});
				h += "</table>";
				
				$("#organizationLayout").html(h);
				dialog = $("#organizationLayout").dialog({
					height: 400,
					width: 500,
					modal: true,
					open: function () {
						// 기존 선택된 멤버가 있을 경우, 로드시 조직도에서 체크 되도록 처리
						// <input type="text" id="toMember" name="toMember"> 에서 읽어옴
						var member = $("#toMember").val();		
						if (member.length > 0) {
							var memberList = member.split(";");
							for (var i = 0; i < memberList.length; i++) {
								if (memberList[i] == "") continue;
								$("#" + memberList[i]).attr("checked", true);
							}
						}
					},
					buttons: {
						"확인" : function() {
							// 조직도에서 선택된 값을 받을 input object에 넣도록 처리
							// 여기서는 <input type="text" id="toMember" name="toMember"..>
							var memberList = "";
							$(".memberChk").each(function() {
								if (this.checked) {
									memberList += $(this).data("memberNum") + ";";
								} 
							});
							
							$("#toMember").val(memberList);
							$(this).dialog("close");
						},
						"취소" : function() {
							$(this).dialog("close");
						}	
					}
				});
			},
			error:function(jqXHR) {
				console.log(jqXHR.resonseText);
			}
		});
	});
});
// ------------------ 조직도 호출 시 필요한 부분(end) --------------------------------------
</script>

<form name="resForm" class="form-horizontal">
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">제  목</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="restitle" name="title" placeholder="title">
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">작 성 자</label>
		<div class="col-sm-10" style="padding-top: 5px;">
			<input type="text" class="form-control" id="resName" name="name" value="${sessionScope.member.userName}" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">구   분</label>
		<div class="col-sm-10" style="padding-top: 5px;">
			<select name="groupNum" class="form-control selectField" onchange="changeGroup('', '');">
				<c:forEach var="vo" items="${groupList}">
					<option value="${vo.groupNum}">${vo.groupName}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">항   목</label>
		<div class="col-sm-10" style="padding-top: 5px;">
			<select name="resourceNum" class="form-control selectField"></select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">종일일정</label>
		<div class="col-sm-10">
			<label class="radio-inline"><input type="radio" name="allDay" id="allDay3" value="1"> 하루종일</label>
			<label class="radio-inline"><input type="radio" name="allDay" id="allDay4" value="0" checked="checked"> 시간지정</label>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">시 작 일</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="resStartDay" name="startDay" style="width: 35%; display: inline-block;" readonly="readonly">
			<select class="form-control" id="resStartTime" name="startTime" style="width: 35%; display: inline-block;">
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
			<input type="text" class="form-control" id="resEndDay" name="endDay" style="width: 35%; display: inline-block;" readonly="readonly">
			<select class="form-control" id="resEndTime" name="endTime" style="width: 35%; display: inline-block;">
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
		<label for="title" class="col-sm-2 control-label">인 원</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="resInwon" name="inwon" placeholder="사용인원">
		</div>
	</div>
	
	<div class="form-group">
		<label for="content" class="col-sm-2 control-label">내 용</label>
		<div class="col-sm-10">
			<textarea class="form-control" name="content" rows="3" style="resize: none;"></textarea>
		</div>
	</div>
	
	<div class="form-group">
		<label for="content" class="col-sm-2 control-label">알 림 여 부</label>
		<div class="col-sm-10">
			<label class="radio-inline"><input type="radio" name="alarm" value="1"> 알 림 O</label>
			<label class="radio-inline"><input type="radio" name="alarm" value="0"> 알 림 X</label>
		</div>
	</div>
	
	<div id="alarmTime" class="form-group" style="display: none;">
		<label for="content" class="col-sm-2 control-label">알 림 시 간</label>
		<div class="col-sm-10">
			<label class="radio-inline"><input type="radio" name="alarmTime" value="0"> 1일 전</label>
			<label class="radio-inline"><input type="radio" name="alarmTime" value="1"> 2일 전</label>
			<label class="radio-inline"><input type="radio" name="alarmTime" value="2"> 3일 전</label>
		</div>
	</div>
	
	<div id="alarmToMember" class="form-group" style="display: none;">
		<label for="content" class="col-sm-2 control-label">알 림 대 상</label>
		<div class="col-sm-10">
			<input type="text" id="toMember" name="toMember">
			<input type="button" id="organizationChart" value="&nbsp;조직도&nbsp;">
		</div>
	</div>
</form>
<div id="organizationLayout" title="조직도"></div>