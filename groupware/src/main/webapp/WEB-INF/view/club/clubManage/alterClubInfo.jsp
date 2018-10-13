<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
jQuery(function(){
	jQuery("#updateClubInfoButn").click(function(){
		location.href="<%=cp%>/clubManage/updateClubInfo?clubNum=${clubInfo.clubNum}";
		return;
	});
	
});
</script>


<ul class="nav nav-tabs" style="margin-top: 30px;">
  <li role="presentation" class="active"><a>동호회 정보</a></li>
  <li role="presentation"><a href="<%=cp%>/club/alterCategory?clubNum=${clubInfo.clubNum}">게시판 카테고리 설정</a></li>
  <li role="presentation" style="float: right;"><a href="#" onclick="deleteClubChk()" style="color: #B40404;">동호회 삭제</a></li>
</ul>

<div style="width:1100; height: 700px; clear: both; margin: 0px; padding: 0px;">
	<div style="float: left; margin: 20px 0px 0px 50px; font-size: 16px; width: 550px; ">
		<table style="border-spacing: 0px;">
			<tr height="70">
				<td width="150" style="text-align: left; font-weight: 600;">동호회 이름</td>
				<td width="400">
					<div style="width: 100%; padding-left:5px; border-bottom: 1.5px solid #BDBDBD;">
						${clubInfo.clubName}
					</div>
				</td>
			</tr>
			<tr height="70">
				<td  style="text-align: left; font-weight: 600;">동호회 소개글</td>
				<td>
					<div style="width: 100%; padding-left:5px; border-bottom: 1.5px solid #BDBDBD;">
						${clubInfo.clubIntro}
					</div>
				</td>
			</tr>
			<tr height="70">
				<td style="text-align: left; font-weight: 600;">개설자</td>
				<td>
					<div style="width: 100%; padding-left:5px; border-bottom: 1.5px solid #BDBDBD;">
						${clubInfo.memberName}
					</div>
				</td>
			</tr>
			<tr height="70">
				<td style="text-align: left; font-weight: 600;">가입 최대 인원수</td>
				<td>
					<div style="width: 100%; padding-left:5px; border-bottom: 1.5px solid #BDBDBD;">
						${clubInfo.maxPeople}
					</div>
				</td>
			</tr>
			<tr height="70">
				<td style="text-align: left; font-weight: 600;">주제</td>
				<td>
					<div style="width: 100%; padding-left:5px; border-bottom: 1.5px solid #BDBDBD;">
						${clubInfo.clubSubject}
					</div>
				</td>
			</tr>
			<tr height="70">
				<td style="text-align: left; font-weight: 600;">메인 이미지</td>
				<td>
					<div style="width: 100%; padding-left:5px; border-bottom: 1.5px solid #BDBDBD;">
						${clubInfo.clubMainImg==null?"없음":clubInfo.clubMainImg}
					</div>
				</td>
			</tr>
			<tr height="20"><td colspan="2">&nbsp;</td></tr>
			<tr height="80">
				<td style="text-align: left;  font-weight: 600;" valign="top">동호회 가입자 목록</td>
				<td style="text-align: left; border-bottom: 1px solid #BDBDBD; border-top: 1px solid #BDBDBD; overflow-y: auto; padding-left:5px; background: #FAFAFA;" valign="top">
					<c:forEach var="dto" items="${joinMemberList}" varStatus="status">
						${dto.joinMemberName}&nbsp;&nbsp;&nbsp;
						<c:if test="${status.count%4==0}"><br></c:if>
					</c:forEach>
				</td>
			</tr>
		</table>
		<div style="clear: both; width: 480px; height: 100px; margin-left: 70px; padding-top: 30px;">
			<button id="updateClubInfoButn" class="clubButn" style="float: right;">정보수정</button>
		</div>
	</div>
	
	<div style="float: left; width: auto; height: auto; margin: 30px 0px 0px 70px; width: 420px;">
		<div style="clear: both; padding-left: 10px; margin-bottom: 10px; font-size: 16px; font-weight: 600;">
			대표 이미지
		</div>
		<div style="clear: both; width:412px; height:412px; border: 1.2px solid #A4A4A4;">
			<div style="width:400px; height:400px; margin:5px; border: 1.0px solid #A4A4A4;  line-height: 380px; text-align: center;">
				<img style=" height: auto; max-width: 100%; max-height:400px; margin: auto;" src="<%=cp%>/uploads/club/${clubInfo.memberNum}/${clubInfo.clubImg}">
			</div>
		</div>
	</div>
</div>

