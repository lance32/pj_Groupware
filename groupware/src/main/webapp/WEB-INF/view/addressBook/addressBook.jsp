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
	border: none;
	outline: 0;
	font-size: 15px;
}
.butn:hover{
	background: #61380B;
	color: #ffffff;
	cursor: pointer;
}

.address{
	height: 50px; 
	border-bottom: 1px solid #E6E6E6; 
	border-top:1px solid #E6E6E6; 
	border-left:2px solid #E6E6E6; 
	background: #ffffff; 
}
.address:hover{
	background: #FBF8EF;
	cursor: pointer;
}
.addressList{
 	line-height: 50px; 
 	text-align:center;
 	 float: left; 
}

.groupItems:hover{
	background: #F2DFCA;
}
</style>
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.css" type="text/css">
<script type="text/javascript">
jQuery(function(){
	jQuery("#addressInfo").hide();
	
	//연락처 클릭시 정보보기 AJAX
	jQuery(".address").click(function(){
		jQuery("#infoContent").empty();
		jQuery("#infoButn").empty();
		jQuery(".address").css("border-left","2px solid #E6E6E6");
		jQuery(this).css("border-left","none");
		
		var addressBookNum=jQuery(this).children("input").val();
		if(! addressBookNum){
			alert("연락처의 정보가 없습니다.");
			jQuery(".address").css("border-left","2px solid #E6E6E6");
			return;
		}
		
		var query="addressBookNum="+addressBookNum;
		var url="<%=cp%>/addressBook/addressInfo";
		jQuery.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				jQuery("#infoContent").append(""
					+"<table style='margin: 10px 30px;'>"
					+"	<tr height='40px'> <td width='80px'>이름</td> <td>"+data.name+"</td> </tr>"
					+"	<tr height='40px'> <td>전화번호</td> <td>"+data.tel+"</td> </tr>"
					+"	<tr height='40px'> <td>그룹</td> <td>"+data.groupName+"</td> </tr>"
					+"	<tr height='40px'> <td>소속</td> <td>"+data.belongto+"</td> </tr>"
					+"	<tr height='40px'> <td>이메일</td> <td>"+data.email+"</td> </tr>"
					+"	<tr height='40px'> <td>FAX 번호</td> <td>"+data.fax+"</td> </tr>"
					+"	<tr height='40px'> <td>주소1</td> <td>"+data.addr1+"</td> </tr>"
					+"	<tr height='40px'> <td>주소2</td> <td>"+data.addr2+"</td> </tr>"
					+"	<tr height='40px'> <td>우편번호</td> <td>"+data.zip+"</td> </tr>"
					+"</table>"
				);
				jQuery("#infoButn").append("<button id='deleteAddressButn' value='"+data.addressBookNum+"' type='button' class='butn' style='float:right; margin-right: 20px;'>삭제</button>");
				jQuery("#infoButn").append("<button id='updateAddressButn' value='"+data.addressBookNum+"' type='button' class='butn' style='float:right; margin-right: 10px;'>수정</button>");
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	console.log(jqXHR.responseText);
		    }
		}); 
		
		jQuery("#addressInfo").show();
	});

	//추가 버튼 클릭시
	jQuery("#addAdressButn").click(function(){
		location.href="<%=cp%>/addressBook/created";
		return;
	});
	
	//삭제 버튼 클릭시
	jQuery("body").on("click","#deleteAddressButn",function(){
		if(! confirm("삭제하시겠습니까?")){
			return;
		}
		var addressBookNum=jQuery(this).val();
		location.href="<%=cp%>/addressBook/delete?addressBookNum="+addressBookNum;
		return;
	});
	
	//수정 버튼 클릭시
	jQuery("body").on("click","#updateAddressButn",function(){
		var addressBookNum=jQuery(this).val();
		location.href="<%=cp%>/addressBook/update?addressBookNum="+addressBookNum;
		return;
	});
	
	//나가기 버튼 클릭시
	jQuery("#exitButn").click(function(){
		window.close();
	});
	
	//새로고침 버튼 클릭시
	jQuery("#refreshButn").click(function(){
		location.href="<%=cp%>/addressBook/addressBook";
		return;
	});
	
	//검색 돋보기 모양 클릭시
	jQuery("#nameSearchDiv").click(function(){
		var f=document.searchForm;
		
		searchValue=jQuery("#searchValue").val();
		if(! searchValue){
			alert("검색어를 입력하세요.");
			return;
		}
		f.action="<%=cp%>/addressBook/addressBook" 
		f.submit();
	});

