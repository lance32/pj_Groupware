<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp=request.getContextPath();
%>
 <style type="text/css">
 .body{
 	border-left: 2px solid #BDBDBD;
 	border-right: 2px solid #BDBDBD;
 }
 .mainTableTr{
 	text-align: center; 
 	height: 32px;
 	color: #A4A4A4;
 }
 .mainTableTr td{
 	 text-overflow: ellipsis; white-space: nowrap; overflow: hidden;
 }
 
 .moreButn{
 	width: auto;
 	height: auto;
 	padding: 1px 5px 2px;
 	background: #FAFAFA;
 	border:none;
 	border: 2px solid #BDBDBD;
 	color: #848484;
 	outline: 0;
 	float: right;
 }
  .moreButn:hover{
  	border: 2px solid #5297BC;
	color: #0F7FBB;
	background:#F5FAFD;
  }
 
 .topName a{
	color: #585858;
 }
 .topName:hover a{
 	color: #0F7FBB;
 }
 </style>
 
 <script type="text/javascript">
jQuery(function(){
	//머릿글 공지사항 클릭시
	//공지사항 more버튼 클릭시
	jQuery("#noticeTop").click(function(){
		location.href="<%=cp%>/notice/list";
	});
	jQuery("#noticeTopMoreButn").click(function(){
		location.href="<%=cp%>/notice/list";
	});
	
	//머릿글 결재 문서함 클릭시
	//결재 문서함 more버튼 클릭시
	jQuery("#approvalTop").click(function(){
		location.href="#";
	});
	jQuery("#approvalTopMoreButn").click(function(){
		location.href="#";
	});
	
	//머릿글 받은 쪽지 클릭시
	//받은 쪽지 more버튼 클릭시
	jQuery("#messageTop").click(function(){
		location.href="<%=cp%>/message/msgReceive";
	});
	jQuery("#messageTopMoreButn").click(function(){
		location.href="<%=cp%>/message/msgReceive";
	});
	
	//머릿글 내 일정 클릭시
	//내 일정 more버튼 클릭시
	jQuery("#scheduleTop").click(function(){
		location.href="<%=cp%>/schedule/list";
	});
	jQuery("#scheduleTopMoreButn").click(function(){
		location.href="<%=cp%>/schedule/list";
	});
	
});
</script>
 
<div style="clear: both; width: 100%; height: 240px; padding: 20px 50px;background: #F2F2F2; overflow:hidden; border-bottom: 1px solid #E6E6E6; border-top:2px solid #E6E6E6;">
	<div id="myCarousel" class="carousel slide" data-ride="carousel" >
	
		<ol class="carousel-indicators" style="height: 0px;">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
		</ol>
	    
		<div class="carousel-inner">
			<div class="item active">
				<img src="<%=cp%>/resource/images/office.jpg" style="height: 200px;">
			</div>
			<div class="item">
				<img src="<%=cp%>/resource/images/building.jpg" style="height: 200px;">
			</div>
			<div class="item">
				<img src="<%=cp%>/resource/images/office2.jpg" style="height: 200px;">
			</div>
		</div>
		
		<a class="left carousel-control" href="#myCarousel" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="right carousel-control" href="#myCarousel" data-slide="next">
			<span class="glyphicon glyphicon-chevron-right"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
</div>
 
