<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
</script>


<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>


	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-book" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;업무 일지</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>

<div>
<form name="workLogForm" method="post" enctype="multipart/form-data" onsubmit="return submitContent(this);">
<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">

<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
<td width="100" bgcolor="#eeeeee" style="text-align: center;">기안자</td>
<td style="padding-left:10px;"> 
${sessionScope.member.userName}
</td>
</tr>

<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
<td width="100" bgcolor="#eeeeee" style="text-align: center;">업무일지</td>
<td><span class="glyphicon glyphicon-book" style="font-size: 15px;">1</span></td>
<td><span class="glyphicon glyphicon-book" style="font-size: 15px;">2</span></td>
<td><span class="glyphicon glyphicon-book" style="font-size: 15px;">3</span></td>
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
<input type="hidden" name="num" value="${dto.num}">
<input type="hidden" name="page" value="${page}">
</c:if>
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
//oEditors.getByIdcontent.exec("PASTE_HTML", "로딩이 완료된 후에 본문에 삽입되는 text);
},

fCreator: "createSEditor2"
});

function pasteHTML() {
var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입<\/span>";
oEditors.getByIdcontent.exec("PASTE_HTML", sHTML);
}

function showHTML() {
var sHTML = oEditors.getByIdcontent.getIR();
alert(sHTML);
}

function submitContents(elClickedObj) {
oEditors.getByIdcontent.exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용
// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리.
try {
// elClickedObj.form.submit();

} catch(e) {}
}

function setDefaultFont() {
var sDefaultFont = '돋움';
var nFontSize = 24;
oEditors.getByIdcontent.setDefaultFont(sDefaultFont, nFontSize);
}
</script> 


