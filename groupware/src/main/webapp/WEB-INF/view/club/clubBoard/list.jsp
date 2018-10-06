<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
/* 
.clubButn{
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
.clubButn:hover{
	background: #151515;
	color: #ffffff;
	cursor: pointer;
}
 */
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

</style>

<script type="text/javascript">
/* 

//스크롤바 존재여부
function checkScrollBar() {
	var hContent=jQuery("body").height();
	var hWindow=jQuery(window).height();
	if(hContent>hWindow){
		return true;
	}
	return false;
}

//스크롤 페이징
jQuery(function(){
	jQuery(window).scroll(function() {
		if(jQuery(window).scrollTop()+100>=jQuery(document).height()-jQuery(window).height()) {
			if(pageNo<totalPage) {
				++pageNo;
				listPage(pageNo);
			}
		}
	});
});

 */

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
	
	//오른쪽 manageBox
	jQuery("#hideManageBox").click(function(){
		var manageBox=jQuery("#manageBox");
		if(manageBox.css("display")=="none"){
			jQuery("#manageBox").show();
		}else{
			jQuery("#manageBox").hide();
		}
	});
	
	jQuery("#boardMainDiv").children(".separator").eq(0).remove();
});

jQuery(function(){
	jQuery(".replyDiv").hide();
	//댓글 버튼 클릭시
	jQuery(".showReplyButn").click(function(){
		var replyDiv = jQuery(this).parent("div").parent("div").parent("div").children(".replyDiv");
		if(replyDiv.css("display") == "none"){
			replyDiv.show();
		}else{
			replyDiv.hide();
		}
		var listReplyDiv=replyDiv.children(".listReply");
		var boardNum=jQuery(this).val();
		listPage(1,listReplyDiv,boardNum);
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
	jQuery(".createReplyButn").click(function(){
		if(! confirm("댓글을 생성 하시겠습니까?")){
			return;
		}
		var replyContentInput=jQuery(this).parent("div").parent("div").children(".replyContentInput");
		var replyContent=replyContentInput.val();
	    if(!replyContent) {
			alert("내용을 입력하세요.");
	       	jQuery(replyContentInput).focus();
	       	return;
	    }
		var clubNum=jQuery(this).parent("div").parent("div").children(".replyClubNumInput").val();
		var boardNum=jQuery(this).parent("div").parent("div").children(".replyBoardNumInput").val();
		var categoryNum=jQuery(this).parent("div").parent("div").children(".replyCategoryNumInput").val();
		
	    createReply(replyContent, clubNum, boardNum, categoryNum);
	});
	
	//댓글의 답글달기 버튼 클릭시
	jQuery(document).on("click",".createReplyAnswerButn",function(){
		if(! confirm("답글을 생성 하시겠습니까?")){
			return;
		}
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
		var f=document.searchForm;
		
    	var str = f.searchValue.value;
        if(!str) {
        	alert("검색어를 입력하세요.");
            f.searchValue.focus();
            return;
        }
        f.action="<%=cp%>/clubBoard/list";
        f.submit();
	});
	
	//새로고침 버튼 클릭시
	jQuery("#refreshClubBoardButn").click(function(){
		location.href="<%=cp%>/clubBoard/list?clubNum=${clubInfo.clubNum}&categoryNum=${categoryNum}";
		return;
	});
	
	//게시글 작성 버튼 클릭시
	jQuery("#createClubBoardButn").click(function(){
		location.href="<%=cp%>/clubBoard/createBoard?clubNum=${clubInfo.clubNum}&categoryNum=${categoryNum}";
		return;
	});
	
	//내가 쓴글 클릭시
	jQuery("#myBoardButn").click(function(){
		var f=document.myBoardForm;
        f.action="<%=cp%>/clubBoard/list";
        f.submit();
	});
});

//게시물 삭제 a태그 클릭시
function deleteClubBoard(boardNum){
	if(confirm("게시물을 정말 삭제하시겠습니까?")){
		location.href="<%=cp%>/clubBoard/deleteBoard?boardNum="+boardNum+"&clubNum=${clubInfo.clubNum}"
	}
	return;
}

//댓글 추가
function createReply(replyContent, clubNum, boardNum, categoryNum) {
	
	replyContent = encodeURIComponent(replyContent);
	
	var query="replyContent="+replyContent+"&clubNum="+clubNum+"&boardNum="+boardNum;
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
				listPage(1,listReplyDiv,boardNum);
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
function listPage(page,listReplyDiv,boardNum) {
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
			if(classify=="answer"){
				var state=data.state;
				if(state=="true") {
					listAnswerPage(listReplyAnswerDiv,answer);
				} else if(state=="false") {
					alert("댓글삭제에 실패했습니다.");
				}
			}else{
				if(state=="true") {
					listPage(1,listReplyDiv,boardNum);
				} else if(state=="false") {
					alert("답글삭제에 실패했습니다.");
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


<div style="width: 85%; height: auto; float: left; padding-top: 20px;">

	<div id="boardMainDiv" style="width: 1000px; clear: both; margin: 0px auto; padding-bottom: 150px; ">
		<c:if test="${empty boardList}">
			<div style="width: 100%; height: 130px; clear: both; border: 2px solid #BDBDBD; border-radius: 5px; text-align: center; padding-top: 30px; background: #FAFAFA;">
				<span style="font-size: 22px; font-weight: 400; color: #6E6E6E;">등록된 게시물이 없습니다.</span>
			</div>
		</c:if>
		<c:forEach var="dto" items="${boardList}">
			<div class="separator" style="clear: both; width: 100%; text-align: center; margin: 10px 0px; ">
				<span class="glyphicon glyphicon-minus" style="font-size: 20px; color: #A4A4A4;"></span>
			</div>
			<div style="width: 100%; clear: both; border-top:1px solid #D8D8D8; border-bottom: 2px solid #BDBDBD;">
				<%-- 게시물 내용 --%>
				<div style="width: 100%; height: 80px; border-bottom: 1.5px solid #BDBDBD; padding-left: 10px; background: #FAFAFA;">
					<div style="clear:both; width: 100%; height: 40px; margin-bottom: 10px; padding-left: 5px;">
						<span style="max-width:800px; font-size: 28px; overflow: hidden;">${dto.subject}</span>
						<c:if test="${sessionScope.member.userId==dto.memberNum}">
							<div style="float: right; padding-right: 5px;">
								<a href="<%=cp%>/clubBoard/updateBoard?boardNum=${dto.boardNum}&clubNum=${clubInfo.clubNum}&categoryNum=${categoryNum}" style="color: #424242; cursor: pointer;">수정</a>&nbsp;|
								<a onclick="deleteClubBoard(${dto.boardNum})" style="color: #424242; cursor: pointer;">삭제</a>
							</div>
						</c:if>
					</div>
					<span style="color: #848484;">작성자 : ${dto.memberName}</span>
					<span style="float: right; color: #A4A4A4; padding-right: 10px;">작성 날짜 : ${dto.created}</span>
				</div>
				<div style="width: 100%; padding: 10px; min-height: 160px;">
					${dto.content}
				</div>
				<div style="clear: both; width: 100%; height:45px; margin: 40px 0px 0px 10px;">
					<div style="float: left; width: 520px; padding-bottom: 10px">
						<button type="button" class="showReplyButn" value="${dto.boardNum}">댓글 (${dto.replyCount})</button>
						<div id="boardLikeDiv${dto.boardNum}" style="float: right;">
							<c:if test="${dto.isBoardLike==1}">
							<button type='button' onclick="cancleBoardLike(${dto.boardNum})" class='likeButn' style='background: #F78181; color: #FFFFFF;'>좋아요&nbsp;${dto.likeCount}</button>
							</c:if>
							<c:if test="${dto.isBoardLike!=1}">
							<button type='button' onclick="boardLike(${dto.boardNum})" class='likeButn'>좋아요&nbsp;${dto.likeCount}</button>
							</c:if>
						</div>
					</div>
					
					<%-- 파일첨부 --%>
					<c:if test="${not empty dto.saveFileName}">
						<div style="width: 300px; height:40px; float: right; background: #F2F2F2; margin: 5px 10px 0px 0px; padding: 10px 20px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
							<a href="<%=cp%>/clubBoard/download?boardNum=${dto.boardNum}" style="color: #585858;">
								<span class="glyphicon glyphicon-floppy-disk" style="font-size: 13px;"></span> 
								<span>${dto.originalFileName}</span>
							</a>
						</div>
					</c:if>
				</div>
				
				
				<div class="replyDiv">
					<%-- 댓글 input --%>
					<div style="width: 100%; padding: 10px 30px; border-top: 1px solid #BDBDBD;">
						<textarea class="replyContentInput" style="max-width: 100%; min-width:100%; min-height: 90px; border: 2px solid #D8D8D8; padding-left: 5px;"></textarea>
						<div style="clear: both; width: 100%; height: 30px;">
							<button type="button" class="createReplyButn" style="float: right;">댓글달기</button>
						</div>
						<input type="hidden" class="replyClubNumInput" value="${clubInfo.clubNum}">
						<input type="hidden" class="replyBoardNumInput" value="${dto.boardNum}">
						<input type="hidden" class="replyCategoryNumInput" value="${categoryNum}">
					</div>
					
					<div class="listReply" style="width: 100%; padding: 0px 30px 10px 30px; border-top: 1px solid #BDBDBD;">
					</div>
				</div>
				
			</div>
		</c:forEach>
	</div>
</div>

<div id="manageBox" style="float:right; position: fixed ; right:20px; width: 250px; height: 320px; border: 2px solid #A4A4A4; border-radius:5px; z-index: 899; background: #FFFFFF; margin-top: 30px;">
	<div style="width: 100%; height: 28px; border-bottom: 1.5px solid #D8D8D8; background:#F7F2E0; "></div>
	<div style="padding: 15px 5px;">
		<form name="searchForm" method="post">
			<select name="searchKey" style="margin-bottom: 5px;">
				<option value="subject" ${searchKey=="subject"? "selected='selected'":""}>제목</option>
				<option value="content" ${searchKey=="content"? "selected='selected'":""}>내용</option>
				<option value="all" ${searchKey=="all"? "selected='selected'":""}>제목+내용</option>
				<option value="userName" ${searchKey=="userName"? "selected='selected'":""}>작성자</option>
				<option value="created" ${searchKey=="created"? "selected='selected'":""}>등록일</option>
			</select><br> 
			<input type="text" name="searchValue" style="width: 180px; height: 27px;">
			<button class="clubButn" id="searchButn">검색</button>
			<div style="width: 100%; text-align: center; padding-top: 20px;">
				<button type="button" id="refreshClubBoardButn" class="clubBoardManageButn">새로고침</button>
			</div>
			<input type="hidden" name="clubNum" value="${clubInfo.clubNum}">
			<input type="hidden" name="categoryNum" value="${categoryNum}">
		</form>
		
		<div style="margin:10px 15px; border-bottom:1px solid #D8D8D8;"></div>
		
		<div style="width: 100%; text-align: center; padding-top: 15px;">
			<button type="button" id="createClubBoardButn" class="clubBoardManageButn">게시글 작성</button>
		</div>
		<div style="width: 100%; text-align: center; padding-top: 15px;">
			<form name="myBoardForm" method="post">
				<button type="button" id="myBoardButn" class="clubBoardManageButn">내가 쓴글</button>
				<input type="hidden" name="searchKey" value="userId">
				<input type="hidden" name="searchValue" value="${sessionScope.member.userId}">
				<input type="hidden" name="clubNum" value="${clubInfo.clubNum}">
				<input type="hidden" name="categoryNum" value="${categoryNum}">
			</form>
		</div>
	</div>
</div>

<div id="hideManageBox">
	<span class="glyphicon glyphicon-menu-hamburger" style="font-size: 18px; color: #848484;"></span>
</div>






