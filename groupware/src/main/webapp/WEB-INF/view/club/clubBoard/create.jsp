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
<style>
#categorySelect{
	width:150px;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
jQuery(function(){
	//카테고리 자동 선택
	jQuery("#categorySelect").val("${categoryNum}").prop("selected", true);
	
	//등록취소 버튼 클릭시
	jQuery("#CancleButn").click(function(){
		location.href="<%=cp%>/clubBoard/list?clubNum=${clubInfo.clubNum}&categoryNum=${categoryNum}";
		return;
	});
	
	//초기화 버튼 클릭시
	jQuery("#resetButn").click(function(){
		document.boardForm.reset();
		jQuery("#categorySelect").val("${categoryNum}").prop("selected", true);
		var resetContent="${BoardInfo.content}";
		SEresetContent(resetContent);
	});
	
	jQuery("#inputFileDiv").hide();
	//첨부된 파일에서 삭제 버튼 클릭시
	jQuery("#deleteFileButn").click(function(){
		jQuery("#insertedFileDiv").hide();
		jQuery("#inputFileDiv").show();
		jQuery("#inputTagDiv").append("<input name='upload' type='file' style='margin-bottom: 10px;'>");
		jQuery("#inputTagDiv").append("<input name='isDeleteFile' type='hidden' value='true'>");
	});
	
});

function check() {
    var f = document.boardForm;

	var str = f.subject.value;
    if(!str) {
		alert("제목을 입력하세요.");
        f.subject.focus();
        return false;
    }
	str = f.content.value;
    if(!str || str=="<p>&nbsp;</p>") {
		alert("내용을 입력하세요.");
        return false;
    }
    if(! confirm("작업을 완료하시겠습니까?")){
        return false;
    }
    if(${mode}=='update'){
		f.action="<%=cp%>/clubBoard/updateBoard?pageNo=${pageNo}";
    }else{
		f.action="<%=cp%>/clubBoard/createBoard";
    }
    return true;
}

</script>


<div style="clear: both; margin: 10px 0px 40px 70px;">
	<span class="glyphicon glyphicon-pencil" style="font-size: 28px; margin-left: 10px;"></span> 
	<span style="font-size: 30px;">&nbsp;게시글 <c:if test="${mode=='create'}">작성</c:if><c:if test="${mode=='update'}">수정</c:if></span><br>
	<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>

<div style="width: 1200px; margin: 0px 0px 0px 80px;">
	<form name="boardForm" method="post" onsubmit="return submitContents(this);" enctype="multipart/form-data">
		<div style="clear:both; width: 100%; height: 40px; border-top: 2px solid #BDBDBD; line-height: 37px; vertical-align: middle;">
			<div style="float: left; width: 200px; height: 100%; background: #F2F2F2; font-weight: 600;padding-left: 20px; margin-right: 30px;">카테고리 선택</div>
			<select id="categorySelect" name="categoryNum" ${mode=="update" ? "disabled='disabled' style='background: #E6E6E6;'" : ""} >
				<c:forEach var="dto" items="${clubCategoryItem}">
					<option value="${dto.categoryNum}">${dto.categoryName}</option>
				</c:forEach>
			</select>
		</div>
		<div style="clear:both; width: 100%; height: 40px; border-top: 1px solid #BDBDBD; line-height: 37px; vertical-align: middle;">
			<div style="float: left; width: 200px; height: 100%; background: #F2F2F2; font-weight: 600;padding-left: 20px; margin-right: 30px;">제목</div>
			<input name="subject" type="text" style="width: 700px; height: 25px;" maxlength="20" value="${BoardInfo.subject}">
		</div>
		<div style="clear:both; width: 100%; border-top: 1px solid #BDBDBD; border-bottom: 1px solid #BDBDBD;">
			<textarea name="content" id="content" style="width: 100%; min-height: 400px;">${BoardInfo.content}</textarea>		
		</div>
		<c:if test="${empty BoardInfo.originalFileName}">
		<div style="clear:both; width: 100%; min-height:50px; height:auto; border-bottom: 2px solid #BDBDBD; display: flex;">
			<div style="float: left; width: 200px; display: flex; background: #F2F2F2; font-weight: 600; padding:10px 20px; margin-right: 40px;">파일 첨부</div>
			<div style="float: left; width: 900px; padding-top: 10px;">
				<input name="upload" type="file" style="margin-bottom: 10px;">
				<input name='isDeleteFile' type='hidden' value='none'>
			</div>
		</div>
		</c:if>
		<c:if test="${not empty BoardInfo.originalFileName}">
		<div id="insertedFileDiv" style="clear:both; width: 100%; min-height:50px; height:auto; border-bottom: 2px solid #BDBDBD; display: flex;">
			<div style="float: left; width: 200px; display: flex; background: #F2F2F2; font-weight: 600; padding:10px 20px; margin-right: 40px;">첨부된 파일</div>
			<div style="float: left; width: 900px; padding-top: 10px;">
				<span class="glyphicon glyphicon-floppy-disk" style="font-size: 13px;"></span> 
				${BoardInfo.originalFileName}
				<button id="deleteFileButn" type="button" style="margin-left: 10px;">삭제</button>
			</div>
		</div>
		<div id="inputFileDiv" style="clear:both; width: 100%; min-height:50px; height:auto; border-bottom: 2px solid #BDBDBD; display: flex;">
			<div style="float: left; width: 200px; display: flex; background: #F2F2F2; font-weight: 600; padding:10px 20px; margin-right: 40px;">파일 첨부</div>
			<div id="inputTagDiv" style="float: left; width: 900px; padding-top: 10px;">   </div>
		</div>
		</c:if>
			
		<div style="clear:both; width: 100%; height: 60px; padding: 10px 5px;">
			<button id="resetButn" type="button" class="clubButn">초기화</button>
			<button id="CancleButn" type="button" class="clubButn" style="float: right; margin-left: 10px;">
				<c:if test="${mode=='create'}">등록취소</c:if>
				<c:if test="${mode=='update'}">수정취소</c:if>
			</button>
			<button type="submit" class="clubButn" style="float: right;">
				<c:if test="${mode=='create'}">등록하기</c:if>
				<c:if test="${mode=='update'}">수정완료</c:if>
			</button>
		</div>
		<input type="hidden" name="memberNum" value="${sessionScope.member.userId}">
		<input type="hidden" name="clubNum" value="${clubInfo.clubNum}">
		<c:if test="${mode=='update'}">
			<input type="hidden" name="boardNum" value="${BoardInfo.boardNum}">
			<input type="hidden" name="saveFileName" value="${BoardInfo.saveFileName}">
		</c:if>
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

//초기화
function SEresetContent(resetContent){
	oEditors.getById["content"].exec("SET_IR", [""]);
	oEditors.getById["content"].exec("PASTE_HTML", [resetContent]);
}
</script>  
