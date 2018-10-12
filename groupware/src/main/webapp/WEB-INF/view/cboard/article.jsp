<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script>
$(function(){
// 삭제 버튼
	$("#btnDelete").click(function(){
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.memberNum}">
		var num = "${dto.num}";
		var page = "${page}";
		var query = "num="+num+"&page="+page;
		var url = "<%=cp%>/${cb.tableName}/delete?"+query;
		
		if(confirm("게시물을 삭제 하시겠습니까?")){
			location.href = url;
		}
	});
</c:if>

<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.memberNum}">
	alert("게시물을 삭제할 수  없습니다.");
</c:if>
// 수정 버튼
	$("#btnUpdate").click(function(){
<c:if test="${sessionScope.member.userId==dto.memberNum}">
		var num = "${dto.num}";
		var page = "${page}";
		var query = "num="+num+"&page="+page;
		var url = "<%=cp%>/${cb.tableName}/update?"+query;
		
		location.href = url;
	});
</c:if>

<c:if test="${sessionScope.member.userId!=dto.memberNum}">
	alert("게시물을 수정할 수  없습니다.");
</c:if>
});

// 게시물 좋아요 처리
<c:if test="${cb.canLike == '1'}">
$(function(){
	$(".btnSendBoardLike").click(function(){
		var url="<%=cp%>/${cb.tableName}/insertBoardLike";
		var query="num=${dto.num}&canLike=1";
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					var count = data.boardLikeCount;
					$("#boardLikeCount").text(count);
				} else if(state=="false") {
					var count = data.boardLikeCount;
					$("#boardLikeCount").text(count);
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		location.href="<%=cp%>/login";
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	});
});
</c:if>

<c:if test="${cb.canReply == '1'}">
// 댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/${cb.tableName}/listReply";
	var query="num=${dto.num}&pageNo="+page;
	$.ajax({
		type:"get"
		,url:url
		,data:query
		,success:function(data) {
			$("#listReply").html(data);
		}
	    ,beforeSend :function(jqXHR) {
	    	jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/login";
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

// 댓글 등록
$(function(){
	$("#btnSendReply").click(function(){
		var num = "${dto.num}";
		var content = $("#replyArea").val().trim();
		if(! content){
			$("#replyArea").focus();
			return;
		}
		content = encodeURIComponent(content);
		
		var url = "<%=cp%>/${cb.tableName}/insertReply";
		var query = "num="+num+"&content="+content+"&answer=0";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				$("#replyArea").val("");
				var state=data.state;
				if(state=="true") {
					listPage(1);
				} else if(state=="false") {
					alert("댓글을 추가 하지 못했습니다.");
					listPage(1);
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		location.href="<%=cp%>/login";
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	});
});

// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("댓글을 삭제하시겠습니까?"))
			return;
		
		var replyNum = $(this).attr("data-replyNum");
		var page = $(this).attr("data-pageNo");
		
		var url = "<%=cp%>/${cb.tableName}/deleteReply";
		var query = "replyNum="+replyNum+"&mode=reply";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				listPage(page);
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		location.href="<%=cp%>/login";
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	});
});

// 답글 작성 영역 열기
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $replyAnswer = $(this).closest("tr").next();
		
		var isVisible = $replyAnswer.is(':visible');
		var replyNum = $(this).attr("data-replyNum");
		
		if(isVisible){
			$replyAnswer.hide();
		} else {
			$replyAnswer.show();
			listReplyAnswer(replyNum);
			countReplyAnswer(replyNum);
		}
	});
});

// 댓답글 추가
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var num = "${dto.num}";
		var replyNum = $(this).attr("data-replyNum");
		
		var $td = $(this).closest("td");
		var content = $td.find("textArea").val().trim();
		if(! content){
			$td.find("textArea").focus();
			return;
		}
		content = encodeURIComponent(content);
		
		var url = "<%=cp%>/${cb.tableName}/insertReply";
		var query = "num="+num+"&content="+content+"&answer="+replyNum;
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				$td.find("textarea").val("");
				var state=data.state;
				if(state=="true") {
					listReplyAnswer(replyNum);
					countReplyAnswer(replyNum);
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		location.href="<%=cp%>/login";
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	});
});

