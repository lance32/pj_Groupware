<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script>
$(function() {
	$("input[name=sDay]").datepicker();
	$("input[name=eDay]").datepicker();
	
	$("select[name=searchKey]").change(function(){
		var search = $("option:selected").val();
		if(search == 'start'){
			$("#searchDay").show();
			$("input[name=searchValue]").prop("readonly", true);
		} else {
			$("#searchDay").hide();
			$("input[name=sDay]").val("");
			$("input[name=eDay]").val("");
			$("input[name=searchValue]").prop("readonly", false);
		}
	});
});

function setInputDate(option, value) {
	var date = new Date();

	$("#endDate").val(dateToString(date));
	if(option=="day") {
		$("#startDate").val(dateToString(date));
	} else if(option=="week") {
		date.setDate(date.getDate()-7);
		$("#startDate").val(dateToString(date));
	} else if(option=="month") {
		date.setMonth(date.getMonth()-value);
		date.setDate(date.getDate()+1);
		$("#startDate").val(dateToString(date));
	} else if(option=="year") {
		date.setFullYear(date.getFullYear()-value);
		date.setDate(date.getDate()+1);
		$("#startDate").val(dateToString(date));
	}
}

// 날짜를 문자열로
function dateToString(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    if(m < 10) m='0'+m;
    var d = date.getDate();
    if(d < 10) d='0'+d;
    
    return y + '-' + m + '-' + d;
}

// 문자열을 날짜로
function stringToDate(value) {
	var format=/(\.)|(\-)|(\/)/g;
	value=value.replace(format, "");
    
    format = /[12][0-9]{3}[0-9]{2}[0-9]{2}/;
    if(! format.test(value))
        return "";
    
    var y = parseInt(value.substr(0, 4));
    var m = parseInt(value.substr(4, 2));
    var d = parseInt(value.substr(6, 2));
    
    return new Date(y, m-1, d);
}

function isValidDateFormat(data){
    var regexp = /[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}/;
    if(! regexp.test(data))
        return false;

    regexp=/(\.)|(\-)|(\/)/g;
    data=data.replace(regexp, "");
    
	var y=parseInt(data.substr(0, 4));
    var m=parseInt(data.substr(4, 2));
    if(m<1||m>12) 
    	return false;
    var d=parseInt(data.substr(6));
    var lastDay = (new Date(y, m, 0)).getDate();
    if(d<1||d>lastDay)
    	return false;
		
	return true;     
}

// 두 날짜 사이의 일자 구하기
function diffDays(startDate, endDate) {
    var format=/(\.)|(\-)|(\/)/g;
    startDate=startDate.replace(format, "");
    endDate=endDate.replace(format, "");
    
    format = /[12][0-9]{3}[0-9]{2}[0-9]{2}/;
    if(! format.test(startDate))
        return "";
    if(! format.test(endDate))
        return "";
    
    var sy = parseInt(startDate.substr(0, 4));
    var sm = parseInt(startDate.substr(4, 2));
    var sd = parseInt(startDate.substr(6, 2));
    
    var ey = parseInt(endDate.substr(0, 4));
    var em = parseInt(endDate.substr(4, 2));
    var ed = parseInt(endDate.substr(6, 2));

    var fromDate=new Date(sy, sm-1, sd);
    var toDate=new Date(ey, em-1, ed);
    
    var sn=fromDate.getTime();
    var en=toDate.getTime();
    
    var diff=en-sn;
    var day=Math.floor(diff/(24*3600*1000));
    
    return day;
}

function searchList() {
	var f=document.searchForm;
		var search = $("option:selected").val();
		if(search == 'start'){
			$("#searchDay").show();
			$("input[name=searchValue]").prop("readonly", true);
			
			if(! isValidDateFormat(f.startDate.value)) {
				f.startDate.focus();
				return;
			}
			
			if(! isValidDateFormat(f.endDate.value)) {
				f.endDate.focus();
				return;
			}
			
			if(diffDays(f.startDate.value, f.endDate.value) < 0) {
				alert("시작일은 종료일보다 클수 없습니다.");
				f.startDate.focus();
				return;
			}
		} else {
			$("#searchDay").hide();
			$("input[name=sDay]").val("");
			$("input[name=eDay]").val("");
			$("input[name=searchValue]").prop("readonly", false);
		}

	f.submit();
}
</script>
<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-calendar"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;일 정 검 색</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
<table id="tb" style="width: 85%;">
	<tr>
		<td id="count" colspan="2">${dataCount }개(${page }/${total_page } 페이지)</td>
		<td></td>
		<td></td>
	</tr>

	<tr class="cf">
		<td width="190">일정분류</td>
		<td width="350" style="text-align: center;">제목</td>
		<td width="250">시작일</td>
		<td width="250">종료일</td>
		<td width="190">장소</td>
		<td width="190">작성자</td>
		<td width="300">작성일</td>
	</tr>
	<c:forEach var="dto" items="${list}">
		<tr class="tr">
			<td style="text-align: center;">${dto.color == 'blue'?'개인일정': (dto.color=='black'?'가족일정':(dto.color=='red'? '부서일정':'회사일정'))}</td>
			<td>${dto.title }</td>
			<td>${dto.startDay }</td>
			<td>${dto.endDay }</td>
			<td>${dto.place }</td>
			<td>${dto.name }</td>
			<td>${dto.created }</td>
		</tr>
	</c:forEach>
</table>
<br>
<div style="text-align: center;">
	<form name="searchForm" action="<%=cp%>/schedule/list" method="post">
		${paging }
		<br>
		<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/schedule/list';">새 로 고 침</button>
   		<select name="searchKey" class="selectBox" style="margin-bottom: 5px;">
          	<option value="title">제 목</option>
           	<option value="name">작 성 자</option>
          	<option value="content">내 용</option>
          	<option value="start">시 작 일</option>
      	</select>
    	<input type="text" name="searchValue" class="searchBox">
    	
   		<button type="button" class="butn" onclick="searchList()">검색</button>
   		<div class="form-group" align="center"><br>
		
		<div id="searchDay" style="display: none;">
       		<button type="button" class="butn" onclick="setInputDate('day', 0);">오늘</button>
       		<button type="button" class="butn" onclick="setInputDate('week', 1);">1주일</button>
       		<button type="button" class="butn" onclick="setInputDate('month', 1);">1개월</button>
       		<button type="button" class="butn" onclick="setInputDate('month', 3);">3개월</button>
       		<button type="button" class="butn" onclick="setInputDate('month', 6);">6개월</button>
       		<button type="button" class="butn" onclick="setInputDate('year', 1);">1년</button>
       		
       		<input type="text" name="sDay" id="startDate" class="searchBox" readonly="readonly">
       		~
       		<input type="text" name="eDay" id="endDate" class="searchBox" readonly="readonly">
		</div>
		</div>
   	</form>

</div>