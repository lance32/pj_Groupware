<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* ---------- CALENDAR ---------- */

.calendarBody {
	background: #f9f9f9;
	color: #0e171c;
	font: 500 100%/1.5em 'Lato', sans-serif;
}

.calendarBody a {
	text-decoration: none;
}

.calendarBody h2 {
	font-size: 15px;
	line-height: 20px;
	margin: 4px 0px;
}

.calendarBody table {
	border-collapse: collapse;
	border-spacing: 0;
	font-size: 11px;
	margin-left: 6px;
}

.calendarBody {
	height: 243px;
	width: 196px;
	padding-top: 10px;
	position: relative;
	border-bottom: 1px solid #D8D8D8;
}

/* */

.calendar {
	text-align: center;
}

.calendar header {
	position: relative;
}

.calendar h2 {
	text-transform: uppercase;
}

.calendar thead {
	font-weight: 600;
	text-transform: uppercase;
}

.calendar tbody {
	color: #7c8a95;
}

.calendar td {
	border: 2px solid transparent;
	border-radius: 50%;
	display: inline-block;
	height: 20px;
	line-height: 20px;
	text-align: center;
	width: 20px;
}

.current-day {
	background: #00addf;
	color: #f9f9f9;
}

.btn-prev,
.btn-next {
	border: 2px solid #cbd1d2;
	border-radius: 50%;
	color: #cbd1d2;
	height: 17px;
	font-size: 13px;
	line-height: 17px;
	margin: -1em;
	position: absolute;
	top: 50%;
	width: 17px;
	cursor: pointer;
}

.btn-prev:hover,
.btn-next:hover {
	background: #cbd1d2;
	color: #f9f9f9;
}

.btn-prev {
	left: 30px;
}

.btn-next {
	right: 30px;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
jQuery(function(){
	buildCalendar();
});
var monthOfYear=["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

var today = new Date();
var date = new Date();
function prevCalendar() {
	today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
	buildCalendar();
}
function nextCalendar() {
	today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
	buildCalendar();
}
function buildCalendar(){
	var doMonth = new Date(today.getFullYear(),today.getMonth(),1); //이번 달의 첫째 날
	var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0); //이번 달의 마지막 날
	var tbCalendar = document.getElementById("tbCalendar");
	jQuery("#calendar_year").html(today.getFullYear());
	jQuery("#calendar_month").html(monthOfYear[today.getMonth()]);
	
	var row = null;
	var cnt = 0;
	jQuery("#tbCalendar").html("");
	row = tbCalendar.insertRow();
	for (i=0; i<doMonth.getDay(); i++) {
		cell = row.insertCell();
		cnt = cnt + 1;
	}
	for (i=1; i<=lastDate.getDate(); i++) { 
		cell = row.insertCell();
		cell.innerHTML = i;
		cnt = cnt + 1;
	}
	for(i=0; i<7; i++){
		if(cnt%7!=0){
			cell = row.insertCell();
			cnt = cnt + 1;
		}
	}
	if (today.getFullYear() == date.getFullYear() && today.getMonth() == date.getMonth()) {
		jQuery("#tbCalendar td:Contains("+today.getDate()+")").addClass("current-day event");
	}
}
</script>

</head>
<body>

	<div class="calendarBody">
		<div class="calendar">
			<header>				
				<h2 id="calendar_month"> October </h2>
				<a class="btn-prev fontawesome-angle-left" onclick="prevCalendar()">&lt;</a>
				<a class="btn-next fontawesome-angle-right" onclick="nextCalendar()">&gt;</a>
			</header>
			<table>
				<thead>
					<tr>
						<td style="color: #DF0101;">Su</td>
						<td>Mo</td>
						<td>Tu</td>
						<td>We</td>
						<td>Th</td>
						<td>Fr</td>
						<td style="color: #A4A4A4;">Sa</td>
					</tr>
				</thead>

				<tbody id="tbCalendar">
					
				</tbody>
				
			</table>
		</div> <!-- end calendar -->
		<div id="calendar_year" style="clear:both; width:100%; text-align:right; font-size: 11px; color:#848484; position:absolute; right:0px; bottom:0px; padding: 0px 5px 3px 0px; border-top: 1px solid #0F89B9; background: #F2F2F2;">
			2018
		</div>
	</div> <!-- end calendarBody -->
	
	
</body>
</html>