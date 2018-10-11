<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style>
#paginate {
	clear: both;
	text-align: center;
	height: 28px;
	white-space: nowrap;
}

#paginate a {
	border: 1px solid #ccc;
	height: 28px;
	color: #000000;
	text-decoration: none;
	padding: 4px 7px 4px 7px;
	margin-left: 3px;
	line-height: normal;
	vertical-align: middle;
	outline: none;
}

#paginate a:hover, a:active {
	border: 1px solid #147FCC;
	color: #0174DF;
	vertical-align: middle;
	line-height: normal;
}

#paginate .curBox {
	border: 1px solid #424242;
	background: #4e4e4e;
	color: #ffffff;
	font-weight: bold;
	height: 28px;
	padding: 4px 8px 4px 8px;
	margin-left: 3px;
	line-height: normal;
	vertical-align: middle;
}

#paginate .numBox {
	border: 1px solid #ccc;
	height: 28px;
	text-decoration: none;
	padding: 4px 7px 4px 7px;
	margin-left: 3px;
	line-height: normal;
	vertical-align: middle;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
	var aa = String(window.location);
	var ss = aa.split("=");
	var argv = ss[1];
	
	if(argv == "1"){
		$("#title").html("결재할 문서");
	}else if(argv == "2"){
		$("#title").html("진행중 문서");
	}else if(argv == "3"){
		$("#title").html("완료 문서");
	}else if(argv == "4"){
		$("#title").html("반려 문서");
	}
	
	$.ajax({
    	url:"<%=cp%>/approval/getList",
    	type:"get",
		dataType:"json",
		data:{type:argv},
		success: function(data) { 
			var retHtml = "<table id='tb' style='margin-left:0px; width: 100%;''>"
				+ "<tr class='cf'>"
				+ "<td width='100'>문서번호</td>"
				+ "<td width='auto' style='text-align: left;''>제목</td>"
				+ "<td width='100'>날 짜</td></tr>";
				$(data).each(function (e) {
					debugger;
					var html = "";
	                html = html + "<tr>";

	                    html = html + "<td><center>" + this["docuNum"] + "</center></td>"; // output each Row as
	                    html = html + "<td><a href='"+$("#path").val()+"/approval/approval_viewer?param="+this["docuNum"]+"'>" + this["subject"] + "</a></td>";
	                    html = html + "<td><center>" + this["created"] + "</center></td>";
	                
	                html = html + "</tr>"; // output each row with end of line
	                
	                retHtml += html;
	            });
				retHtml += "</table>";
				$("#work_title").html(retHtml);
		},
		error: function(jqXHR) {
			console.log(jqXHR.resonseText);
		}
    });

})
</script>

<input type="hidden" id="path" value="<%=cp%>">
<div id="test" style="width: 100%; height: 600px;">

	<%-- 상단 대표글씨 --%>
	<div style="clear: both; margin: 10px 0px 15px 80px;">
		<span class="glyphicon glyphicon-pencil" style="font-size: 28px; margin-left: 10px;"></span> 
		<span style="font-size: 30px;">
		<div id="title">
		</div></span>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>

		<div id="work_title" class="work_title" style="height:400px;">
			<table id='tb' style='margin-left:0px; width: 100%;''>
				<tr class='cf'>
				<td width='25%'>문서번호</td>
				<td width='25%' style='text-align: left;''>제목</td>
				<td width='25%'>결재상태</td>
				<td width='25%'>날짜</td></tr>
			</table>
		</div>
	</div>
</div>
