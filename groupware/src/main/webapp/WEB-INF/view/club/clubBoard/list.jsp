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
	background: #FAFAFA;
	color: #848484;
	border:none;
	border: 2px solid #F5A9A9;
	outline: 0;
	font-size: 15px;
}
</style>

<script type="text/javascript">

jQuery(function(){
	jQuery(".replyListDiv").hide();
	jQuery(".replyAnswerDiv").hide();
	
	//댓글 버튼 클릭시
	jQuery(".showReplyButn").click(function(){
		var replyDiv = jQuery(this).parent("div").parent("div").parent("div").children(".replyListDiv");
		if(replyDiv.css("display") == "none"){
			replyDiv.show();
		}else{
			replyDiv.hide();
		}
	});
	
	//댓글의 답글 버튼 클릭시
	jQuery(".showReplyAnswerButn").click(function(){
		var replyAnswerDiv = jQuery(this).parent("div").parent("div").parent("div").children(".replyAnswerDiv");
		if(replyAnswerDiv.css("display") == "none"){
			replyAnswerDiv.show();
		}else{
			replyAnswerDiv.hide();
		}
	});
	
//---
	
	//게시글 작성 버튼 클릭시
	jQuery("#createClubBoardButn").click(function(){
		location.href="<%=cp%>/clubBoard/createBoard?clubNum=${clubInfo.clubNum}&categoryNum=${categoryNum}";
		return;
	});
	
});

//삭제 a태그 클릭시
function deleteClubBoard(boardNum){
	if(confirm("게시물을 정말 삭제하시겠습니까?")){
		location.href="<%=cp%>/clubBoard/deleteBoard?boardNum="+boardNum+"&clubNum=${clubInfo.clubNum}"
	}
	return;
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
				<div style="width: 100%; padding: 10px; min-height: 140px;">
					${dto.content}
				</div>
				<div style="clear: both; width: 100%; height:45px; margin: 20px 0px 0px 10px;">
					<div style="float: left; width: 520px; padding-bottom: 10px">
						<button type="button" class="showReplyButn">댓글 (0)</button>
						<button type="button" class="likeButn" style="float: right;">좋아요&nbsp;3</button>
					</div>
					
					<%-- 파일첨부 --%>
					<c:if test="${not empty dto.saveFileName}">
						<div style="width: 300px; height:40px; float: right; background: #F2F2F2; margin: 5px 10px 0px 0px; padding: 10px 20px; overflow: hidden;">
							<a href="<%=cp%>/bbs/download?num=${dto.boardNum}" style="color: #585858;">
								<span class="glyphicon glyphicon-floppy-disk" style="font-size: 13px;"></span> 
								<span>${dto.originalFileName}</span>
							</a>
						</div>
					</c:if>
				</div>
				
				
				<div class="replyListDiv">
					<%-- 댓글 input --%>
					<div style="width: 100%; padding: 10px 30px; border-top: 1px solid #BDBDBD;">
						<textarea style="max-width: 100%; min-width:100%; min-height: 90px; border: 2px solid #D8D8D8; padding-left: 5px;"></textarea>
						<div style="clear: both; width: 100%; height: 30px;">
							<button class="clubButn" style="float: right;">댓글달기</button>
						</div>
					</div>
				
					<div style="width: 100%; padding: 10px 30px; border-top: 1px solid #BDBDBD;">
						<%-- 댓글 목록 --%>
						<div style="width: 100%; clear: both; border-bottom: 1px solid #D8D8D8;">
							<div style="width: 100%; height: 20px; clear: both;">
								<span style="font-size: 15px;">테스트2</span>
								<span style="color: #6E6E6E; font-size: 13px;">&nbsp; | 2018-10-02 15:35</span>
							</div>
							<div style="width: 100%; clear: both; padding: 10px; color: #6E6E6E;">
								댓글
							</div>
							<div style="clear: both; width: 100%; height: 40px;">
								<button class="showReplyAnswerButn">답글 (0)</button>
							</div>
						</div>
						
						<div class="replyAnswerDiv">
							<%-- 답글 input --%>
							<div style="clear: both; width: 100%; padding: 10px 20px; background: #FCFCFC; border-bottom: 1px solid #D8D8D8;">
								<span style="width: 3%; vertical-align: top; font-size: 18px;">└</span>
								<textarea style="max-width: 97%; min-width:97%; min-height: 80px; border: 1.2px solid #A4A4A4; padding-left: 5px;"></textarea>
								<div style="clear: both; width: 100%; height: 30px; padding-right: 5px;">
									<button class="clubButn" style="float: right;">답글달기</button>
								</div>
							</div>
						
							<%-- 답글 목록 --%>
							<div style="clear: both; width: 100%; padding: 10px 20px; background: #FAFAFA; border-bottom: 1px solid #D8D8D8;">
								<span style="width: 3%; vertical-align: top; font-size: 18px;">└</span>
								<span style="font-size: 15px;">테스트3</span>
								<span style="color: #6E6E6E; font-size: 13px;">&nbsp; | 2018-10-02 15:35</span>
								<div style="clear: both; width: 100%; padding: 5px 20px;">
									답글
								</div>
							</div>
						</div>
						
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
			<button type="button" class="clubBoardManageButn">새로고침</button>
		</div>
		
		<div style="margin:15px 15px; border-bottom:1px solid #D8D8D8;"></div>
		
		<div style="width: 100%; text-align: center; padding-top: 5px;">
			<button type="button" id="createClubBoardButn" class="clubBoardManageButn">게시글 작성</button>
		</div>
	</div>
	내가쓴글
	
</div>









