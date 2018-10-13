<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
.timeNumberBox{
	width: 22px;
	height: 30px;
	background: #424242;
	border-radius: 4px;
	float: left;
	
	font-size:16px;
	font-weight: 600;
	color: #F2F2F2;
	text-align: center;
	line-height:28px;
	vertical-align: middle;
}
/* ---------- CALENDAR ---------- */

.calendarBody {
	background: #FCFCFC;
	color: #0e171c;
	font: 500 100%/1.5em 'Lato', sans-serif;
}

.calendarBody a {
	text-decoration: none;
}

.calendarBody h2 {
	font-size: 16px;
	line-height: 30px;
	margin: 0px 0px;
}

.calendarBody table {
	width: 99%;
	border-collapse: collapse;
	border-spacing: 0;
	font-size: 11px;
}

.calendarBody {
	height: 260px;
	width: 99%;
	padding-top: 10px;
	position: relative;
	border-bottom: 1px solid #D8D8D8;
	
}

/* */

.calendar {
	text-align: center;
	margin-bottom: 5px;
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
	height: 25px;
	line-height: 22px;
	text-align: center;
	width: 12.4%;
}

.calendar .prev-month,
.calendar .next-month {
	color: #cbd1d2;
}

.current-day {
	background: #00addf;
	color: #f9f9f9;
}

.btn-prev,
.btn-next {
	border: 2px solid #BDBDBD;
	border-radius: 50%;
	color: #BDBDBD;
	height: 17px;
	font-size: 13px;
	line-height: 14px;
	margin: -1em;
	position: absolute;
	top: 65%;
	width: 17px;
	cursor: pointer;
}

.btn-prev:hover,
.btn-next:hover {
	background: #cbd1d2;
	color: #FFFFFF;
}

.btn-prev {
	left: 35px;
}

.btn-next {
	right: 35px;
}

#authorityButn{
	width: 95%; 
	height: 45px; 
	background: #BDBDBD; 
	padding-left: 25px; 
	border-left: 15px solid #FFBF00; 
	margin-top: 40px;
	cursor: pointer;
}

</style>

<script type="text/javascript">
function startTime() {
	var today = new Date();
	var h = today.getHours();
	var m = today.getMinutes();
	h = checkHour(h);
	h = ''+checkTime(h);
	m = ''+checkTime(m);
	var h1 = h.substring(0,1);
	var h2 = h.substring(1,2);
	var m1 = m.substring(0,1);
	var m2 = m.substring(1,2);
	jQuery("#hour1").html(h1);
	jQuery("#hour2").html(h2);
	jQuery("#minute1").html(m1);
	jQuery("#minute2").html(m2);
	var t = setTimeout(startTime, 1000);
}
function checkTime(i) {
	if (i < 10) {
		i = "0" + i
	}
	return i;
}
function checkHour(i){
	if(i==0){
		i=12;
		jQuery("#time").html("오전");
		return i;
	}
	if(i>=12){
		if(i>=13){
			i = i-12;
		}
		jQuery("#time").html("오후");
	}else{
		jQuery("#time").html("오전");
	}
	return i;
}
window.onload=startTime;

jQuery(function(){
	jQuery("#authorityButn").click(function(){
		location.href="<%=cp%>/authority/authoritylist";
	});
});

//calendar
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
		if(cnt%7==0){
			row = tbCalendar.insertRow();
		}
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

<div style="width: 99%; height: 60px; margin-top:50px; padding: 8px 0px; background: #F2F2F2; border-top: 2px solid #848484; border-bottom: 10px solid #BDBDBD; text-align: center;">
	<div style="display: inline-block;">
		<div id="time" class="timeNumberBox" style="width: 50px; margin-right: 15px;"></div>
		<div id="hour1" class="timeNumberBox"></div>
		<div id="hour2" class="timeNumberBox" style="margin-left: 3px;"></div>
		<div style="font-size: 20px; font-weight: 600; float: left;">&nbsp;:&nbsp;</div>
		<div id="minute1" class="timeNumberBox"></div>
		<div id="minute2" class="timeNumberBox" style="margin-left: 3px;"></div>
	</div>
</div>

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
	
	<c:if test="${sessionScope.member.userId == 'admin'}">
	<div id="authorityButn">
		<span style="height: 100%; line-height: 46px; vertical-align: middle; font-size: 21px; color: #FAFAFA;">
			권한 설정
		</span>
		<span style="float:right; margin-right:20px;  font-size: 21px; color: #E6E6E6; line-height: 46px; vertical-align: middle;">&gt;</span>
	</div>
	</c:if>