//---

	//그룹추가 버튼 클릭시
	jQuery("#alterGroupButn").click(function(){
		jQuery("#alterGroup-dialog").dialog({
			modal: true,
			minHeight: 380,
			maxHeight: 380,
			minWidth: 480,
			maxWidth: 480,
			title: '그룹정보',
			close: function(event, ui) {
			}
		});
	});
	
	//dialog 그룹목록에서 선택시
	jQuery(document).on("click",".groupItems", function(){
		var groupNum=jQuery(this).children(".groupNumHidden").val();
		var groupName=jQuery(this).children("span").text();
		jQuery("#updateGroupName").val(groupName);
		jQuery("#choosingGroupNum").val(groupNum);
	});
	
	//dialog 추가 버튼 클릭시
	jQuery("#createGroupButn").click(function(){
	    var f = document.createGroupForm;

		var str = f.groupName.value;
	    if(!str) {
			alert("그룹 이름을 입력하세요.");
	        f.groupName.focus();
	        return;
	    }
	    f.action="<%=cp%>/addressBook/createGroup";
	    f.submit();
	});
	
	//dialog 삭제 버튼 클릭시
	jQuery("#deleteGroupButn").click(function(){
		var groupNum=jQuery("#choosingGroupNum").val();
		location.href="<%=cp%>/addressBook/deleteGroup?groupNum="+groupNum;
		return;
	});
	
	//dialog 수정 버튼 클릭시
	jQuery("#updateGroupButn").click(function(){
		var groupNum=jQuery("#choosingGroupNum").val();
		var groupName=jQuery("#updateGroupName").val();
		location.href="<%=cp%>/addressBook/updateGroup?groupNum="+groupNum+"&groupName="+groupName;
		return;
	});
});

var state="${state}";
if(state=="dialogOpen"){
	jQuery(function(){
		jQuery("#alterGroupButn").click();
	});
}

</script>
</head>
<body>
	
<div style="width:800px; height:542px;margin: 10px 0px 0px 10px;">
	<div style="clear:both; width: 100%; height: 40px; background: #C46F1A; padding: 0px; margin: 0px;">
		<div style="margin: 10px 0px 0px 10px; float: left; font-weight: bold; color: #FAFAFA">
			<span class="glyphicon glyphicon-book" style="font-size: 15px; margin-right: 10px;"></span>주소록 목록
		</div>
		<div style="width: 230px; height: 40px; float: right; padding:10px 25px 0px 0px;">
			<form name="searchForm" method="post">
				<div id="nameSearchDiv" style="float: right; width: 20px; height: 20px; text-align: center; background: #ffffff; border-bottom-right-radius: 5px; border-top-right-radius:  5px; cursor: pointer; ">
					<span class="glyphicon glyphicon-search" style="font-size: 11px;"></span>
				</div>
				<input type="text" name="searchValue" id="searchValue" style="border:none;  border-bottom-left-radius:5px; border-top-left-radius:5px; height: 20px; float: right; padding-left: 5px;" placeholder="이름검색..">
			</form>
		</div>
	</div>
	
	<div style="width: 400px; height: 460px; float: left; border-left: 2px solid #BDBDBD; border-bottom: 2px solid #BDBDBD; border-top: 3px solid #E6E6E6;">
		<div id="addressInfo" style="width: 100%; height: 450px; border-top: 1px solid #E6E6E6;">
			<div id="infoContent" style='width: 100%; height: 400px;'> 
			 </div>
			 <div id="infoButn" style='width: 100%; height: 50px;'>	
			 </div>
		</div>
	</div>
	<div style="width: 400px; height: 460px; float: left;  border-right: 2px solid #BDBDBD; border-bottom: 2px solid #BDBDBD;">
		<div style="width: 100%; height:458px; float: left; overflow-y:scroll; background: #E6E6E6; padding: 3px 0px 3px 0px;">
			<c:forEach var="dto" items="${list}">
				<div class="address">
					<div class="addressList" style="width: 30%; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">${dto.name}</div>
					<div class="addressList" style="width: 30%; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">${dto.groupName}</div>
					<div class="addressList" style="width: 40%; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">${dto.tel}</div>
					<input type="hidden" value="${dto.addressBookNum}">
				</div>
			</c:forEach>
		</div>
		
	</div>
	<div style="clear: both; width: 100%; height: 40px; padding-right: 5px;">
		<button id="exitButn" type="button" class="butn" style="margin: 5px 0px 0px 5px;">나가기</button>
		<button id="refreshButn" type="button" class="butn" style="margin: 5px 0px 0px 10px;">새로고침</button>
		<button id="addAdressButn" type="button" class="butn" style="margin: 5px 0px 0px 10px; float: right;">추가</button>
		<button id="alterGroupButn" class="butn" type="button" style="float: right; margin-top: 5px;">그룹 추가</button>
	</div>
	
