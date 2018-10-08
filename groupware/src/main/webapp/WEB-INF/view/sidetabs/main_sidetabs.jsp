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
	var s = today.getSeconds();
	h = checkHour(h);
	m = checkTime(m);
	s = checkTime(s);
	document.getElementById('clock').innerHTML = h + " : " + m + " : " + s;
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
		i="오전&nbsp;&nbsp;&nbsp;"+12;
		return i;
	}
	if(i>=12){
		if(i>=13){
			i = i-12;
		}
		i = "오후&nbsp;&nbsp;&nbsp;"+i;
	}else{
		i="오전&nbsp;&nbsp;&nbsp;"+i;
	}
	return i;
}
window.onload=startTime;
</script>

<div style="width: 99%; height: 50px;">
	<div style="width:99%; height: 99%; padding-left: 5px; box-shadow: 3px 5px 5px 1px #A4A4A4; padding-top: 10px; background: #FAFAFA;">
		<div style="font-size: 21px; font-weight: 600;">
			<span id="clock" style="padding: 0px 10px;"></span>
		</div>
	</div>
</div>