<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
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
</script>

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

</style>

<div style="width: 99%; height: 55px; margin-top:50px; padding: 8px 0px; background: #E6E6E6; border-top: 2px solid #848484; border-bottom: 2px solid #848484; text-align: center;">
	<div style="display: inline-block;">
		<div id="time" class="timeNumberBox" style="width: 50px; margin-right: 10px;"></div>
		<div id="hour1" class="timeNumberBox"></div>
		<div id="hour2" class="timeNumberBox" style="margin-left: 3px;"></div>
		<div style="font-size: 20px; font-weight: 600; float: left;">&nbsp;:&nbsp;</div>
		<div id="minute1" class="timeNumberBox"></div>
		<div id="minute2" class="timeNumberBox" style="margin-left: 3px;"></div>
	</div>
</div>




