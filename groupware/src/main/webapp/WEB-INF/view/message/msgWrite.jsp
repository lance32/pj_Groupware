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
					console.log(jqXHR.responseText);
				}
			});
		});
	});
	// ------------------ 조직도 호출 시 필요한 부분(end) --------------------------------------
	
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
				<td colspan="2"><div style="padding-top: 5px;"><textarea id="content" name="content" rows="15" cols="45" style="width: 90%;"></textarea></div></td>
			</tr>
		</table>
		<span><input type="button" value="&nbsp;전송&nbsp;" onclick="send();"></span>
	</form>
</div>
<div id="organizationLayout" title="조직도"></div>