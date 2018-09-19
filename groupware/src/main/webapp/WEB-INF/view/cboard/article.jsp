<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script>
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
			
			<tr>
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
				  		<c:if test="${sessionScope.member.userId==dto.memberNum}">				    
				      		<button type="button" class="btn" id="btnUpdate">수정</button>
				       	</c:if>
				       <c:if test="${sessionScope.member.userId==dto.memberNum || sessionScope.member.userId=='admin'}">		    
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
    </c:if>
</div>