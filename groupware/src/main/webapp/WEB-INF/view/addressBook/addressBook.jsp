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
<title>주소록</title>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<style type="text/css">
*{
	margin: 0px;
	padding: 0px;
}

.butn{
	width: auto;
	height: auto;
	padding: 5px 10px;
	border-radius: 5px;
	background: #8F5116;
	color: #E6E6E6;
	border: 1px solid #D7904E;
	outline: 0;
	font-size: 15px;
}
.butn:hover{
	background: #E87C16;
	color: #ffffff;
	cursor: pointer;
}

#nameSearchDiv:hover{
	cursor: pointer;
}
.address{
	height: 50px; 
	border-bottom: 1px solid #E6E6E6; 
	border-top:1px solid #E6E6E6; 
	border-left:2px solid #F2F2F2; 
	background: #ffffff; 
}
.address:hover{
	background: #FBF8EF;
	cursor: pointer;
}

</style>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.css" type="text/css">
<script type="text/javascript">
jQuery(function(){
	jQuery("#addressInfo").hide();
	jQuery(".address").click(function(){
		jQuery(".address").css("border-left","2px solid #F2F2F2");
		jQuery(this).css("border-left","none");
		jQuery("#addressInfo").show();
	});
	
	//추가 버튼 클릭시
	jQuery("#addAdressButn").click(function(){
		location.href="<%=cp%>/addressBook/created";
		return;
	});
	
	
});
</script>
</head>
<body>

<div style="width:800px; height:542px;margin: 10px 0px 0px 10px;">
	<div style="clear:both; width: 100%; height: 40px; background: #C46F1A; padding: 0px; margin: 0px;">
		<div style="margin: 10px 0px 0px 10px; float: left; font-weight: bold; color: #FAFAFA">
			<span class="glyphicon glyphicon-book" style="font-size: 15px; margin-right: 10px;"></span>주소록 목록
		</div>
		<div style="width: 230px; height: 40px; float: right; padding:10px 25px 0px 0px;">
			<div id="nameSearchDiv" style="float: right; width: 20px; height: 20px; text-align: center; background: #ffffff; border-bottom-right-radius: 5px; border-top-right-radius:  5px; ">
				<span class="glyphicon glyphicon-search" style="font-size: 11px;"></span>
			</div>
			<input type="text" style="border:none;  border-bottom-left-radius:5px; border-top-left-radius:5px; height: 20px; float: right;" placeholder="연락처 이름검색..">
		</div>
	</div>
	
	<div style="width: 400px; height: 460px; float: left; border-left: 2px solid #E6E6E6; border-bottom: 2px solid #E6E6E6; border-top: 3px solid #F2F2F2;">
		<div id="addressInfo" style="width: 100%; height: 450px; border-top: 1px solid #E6E6E6;">
			<div style="width: 100%; height: 400px;">
				<table style="margin: 10px 20px;">
					<tr height="40px">
						<td width="80px">이름</td>
						<td>테스트</td>
					</tr>
					<tr height="40px">
						<td>전화번호</td>
						<td>010-1111-1111</td>
					</tr>
					<tr height="40px">
						<td>그룹</td>
						<td>일반</td>
					</tr>
					<tr height="40px">
						<td>소속</td>
						<td></td>
					</tr>
					<tr height="40px">
						<td>이메일</td>
						<td></td>
					</tr>
					<tr height="40px">
						<td>FAX 번호</td>
						<td></td>
					</tr>
					<tr height="40px">
						<td>주소1</td>
						<td></td>
					</tr>
					<tr height="40px">
						<td>주소2</td>
						<td></td>
					</tr>
					<tr height="40px">
						<td>우편번호</td>
						<td></td>
					</tr>
				</table>
			</div>
	
			<div style="width: 100%; height: 50px;">
				<button type="button" class="butn" style="float:left; margin-left: 10px;">수정</button>
				<button type="button" class="butn" style="float:right; margin-right: 20px;">삭제</button>
			</div>
		</div>
	</div>
	<div style="width: 400px; height: 460px; float: left;  border-right: 2px solid #E6E6E6; border-bottom: 2px solid #E6E6E6;">
		<div style="width: 100%; height:458px; float: left; overflow-y:scroll; background: #F2F2F2; padding: 3px 0px 3px 0px;">
			
			<div class="address">
				<div style="width: 30%; line-height: 50px; text-align:center; float: left; ">테스트</div>
				<div style="width: 70%; line-height: 50px; text-align:center; float: left;">010-1111-1111</div>
			</div>
			<div class="address">
				<div style="width: 30%; line-height: 50px; text-align:center; float: left; ">테스트2</div>
				<div style="width: 70%; line-height: 50px; text-align:center; float: left;">010-1111-1111</div>
			</div>
		
		</div>
		
	</div>
	<div style="clear: both; width: 100%; height: 40px; padding-right: 5px;">
		<button id="addAdressButn" type="button" class="butn" style="margin: 5px 0px 0px 5px; float: right;">추가</button>
	
	</div>
	
</div>

</body>
</html>