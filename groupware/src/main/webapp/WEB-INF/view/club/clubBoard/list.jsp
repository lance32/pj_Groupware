<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.clubBoardManageButn{
	width: 90%;
	height: auto;
	padding: 5px 10px;
	border-radius: 5px;
	background: #FAFAFA;
	color: #848484;
	border:none;
	border: 2px solid #A4A4A4;
	outline: 0;
	font-size: 15px;
}
.clubBoardManageButn:hover{
	border: 2px solid #848484;
	background:#E6E6E6;
	color: #000000;
}

.showReplyButn{
	width: auto;
	height: auto;
	padding: 5px 10px;
	border-radius: 1px;
	background: #FAFAFA;
	color: #848484;
	border:none;
	border: 2px solid #A4A4A4;
	outline: 0;
	font-size: 15px;
}
.showReplyButn:hover{
	border: 2px solid #848484;
	background:#F2F2F2;
	color: #000000;
}

.showReplyAnswerButn{
	width: auto;
	height: auto;
	padding: 3px 5px;
	border-radius: 1px;
	background: #FAFAFA;
	color: #848484;
	border:none;
	border: 2px solid #A4A4A4;
	outline: 0;
	font-size: 13px;
}
.showReplyAnswerButn:hover{
	border: 2px solid #848484;
	background:#F2F2F2;
	color: #000000;
}

.likeButn{
	width: auto;
	height: auto;
	padding: 5px 10px;
	border-radius: 4px;
	background: #FFFFFF;
	color: #848484;
	border:none;
	border: 2px solid #F5A9A9;
	outline: 0;
	font-size: 15px;
}

.createReplyButn{
	width: auto;
	height: auto;
	padding: 5px 10px;
	border-radius: 5px;
	background: #424242;
	color: #F2F2F2;
	border:none;
	outline: 0;
	font-size: 15px;
}
.createReplyButn:hover{
	background: #151515;
	color: #ffffff;
	cursor: pointer;
}

.createReplyAnswerButn{
	width: auto;
	height: auto;
	padding: 5px 10px;
	border-radius: 5px;
	background: #424242;
	color: #F2F2F2;
	border:none;
	outline: 0;
	font-size: 15px;
}
.createReplyAnswerButn:hover{
	background: #151515;
	color: #ffffff;
	cursor: pointer;
}

#hideManageBox{
	position: fixed; 
	right:20px; 
	width: 30px; 
	height: 30px; 
	border: 2px solid #BDBDBD; 
	border-radius:5px; 
	z-index: 900; 
	margin-top: 30px; 
	text-align: center; 
	line-height: 28px; 
	cursor: pointer;
	background: #FFFFFF;
}
#hideManageBox:hover{
	background: #F2F2F2;
}

.moreListDiv{
	width: 1000px; 
	height:50px; 
	margin: 0px auto; 
	clear: both; 
	text-align: center; 
	border: 2px solid #D8D8D8; 
	background: #FAFAFA; 
	font-size: 20px; 
	font-weight: 600; 
	color: #585858; 
	padding-top: 5px;
	cursor: pointer;
}
.moreListDiv:hover{
	border: 2px solid #BDBDBD; 
	background: #F2F2F2; 
	color: #424242; 
}
</style>

<script type="text/javascript">
var pageNo=${pageNo};

jQuery(function(){
	listPage(pageNo,'','','');
});

//게시물 리스트
 function listPage(page,searchKey,searchValue,state) {
 	var url="<%=cp%>/clubBoard/listBoard";
 	var query="pageNo="+page+"&clubNum=${clubInfo.clubNum}&categoryNum=${categoryNum}&searchKey="+searchKey+"&searchValue="+searchValue+"&state="+state;
 	
 	jQuery.ajax({
 		type:"get"
 		,url:url
 		,data:query
 		,success:function(data) {
 			jQuery("#boardMainDiv").empty();
 			jQuery("#boardMainDiv").html(data);
 			jQuery("#boardMainDiv").children(".separator").eq(0).remove();
 		}
 	    ,beforeSend :function(jqXHR) {
 	    	jqXHR.setRequestHeader("AJAX", true);
 	    }
 	    ,error:function(jqXHR) {
 	    	if(jqXHR.status==403) {
 	    		login();
 	    		return;
 	    	}
 	    	console.log(jqXHR.responseText);
 	    }
 	});
 }

 jQuery(function(){
	//창크기가 1630으로 줄어들때
	jQuery(window).resize(function() {
		windowWidth=jQuery(this).width();
		if(windowWidth<1600){
			jQuery("#manageBox").hide();
		}else{
			jQuery("#manageBox").show();
		}
	});
		
	//오른쪽 manageBox 줄3개 영역 클릭시
	jQuery("#hideManageBox").click(function(){
		var manageBox=jQuery("#manageBox");
		if(manageBox.css("display")=="none"){
			jQuery("#manageBox").show();
		}else{
			jQuery("#manageBox").hide();
		}
	});
	
	//선택된 카테고리 백그라운드 추가
	jQuery(document).on("ready", function(){
		jQuery("#li${categoryNum}").css("background","#D8D8D8");
	});
	
 });
 
