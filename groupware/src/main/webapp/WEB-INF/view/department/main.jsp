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
	$.ajax({
		url:"<%=cp%>/department/deptInfo?id=" + id,
		type: "get",
		dataType: "json",
		success: function(data) {
			var tb = "<table id='tb' style='margin-left: 10px;'><tr class='cf'><td width='50'>&nbsp;</td><td width='200'><h4>부서</h4></td><td width='200'><h4>직위</h4></td><td width='200'><h4>이름</h4></td></tr>";
			$.each(data.deptInfo, function(idx, val) {
				tb += "<tr class='tr'><td><input type='checkbox'></td><td style='text-align: left;'><h4>" 
				   + val.departmentName + "</h4></td><td><h4>" + val.positionName + "</h></td><td><h4>" + val.name + "</h4></td></tr>";
			});
			tb += "</table><input type='hidden' id='deptId' value='" + id + "'>";
			$("#deptInfoLayer").html(tb);
		},
		error: function(jqHXR) {
			console.log(jqHXR.responseText);
		}
	});
}

function getNextId() {
	var lastId = 0;
	$("li").each(function() {
		currId = $(this).attr("id") * 1;
		if (lastId < currId) {
			lastId = currId;
		}
	});
	return lastId + 1;
}

function add() {
	var id = $("#deptId").val();
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
				var nextId = getNextId();
				var li = "<ul><h4><li id='" + nextId + "' onclick='deptManage(" + nextId + ");'>" + $("#departmentName").val() + "</li></h4></ul>";
				$(li).insertAfter("#" + id);
				
				$(this).dialog("close");
			},
			"취소":function() {
				$(this).dialog("close");
			}
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
			$("#departmentName").val($("#" + id).text());
		}, 
		buttons:{
			"변경":function() {
				$("#" + id).text($("#departmentName").val());
				$(this).dialog("close");
			},
			"취소":function() {
				$(this).dialog("close");
			}
		}
	});
}

function move() {
	var id = $("#deptId").val();
	$("#moveDeptLayer").dialog({
		title:"부서 이동",
		height: 400,
		width: 400,
		modal: true,
		open:function() {
			$("#dept_organization li").each(function() {
				console.log($(this).text());
				var num = $(this).attr("id");
				var name= $(this).text();
				if (name != "(회사)" && num != id) {
					var option = "<option value='"+ num +"'>" + name + "</option>";
					//console.log(option);
					$("#deptNum").append(option);
				}
			});
		}, 
		buttons:{
			"이동":function() {
				$("#" + id).text($("#departmentName").val());
				$(this).dialog("close");
			},
			"취소":function() {
				$(this).dialog("close");
			}
		}
	});
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
					
					out.println("<h4><li id='" + department.getDepartmentNum() 
								+ "' onclick='deptManage(" + department.getDepartmentNum() + ")'>" 
								+ department.getDepartmentName() + "</li><h4>");
					
					preOrder = order;
				}
				
				for (int i = 0; i < preOrder - 1; i++) {
					out.println("</ul>");	
				}
				%>
				</ul>
			</ul>
		</div>
	
		<div id="dept_Info" style="width:80%;">
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
				<a href="#" class="numBox">2</a>
				<a href="#" class="numBox">3</a>
				<a href="#">다음</a>
			</div>
			<br>
			<div style="text-align:center;">
				<select class="selectBox">				<%-- 선택박스  --%>
					<option>부서</option>
					<option>이름</option>
				</select>
				<input type="text" class="searchBox">		<%-- 입력창 --%>
				<button type="button" class="btn">검색</button>		<%-- 버튼 --%>
				<br>
			</div>
			<br>
			<div style="padding-left: 10px;">
				<button onclick="add();">&nbsp;부서 추가&nbsp;</button>&nbsp;&nbsp;
				<button onclick="rename();">&nbsp;부서명 변경&nbsp;</button>&nbsp;&nbsp;
				<button onclick="move();">&nbsp;부서 이동&nbsp;</button>
			</div>
		</div>
	</div>
</div>
<div id="createDeptLayer" style="display:none;">
	<input type="hidden" id="departmentNum" name="departmentNum"><br>
	<label>부서명</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="departmentName" name="departmentName">
</div>
<div id="moveDeptLayer" style="display:none;">
	<input type="hidden" id="toDepartmentNum" name="toDepartmentNum"><br>
	<label>부서명</label>&nbsp;&nbsp;&nbsp;&nbsp;<select id="deptNum"></select>
</div>
