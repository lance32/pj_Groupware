<%@ page import="java.util.List" %>
<%@ page import="com.sp.department.Department" %>
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
ul {
	list-style-type: none;
	padding-left: 20px;
}
li {
	cursor: pointer;
}

#dept_content {
	width: 1000px;
    display: -webkit-flex; /* Safari */
    display: flex;
}

#dept_content div {
    -webkit-flex: 1;  /* Safari 6.1+ */
    -ms-flex: 1;  /* IE 10 */    
    flex: 1;
}
</style>

<script type="text/javascript">
function deptManage(id) {
	var deptName = $("#" + id).text();
	id = id.replace("dept", "");
	$.ajax({
		url:"<%=cp%>/department/deptInfo?id=" + id,
		type: "get",
		dataType: "json",
		success: function(data) {
			var tb = "<p style='font-weight:bold; font-size: 20px; margin-left: 10px;'>" + deptName + "</p>";  
			tb += "<table id='tb' style='margin-left: 10px;'><tr class='cf'><td width='50'>&nbsp;</td><td width='200'><h4>부서</h4></td><td width='200'><h4>직위</h4></td><td width='200'><h4>이름</h4></td></tr>";
			$.each(data.deptInfo, function(idx, val) {
				if (val.name == null)
					return true;
				tb += "<tr class='tr'><td><input type='checkbox' class='chkMemNum' data-member-num ='"+val.memberNum+"'></td><td style='text-align: left;'><h4>" 
				   + val.departmentName + "</h4></td><td><h4>" + val.positionName + "</h></td><td><h4>" + val.name + "</h4></td></tr>";
			});
			tb += "</table><input type='hidden' id='deptId' value='" + id + "'>";
			$("#deptInfoLayer").html(tb);
			$("#dept_Info").css("display", "block");
		},
		error: function(jqHXR) {
			console.log(jqHXR.responseText);
		}
	});
}

function getNextId() {
	var lastId = 0;
	$("#dept_organization li").each(function() {
		var currId = $(this).attr("id");
		if (currId != undefined) {
			currId = currId.replace("dept", "") * 1;	// 숫자로 변경
	
			if (lastId < currId) {
				lastId = currId;
			} 
		}
	});
	
	console.log("lastId = " + lastId);
	return (lastId + 1);
}

function add() {
	var id = $("#deptId").val();
	console.log("id = " + id);
	if (id == undefined) {
		alert('추가할 부서의 위치를 선택하세요');
		return false;
	}
		
	$("#createDeptLayer").dialog({
		title:"부서 추가",
		height: 200,
		width: 400,
		modal: true,
		open:function() {
			$("#departmentName").val("새 부서");
		}, 
		buttons:{
			"추가":function() {
				var parentExtraData = $("#dept" + id).data('extra').split(":");
				var nextId = getNextId();
				console.log(nextId);
				var extraData = id + ":" + (parentExtraData[1] * 1 + 1) + ":" + parentExtraData[2] + ":" + (parentExtraData[3] * 1 + 1) + ":" + nextId;
				var li = "<ul><li style='font-size: 20px; font-weight: bold;' id='dept" + nextId + "' onclick='deptManage(\"dept" + nextId + "\");' data-extra='"
				+ extraData + "'>" + $("#departmentName").val() + "</li></ul>";
				$(li).insertAfter("#dept" + id);
				updateAddDept(extraData, $("#departmentName").val());
				$(this).dialog("close");
			},
			"취소":function() {
				$(this).dialog("close");
			}
		}
	});
}

function updateAddDept(extraData, deptName) {
	var key = encodeURI(encodeURIComponent(deptName));
	
	$.ajax({
		url:"<%=cp%>/department/updateDeptInfo?type=add&key=" + key + "&data=" + extraData,
		type:"get",
		success:function() {
			alert(deptName + '가 생성 되었습니다.');
			//deptManage(deptNum);
		}, 
		error:function(jqHXR) {
			console.log(jqHXR.responseText);
		}
	});
}

