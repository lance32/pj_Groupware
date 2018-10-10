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
	border: 1px solid #BDBDBD;
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
	height: 250px;
	width: 99%;
	padding-top: 10px;
	
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
}

.btn-prev:hover,
.btn-next:hover {
	background: #cbd1d2;
	color: #f9f9f9;
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
		location.href="<%=cp%>/authority/authorityList";
	});
});

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
				<h2> October </h2>
				<a class="btn-prev fontawesome-angle-left" href="#">&lt;</a>
				<a class="btn-next fontawesome-angle-right" href="#">&gt;</a>
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

				<tbody>
					
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
						<td>9</td>
						<td class="current-day event">10</td>
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
		</div>
		<div style="clear: both; float: right; font-size: 11px; color:#848484; margin-right: 5px;">2018</div>
	</div>
	
