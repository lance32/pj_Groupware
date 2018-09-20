<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
	function send() {
		if ($("#subject").val() == "") {
			alert('제목이 없습니다.');
			$(this).focus();
			return false;	
		}
		
		if ($("#members").val() == "") {
			alert('받는 사람이 없습니다.');
			$(this).focus();
			return false;
		}
		
		if ($("#content").val() == "") {
			alert('내용이 없습니다.');
			$(this).focus();
			return false;
		}
		
		document.msgWriteForm.submit();
	}
	
	// 부서 클릭시 처리
	function deptCheck(deptNum) {
		if ($("#dept" + deptNum).prop('checked')) {
			$(".dept" + deptNum).each(function() {
				//$(this).attr('checked') = true;
				alert('test');
			});
		}		
	}
	
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
					$.each(data, function(idx, val) {
						var ws = "";
						for (var i = 1; i < val.deptOrder; i++) {
							ws += "&nbsp;&nbsp;&nbsp;&nbsp;";
						}
						
						if (preDeptName != val.deptName) {
							h += "<tr><td>";
							h += ws;
							h += "<input type='checkbox' id='dept" + val.deptNum + "' onclick='deptCheck(\"dept"+ val.deptNum +"\");'>";
							h += val.deptName;
							h += "</td></tr>";
							preDeptName = val.deptName;
						} 

						if(val.memberName != undefined) {
							h += "<tr><td>";
							ws += "&nbsp;&nbsp;&nbsp;&nbsp;"
							h += ws;
							h += "<input type='checkbox' class='memberChk dept" + val.deptNum + "' data-member-num='" + val.memberNum + "'>";
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
						buttons: {
							"확인" : function() {
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
		//	console.log(dialog);
		});
		
	});
	
</script>
<div id="msgWrite" style="width:100%; height: 600px;">
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-send" style="font-size: 28px; margin-left: 10px;" ></span>
		<span style="font-size: 30px;">&nbsp;쪽지 쓰기</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	<form name="msgWriteForm" method="post" action="<%=cp%>/message/msgWrite" >
		<table style="width:100%; border-top: 2px solid #a1c9e4;">
			<tr>
				<td style="border-bottom: 1px dotted #dfdfdf; padding:5px; background: #f7f7f7; color: #595959; text-align:center; width: 15%;">제목</td>
				<td style="background: #fff; width: 85%;"><input type="text" id="subject" name="subject" style="width: 80%; border: 1px solid #d7d7d7;"></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px dotted #dfdfdf; padding:5px; background: #f7f7f7; color: #595959; text-align:center; width: 15%;">받는이</td>
				<td style="background: #fff; width: 85%;">
					<span><input type="text" id="toMember" name="toMember" style="background: #fff; color: #333; width: 80%; border: 1px solid #d7d7d7;" readOnly="readOnly"></span>
					<span><input type="button" id="organizationChart" value="&nbsp;조직도&nbsp;"></span>
				</td>
			</tr>
			<tr>
				<td colspan="2"><div style="padding-top: 5px;"><textarea id="content" name="content" rows="15" cols="45" style="width: 87%;"></textarea></div></td>
			</tr>
		</table>
		<span><input type="button" value="&nbsp;전송&nbsp;" onclick="send();"></span>
	</form>
</div>
<div id="organizationLayout" title="조직도"></div>