function rename() {
	var id = $("#deptId").val();
	$("#createDeptLayer").dialog({
		title:"부서명 변경",
		height: 200,
		width: 400,
		modal: true,
		open:function() {
			$("#departmentName").val($("#dept" + id).text());
		}, 
		buttons:{
			"변경":function() {
				var deptName = $("#departmentName").val();
				$("#dept" + id).text(deptName);
				updateRenameDept(id, deptName);
				
				$(this).dialog("close");
			},
			"취소":function() {
				$(this).dialog("close");
			}
		}
	});
}

function updateRenameDept(deptNum, deptName) {
	var data = encodeURI(encodeURIComponent(deptName));
	
	$.ajax({
		url:"<%=cp%>/department/updateDeptInfo?type=rename&key=" + deptNum + "&data=" + data,
		type:"get",
		success:function() {
			alert(deptName + '로 변경되었습니다.');
			deptManage("dept" + deptNum);
		}, 
		error:function(jqHXR) {
			console.log(jqHXR.responseText);
		}
	});
}

function move() {
	var id = $("#deptId").val();
	$("#moveDeptLayer").dialog({
		title:"부서 이동",
		height: 230,
		width: 400,
		modal: true,
		open:function() {
			$("#dept_organization li").each(function() {
				var num = $(this).attr("id");
				var name= $(this).text();
				if (name != "(회사)" && num != id) {
					var option = "<option value='"+ num +"'>" + name + "</option>";
					$("#deptNum").append(option);
				}
			});
		}, 
		buttons:{
			"이동":function() {
				$("#" + id).text($("#departmentName").val());
				$(this).dialog("close");
				var memNums = "";
				$(".chkMemNum").each(function() {
					if (this.checked) {
						//console.log($(this).data('memberNum'));
						if (memNums != "") 
							memNums += ",";
						memNums += $(this).data("memberNum");
					}
				});
				var deptNum = $("#deptNum").val();
				updateMoveDept(deptNum, memNums);
			},
			"취소":function() {
				$(this).dialog("close");
			}
		}
	});
}

function updateMoveDept(deptNum, memNums) {
	console.log("deptNum:" + deptNum + ", memNum:" + memNums);
	if (deptNum == undefined || memNums == undefined) {
		alert('선택된 사용자가 없습니다.');
		return false;
	}
	
	$.ajax({
		url:"<%=cp%>/department/updateDeptInfo?type=move&key=" + deptNum.replace("dept", "") + "&data=" + memNums,
		type:"get",
		success:function() {
			alert('부서 이동이 완료 되었습니다.');
			deptManage(deptNum);
		}, 
		error:function(jqHXR) {
			console.log(jqHXR.responseText);
		}
	});
}

function remove() {
	var id = $("#deptId").val();
	$("#dept" + id).remove();
	
/*	
	$("#moveDeptLayer").dialog({
		title:"부서 삭제",
		height: 230,
		width: 400,
		modal: true,
		open:function() {
			$("#dept_organization li").each(function() {
				var num = $(this).attr("id");
				var name= $(this).text();
				if (name != "(회사)" && num != id) {
					var option = "<option value='"+ num +"'>" + name + "</option>";
					$("#deptNum").append(option);
				}
			});
		}, 
		buttons:{
			"이동":function() {
				$("#" + id).text($("#departmentName").val());
				$(this).dialog("close");
				var memNums = "";
				$(".chkMemNum").each(function() {
					if (this.checked) {
						//console.log($(this).data('memberNum'));
						if (memNums != "") 
							memNums += ",";
						memNums += $(this).data("memberNum");
					}
				});
				var deptNum = $("#deptNum").val();
				updateMoveDept(deptNum, memNums);
			},
			"취소":function() {
				$(this).dialog("close");
			}
		}
	});
	*/
}
</script>

