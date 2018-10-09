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
<title>주소록 연락처 등록</title>
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
	border: none;
	outline: 0;
	font-size: 15px;
}
.butn:hover{
	background: #61380B;
	color: #ffffff;
	cursor: pointer;
}

.addressItem{
	text-align: right;
	padding-right: 20px;
	color: #424242;
}

.addressInput{
	outline: none;
	border: none;
	border-bottom: 1.3px solid #A4A4A4;
	width: 300px;
}
.addressInput:focus{
	border-bottom: 2px solid orange;
}

</style>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.css" type="text/css">
<script type="text/javascript">
jQuery(function(){
	//추가(수정) 버튼 클릭시 insertAddressButn
	jQuery("#addAddressButn").click(function(){
		var state="true";
		var f=document.addAddressForm;
		
		var str=f.name.value;
		if(!str){
			alert("이름은 필수 입력사항 입니다.");
			f.name.focus();
			state="false";
			return state;
		}
		
		var str=f.tel.value;
		if(!str){
			alert("전화번호는 필수 입력사항 입니다.");
			f.tel.focus();
			state="false";
			return state;
		}
		if(!/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/.test(str)){
			alert("전화번호 형식이 틀렸습니다.");
			f.tel.focus();
			state="false";
			return state;
		}
		
		var str=f.email.value;
		if(str){
			if(!/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i.test(str)){
				alert("이메일 형식이 틀렸습니다.");
				f.email.focus();
				state="false";
				return state;
			}
		}
		
		if(state=="true"){
			f.action="<%=cp%>/addressBook/${mode}";
			f.submit();
		}
	});
	
	//취소버튼 클릭시
	jQuery("#addCancelButn").click(function(){
		location.href="<%=cp%>/addressBook/addressBook";
		return;
	});
	
});
</script>
</head>
<body>

<div style="width:800px; height:540px;margin: 10px 0px 0px 10px;">
	<div style="clear:both; width: 100%; height: 40px; background: #C46F1A; padding: 0px; margin: 0px;">
		<div style="margin: 10px 0px 0px 10px; float: left; font-weight: bold; color: #FAFAFA">
			<span class="glyphicon glyphicon-book" style="font-size: 15px; margin-right: 10px;"></span>연락처 <c:if test="${mode=='update'}">수정</c:if><c:if test="${mode=='created'}">추가</c:if>
		</div>
	</div>
	
	<div style="width: 480px; height: 500px; float: left; border-left: 2px solid #BDBDBD; border-bottom: 2px solid #BDBDBD; border-right: 1px solid #BDBDBD;">
		<form name="addAddressForm" method="post">
			<div style="margin: 20px 30px 10px 30px;">
				<table style="border-spacing: 0px;">
					<tr height="1px;"><td width="90px;"></td><td width="120px;"></td><td width="50px;"></td><td width="130px;"></td></tr>
					<tr height="50px;">
						<td class="addressItem"> 이름 </td>
						<td colspan="3"><input type="text" name="name" class="addressInput"  autocomplete="off" value="${addressInfo.name}" maxlength="25" placeholder="ex) 김한조"></td>
					</tr>
					<tr height="50px;">
						<td class="addressItem">전화번호</td>
						<td colspan="3"><input type="text" name="tel" class="addressInput"  autocomplete="off" value="${addressInfo.tel}" maxlength="20" placeholder="ex) 010-1234-5678"></td>
					</tr>
					<tr height="50px;">
						<td class="addressItem"> 그룹 </td>
						<td>
							<select id="groupSeparate" name="groupNum" style="width: 100px; height: 25px;">
							 <c:forEach var="dto" items="${groupList}">
								<option value="${dto.groupNum}" ${addressInfo.groupNum==dto.groupNum ? "selected='selected'":""}>${dto.groupName}</option> 
							 </c:forEach>
							</select>
						</td>
						<td style="color: #424242;"> 소속 </td>
						<td><input type="text" name="belongto" class="addressInput"  autocomplete="off" style="width: 130px;" value="${addressInfo.belongto}" maxlength="10"></td>
					</tr>
					<tr height="50px;">
						<td class="addressItem"> 이메일 </td>
						<td colspan="3"><input type="text" name="email" class="addressInput"  autocomplete="off" value="${addressInfo.email}" maxlength="30" placeholder="ex) email123@mail.com"></td>
					</tr>
					<tr height="50px;">
						<td class="addressItem"> FAX 번호 </td>
						<td colspan="3"><input type="text" name="fax" class="addressInput"  autocomplete="off" value="${addressInfo.fax}" maxlength="20"></td>
					</tr>
					<tr height="50px;">
						<td class="addressItem"> 주소1 </td>
						<td colspan="3"><input type="text" name="addr1" class="addressInput"  autocomplete="off" value="${addressInfo.addr1}" maxlength="30"></td>
					</tr>
					<tr height="50px;">
						<td class="addressItem"> 주소2 </td>
						<td colspan="3"><input type="text" name="addr2" class="addressInput"  autocomplete="off" value="${addressInfo.addr2}" maxlength="30"></td>
					</tr>
					<tr height="50px;">
						<td class="addressItem"> 우편번호 </td>
						<td colspan="3"><input type="text" name="zip" class="addressInput"  autocomplete="off" value="${addressInfo.zip}" maxlength="20"></td>
					</tr>
				</table>
				<c:if test="${mode=='update'}">
				<input type="hidden" name=addressBookNum value="${addressInfo.addressBookNum}">
				</c:if>
				<input type="hidden" name="memberNum" value="${sessionScope.member.userId}">
			</div>
		</form>
		<div style="clear:both; width: 100%; height: 50px;">
			<button class="butn" type="reset" style="float: left; margin: 20px 0px 0px 30px;">초기화</button>
			<button id="addCancelButn" class="butn" style="float: right; margin: 20px 20px 0px 10px;">취소</button>
			<button id="addAddressButn" class="butn" type="button" style="float: right; margin-top: 20px;"><c:if test="${mode=='update'}">수정</c:if><c:if test="${mode=='created'}">추가</c:if></button>
		</div>
	</div>
	<div style="width: 320px; height: 500px; float: left;  border-right: 2px solid #BDBDBD; border-bottom: 2px solid #BDBDBD; opacity:0.5; pointer-events: none;"><%--opacity:0.5; pointer-events: none; --%>
		<div style="width: 100%; height: 40px; float: left;">
			<input type="checkbox" style="margin: 13px; width: 15px; height: 15px;">
			<button class="butn" style="float: right; margin: 5px;">사원목록에서 추가</button>
		</div>
		<div style="width: 100%; height:395px; float: left; overflow-y:scroll; background: #E6E6E6; margin-top: 5px;">
		
		</div>
		<div style="width: 100%; height: 58px; float: left;">
			<button class="butn" style="float: left; margin: 10px;">삭제</button>
			<button id="insertAddressButn" type="button" class="butn" style="float: right; margin: 10px;">추가완료</button>
		</div>
	</div>
	
</div>


</body>
</html>