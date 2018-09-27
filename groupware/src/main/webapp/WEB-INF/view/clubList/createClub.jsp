<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
.textInput{
	border: 1px solid #6E6E6E;
	border-radius: 3px;
	height: 27px;
}
</style>

<script type="text/javascript">

jQuery(function(){
	
	//개설취소버튼 클릭시
	jQuery("#cancelButn").click(function(){
		location.href="<%=cp%>/clubList/clubList";
		return;
	});
	
	//개설완료 버튼 클릭시
	jQuery("#createClubButn").click(function(){
		var f=document.createClubForm;
		
		var str=f.clubName.value;
		if(!str){
			alert("동호회 이름은 필수 입력사항 입니다.");
			f.clubName.focus();
			return;
		}
		var str=f.clubIntro.value;
		if(!str){
			alert("동호회 소개글은 필수 입력사항 입니다.");
			f.clubIntro.focus();
			return;
		}
		var str=f.maxPeople.value;
		if(!str){
			alert("가입 최대 인원수는 필수 입력사항 입니다.");
			f.maxPeople.focus();
			return;
		}
		var str=f.clubSubject.value;
		if(!str){
			alert("주제는 필수 입력사항 입니다.");
			f.clubSubject.focus();
			return;
		}
		var str=f.upload.value;
    	if(! str) {
    		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
    			alert("대표 이미지는 이미지 파일만 가능합니다. ");
    			f.upload.focus();
    			return false;
    		}
    	}    
    	
		f.action="<%=cp%>/clubList/createClub";
		f.submit();
	});
	
	
});


</script>

<div style="">
	<div style="clear: both; margin: 10px 0px 40px 10px;">
		<span class="glyphicon glyphicon-edit" style="font-size: 28px; margin-left: 10px;"></span> 
		<span style="font-size: 30px;">&nbsp;동호회 개설</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	<form name="createClubForm" method="post" enctype="multipart/form-data">
		<table style="margin-left: 50px; border-spacing: 0px;">
			<tr height="60">
				<td width="130" style="text-align: left;">동호회 이름</td>
				<td width="700"><input name="clubName" type="text" class="textInput" style="width: 95%"></td>
			</tr>
			<tr height="90">
				<td style="text-align: left; padding-top: 20px;" valign="top">동호회 소개글<br>(최대 35글자)</td>
				<td ><textarea name="clubIntro" class="textInput" style="width:95%; height: 50px;" maxlength="35"></textarea></td>
			</tr>
			<tr height="60">
				<td style="text-align: left;">개설자</td>
				<td >
					<input type="text" class="textInput" style="width: 40%; background:#F2F2F2;" readonly="readonly" value="${sessionScope.member.userName}">
					<input type="hidden" name="memberNum" value="${sessionScope.member.userId}">
				</td>
			</tr>
			<tr height="60">
				<td style="text-align: left;">가입 최대 인원수</td>
				<td ><input name="maxPeople" type="text" class="textInput" style="width: 20%" >&nbsp; 명</td>
			</tr>
			<tr height="60">
				<td style="text-align: left;">주제</td>
				<td ><input name="clubSubject" type="text" class="textInput" style="width: 60%"></td>
			</tr>
			<tr height="60">
				<td style="text-align: left;">대표 이미지</td>
				<td ><input name="upload" type="file"></td>
			</tr>
		</table>
		
		<div style="width: 830px; height: 100px; margin-left: 40px; padding-top: 50px;">
			<button type="reset" class="butn" style=" float: left;">초기화</button>
			<button id="cancelButn" type="button" class="butn" style=" float: right; margin-left: 10px;">개설취소</button>
			<button id="createClubButn" type="button" class="butn" style=" float: right;">개설완료</button>
		</div>
	</form>
</div>