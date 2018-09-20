<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script>
$(function(){
	$('#calendar').fullCalendar({
		header : {
			left : 'prev,next today',
			center : 'title',
			right : 'month,agendaWeek,agendaDay'
		},
		defaultDate : '2014-11-12',
		lang : 'ko',
		buttonIcons : false, // show the prev/next text
		weekNumbers : true,
		editable : true,
		eventLimit : true, // allow "more" link when too many events
		events : [ {
			title : 'All Day Event',
			start : '2014-11-01'
		}, {
			title : 'Long Event',
			start : '2014-11-07',
			end : '2014-11-10'
		}, {
			id : 999,
			title : 'Repeating Event',
			start : '2014-11-09T16:00:00'
		}, {
			id : 999,
			title : 'Repeating Event',
			start : '2014-11-16T16:00:00'
		}, {
			title : 'Conference',
			start : '2014-11-11',
			end : '2014-11-13'
		}, {
			title : 'Meeting',
			start : '2014-11-12T10:30:00',
			end : '2014-11-12T12:30:00'
		}, {
			title : 'Lunch',
			start : '2014-11-12T12:00:00'
		}, {
			title : 'Meeting',
			start : '2014-11-12T14:30:00'
		}, {
			title : 'Happy Hour',
			start : '2014-11-12T17:30:00'
		}, {
			title : 'Dinner',
			start : '2014-11-12T20:00:00'
		}, {
			title : 'Birthday Party',
			start : '2014-11-13T07:00:00'
		}, {
			title : 'Click for Google',
			url : 'http://google.com/',
			start : '2014-11-28'
		} ]
	});
});
</script>

<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-calendar"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;일 정 관 리</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
<div class="container">
	<ul class="nav nav-tabs">
		<li><a href="#">일 간 일 정</a></li>
		<li class="active"><a href="#">월 간 일 정</a></li>
		<li><a href="#">일 정 검 색</a></li>
	</ul>
	<br>
	<div id="calendar" style="width: 95%; min-height: 700px; border: 1px solid black;"></div>
</div>