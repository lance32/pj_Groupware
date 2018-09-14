<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">

.chatRoom_ListItem{
	height: 40px;
	font-size: 17px;
	border-bottom: 1px solid #E6E6E6;
}
	.chatRoom_ListItem:hover{
		background: #D4E3EE;
		cursor: pointer;
		border: 1px solid #0F7ECE;
	}
.chatListItem_subject{
	padding-left: 10px;
	text-align: left;
}
</style>

<script type="text/javascript">
jQuery(function(){
	jQuery(".chatRoom_Info").hide();
	jQuery(".chatRoom_ListItem").click(function(){
		jQuery(".chatRoom_Info").show();
	});
});

</script>

<%--	$("#roomListContainer").append("<p data-roomId='"+roomId+"'>"+subject+"</p>"); --%>
	<div style="clear: both; margin: 10px 0px 40px 10px;">
		<span class="glyphicon glyphicon-transfer" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;채팅</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	
	
	<div class="chatRoom_List" style="width: 500px; height:650px; border: 2px solid #BDBDBD; margin-left: 15px; text-align: center; float: left;">
		<table style="border-spacing: 0px; border-collapse: collapse;margin: 0px auto;">
			<tr height="50px;" style="font-size: 20px; font-weight: 300; background: #A4A4A4;">
				<td width="200px;">채팅방 이름</td>
				<td width="180px;">개설 시간</td>
				<td width="118px;">참여인원수</td>
			</tr>
			
			<tr class="chatRoom_ListItem">
				<td class="chatListItem_subject">테스트 채팅방</td>
				<td class="chatListItem_date">2018-09-13 17:33</td>
				<td class="chatListItem_number">3/5</td>
			</tr>
			
		</table>
	</div>
	<div class="chatRoom_Info" style="float: left; width: 400px; height: 650px; border:1px solid #BDBDBD; background: #FAFAFA;">
		<p style="height: 40px; line-height:40px; font-size: 17px; text-align: center; border-bottom: 1px solid #D8D8D8; ">채팅방 정보</p>
	</div>
	

<%--
	새로고침 만들기
	정보 밑에 참여하기 버튼
	
	정보있던자리에 채팅화면
	새창으로 열기 버튼

	//개설자가 나가도 채팅방 유지.(마지막한명이 나갈시 종료)
	//채팅방 리스트에는 제목, 개설시간과 (3/5) 이렇게 인원수만 표시
	//채팅방정보에는 개설자, 최대접속인원, 현재 접속인원, 접속자 리스트, 개설시간
	//채팅방 창을 새로 띄움. 다른작업 가능. 여러개 띄울수 있음.
 --%>