jQuery(function(){
	//댓글 버튼 클릭시
	jQuery(document).on("click", ".showReplyButn", function(){
		var replyDiv = jQuery(this).parent("div").parent("div").parent("div").children(".replyDiv");
		if(replyDiv.css("display") == "none"){
			replyDiv.show();
		}else{
			replyDiv.hide();
		}
		var listReplyDiv=replyDiv.children(".listReply");
		var boardNum=jQuery(this).val();
		listReplyPage(1,listReplyDiv,boardNum);
	});
	
	//댓글의 답글 버튼 클릭시
	jQuery(document).on("click", ".showReplyAnswerButn", function(){
		var replyAnswerDiv = jQuery(this).parent("div").parent("div").next(".replyAnswerDiv");
		if(replyAnswerDiv.css("display") == "none"){
			replyAnswerDiv.show();
		}else{
			replyAnswerDiv.hide();
		}
		var answer=jQuery(this).val();
		var listReplyAnswerDiv=replyAnswerDiv.children(".listReplyAnswer");
			
		listAnswerPage(listReplyAnswerDiv,answer);
	});
	
	//댓글달기 버튼 클릭시
	jQuery(document).on("click", ".createReplyButn", function(){
		var replyContentInput=jQuery(this).parent("div").parent("div").children(".replyContentInput");
		var replyContent=replyContentInput.val();
	    if(!replyContent) {
			alert("내용을 입력하세요.");
	       	jQuery(replyContentInput).focus();
	       	return;
	    }
		var boardNum=jQuery(this).parent("div").parent("div").children(".replyBoardNumInput").val();
		
	    createReply(replyContent, boardNum);
	});
	
	//댓글의 답글달기 버튼 클릭시
	jQuery(document).on("click",".createReplyAnswerButn",function(){
		var replyContentInput=jQuery(this).parent("div").parent("div").children(".replyAnswerContent");
		var replyContent=replyContentInput.val();
	    if(!replyContent) {
			alert("내용을 입력하세요.");
	       	jQuery(replyContentInput).focus();
	       	return;
	    }
		var clubNum="${clubInfo.clubNum}";
		var boardNum=jQuery(this).parent("div").parent("div").children(".replyAnswerBoardNum").val();
		var answer=jQuery(this).val();
		
		createReplyAnswer(replyContent, clubNum, boardNum, answer);
	});
	
	
	//검색 버튼 클릭시
	jQuery("#searchButn").click(function(){
		searchKey=jQuery("#searchKey").val();
		searchValue=jQuery("#searchValue").val();
		if(! searchValue){
			alert("검색어를 입력하세요.");
			searchValue.focus();
			return;
		}
		listPage(1,searchKey,searchValue,'');
		jQuery("#searchValue").val("");
	});
	
	//새로고침 버튼 클릭시
	jQuery("#refreshClubBoardButn").click(function(){
		location.href="<%=cp%>/clubBoard/list?clubNum=${clubInfo.clubNum}&categoryNum=${categoryNum}";
		return;
	});
	
	//게시글 작성 버튼 클릭시
	jQuery("#createClubBoardButn").click(function(){
		var categoryAuthority="${categoryAuthority}";
		var founder="${clubInfo.memberNum}";
		var userId="${sessionScope.member.userId}";
		if(categoryAuthority==1 && founder!=userId){
			alert("이 게시판은 동호회 관리자만 글작성이 허용됩니다.");
			return;
		}
		location.href="<%=cp%>/clubBoard/createBoard?clubNum=${clubInfo.clubNum}&categoryNum=${categoryNum}";
		return;
	});
	
	//내가 쓴글 클릭시
	jQuery("#myBoardButn").click(function(){
		searchKey="userId";
		searchValue="${sessionScope.member.userId}";
		listPage(1,searchKey,searchValue,'');
	});
	
});


