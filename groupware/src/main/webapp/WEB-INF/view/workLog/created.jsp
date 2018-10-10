<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>

<style type="text/css">
#day, #week, #month {
	cursor: pointer;
}
</style>
<script type="text/javascript">

$(function() {
	$("#day").click(function() {
		if(confirm("내용이 저장되지 않습니다 변경 하시 겠습니까 ? ")) {
		location.href = "<%=cp%>/workLog/created?num=1";
	}
		<%-- var query = "<%=cp%>/workLog/form?num=1"; 
		$.ajax({
			type:"get",
			url: query,
			dataType:"json",
			success:function(data) {
				console.log($("#content").val());
				console.log("1");
				$("#content").val(data.dto.formValue);
				console.log($("#content").val());			
			},
			error:function(jqXHR) {
			}
		}); --%>
		
	});
});

$(function() {
	$("#week").click(function() {
		if(confirm("내용이 저장되지 않습니다 변경 하시 겠습니까 ? ")) {
			location.href = "<%=cp%>/workLog/created?num=2";
		}
<%-- 		
		var query = "<%=cp%>/workLog/created?num=2"; 
 		$.ajax({
			type:"get",
			url: query,
			dataType:"json",
			success:function(data) {
				
				console.log($("#content").val());
				console.log("2");
				$("#content").val(data.dto.formValue);
				console.log($("#content").val());
			},
			error:function(jqXHR) {
				console.log(jqXHR.responseText);
			}
		});  --%>
		
	});
});

$(function() {
	$("#month").click(function() {
		if(confirm("내용이 저장되지 않습니다 변경 하시 겠습니까 ? ")) {
			location.href = "<%=cp%>/workLog/created?num=3";
		}
	<%-- var query = "<%=cp%>/workLog/form?num=3";  
		$.ajax({
			type:"get",
			url: query,
			dataType:"json",
			success:function(data) {
				console.log($("#content").val());
				console.log("3");
				$("#content").val(data.dto.formValue);
				console.log($("#content").val());
				
			},
			error:function(jqXHR) {
				console.log(jqXHR.responseText);
			}
		}); --%>		
	});
});


function ss() {
	var f = document.workLogForm;
	alert("11111");
	alert($("#content").val());
	f.action = "<%=cp%>/workLog/created";
	return true;
}

</script>
<div>
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-book" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;업무 일지</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>

<div>
<form name="workLogForm" id= "workLogForm" method="post" enctype="multipart/form-data" onsubmit="return submitContent(this);">
<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
<td width="100" bgcolor="#eeeeee" style="text-align: center;">기안자</td>
<td style="padding-left:10px;"> 
${sessionScope.member.userId}
</td>
</tr>

<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
<td width="100" bgcolor="#eeeeee" style="text-align: center;">업무일지</td>
<td>
<span class="glyphicon glyphicon-book" style="font-size: 15px; padding-left: 20px;" id ="day">일일</span>
<span class="glyphicon glyphicon-book" style="font-size: 15px; padding-left: 20px;" id ="week">주간</span>
<span class="glyphicon glyphicon-book" style="font-size: 15px; padding-left: 20px;" id = "month">월간</span>
</td>
</tr>

<tr align="left" style="border-bottom: 1px solid #cccccc;"> 
<td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내    용</td>
<td height="870px;" valign="top" style="padding:5px 0px 5px 10px;" > 
<textarea name="content" id="content" class="boxTA" style="width: 95%; height:870px;">${dto.formValue}</textarea>
</td>
</tr>
</table>

<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
<tr height="45"> 
<td align="center" >
<button type="submit" class="btn">${mode=='update'?'수정완료':'등록하기'}</button>
<input type ="hidden" name = "memberNum" value = "${sessionScope.member.userId}">
<button type="reset" class="btn">다시입력</button>
<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/workLog/list';">${mode=='update'?'수정취소':'등록취소'}</button>
<c:if test="${mode=='update'}">
<input type="hidden" name="workLogNum" value="${dto.workLogNum}">
<input type="hidden" name="page" value="${page}">
</c:if>
<input type="hidden" id = "num" name="num" value="${dto.num}">
<input type="hidden" name="content" value ="$('content').val()">
</td>
</tr>
</table>
</form>
</div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "<%=cp%>/resource/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){	
		}
	}, 
	fOnAppLoad : function(){
		
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	

	return ss();	
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>  
</div>