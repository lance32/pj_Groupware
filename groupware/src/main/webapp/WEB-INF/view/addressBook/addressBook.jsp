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
.addressList{
 	line-height: 50px; 
 	text-align:center;
 	 float: left; 
}

</style>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.css" type="text/css">
<script type="text/javascript">
jQuery(function(){
	jQuery("#addressInfo").hide();
	
	//연락처 클릭시 정보보기 AJAX
	jQuery(".address").click(function(){
		jQuery("#infoContent").empty();
		jQuery("#infoButn").empty();
		jQuery(".address").css("border-left","2px solid #F2F2F2");
		jQuery(this).css("border-left","none");
		
		var addressBookNum=jQuery(this).children("input").val();
		if(! addressBookNum){
			alert("연락처의 정보가 없습니다.");
			jQuery(".address").css("border-left","2px solid #F2F2F2");
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
				jQuery("#infoButn").append("<button type='button' class='butn' style='float:left; margin-left: 10px;'>수정</button>");
				jQuery("#infoButn").append("<button id='deleteAddressButn' value='"+data.addressBookNum+"' type='button' class='butn' style='float:right; margin-right: 20px;'>삭제</button>");
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
			<div id="infoContent" style='width: 100%; height: 400px;'> 
			 </div>
			 <div id="infoButn" style='width: 100%; height: 50px;'>	
			 </div>
		</div>
	</div>
	<div style="width: 400px; height: 460px; float: left;  border-right: 2px solid #E6E6E6; border-bottom: 2px solid #E6E6E6;">
		<div style="width: 100%; height:458px; float: left; overflow-y:scroll; background: #F2F2F2; padding: 3px 0px 3px 0px;">
			<c:forEach var="dto" items="${list}">
				<div class="address">
					<div class="addressList" style="width: 30%;">${dto.name}</div>
					<div class="addressList" style="width: 30%;">${dto.groupName}</div>
					<div class="addressList" style="width: 40%;">${dto.tel}</div>
					<input type="hidden" value="${dto.addressBookNum}">
				</div>
			</c:forEach>
		</div>
		
	</div>
	<div style="clear: both; width: 100%; height: 40px; padding-right: 5px;">
		<button id="addAdressButn" type="button" class="butn" style="margin: 5px 0px 0px 5px; float: right;">추가</button>
	
	</div>
	
</div>

</body>
</html>