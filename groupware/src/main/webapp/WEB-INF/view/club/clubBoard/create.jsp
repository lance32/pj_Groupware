<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<%-- 
작성자 readonly
카테고리 선택
제목
내용
파일첨부
스마트에디터 사용.
--%>
<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>



<div style="clear: both; margin: 10px 0px 40px 70px;">
	<span class="glyphicon glyphicon-pencil" style="font-size: 28px; margin-left: 10px;"></span> 
	<span style="font-size: 30px;">&nbsp;게시글 작성</span><br>
	<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>

<div style="width: 1200px; margin: 0px 0px 0px 80px;">

	<div style="clear:both; width: 100%; height: 40px; border-top: 2px solid #BDBDBD; line-height: 37px; vertical-align: middle;">
		<div style="float: left; width: 200px; height: 100%; background: #F2F2F2; font-weight: 600;padding-left: 20px; margin-right: 30px;">카테고리 선택</div>
		<select style="width:150px;"></select>
	</div>
	<div style="clear:both; width: 100%; height: 40px; border-top: 1px solid #BDBDBD; line-height: 37px; vertical-align: middle;">
		<div style="float: left; width: 200px; height: 100%; background: #F2F2F2; font-weight: 600;padding-left: 20px; margin-right: 30px;">제목</div>
		<input type="text" style="width: 700px; height: 25px;">
	</div>
	<div style="clear:both; width: 100%; border-top: 1px solid #BDBDBD; border-bottom: 1px solid #BDBDBD;">
		<textarea name="content" id="content" style="width: 100%; height: 300px;"></textarea>		
	</div>
	<div style="clear:both; width: 100%; min-height:50px; height:auto; border-bottom: 2px solid #BDBDBD; display: flex;">
		<div style="float: left; width: 200px; display: flex; background: #F2F2F2; font-weight: 600; padding:10px 20px; margin-right: 40px;">파일 첨부</div>
		<div style="float: left; width: 900px; padding-top: 10px;">
			<input type="file" style="margin-bottom: 10px;">
			<input type="file" style="margin-bottom: 10px;">
		</div>
	</div>
		
	<div style="clear:both; width: 100%; height: 60px; padding: 10px 5px;">
		<button type="button" class="clubButn">초기화</button>
		<button type="button" class="clubButn" style="float: right; margin-left: 10px;">등록취소</button>
		<button type="button" class="clubButn" style="float: right;">등록하기</button>
	</div>
</div>


<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "<%=cp%>/resource/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//alert("아싸!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.</span>";
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>  
