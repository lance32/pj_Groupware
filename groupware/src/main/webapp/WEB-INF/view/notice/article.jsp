<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script>
$(function(){
	
	$("#btnDelete").click(function(){
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.memberNum}">
		var num = "${dto.num}";
		var page = "${page}";
		var query = "num="+num+"&page="+page;
		var url = "<%=cp%>/notice/delete?"+query;
		
		if(confirm("게시물을 삭제 하시겠습니까?")){
			location.href = url;
		}
	});
</c:if>

<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.memberNum}">
	alert("게시물을 삭제할 수  없습니다.");
</c:if>

	$("#btnUpdate").click(function(){
<c:if test="${sessionScope.member.userId==dto.memberNum}">
		var num = "${dto.num}";
		var page = "${page}";
		var query = "num="+num+"&page="+page;
		var url = "<%=cp%>/notice/update?"+query;
		
		location.href = url;
	});
</c:if>

<c:if test="${sessionScope.member.userId!=dto.memberNum}">
	alert("게시물을 수정할 수  없습니다.");
</c:if>
});
$(function(){
	listPage(1);
});
// 댓글 페이징
function listPage(page){
	var url="<%=cp%>/notice/listReply";
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
		var replyContent = $("#replyArea").val().trim();
		if(! replyContent){
			$("#replyArea").focus();
			return;
		}
		replyContent = encodeURIComponent(replyContent);
		
		var url = "<%=cp%>/notice/insertReply";
		var query = "num="+num+"&content="+replyContent+"&answer=0";
		$.ajax({
			type : "post",
			url : url,
			data : query,
			dataType : "json",
			success:function(data) {
				$("#replyArea").val("");
				var state=data.state;
				if(state=="true") {
					listPage(1);
				} else if(state=="false") {
					alert("댓글을 추가 하지 못했습니다.");
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
	});
});

//댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? "))
		    return;
		
		var replyNum=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/notice/deleteReply";
		var query="replyNum="+replyNum+"&mode=reply";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				// var state=data.state;
				listPage(page);
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
	});
});

// 답글 리스트
function listReplyAnswer(answer) {
	var url="<%=cp%>/notice/listReplyAnswer";
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

//댓글별 답글 개수
function countReplyAnswer(answer) {
	var url="<%=cp%>/notice/countReplyAnswer";
	var query = "answer="+answer;
	$.ajax({
		type:"post"
		,url: url
		,data: query
		,dataType:"json"
		,success:function(data) {
			var count=data.count;
			var answerCount="#answerCount"+answer;
			$(answerCount).html(count);
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

//답글 리스트 띄우기
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $tr = $(this).closest("tr").next();
		
		var isVisible = $tr.is(':visible');
		var replyNum = $(this).attr("data-replyNum");
			
		if(isVisible) {
			$tr.hide();
		} else {
			$tr.show();
            
			// 답글 리스트
			listReplyAnswer(replyNum);
			// 답글 개수
			countReplyAnswer(replyNum);
		}
	});
	
});

//댓글별 답글 등록
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var num="${dto.num}";
		var replyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		var content=$td.find("textarea").val().trim();
		
		if(! content) {
			$td.find("textarea").focus();
			return;
		}
		content = encodeURIComponent(content);
		
		var query="num="+num+"&content="+content+"&answer="+replyNum;
		var url="<%=cp%>/notice/insertReply";
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
		    		login();
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	});
});

//댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? "))
		    return;
		
		var replyNum=$(this).attr("data-replyNum");
		var answer=$(this).attr("data-answer");
		
		var url="<%=cp%>/notice/deleteReply";
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
		    		login();
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	});
});
</script>

<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-bullhorn"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;공 지 사 항</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
<div class="body-container" style="width: 80%;">
    
    <div>
    	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">${dto.subject }</td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">작 성 자 : ${dto.name }</td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        	${dto.created } | 조 회 수 : ${dto.hitCount }
			    </td>
			</tr>
			
			<tr>
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="300">
			   	   ${dto.content }
			   </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
		    	<c:if test="${not empty dto.saveFilename}">
			       	첨&nbsp;&nbsp;부 : 
		             	<a href="<%=cp%>/notice/download?num=${dto.num}">${dto.originalFilename}</a>
		       	</c:if>
			    </td>
			</tr>
			
				<c:if test="${not empty preReadDto}">
					<tr height="35" style="border-bottom: 1px solid #cccccc;">
					    <td colspan="2" align="left" style="padding-left: 5px;">
					       	이전글 :
					              <a href="<%=cp%>/notice/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					    </td>
					</tr>
				</c:if>
				<c:if test="${not empty nextReadDto}">
					<tr height="35" style="border-bottom: 1px solid #cccccc;">
					    <td colspan="2" align="left" style="padding-left: 5px;">
					       	다음글 :
					              <a href="<%=cp%>/notice/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					    </td>
					</tr>
				</c:if>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
			       <c:if test="${sessionScope.member.userId==dto.memberNum}">				    
			          <button type="button" class="btn" id="btnUpdate">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.member.userId==dto.memberNum || sessionScope.member.userId=='admin'}">		    
			          <button type="button" class="btn" id="btnDelete">삭제</button>
			       </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
    
    <div>
		<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr height='30'> 
				 <td align='left' >
				 	<span style='font-weight: bold;' >댓 글</span>
				 </td>
			</tr>
			<tr>
			   	<td style='padding:5px 5px 0px;'>
					<textarea id="replyArea" class='boxTA' style='width:100%; height: 70px; resize: none'></textarea>
			    </td>
			</tr>
			<tr>
			   <td align='right'>
			        <button type='button' id="btnSendReply" class='btn' data-num='10' style='padding:5px 10px; margin-right: 5px;'>댓글 등록</button>
			    </td>
			 </tr>
		</table>
		     
		<div id="listReply"></div>
    
    </div>
    
</div>