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
	height: 220px;
	width: 196px;
	padding-top: 10px;
	
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
/* var calendar = new Date();

var year = calendar.getFullYear();		// yyyy 년도
var month = calendar.getMonth();		// 0~11 (1~12월)
var monthDay = calendar.getDate();	// 1~31 (1~31일)
var weekday = calendar.getDay();		// 0 ~ 6 (월~ 일)

var dayOfWeek=["Su","Mo","Tu","We","Th","Fr","Sa"];
var monthOfYear=["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

calendar.setDate(1);

var days_of_week = 7;
var days_of_month = 31;

jQuery("#monthName").html(monthOfYear[month]);

var str="";

str+="<tr>"
for(var i=0; i<calendar.getDay(); ++i){
	str +="<td class='prev-month'>&nbsp;</td>"
	if(i==6){
		str += "</tr>"
	}
}

for(var i=0; i<days_of_month; ++i){
	if(calendar.getDate()>i){
		
	}
}
//미완 */
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
						<td>Su</td>
						<td>Mo</td>
						<td>Tu</td>
						<td>We</td>
						<td>Th</td>
						<td>Fr</td>
						<td>Sa</td>
					</tr>
				</thead>

				<tbody id="tbCalendar">
					
					<tr>
						<td class="prev-month">30</td>
						<td>1</td>
						<td>2</td>
						<td>3</td>
						<td>4</td>
						<td>5</td>
						<td>6</td>
					</tr>
					<tr>
						<td>7</td>
						<td>8</td>
						<td class="current-day event">9</td>
						<td>10</td>
						<td>11</td>
						<td>12</td>
						<td>13</td>
					</tr>
					<tr>
						<td>14</td>
						<td>15</td>
						<td>16</td>
						<td>17</td>
						<td>18</td>
						<td>19</td>
						<td>20</td>
					</tr>
					<tr>
						<td>21</td>
						<td>22</td>
						<td>23</td>
						<td>24</td>
						<td>25</td>
						<td>26</td>
						<td>27</td>
					</tr>
					<tr>
						<td>28</td>
						<td>29</td>
						<td>30</td>
						<td>31</td>
						<td class="next-month">1</td>
						<td class="next-month">2</td>
						<td class="next-month">3</td>
					</tr>
					<tr>
						<td class="next-month">4</td>
						<td class="next-month">5</td>
						<td class="next-month">6</td>
						<td class="next-month">7</td>
						<td class="next-month">8</td>
						<td class="next-month">9</td>
						<td class="next-month">10</td>
					</tr>
				</tbody>
			</table>
		</div> <!-- end calendar -->
		<div id="calendar_year" style="clear: both; float: right; font-size: 11px; color:#848484; margin-right: 5px;">2018</div>
	</div> <!-- end calendarBody -->
</body>
</html>