</div>

<div id="alterGroup-dialog" style="display: none; margin: 0px; padding: 0px; overflow: inherit;">
	<div style="width:470px; height: 330px; padding-top: 10px;">
		<div style="width: 140px; height: 100%; border:2px solid #D2A97A; float: left;">
			<div style="width: 100%; height: 8%; border-bottom: 1px solid #D2A97A; padding: 5px 10px; font-weight: 600; background: #CA8C45; color: #F2F2F2;">그룹 목록</div>
			<div style="height: 92%; overflow-y: scroll;  padding: 10px 2px;">
				<c:forEach var="dto" items="${groupList}">
				<div class="groupItems" style="clear: both; width:100%; height: 22px; padding-left: 10px; margin-bottom: 5px; cursor: pointer; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
					<span>${dto.groupName}</span>
					<input type="hidden" class="groupNumHidden" value="${dto.groupNum}">
				</div>
				</c:forEach>
			</div>
		</div>
		
		<div style="width: 300px; height: 100%; float: left; margin-left: 10px; padding-top: 15px;">
			<div style="width:280px; height:110px;  margin-bottom: 40px; padding-left: 10px; background: #FBF8EF; padding-top: 10px;">
				<div style="clear: both; margin-bottom: 20px;">
					<span>그룹 추가</span><br>
					<div style="clear: both; width: 120px; height: 1px; border-bottom: 2px solid black;"></div>
				</div>
				<div style="padding-left: 10px;">
					<form name="createGroupForm" method="post">
						<input type="text" name="groupName" style="width: 180px; height:27px; border: 1.2px solid #848484; border-radius: 4px; padding-left: 5px;" maxlength="10">
						<button type="button" id="createGroupButn" class="butn">추가</button>
					</form>
				</div>
			</div>
			
			<div style="width:280px; height:140px; padding-left: 10px; background: #FBF8EF; padding-top: 10px;">
				<div style="clear: both; margin-bottom: 20px;">
					<span>그룹 수정</span><br>
					<div style="clear: both; width: 120px; height: 1px; border-bottom: 2px solid black;"></div>
				</div>
				<input type="hidden" id="choosingGroupNum" value="">
				<div style="padding-left: 10px;">
					<input id="updateGroupName" type="text" style="width: 180px; height:27px; border: 1.2px solid #848484; border-radius: 4px; padding-left: 5px;" maxlength="10">
					<button type="button" id="updateGroupButn" class="butn">수정</button>
				</div>
				<div style="padding-left: 10px;">
					<div style="float: left;">
						<span style="font-size: 11px; color: #6E6E6E;">※ 왼쪽 목록에서 그룹을 선택하여<br>&nbsp;&nbsp;&nbsp; 수정할 수 있습니다.</span>
					</div>
					<div style="float: left; margin: 5px 0px 0px 18px;">
						<button type="button" id="deleteGroupButn" class="butn">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
</body>
</html>