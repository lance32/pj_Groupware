<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
jQuery(function(){
	jQuery(".replyDiv").hide();
	
	//페이지가 총페이지수와 같으면 더보기 hide
	if(pageNo>='${total_page}'){
		jQuery("#nextListDiv").hide();
	}else{
		jQuery("#nextListDiv").show();
	}
	
	//페이지가 1이 아니면 이전글 보기 show
	if(pageNo>1){
		jQuery("#preListDiv").show();
	}else{
		jQuery("#preListDiv").hide();
	}
	
	//이전글 보기 클릭시
	jQuery("#preListDiv").click(function(){
		pageNo--;
		if(pageNo<=1){
			pageNo=1;
		}
		listPage(pageNo,'','','pre');
		jQuery("html, body").animate({ scrollTop: 8000}, 500);
	});

	//더보기 클릭시
	jQuery("#nextListDiv").click(function(){
		pageNo++;
		if(pageNo>='${total_page}'){
			pageNo='${total_page}';
		}
		listPage(pageNo,'','','');
		jQuery("html, body").animate({scrollTop: 100}, 500);
	});
	
	jQuery(document).ready(function(){
		if(mode=="update"){
			scrollUpdateComplete(boardNum);
		}
	});
	
});


//게시물 수정 a태그 클릭시
function updateClubBoard(boardNum, clubNum, categoryNum){
	location.href="<%=cp%>/clubBoard/updateBoard?boardNum="+boardNum+"&clubNum="+clubNum+"&categoryNum="+categoryNum+"&pageNo="+pageNo;
}
</script>


		<c:if test="${empty boardList}">
			<div style="width: 100%; height: 130px; clear: both; border: 2px solid #BDBDBD; border-radius: 5px; text-align: center; padding-top: 30px; background: #FAFAFA;">
				<span style="font-size: 22px; font-weight: 400; color: #6E6E6E;">등록된 게시물이 없습니다.</span>
			</div>
		</c:if>
		<c:forEach var="dto" items="${boardList}">
			<div class="separator" style="clear: both; width: 100%; text-align: center; margin: 10px 0px; ">
				<span class="glyphicon glyphicon-minus" style="font-size: 20px; color: #A4A4A4;"></span>
			</div>
			<span style="color: #848484; font-size: 12px; padding-left: 5px;">게시물 번호 : ${dto.boardNum}</span>
			<div id="boardDiv${dto.boardNum}" class="boardDiv" style="width: 100%; clear: both; border-top:1px solid #D8D8D8; border-bottom: 2px solid #BDBDBD;">
				<%-- 게시물 내용 --%>
				<div style="width: 100%; height: 80px; border-bottom: 1.5px solid #BDBDBD; padding-left: 10px; background: #FAFAFA;">
					<div style="clear:both; width: 100%; height: 40px; margin-bottom: 10px; padding-left: 5px;">
						<span style="max-width:800px; font-size: 28px; overflow: hidden;">${dto.subject}</span>
						<c:if test="${sessionScope.member.userId==dto.memberNum}">
							<div style="float: right; padding-right: 5px;">
								<a onclick="updateClubBoard('${dto.boardNum}','${dto.clubNum}','${categoryNum}')" style="color: #424242; cursor: pointer;">수정</a>&nbsp;|
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
					<div style="float: left; width: 529px; padding-bottom: 10px">
						<button type="button" class="showReplyButn" value="${dto.boardNum}">댓글 (<span>${dto.replyCount}</span>)</button>
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
						<input type="hidden" class="replyBoardNumInput" value="${dto.boardNum}">
					</div>
					
					<div class="listReply" style="width: 100%; padding: 0px 30px 10px 30px; border-top: 1px solid #BDBDBD;">
					</div>
				</div>
				
			</div>
		</c:forEach>