<div id="departmentMain" style="width:100%; height:600px; ">
	<%-- 상단 대표글씨 --%>
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-th-list" style="font-size: 25px; margin-left: 10px;"></span>
		<span style="font-size: 25px;">&nbsp;부서 관리</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>

	<div id="dept_content">
		<div id="dept_organization" style="border: 1px solid gray; width:200px;">
			<ul>
			<li>(회사)</li>  
				<ul>
				<%
				List<Department> list = (List<Department>)request.getAttribute("deptList");
				
				int preOrder = 1;
				for (Department department : list) {
					int order = department.getDeptOrder();
					if (preOrder > order) {
						for (int i = 0; i < preOrder - order; i++) {
							out.println("</ul>");
						}
					} else if (preOrder < order) {
						out.println("<ul>"); 
					}
					
					out.println("<li style='font-size: 20px; font-weight: bold;' id='dept" + department.getDepartmentNum() 
								+ "' onclick='deptManage(\"dept" + department.getDepartmentNum() 
							 	+ "\");' data-extra='" + department.getParentDepartment() + ":" 
								+ department.getDeptOrder() + ":" 
							 	+ department.getDeptGroup() + ":" 
								+ department.getIdx() +":" 
							 	+ department.getDepartmentNum() + "'>" 
								+ department.getDepartmentName() + "</li>");
					
					preOrder = order;
				}
				
				for (int i = 0; i < preOrder - 1; i++) {
					out.println("</ul>");	
				}
				%>
				</ul>
			</ul>
		</div>
	
		<div id="dept_Info" style="width:80%; display:none;">
			<div id="deptInfoLayer">
			<table id="tb" style="margin-left: 10px;"><%-- 테이블 길이 수정 가능 --%>
				<tr class="cf">
					<%-- 구분 폭 수정 가능 --%>
					<td width="50">&nbsp;</td>
					<td width="200"><h4>부서</h4></td>
					<td width="200"><h4>직위</h4></td>
					<td width="200"><h4>이름</h4></td>
				</tr>
				<c:forEach var="dto" items="${deptMemberList}" end="11">
					<c:if test="${dto.name != null}">
					<tr class="tr">
						<td><input type="checkbox"></td>
						<td style="text-align: left;"><h4>${dto.departmentName}</h4></td>
						<td><h4>${dto.positionName}</h4></td>
						<td><h4>${dto.name}</h4></td>
					</tr>
					</c:if>
				</c:forEach>
			</table>
			</div>
			<br>
			<div id='paginate'>	<%-- MyUtil.java 안에 있음. ${paging}으로 써야됨. --%>
				<a href="#">처음</a>
				<span class="curBox">1</span>
				<a href="#">다음</a>
			</div>
			<br>
			<div style="padding:10px auto 10px;" align="center">
				<button style="margin-left:10px;" class="butn" onclick="add();">&nbsp;부서 추가&nbsp;</button>&nbsp;&nbsp;
				<button class="butn" onclick="remove();">&nbsp;부서 삭제&nbsp;</button>&nbsp;&nbsp;
				<button class="butn" onclick="rename();">&nbsp;부서명 변경&nbsp;</button>&nbsp;&nbsp;
				<button class="butn" onclick="move();">&nbsp;부서원 이동&nbsp;</button>&nbsp;&nbsp;
			</div>
		</div>
	</div>
</div>
<div id="createDeptLayer" style="display:none;">
	<input type="hidden" id="departmentNum" name="departmentNum"><br>
	<label>부서명</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="departmentName" name="departmentName">
</div>
<div id="moveDeptLayer" style="display:none; text-align:center;">
	<p style="text-align:left; margin-bottom:0;">이동할 부서를 선택하세요</p>
	<input type="hidden" id="toDepartmentNum" name="toDepartmentNum"><br>
	<label>부서명</label>&nbsp;&nbsp;&nbsp;&nbsp;<select id="deptNum"></select>
</div>
