<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<div style="width: 1102px; height: 800px; border-radius: 5px; border: 1.2px solid #A4A4A4; margin: 15px auto; padding: 20px 0px 70px;">

	<div style="width: 100%; height: 300px; border-bottom: 2px solid #848484; border-top: 2px solid #848484; margin-bottom: 10px;">
	</div>
	
	<div style="width: 100%;">
		<div style="width: 49.5%; float: left;">
			<div style="width: 99%; height: 50px;"></div>
			<div style="width: 90%; height: 397px; border-bottom: 1px solid #848484; margin: 0px auto;">
				<table id="tb" style="width:100%;">
				
					<tr class="cf" >
						<td colspan="3" style="text-align: left; padding-left: 20px;">
							<span class="glyphicon glyphicon-th-list" style="font-size: 16px; color: #FAFAFA; margin-right: 3px;"></span>
							<span style="color: #FAFAFA;">공지사항</span>
						</td>
					</tr>
					
					
					<!-- boardNum, subject, TO_CHAR(created,'yyyy-mm-dd') created, originalFilename -->
					<c:if test="${empty noticeList}">
						<tr>
							<td colspan="3" style="text-align: center;">등록된 게시물이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="dto" items="${noticeList}">
						<tr class="tr">
							<td width="65%" style="text-align: left; padding-left: 10px;">${dto.subject}</td>
							<td width="25%">${dto.created}</td>
							<td width="10%">
								<c:if test="${not empty dto.originalFileName}">
									<span class="glyphicon glyphicon-floppy-disk" style="font-size: 13px;"></span> 
								</c:if>
							</td>
						</tr>
					</c:forEach>
	
				</table>
			</div>
			
		</div>
	</div>
	
	
	
</div>