//댓답글 리스트
function listReplyAnswer(answer) {
	var url="<%=cp%>/${cb.tableName}/listReplyAnswer";
	var query = "answer="+answer;
	$.ajax({
		type:"get"
		,url:url
		,data:query
		,success:function(data) {
			var answerList="#listReplyAnswer"+answer;
			$(answerList).html(data);
		}
	    ,beforeSend :function(jqXHR) {
	    	jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/login";
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

// 댓답글 개수
function countReplyAnswer(answer) {
	var url="<%=cp%>/${cb.tableName}/countReplyAnswer";
	var query = "answer="+answer;
	
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var count=data.count;
			var answerCountId="#answerCount"+answer;
			$(answerCountId).html(count);
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/login";
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

// 댓답글 삭제
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("댓글을 삭제하시겠습니까 ?"))
		    return;
		
		var replyNum=$(this).attr("data-replyNum");
		var answer=$(this).attr("data-answer");
		
		var url="<%=cp%>/${cb.tableName}/deleteReply";
		var query="replyNum="+replyNum+"&mode=answer";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				listReplyAnswer(answer);
				countReplyAnswer(answer);
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		location.href="<%=cp%>/login";
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	});
});

</c:if>
</script>

<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-comment"
		style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;${cb.boardName }</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
<div class="body-container" style="width: 80%;">
    <div>
    	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
			    <c:if test="${dto.depth != 0}">
			    	[Re]
			    </c:if>
			    ${dto.title }</td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">작 성 자 : ${dto.name }</td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        	${dto.created } | 조 회 수 : ${dto.hitCount }
			    </td>
			</tr>
			<tr style="${cb.canLike=='0'?'border-bottom: 1px solid #cccccc;':''}">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="300">
			   	   ${dto.content }
			   </td>
			</tr>
			
			<c:if test="${cb.canLike=='1'}">
				<tr style="border-bottom: 1px solid #cccccc;">
				  <td colspan="2" align="center" height="40" style="padding-bottom: 15px;">
				       <button type='button' id="btnTest" class='btn btnLike btnSendBoardLike'>
				       <span class="glyphicon glyphicon-heart"></span>&nbsp;<span id="boardLikeCount">${boardLikeCount}</span></button>
				   </td>
				</tr>
			</c:if>
			
			<c:forEach var="vo" items="${listFile}">			
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
				    <td colspan="2" align="left" style="padding-left: 5px;">
				       첨&nbsp;&nbsp;부 :
			           <c:if test="${not empty vo.saveFilename}">
			                   <a href="<%=cp%>/${cb.tableName}/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>
			                   (<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)
			           </c:if>
				    </td>
				</tr>
			</c:forEach>	
			
			<c:if test="${not empty preReadDto}">
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
					<td colspan="2" align="left" style="padding-left: 5px;">
						이전글 :
					  		<a href="<%=cp%>/${cb.tableName}/article?${query}&num=${preReadDto.num}">${preReadDto.title}</a>
					</td>
				</tr>
			</c:if>
				
			<c:if test="${not empty nextReadDto}">
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
					<td colspan="2" align="left" style="padding-left: 5px;">
						다음글 :
					   	<a href="<%=cp%>/${cb.tableName}/article?${query}&num=${nextReadDto.num}">${nextReadDto.title}</a>
					</td>
				</tr>
			</c:if>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
				<tr height="45">
				    <td width="300" align="left">
						
						<c:if test="${cb.canAnswer=='1' && not empty sessionScope.member && sessionScope.member.userId==dto.memberNum}">				    
				       		<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/${cb.tableName}/answer?num=${dto.num}&page=${page}';">답변</button>
				       	</c:if>
				  		
				  		<c:if test="${cb.writePermit == '1' || (cb.writePermit == '0' && msg=='admin')}">				    
				      		<button type="button" class="btn" id="btnUpdate">수정</button>
				       	</c:if>
				       	
				       	<c:if test="${cb.writePermit == '1' || (cb.writePermit == '0' && msg=='admin')}">		    
				          <button type="button" class="btn" id="btnDelete">삭제</button>
				       	</c:if>
				    </td>
				    <td align="right">
				        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/${cb.tableName}/list?${query}';">리스트</button>
				    </td>
				</tr>
			</table>
    </div>
    
    <c:if test="${cb.canReply=='1'}">
    <div>
		<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr height='30'> 
				 <td align='left' >
				 	<span style='font-weight: bold;' >댓 글</span>
				 </td>
			</tr>
			<tr>
			   	<td style='padding:5px 5px 0px;'>
					<textarea id="replyArea" class='boxTA' style='width:100%; height: 50px; resize: none; border-radius: 7px;'></textarea>
			    </td>
			</tr>
			<tr>
			   <td align='right'>
			        <button type='button' id="btnSendReply" class='btn' style='padding:5px 10px; margin-right: 5px;'>댓글 등록</button>
			    </td>
			 </tr>
		</table>
		     
		<div id="listReply"></div>
    </div>
    </c:if>
</div>