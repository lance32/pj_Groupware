<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp=request.getContextPath();
%>
 <style type="text/css">
 .mainTableTr{
 	text-align: center; 
 	border-bottom: 1px solid #E6E6E6;
 	height: 35px;
 	color: #6E6E6E;
 }
 
 td{
  	text-overflow: ellipsis; white-space: nowrap; overflow: hidden;
 }
 
 

 </style>
 
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

jQuery(function(){
	//머릿글 공지사항 클릭시
	jQuery("#noticeTop").click(function(){
		location.href="<%=cp%>/notice/list";
		return;		
	});
	
	//머릿글 받은 쪽지 클릭시
	jQuery("#messageTop").click(function(){
		location.href="<%=cp%>/message/msgReceive";
		return;		
	});
	
	//머릿글 내 일정 클릭시
	jQuery("#scheduleTop").click(function(){
		location.href="<%=cp%>/schedule/list";
		return;		
	});
	
});

</script>
 
<div style="clear: both; width: 95%; height: 770px; margin: 20px 30px;">

	<div style="float:left;  width: 55%; height:100%; padding-top: 30px; padding-right: 70px;">
		<div style="width: 100%; height:32%; ">
			<div style="width:450px; height: 130px; padding-left: 20px; box-shadow: 3px 5px 5px 1px #A4A4A4;">
				<div style="font-size: 20px;">현재 시각</div>
				<div style="font-size: 40px; font-weight: 700;">
					<span id="clock" style="border-bottom: 2px solid #BDBDBD; padding: 0px 10px;"></span>
				</div>
			</div>
		</div>
		
		<%-- 공지사항 --%>
		<div style="width: 100%; height:68%;">
			<div style="width: 100%; height: 90%;">
				<div id="noticeTop" class="tableTop" style="width: 190px; padding-left: 10px; cursor: pointer; border-bottom: 2px solid #585858;">
					<span class="glyphicon glyphicon-bullhorn" style="font-size: 23px;"></span>
					<a style="font-size: 25px; margin-left: 10px; text-decoration: none; color: #6E6E6E;">공지사항</a>
				</div>
				<table style="width: 100%; border-spacing: 0px; border-collapse: collapse; font-size: 15px;">
					<tr height="40" style="background: #BDBDBD; text-align: center; font-size: 17px; font-weight: 600;">
						<td width="40%">제목</td>
						<td width="30%">작성자</td>
						<td width="30%">작성일</td>
					</tr>
					
					<c:forEach var="noticeList" items="${noticeList_main}">
						<tr class="mainTableTr">
							<td style="text-align: left; padding-left: 10px; overflow: hidden;">
								<a href="<%=cp%>/notice/article?num=${noticeList.num}&page=1" style="color: #848484;">${noticeList.subject}</a>
							</td>
							<td>${noticeList.name}</td>
							<td>${noticeList.created}</td>
						</tr>
					</c:forEach>
					
				</table>
			</div>
		</div>
		
	</div>
	
	<div style="float:left; width: 45%; height: 100%; padding-left: 20px;">
		<%-- 미확인 결재 --%>
		<div style="clear: both; width: 100%; height: 35%;">
			<div style="width: 100%; height: 90%;">
				<div class="tableTop" style="width: 200px; padding-left: 10px; cursor: pointer; border-bottom: 2px solid #585858;">
					<span class="glyphicon glyphicon-folder-open" style="font-size: 20px;"></span>
					<a style="font-size: 23px; margin-left: 10px; text-decoration: none; color: #6E6E6E;">결재 문서함</a>
				</div>
				<table style="width: 100%; border-spacing: 0px; border-collapse: collapse; font-size: 13px;">
					<tr height="35" style="background: #BDBDBD; text-align: center; font-size: 15px; font-weight: 600;">
						<td width="10%">번호</td>
						<td width="40%">제목</td>
						<td width="25%">작성자</td>
						<td width="25%">상태</td>
					</tr>
				</table>
			</div>
		</div>
		<%-- 미확인 쪽지 --%>
		<div style="clear: both; width: 100%; height: 35%;">
			<div style="width: 100%; height: 90%;">
				<div id="messageTop" class="tableTop" style="width: 170px; padding-left: 10px; cursor: pointer; border-bottom: 2px solid #585858;">
					<span class="glyphicon glyphicon-send" style="font-size: 20px;"></span>
					<a style="font-size: 23px; margin-left: 10px; text-decoration: none; color: #6E6E6E;">받은 쪽지</a>
				</div>
				<table style="width: 100%; border-spacing: 0px; border-collapse: collapse; font-size: 15px;">
					<tr height="35" style="background: #BDBDBD; text-align: center; font-size: 17px; font-weight: 600;">
						<td width="45%">제목</td>
						<td width="25%">보낸사람</td>
						<td width="30%">보낸시간</td>
					</tr>
					<c:forEach var="messageList" items="${messageList_main}">
						<tr class="mainTableTr" style="height: 30px;">
							<td style="text-align: left; padding-left: 10px;">
								<a href="<%=cp%>/message/msgRead?msgNum=${messageList.msgNum}&memberNum=${messageList.sendMember}" style="color: #6E6E6E;">${messageList.subject}</a>
							</td>
							<td>${messageList.sendMemberName}</td>
							<td>${messageList.sendTime}</td>
						</tr>
					</c:forEach>
				</table>
			</div>

		</div>
		<%-- 일정 --%>
		<div style="clear: both; width: 100%; height: 30%;">
			<div style="width: 100%; height: 90%;">
				<div id="scheduleTop" class="tableTop" style="width: 170px; padding-left: 10px; cursor: pointer; border-bottom: 2px solid #585858;">
					<span class="glyphicon glyphicon-calendar" style="font-size: 20px;"></span>
					<a style="font-size: 23px; margin-left: 10px; text-decoration: none; color: #6E6E6E;">내 일정</a>
				</div>
				<table style="width: 100%; border-spacing: 0px; border-collapse: collapse; font-size: 15px;">
					<tr height="35" style="background: #BDBDBD; text-align: center; font-size: 17px; font-weight: 600;">
						<td width="20%">분류</td>
						<td width="30%">제목</td>
						<td width="25%">장소</td>
						<td width="25%">시작일</td>
					</tr>
					<c:forEach var="scheduleList" items="${scheduleList_main}">
						<tr class="mainTableTr" style="height: 30px;">
							<td>${scheduleList.color == 'blue'?'개인일정': (scheduleList.color=='black'?'가족일정':(scheduleList.color=='red'? '부서일정':'회사일정'))}</td>
							<td style="text-align: left; padding-left: 10px;">${scheduleList.title}</td>
							<td>${scheduleList.place}</td>
							<td>${scheduleList.startDay}</td>
						</tr>
					</c:forEach>
					
				</table>
			</div>
		</div>
	</div>


</div>