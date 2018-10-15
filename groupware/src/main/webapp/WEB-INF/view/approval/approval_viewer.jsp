<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>



<script type="text/javascript">
$(document).ready(function () {
	var aa = String(window.location);
	var ss = aa.split("=");
	var argv = ss[1];
	var check = 0;
	var checkUser = "";
	$("#docuNum").val(argv);

	$.ajax({
    	url:"<%=cp%>/approval/getApproval",
    	type:"get",
		dataType:"json",
		data:{docuNum:argv},
		success: function(data) { 
			$("#title").html(data["subject"]);
			$("#contents").html(data["content"]);
		},
		error: function(jqXHR) {
			console.log(jqXHR.resonseText);
		}
    });
	
	$.ajax({
    	url:"<%=cp%>/approval/getApprovalProcess",
    	type:"get",
		dataType:"json",
		data:{docuNum:argv},
		success: function(data) { 
			$(data).each(function (e) {
				$("#app_class"+this["approvalSeq"]).html("<center>"+this["appState"]+"</center>");
				$("#app_name"+this["approvalSeq"]).html(this["memberNum"]);
				$("#app_cmt"+this["approvalSeq"]).html(this["comments"]);
				if(check == 0 && this["appState"] == "PROCESSING"){
					check = 1;
					
					if(this["memberNum"] != $("#session").val()){
						$("#sign").html("");
					}
				}
            });
			if(check == 0){
				$("#sign").html("");
			}
		},
		error: function(jqXHR) {
			console.log(jqXHR.resonseText);
		}
    });	
})
$(function() {
	$("#ok").click(function() {
		$.ajax({
			url:"<%=cp%>/approval/approvalSign",
			type:"get",
			dataType:"json",
			data:{
				docuNum : $("#docuNum").val(),
				comments : $("#comments").val(),
				memberNum : $("#session").val(),
				state : 1				
			},
			success:function(data) {
				alert("승인");
				location.href="approval";
			},
			error:function(jqXHR) {
				console.log(jqXHR.resonseText);
			}
		});
	}),
	$("#no").click(function() {
		$.ajax({
			url:"<%=cp%>/approval/approvalSign",
			type:"get",
			dataType:"json",
			data:{
				docuNum : $("#docuNum").val(),
				comments : $("#comments").val(),
				memberNum : $("#session").val(),
				state : 2				
			},
			success:function(data) {
				alert("반려");
				location.href="approval";
			},
			error:function(jqXHR) {
				console.log(jqXHR.resonseText);
			}
		});
	})
})
</script>

<form id="editform" name="editform" method="post"
	action="/segio/works/approval/edit_format.php"
	enctype="multipart/form-data">
	<input type="hidden" id="session" name="session" value=${sessionScope.member.userId }>
	<input type="hidden" id="docuNum" name="docuNum" value="">
	<input type="submit" title="" value="" style="display: none"> 
	<div class="works_title">
		<span class="glyphicon glyphicon-folder-open"
			style="font-size: 28px; margin-left: 10px;">&nbsp;결재문서</span> 
			<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>

	<!-- 결재자 정보 -->
	<input type="hidden" id="app_uid1" name="app_uid1" value="test6">
	<input type="hidden" id="app_order1" name="app_order1" value="1">

	<div class="app_table">
		<table class="aview" summary="결재선 등록" style="width: 100%;">
			<colgroup>
				<col style="width: 3%">
				<col style="width: 9%">
				<col style="width: 9%">
				<col style="width: 9%">
				<col style="width: 9%">
				<col style="width: 9%">
				<col style="width: 9%">
				<col style="width: 9%">
				<col style="width: 9%">
			</colgroup>
			<tbody>
				<tr>

					<th rowspan="3" scope="col" style="background-color: #FFF6F9;" class="ebtn1">
						<center>결재선<br></center>
					</th>
					<th scope="col" class="ebtn1">
						<div id="app_class0"></div>
					</th>
					<th scope="col" class="ebtn1">
						<div id="app_class1"></div>
					</th>
					<th scope="col" class="ebtn1">
						<div id="app_class2"></div>
					</th>
					<th scope="col" class="ebtn1">
						<div id="app_class3"></div>
					</th>
					<th scope="col" class="ebtn1">
						<div id="app_class4"></div>
					</th>
					<th scope="col" class="ebtn1">
						<div id="app_class5"></div>
					</th>
					<th scope="col" class="ebtn1">
						<div id="app_class6"></div>
					</th>
					<th scope="col" class="ebtn1">
						<div id="app_class7"></div>
					</th>
				</tr>

				<tr>
					<td class="esign" scope="row">
						<div id="app_name0"></div>
					</td>
					<td class="esign" scope="row">
						<div id="app_name1"></div>
					</td>
					<td class="esign" scope="row">
						<div id="app_name2"></div>
					</td>
					<td class="esign" scope="row">
						<div id="app_name3"></div>
					</td>
					<td class="esign" scope="row">
						<div id="app_name4"></div>
					</td>
					<td class="esign" scope="row">
						<div id="app_name5"></div>
					</td>
					<td class="esign" scope="row">
						<div id="app_name6"></div>
					</td>
					<td class="esign" scope="row">
						<div id="app_name7"></div>
					</td>
				</tr>
				<tr>
					<td scope="row">
						<div id="app_cmt0"></div>
					</td>
					<td scope="row">
						<div id="app_cmt1"></div>
					</td>
					<td scope="row">
						<div id="app_cmt2"></div>
					</td>
					<td scope="row">
						<div id="app_cmt3"></div>
					</td>
					<td scope="row">
						<div id="app_cmt4"></div>
					</td>
					<td scope="row">
						<div id="app_cmt5"></div>
					</td>
					<td scope="row">
						<div id="app_cmt6"></div>
					</td>
					<td scope="row">
						<div id="app_cmt7"></div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="app_table2">
		<div class="app_table">
			<table class="aview2" summary="내용">
				<caption>내용</caption>
				<colgroup>
					<col style="width: 13%">
					<col style="width: 20%">
					<col style="width: 13%">
					<col style="width: 20%">
					<col style="width: 14%">
					<col style="width: 20%">
				</colgroup>
				<tbody>
					<tr>
						<!-- 제목 -->
						<th scope="row" class="etitle"><span>제목</span></th>
						<td scope="row" class="eleft" colspan="5">
							<div id="title"></div>
						</td>
					</tr>
					<tr id="context_view">
						<td scope="row" colspan="6" class="econtents">
						<div id="contents"></div>
											</tbody>
										</table>
		</div>
	</div>
	
	<div id="sign">
	<table>
	<tr>
	<td>결재의견</td>
	<td><input type="text" id="comments"></td>
	</tr>
	</table>
	<input type="button" id="ok" value="승인"><input type="button" id="no" value="반려">
	</div>
</form>
