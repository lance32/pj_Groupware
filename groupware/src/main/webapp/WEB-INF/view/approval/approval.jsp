<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
$(document).ready(function () {

    $.ajax({
    	url:"<%=cp%>/approval/getSummaryList",
    	type:"get",
		dataType:"json",
		data:{type:1},
		success: function(data) { 
			var retHtml = "<table id='tb' style='margin-left:0px; width: 500px;'>"
				+ "<tr><td id='count' colspan='2'></td><td></td><td></td></tr>"
				+ "<tr class='cf'>"
				+ "<td width='100'>문서번호</td>"
				+ "<td width='auto' style='text-align: left;''>제목</td>"
				+ "<td width='100'>결재상태</td>"
				+ "<td width='100'>날짜</td></tr>";
				$(data).each(function (e) {
					var html = "";
	                html = html + "<tr>";

	                    html = html + "<td><center>" + this["docuNum"] + "</center></td>"; // output each Row as
	                    html = html + "<td>" + this["subject"] + "</td>";
	                    html = html + "<td><center>" + this["documentState"] + "</center></td>";
	                    html = html + "<td><center>" + this["created"] + "</center></td>";
	                
	                html = html + "</tr>"; // output each row with end of line
	                
	                retHtml += html;
	            });
				retHtml += "</table>";
				$("#tome").html(retHtml);
		},
		error: function(jqXHR) {
			console.log(jqXHR.resonseText);
		}
    });
    
    $.ajax({
    	url:"<%=cp%>/approval/getSummaryList",
    	type:"get",
		dataType:"json",
		data:{type:2},
		success: function(data) { 
			var retHtml = "<table id='tb' style='margin-left:0px; width: 500px;'>"
			+ "<tr><td id='count' colspan='2'></td><td></td><td></td></tr>"
			+ "<tr class='cf'>"
			+ "<td width='100'>문서번호</td>"
			+ "<td width='auto' style='text-align: left;''>제목</td>"
			+ "<td width='100'>결재상태</td>"
			+ "<td width='100'>날짜</td></tr>";
			$(data).each(function (e) {
				debugger;
				var html = "";
                html = html + "<tr>";

                    html = html + "<td><center>" + this["docuNum"] + "</center></td>"; // output each Row as
                    html = html + "<td>" + this["subject"] + "</td>";
                    html = html + "<td><center>" + this["documentState"] + "</center></td>";
                    html = html + "<td><center>" + this["created"] + "</center></td>";
                
                html = html + "</tr>"; // output each row with end of line
                
                retHtml += html;
            });
			retHtml += "</table>";
			$("#progress").html(retHtml);
		},
		error: function(jqXHR) {
			console.log(jqXHR.resonseText);
		}
    });
    
    $.ajax({
    	url:"<%=cp%>/approval/getSummaryList",
    	type:"get",
		dataType:"json",
		data:{type:3},
		success: function(data) { 
			var retHtml = "<table id='tb' style='margin-left:0px; width: 500px;'>"
				+ "<tr><td id='count' colspan='2'></td><td></td><td></td></tr>"
				+ "<tr class='cf'>"
				+ "<td width='100'>문서번호</td>"
				+ "<td width='auto' style='text-align: left;''>제목</td>"
				+ "<td width='100'>결재상태</td>"
				+ "<td width='100'>날짜</td></tr>";
				$(data).each(function (e) {
					debugger;
					var html = "";
	                html = html + "<tr>";

	                    html = html + "<td><center>" + this["docuNum"] + "</center></td>"; // output each Row as
	                    html = html + "<td>" + this["subject"] + "</td>";
	                    html = html + "<td><center>" + this["documentState"] + "</center></td>";
	                    html = html + "<td><center>" + this["created"] + "</center></td>";
	                
	                html = html + "</tr>"; // output each row with end of line
	                
	                retHtml += html;
	            });
				retHtml += "</table>";
				$("#complete").html(retHtml);
		},
		error: function(jqXHR) {
			console.log(jqXHR.resonseText);
		}
    });
    
    $.ajax({
    	url:"<%=cp%>/approval/getSummaryList",
    	type:"get",
		dataType:"json",
		data:{type:4},
		success: function(data) { 
			var retHtml = "<table id='tb' style='margin-left:0px; width: 500px;'>"
				+ "<tr><td id='count' colspan='2'></td><td></td><td></td></tr>"
				+ "<tr class='cf'>"
				+ "<td width='100'>문서번호</td>"
				+ "<td width='auto' style='text-align: left;''>제목</td>"
				+ "<td width='100'>결재상태</td>"
				+ "<td width='100'>날짜</td></tr>";
				$(data).each(function (e) {
					debugger;
					var html = "";
	                html = html + "<tr>";

	                    html = html + "<td><center>" + this["docuNum"] + "</center></td>"; // output each Row as
	                    html = html + "<td>" + this["subject"] + "</td>";
	                    html = html + "<td><center>" + this["documentState"] + "</center></td>";
	                    html = html + "<td><center>" + this["created"] + "</center></td>";
	                
	                html = html + "</tr>"; // output each row with end of line
	                
	                retHtml += html;
	            });
				retHtml += "</table>";
				
				$("#reject").html(retHtml);
		},
		error: function(jqXHR) {
			console.log(jqXHR.resonseText);
		}
    });
});

function display_Init_Data(data){
	$.each(data, function (key, entry) {
		alert("dd");
    });
};

</script>

	<div style=" width: 45%; margin: 10px 0px 15px 10px; float: left;" >
		<a href="<%=cp%>/approval/approval_detail_list?param=1"><span class="glyphicon glyphicon-folder-open" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;결재 문서함</span></a><br><!--본인이 중간 결재자일때 앞:결재해야할 문서 개수, 뒤:결재하고 진행중인 문서 -->
		<div id="tome"></div>
	</div>

     <div style=" width: 45%;margin: 10px 0px 15px 10px; float: left;">
		<a href="<%=cp%>/approval/approval_detail_list?param=2" ><span class="glyphicon glyphicon-folder-open" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;진행 문서함</span></a><br><!--본인이 상신한 문서만  -->
		<div id="progress"></div>

	</div>
	
	<div style=" width: 45%; margin: 10px 0px 15px 10px; float: left;">
		<a href="<%=cp%>/approval/approval_detail_list?param=3" ><span class="glyphicon glyphicon-folder-open" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;완료 문서함</span></a><br><!--본인이 상신한 문서 완료함  -->
		<div id="complete"></div>
	</div>
	
     <div style=" width: 45%;margin: 10px 0px 15px 10px; float: left;">
		<a href="<%=cp%>/approval/approval_detail_list?param=4" ><span class="glyphicon glyphicon-folder-open" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;반려 문서함</span></a><br><!--본인이 상신한 문서 반려  -->
    	<div id="reject"></div>
	</div>