<div style="clear: both; width: 100%; height: 600px;padding: 30px 0px 0px 50px; background: #FAFAFB;">
	<div style="float:left;  width: 50%; height:100%;">
		<%-- 공지사항 --%>
		<div style="width: 99%; height:50%;">
			<div style="width: 99%; height: 260px; border: 1.5px solid #D8D8D8;  padding: 5px 10px; margin-bottom: 10px; background: #FFFFFF;">
				<div style="width: 99%; padding-left: 10px; margin-bottom: 7px;">
					<label id="noticeTop" class="topName" style="cursor: pointer;">
						<span class="glyphicon glyphicon-bullhorn" style="font-size: 20px; color: #1687C4;"></span>&nbsp;
						<a style="font-size: 23px; text-decoration: none; font-weight: 600;">공지사항</a>
					</label>
					<button id="noticeTopMoreButn" class="moreButn" type="button">+more</button>
				</div>
				<table style="width: 99%; border-spacing: 0px; border-collapse: collapse; font-size: 15px; table-layout:fixed;">
					<tr height="20" style="border-bottom:1px solid #CDDCE4; text-align: center; font-size: 11px; color: #A4A4A4;">
						<td width="55%" style="text-align: left; padding-left: 20px;">제목</td>
						<td width="20%">작성자</td>
						<td width="25%">작성일</td>
					</tr>
					<tr height="5">
						<td colspan="3"></td>
					</tr>
					<c:if test="${empty noticeList_main}">
					<tr height="70">
						<td colspan="3" style="text-align: center; color:#6E6E6E;">등록된 내용이 없습니다.</td>
					</tr>
					</c:if>
					<c:forEach var="noticeList" items="${noticeList_main}">
						<tr class="mainTableTr">
							<td style="text-align: left; padding-left: 10px;">
								<a href="<%=cp%>/notice/article?num=${noticeList.num}&page=1" style="color: #6E6E6E;">${noticeList.subject}</a>
							</td>
							<td>${noticeList.name}</td>
							<td>${noticeList.created}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		
		<%-- 미확인 결재 --%>
		<div style="width: 99%; height:50%;">
			<div style="width: 99%; height: 260px; border: 1.5px solid #D8D8D8;  padding: 5px 10px; margin-bottom: 10px; background: #FFFFFF;">
				<div style="width: 99%; padding-left: 10px; margin-bottom: 7px;">
					<label id="approvalTop" class="topName" style="cursor: pointer;">
						<span class="glyphicon glyphicon-folder-open" style="font-size: 20px; color: #1687C4;"></span>&nbsp;
						<a style="font-size: 23px; text-decoration: none; font-weight: 600;">결재 문서함</a>
					</label>
					<button id="approvalTopMoreButn" class="moreButn" type="button">+more</button>
				</div>
				<table style="width: 99%; border-spacing: 0px; border-collapse: collapse; font-size: 15px; table-layout:fixed;">
					<tr height="20" style="border-bottom:1px solid #CDDCE4; text-align: center; font-size: 11px; color: #A4A4A4;">
						<td width="60%" style="text-align: left; padding-left: 20px;">제목</td>
						<td width="20%">작성자</td>
						<td width="20%">상태</td>
					</tr>
					<tr height="5">
					</tr>
					<c:if test="${empty approvalList_main}">
					<tr height="70">
						<td colspan="3" style="text-align: center; color:#6E6E6E;">등록된 내용이 없습니다.</td>
					</tr>
					</c:if>
					<%-- <c:forEach var="approvalList" items="${approvalList_main}">
						<tr class="mainTableTr">
							<td style="text-align: left; padding-left: 10px;">
								<a href="<%=cp%>//?num=${approvalList.num}&page=1" style="color: #6E6E6E;">${approvalList.subject}</a>
							</td>
							<td>${approvalList.name}</td>
							<td>${approvalList.created}</td>
						</tr>
					</c:forEach> --%>
				</table>
			</div>
		</div>
		
	</div>
	
	<div style="float:left; width: 49%; height: 100%; padding-left: 20px;">
		<%-- 받은 쪽지 --%>
		<div style="width: 99%; height:50%;">
			<div style="width: 99%; height: 260px; border: 1.5px solid #D8D8D8;  padding: 5px 10px; margin-bottom: 10px; background: #FFFFFF;">
				<div style="width: 99%; padding-left: 10px; margin-bottom: 7px;">
					<label id="messageTop" class="topName" style="cursor: pointer;">
						<span class="glyphicon glyphicon-send" style="font-size: 20px; color: #1687C4;"></span>&nbsp;
						<a style="font-size: 23px; text-decoration: none; font-weight: 600;">받은 쪽지</a>
					</label>
					<button id="messageTopMoreButn" class="moreButn" type="button">+more</button>
				</div>
				<table style="width: 99%; border-spacing: 0px; border-collapse: collapse; font-size: 15px; table-layout:fixed;">
					<tr height="20" style="border-bottom:1px solid #CDDCE4; text-align: center; font-size: 11px; color: #A4A4A4;">
						<td width="55%" style="text-align: left; padding-left: 20px;">제목</td>
						<td width="20%">보낸사람</td>
						<td width="25%">보낸시간</td>
					</tr>
					<tr height="5">
						<td colspan="3"></td>
					</tr>
					<c:if test="${empty messageList_main}">
					<tr height="70">
						<td colspan="3" style="text-align: center; color:#6E6E6E;">등록된 내용이 없습니다.</td>
					</tr>
					</c:if>
					<c:forEach var="messageList" items="${messageList_main}">
						<tr class="mainTableTr">
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
		
		<%-- 내 일정 --%>
		<div style="width: 99%; height:50%;">
			<div style="width: 99%; height: 260px; border: 1.5px solid #D8D8D8;  padding: 5px 10px; margin-bottom: 10px; background: #FFFFFF;">
				<div style="width: 99%; padding-left: 10px; margin-bottom: 7px;">
					<label id="scheduleTop" class="topName" style="cursor: pointer;">
						<span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: #1687C4;"></span>&nbsp;
						<a style="font-size: 23px; text-decoration: none; font-weight: 600;">내 일정</a>
					</label>
					<button id="scheduleTopMoreButn" class="moreButn" type="button">+more</button>
				</div>
				<table style="width: 99%; border-spacing: 0px; border-collapse: collapse; font-size: 15px; table-layout:fixed;">
					<tr height="20" style="border-bottom:1px solid #CDDCE4; text-align: center; font-size: 11px; color: #A4A4A4;">
						<td width="20%">분류</td>
						<td width="30%">제목</td>
						<td width="25%">장소</td>
						<td width="25%">시작일</td>
					</tr>
					<tr height="5">
						<td colspan="3"></td>
					</tr>
					<c:if test="${empty scheduleList_main}">
					<tr height="70">
						<td colspan="4" style="text-align: center; color:#6E6E6E;">등록된 내용이 없습니다.</td>
					</tr>
					</c:if>
					<c:forEach var="scheduleList" items="${scheduleList_main}">
						<tr class="mainTableTr">
							<td>${scheduleList.color == 'blue'?'개인일정': (scheduleList.color=='black'?'가족일정':(scheduleList.color=='red'? '부서일정':'회사일정'))}</td>
							<td style="color: #6E6E6E;">${scheduleList.title}</td>
							<td>${scheduleList.place}</td>
							<td>${scheduleList.startDay}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		
		
		
	</div>


</div>