//수정 완료시 그 게시물로 스크롤 이동
var mode="${modeScroll}";
var boardNum="${updateBoardNum}";
function scrollUpdateComplete(boardNum){
	var offset = jQuery("#boardDiv"+boardNum).offset();
  	jQuery("html, body").animate({scrollTop: (offset.top-200)}, 500);
}

//게시물 삭제 a태그 클릭시
function deleteClubBoard(boardNum){
	if(confirm("게시물을 정말 삭제하시겠습니까?")){
		location.href="<%=cp%>/clubBoard/deleteBoard?boardNum="+boardNum+"&clubNum=${clubInfo.clubNum}"
	}
}

//댓글 추가
function createReply(replyContent, boardNum) {
	
	replyContent = encodeURIComponent(replyContent);
	
	var query="replyContent="+replyContent+"&clubNum=${clubInfo.clubNum}&boardNum="+boardNum;
	var url="<%=cp%>/clubBoard/insertReply";
	var listReplyDiv=jQuery(".showReplyButn[value="+boardNum+"]").parent("div").parent("div").parent("div").children(".replyDiv").children(".listReply");
	
	jQuery.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			jQuery(".replyContentInput").val("");
			
			var state=data.state;
			if(state=="true") {
				listReplyPage(1,listReplyDiv,boardNum);
				var count=jQuery(".showReplyButn[value="+boardNum+"]").children("span").text();
				count = parseInt(count)+1;
				jQuery(".showReplyButn[value="+boardNum+"]").children("span").empty();
				jQuery(".showReplyButn[value="+boardNum+"]").children("span").html(count);
			} else if(state=="false") {
				alert("댓글추가에 실패했습니다.");
			}
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

//댓글 리스트
function listReplyPage(page,listReplyDiv,boardNum) {
	var url="<%=cp%>/clubBoard/listReply";
	var query="boardNum="+boardNum+"&pageNo="+page;
	
	jQuery.ajax({
		type:"get"
		,url:url
		,data:query
		,success:function(data) {
			jQuery(listReplyDiv).html(data);
		}
	    ,beforeSend :function(jqXHR) {
	    	jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

//댓글 삭제
function deleteReply(replyNum,boardNum,memberNum,classify,answer) {
	if(! confirm("댓글을 삭제 하시겠습니까?")){
		return;
	}
	var query="replyNum="+replyNum+"&boardNum="+boardNum+"&memberNum="+memberNum;
	var url="<%=cp%>/clubBoard/deleteReply";
	var listReplyDiv=jQuery(".showReplyButn[value="+boardNum+"]").parent("div").parent("div").parent("div").children(".replyDiv").children(".listReply");
	var listReplyAnswerDiv=jQuery(".showReplyAnswerButn[value="+answer+"]").parent("div").parent("div").parent("div").children(".replyAnswerDiv").children(".listReplyAnswer");
	
	jQuery.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(classify=="answer"){
				if(state=="true") {
					listAnswerPage(listReplyAnswerDiv,answer);
					var count=jQuery(".showReplyAnswerButn[value="+answer+"]").children("span").text();
					count=parseInt(count)-1;
					jQuery(".showReplyAnswerButn[value="+answer+"]").children("span").empty();
					jQuery(".showReplyAnswerButn[value="+answer+"]").children("span").html(count);
				} else if(state=="false") {
					alert("답글삭제에 실패했습니다.");
				}
			}else{
				if(state=="true") {
					listReplyPage(1,listReplyDiv,boardNum);
					var count=jQuery(".showReplyButn[value="+boardNum+"]").children("span").text();
					count=parseInt(count)-1;
					jQuery(".showReplyButn[value="+boardNum+"]").children("span").empty();
					jQuery(".showReplyButn[value="+boardNum+"]").children("span").html(count);
				} else if(state=="false") {
					alert("댓글삭제에 실패했습니다.");
				}
			}
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

//댓글의 답글 추가
function createReplyAnswer(replyContent, clubNum, boardNum, answer){
	replyContent = encodeURIComponent(replyContent);
	
	var query="replyContent="+replyContent+"&clubNum="+clubNum+"&answer="+answer+"&boardNum="+boardNum;
	var url="<%=cp%>/clubBoard/insertReplyAnswer";
	var listReplyAnswerDiv=jQuery(".showReplyAnswerButn[value="+answer+"]").parent("div").parent("div").parent("div").children(".replyAnswerDiv").children(".listReplyAnswer");
	
	jQuery.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			jQuery(".replyAnswerContent").val("");
			
			var state=data.state;
			if(state=="true") {
				listAnswerPage(listReplyAnswerDiv,answer);
				var count=jQuery(".showReplyAnswerButn[value="+answer+"]").children("span").text();
				count=parseInt(count)+1;
				jQuery(".showReplyAnswerButn[value="+answer+"]").children("span").empty();
				jQuery(".showReplyAnswerButn[value="+answer+"]").children("span").html(count);
			} else if(state=="false") {
				alert("답글추가에 실패했습니다.");
			}
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

//댓글의 답글 리스트
function listAnswerPage(listReplyAnswerDiv,answer) {
	var url="<%=cp%>/clubBoard/listReplyAnswer";
	var query="answer="+answer;
	
	jQuery.ajax({
		type:"get"
		,url:url
		,data:query
		,success:function(data) {
			jQuery(listReplyAnswerDiv).html(data);
		}
	    ,beforeSend :function(jqXHR) {
	    	jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

//게시물 좋아요
function boardLike(boardNum) {
	var url="<%=cp%>/clubBoard/insertBoardLike";
	var clubNum="${clubInfo.clubNum}";
	var query="boardNum="+boardNum+"&clubNum="+clubNum;
	
	jQuery.ajax({
		type:"post"
		,url:url
		,data:query
		,success:function(data) {
			var state=data.state;
			if(state=="true") {
				var count = data.likeCount;
				jQuery("#boardLikeDiv"+boardNum).html("<button type='button' onclick='cancleBoardLike("+boardNum+")' class='likeButn' style='background: #F78181; color: #FFFFFF;'>좋아요&nbsp;"+count+"</button>");
			} else if(state=="moreLike"){
				alert("좋아요는 한번만 입력 가능합니다.");
			}else if(state=="false"){
				alert("좋아요 입력에 실패 했습니다.");
			}
		}
	    ,beforeSend :function(jqXHR) {
	    	jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

//게시물 좋아요 취소
function cancleBoardLike(boardNum) {
	var url="<%=cp%>/clubBoard/cancleBoardLike";
	var clubNum="${clubInfo.clubNum}";
	var query="boardNum="+boardNum+"&clubNum="+clubNum;
	
	jQuery.ajax({
		type:"post"
		,url:url
		,data:query
		,success:function(data) {
			var state=data.state;
			if(state=="true") {
				var count = data.likeCount;
				jQuery("#boardLikeDiv"+boardNum).html("<button type='button' onclick='boardLike("+boardNum+")' class='likeButn'>좋아요&nbsp;"+count+"</button>");
			} else if(state=="false"){
				alert("좋아요 취소에 실패했습니다.");
			}
		}
	    ,beforeSend :function(jqXHR) {
	    	jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}
</script>

<div style="width: 85%; height: auto; float: left; padding-top: 20px; margin-bottom: 10px;">
	<div id="preListDiv" class="moreListDiv" style="margin-bottom: 50px;">이전글 보기</div>
	
	<div id="boardMainDiv" style="width: 1000px; clear: both; margin: 0px auto; padding-bottom: 50px; ">
	</div>
	
	<div id="nextListDiv" class="moreListDiv">더 보기</div>
</div>

<div id="manageBox" style="float:right; position: fixed ; right:20px; width: 250px; height: 320px; border: 2px solid #A4A4A4; border-radius:5px; z-index: 899; background: #FFFFFF; margin-top: 30px;">
	<div style="width: 100%; height: 28px; border-bottom: 1.5px solid #D8D8D8; background:#F7F2E0; "></div>
	<div style="padding: 15px 5px;">
		<select id="searchKey" name="searchKey" style="margin-bottom: 5px;">
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<option value="all">제목+내용</option>
			<option value="userName">작성자</option>
			<option value="created">등록일</option>
		</select><br> 
		<input id="searchValue" type="text" name="searchValue" style="width: 180px; height: 27px;">
		<button class="clubButn" id="searchButn">검색</button>
		<div style="width: 100%; text-align: center; padding-top: 20px;">
			<button type="button" id="refreshClubBoardButn" class="clubBoardManageButn">새로고침</button>
		</div>
		
		<div style="margin:10px 15px; border-bottom:1px solid #D8D8D8;"></div>
		
		<div style="width: 100%; text-align: center; padding-top: 15px;">
			<button type="button" id="createClubBoardButn" class="clubBoardManageButn">게시글 작성</button>
		</div>
		<div style="width: 100%; text-align: center; padding-top: 15px;">
			<button type="button" id="myBoardButn" class="clubBoardManageButn">내가 쓴글</button>
		</div>
	</div>
</div>

<div id="hideManageBox">
	<span class="glyphicon glyphicon-menu-hamburger" style="font-size: 18px; color: #848484;"></span>
</div>




