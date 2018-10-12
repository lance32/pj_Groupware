<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.photoBox img{
	height: auto;
    	max-width: 100%;
	max-height:150px;
	margin: auto;
}

 .moreButn{
 	width: auto;
 	height: auto;
 	padding: 0px 5px;
 	background: #FAFAFA;
 	border:none;
 	border: 2px solid #D8D8D8;
 	color: #848484;
 	outline: 0;
 }

</style>

<div style="width: 1102px; height: 800px; border-radius: 5px; border: 1.2px solid #A4A4A4; margin: 15px auto; padding-bottom: 70px;">
	<span style="font-size: 12px; color: #045FB4; cursor: pointer; margin: 0px 10px; display: none;">메인 사진 변경</span>
	<span style="font-size: 12px; color: #045FB4; display: none; display: none;">※ 사진 크기는 1100px*300px 를 권장합니다.</span>
	<div style="width: 100%; height: 304px; border-bottom: 2px solid #848484; border-top: 2px solid #848484; margin-bottom: 10px; line-height: 290px; text-align: center; overflow: hidden; margin-top: 8px;">
		<img src="<%=cp%>/resource/images/clubMain.jpg" style="	height: auto; max-width: 100%; max-height:300px; margin: auto;">
	</div>
	
	<div style="width: 100%;">
		<div style="width: 49.5%; float: left;">
			<div style="width: 90%; height: 433px; border-bottom: 2px solid #848484; margin: 10px auto 0px; background: #F2F2F2;">
				<table id="tb" style="width:100%;">
				
					<tr class="cf" >
						<td colspan="3" style="text-align: left; padding-left: 20px;">
							<span class="glyphicon glyphicon-th-list" style="font-size: 16px; color: #FAFAFA; margin-right: 3px;"></span>
							<span style="color: #FAFAFA;">공지사항</span>
							<button class="moreButn" style="float: right; margin-right: 10px; font-size: 13px;">+more</button>
						</td>
					</tr>
					
					
					<!-- boardNum, subject, TO_CHAR(created,'yyyy-mm-dd') created, originalFilename -->
					<c:if test="${empty noticeList}">
					<tr>
						<td colspan="3" style="text-align: center;">등록된 게시물이 없습니다.</td>
					</tr>
					</c:if>
					<c:forEach var="dto" items="${noticeList}">
					<tr class="tr" style="background: #FFFFFF;">
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
		
		<div style="width: 49.5%; float: left;">
			<div style="width: 90%; height: 435px; margin: 10px auto 0px;">
				<div style="clear: both; width: 99%; height: 30px; border-bottom: 2px solid #6E6E6E;  padding-left: 10px; background: #F2F2F2;">
					<span class="glyphicon glyphicon-picture" style="font-size: 23px; color: #585858;"></span>
					<span style="font-size: 15px; font-weight: 500; color: #585858;">포토 갤러리</span>
					<button class="moreButn" style="float: right; margin-right: 10px; font-size: 13px; margin-top: 3px; border: 2px solid #A4A4A4;">+more</button>
				</div>
				<div style="height: 403px; width: 99%; padding-top: 10px; border-bottom: 2px solid #6E6E6E;">
					<c:forEach var="dto" items="${photoList}">
					<div style="width: 150px; height: 170px; margin: 10px 5px; float: left;">
						<div class="photoBox" style="width: 100%; height: 150px; border: 1px solid #A4A4A4; line-height: 139px; text-align: center; background: #FAFAFA; border-radius: 2px;">
							${dto.content}
						</div>
						<div style="width: 100%; height: 20px; clear: both; text-align:center; padding:0px 5px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden; color: #6E6E6E;">
							${dto.subject}
						</div>
					</div>
					</c:forEach>
				</div>
				


			</div>
		
		</div>
		
	</div>
	
	
	
</div>