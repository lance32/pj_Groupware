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
</style>

<script type="text/javascript">

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
	
	//댓글달기 버튼 클릭시
	jQuery(".createReplyButn").click(function(){
		if(! confirm("댓글을 생성 하시겠습니까?")){
			return;
		}
		
		var replyContent=jQuery("#replyContentInput").val();
	    if(!replyContent) {
			alert("내용을 입력하세요.");
	       	jQuery("#replyContentInput").focus();
	       	return;
	    }
		var clubNum=jQuery("#replyClubNumInput").val();
		var boardNum=jQuery("#replyBoardNumInput").val();
		var categoryNum=jQuery("#replyCategoryNumInput").val();
		
	    createReply(replyContent, clubNum, boardNum, categoryNum);
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
	
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			jQuery("#replyContentInput").val("");
			
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
function deleteReply(replyNum,boardNum,memberNum) {
	if(! confirm("댓글을 삭제 하시겠습니까?")){
		return;
	}
	
	var query="replyNum="+replyNum+"&boardNum="+boardNum+"&memberNum="+memberNum;
	var url="<%=cp%>/clubBoard/deleteReply";
	var listReplyDiv=jQuery(".showReplyButn[value="+boardNum+"]").parent("div").parent("div").parent("div").children(".replyDiv").children(".listReply");
	
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(state=="true") {
				listPage(1,listReplyDiv,boardNum);
			} else if(state=="false") {
				alert("댓글삭제에 실패했습니다.");
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

</script>


<div style="width: 85%; height: auto; float: left; padding-top: 20px;">

	<div style="width: 1000px; clear: both; margin: 0px auto; ">
		<c:forEach var="dto" items="${boardList}">
			<div style="width: 100%; clear: both; margin-bottom: 30px; border-top:1px solid #D8D8D8; border-bottom: 2px solid #D8D8D8;">
				<%-- 게시물 내용 --%>
				<div style="width: 100%; height: 80px; border-bottom: 1.5px solid #BDBDBD; padding-left: 10px; background: #FAFAFA;">
					<div style="clear:both; width: 100%; height: 40px; margin-bottom: 10px; padding-left: 10px;">
						<span style="max-width:800px; font-size: 30px; overflow: hidden;">${dto.subject}</span>
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
						<button type="button" class="showReplyButn" value="${dto.boardNum}">댓글 (0)</button>
						<button type="button" class="likeButn" style="float: right;">좋아요&nbsp;3</button>
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
						<textarea id="replyContentInput" style="max-width: 100%; min-width:100%; min-height: 90px; border: 2px solid #D8D8D8; padding-left: 5px;"></textarea>
						<div style="clear: both; width: 100%; height: 30px;">
							<button type="button" class="createReplyButn" style="float: right;">댓글달기</button>
						</div>
						<input type="hidden" id="replyClubNumInput" value="${clubInfo.clubNum}">
						<input type="hidden" id="replyBoardNumInput" value="${dto.boardNum}">
						<input type="hidden" id="replyCategoryNumInput" value="${categoryNum}">
					</div>
					
					<div class="listReply" style="width: 100%; padding: 0px 30px 10px 30px; border-top: 1px solid #BDBDBD;">
					</div>
				</div>
				
			</div>
		</c:forEach>
	
	</div>
</div>

<div style="float:right; position: fixed ; right:20px; width: 250px; height: 270px; border: 2px solid #A4A4A4; border-radius:5px; z-index: 900; background: #FFFFFF; margin-top: 30px;">
	<div style="width: 100%; height: 25px; padding-top: 5px; border-bottom: 1.5px solid #D8D8D8;">
	
	</div>
	<div style="padding: 10px 5px;">
		<select></select><br>
		<input type="text" style="width: 180px;">
		<button class="clubButn">검색</button>
		<div style="width: 100%; text-align: center; padding-top: 10px;">
			<button type="button" id="refreshClubBoardButn" class="clubBoardManageButn">새로고침</button>
		</div>
		
		<div style="margin:15px 15px; border-bottom:1px solid #D8D8D8;"></div>
		
		<div style="width: 100%; text-align: center; padding-top: 5px;">
			<button type="button" id="createClubBoardButn" class="clubBoardManageButn">게시글 작성</button>
		</div>
	</div>
	내가쓴글
	
</div>









