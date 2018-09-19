<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script>
$(function(){
	$(".boardManage-detail").hide();
	$(".boardManage-list").each(function(index){
		$(this).click(function(){
			var makeHidden = $(".boardManage-detail").eq(index).is(':hidden');
			$(".boardManage-detail").hide();
			
			if(makeHidden)
				$(".boardManage-detail").eq(index).show();
			else
				$(".boardManage-detail").eq(index).hide();
		});
	});
	
	$("#btnMake").click(function(){
		var dataCount = "${dataCount}";
		if(dataCount>=7){
			alert("게시판은 최대 7개 까지만 만들 수 있습니다.");
			return;
		}
		location.href = "<%=cp%>/boardManage/created";
	});
});

$(function(){
	
});

function updateData(boardNum) {
	var url="<%=cp%>/boardManage/update?boardNum="+boardNum;
	location.href=url;
}

function deleteData(boardNum) {
	if(confirm("삭제하시겠습니까 ?")) {
		var url="<%=cp%>/boardManage/delete?boardNum="+boardNum;
		location.href=url;
	}
}

</script>
<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-list-alt"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;게 시 판 관 리</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>

<table id="tb" style="width: 85%;">
	<tr>
		<td id="count" colspan="2"><button type="button" class="btn" id="btnMake">게 시 판 생 성</button></td>
		<td></td>
		<td></td>
	</tr>

	<tr class="cf">
		<td width="70">번호</td>
		<td width="300" style="text-align: center;">게시판 제목</td>
		<td width="250">게시판 주소</td>
		<td width="300">테이블명</td>
		<td width="200">글쓰기권한</td>
		<td width="100">메뉴위치</td>
	</tr>

	<c:forEach var="dto" items="${list}">
		<tr class="tr boardManage-list">
			<td>${dto.boardNum }</td>
			<td style="text-align: center;">${dto.boardName }</td>
			<td>/${dto.tableName}/list</td>
			<td>${dto.tableName}</td>
			<td>${dto.writePermit==0?"관리자":"회원"}</td>
			<td>${dto.subMenu }</td>
		</tr>
			
		<tr height="50" class="tr boardManage-detail">
			<td colspan="7" style="border-top:none; padding: 5px;">
				<div>
			   		<span style="display: inline-block;width: 120px;">답변 : 
                    	<c:if test="${dto.canAnswer==0}">X</c:if>
                       	<c:if test="${dto.canAnswer==1}">O</c:if>
			      	</span>
			        	
			       	<span style="display: inline-block;width: 120px;">파일첨부 : 
                  		<c:if test="${dto.canFile==0}">X</c:if>
                 		<c:if test="${dto.canFile==1}">O</c:if>
			       	</span>
			        	
			        <span style="display: inline-block;width: 120px;">게시물 추천 :
                     	<c:if test="${dto.canLike==0}">X</c:if>
                      	<c:if test="${dto.canLike==1}">O</c:if>
			        </span>
			        	
			        <span style="display: inline-block;width: 120px;">리플 :
                      	<c:if test="${dto.canReply==0}">X</c:if>
                     	<c:if test="${dto.canReply==1}">O</c:if>
			       	</span>
			        	
			       	<span style="display: inline-block;width: 120px;">리플 추천 :
                     	<c:if test="${dto.canReplyLike==0}">X</c:if>
                    	<c:if test="${dto.canReplyLike==1}">O</c:if>
			       	</span>
			        	
			        <span style="display: inline-block;">왼쪽메뉴 : ${dto.leftMenu}</span>
			        
			        <span style="display: inline-block; float: right">
			       		<button type="button" class="btn"
			      	   		onclick="updateData('${dto.boardNum}');">수정</button>
                       	<button type="button" class="btn"
                           	onclick="deleteData('${dto.boardNum}');">삭제</button>
			       	</span>
			        </div>
			     </td>
			 </tr>
	</c:forEach>

</table>