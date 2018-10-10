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
</style>

<script type="text/javascript">
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

function add(id) {
	$("#createDept").dialog({
		title:"부서 관리",
		height: 400,
		width: 500,
		modal: true,
		open:function() {
			
			$("#departmentName").val($("#" + id).text());
			$("#departmentNum").val(id);
			alert(id + ":" + $("#departmentName").val());
		}, 
		buttons:{
			"확인":function() {
				id = $("#departmentNum").val();
				alert(id + ":" + $("#departmentName").val());
				
				$("#" + id).text($("#departmentName").val());
				$(this).dialog("close");
			},
			"취소":function() {
				$(this).dialog("close");
			},
			"삭제":function() {
				//alert("부서 삭제(팀원들은 상위로 부서로 이동)");
				$("#" + id).remove();
				$(this).dialog("close");
			},
			"부서추가":function() {
				var nextId = getNextId();
				var li = "<ul><li id='" + nextId + "' onclick='add(" + nextId + ");'>새부서</li></ul>";
				$("#" + id).append(li);
				
				$(this).dialog("close");
/*			},
 			"위로":function() {
				//alert("부서 위로 이동");
				var $parents = $("#" + id).parent().parent();
				alert($parents.attr("id"));
				$("#" + id).remove();
				var li = "<li id='" + id + "' onclick='add(" + id + ");'>" + $("#departmentName").val() + "</li>";
				$parents.append(li); 
			},
			"아래로":function() {
				// alert("부서 아래로 이동");
				var $parents = $("#" + id).children();
				$("#" + id).remove();
				var li = "<ul><li id='" + id + "' onclick='add(" + idd + ");'>" + $("#departmentName").val() + "</li></ul>";
				$parents.append(li); */
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

	<div id="organization" style="border: 1px solid gray; width:200px;">
		<ul>
		<li>(root)</li>  
			<ul>
			<%
			List<Department> list = (List<Department>)request.getAttribute("list");
			
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
				
				out.println("<li id='" + department.getDepartmentNum() 
							+ "' onclick='add(" + department.getDepartmentNum() + ")'>" 
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
</div>
<div id="createDept" style="display:none;">
	<label>id</label> <input type="text" id="departmentNum" name="departmentNum"><br>
	<label>부서명</label> <input type="text" id="departmentName" name="departmentName">
</div>
