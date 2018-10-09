<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.info-table{
	
    border-radius: 5px;
    width:100%;
    height:100%;
}

.info-subject{
	font-size:20px;
	text-align:center;
    border-radius:5px;
    width:100px;
    height:20px;
    background: #efefef;
}

.info-value{
	padding-left:10px;
	width:250px;
}



.side-info td{
	height:40px;
	text-align:center;
	font-size:15px;
	border-right: 1px solid #efefef;
}

</style>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
<%-- function deletemember() {
<c:if test="${sessionScope.member.userId=='admin'}">
	var memberNum = "${dto.memberNum}";
	var page = "${page}";
	var query = "memberNum="+memberNum+"&page="+page;
	var url = "<%=cp%>/member/delete?" + query;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
			location.href=url;
	}
</c:if>    
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.memberNum}">
	alert("게시물을 삭제할 수  없습니다.");
</c:if>
} --%>

function updateMemberAdmin() {
	<c:if test="${sessionScope.member.userId=='admin'}">
	var  memberNum = "${dto.memberNum}";
	var page = "${page}";
	var query = "memberNum="+memberNum+"&page="+page;
	var url = "<%=cp%>/member/updateAdmin?" + query;

	location.href=url;
</c:if> 
	
};

function submitMemberAdmin(){
	var f=document.adminForm;
	f.action="<%=cp%>/member/updateAdmin";
	
	f.submit();	
};

function qualifyDelete() {
	<c:if test="${sessionScope.member.userId=='admin'}">
	var serialNum = "${dto.serialNum}";
	var page = "${page}";
	var query = "page="+page+"&serialNum="+serialNum;
	var url = "<%=cp%>/member/deleteQualify?" + query;

	if(confirm("정보를 삭제 하시 겠습니까 ? ")) {
			location.href=url;
	};
	</c:if>
};

</script>

<div class="body-title">
	<h3><span style="font-family: Webdings">2</span>
		<c:if test="${mode!='updateAdmin'}">
		사원 정보
		</c:if>
		<c:if test="${mode=='updateAdmin'}">
		사원 정보 수정
		</c:if>
	</h3>
</div>
<div>
	<form name="adminForm" method="post">
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;" class="info-table">
		<tr style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;">
			<td rowspan="5" style="width:270px; height:250px;">
			<img src="<%=cp%>/upload/member/${dto.saveFilename}"
			style="width:260px; height:240px;">
			</td>
			<td class="info-subject">
			이름
			</td>
			<td class="info-value">
				${dto.name}
			</td>
			<td class="info-subject">
				근무구분
			</td>
			<td class="info-value">
				<c:if test="${mode=='updateAdmin'}">
		    	<select class="selectField" id="status" name="status">
				<option value="">선 택</option>
				<option value="0" ${dto.status==0 ? "selected='selected'" : ""}>퇴사</option>
				<option value="1" ${dto.status==1 ? "selected='selected'" : ""}>재직</option>
				<option value="2" ${dto.status==2 ? "selected='selected'" : ""}>휴직</option>
				<option value="3" ${dto.status==3 ? "selected='selected'" : ""}>정직</option>
				</select>
		        </c:if>
				<c:if test="${mode!='updateAdmin'}">
			
				<c:if test="${dto.status == 1}">
				재직
				</c:if>
				<c:if test="${dto.status == 0}">
				퇴사
				</c:if>
				<c:if test="${dto.status == 2}">
				휴직
				</c:if>
				<c:if test="${dto.status == 3}">
				정직
				</c:if>
				</c:if>
			</td>
		</tr>
		
		<tr style="border-bottom: 1px solid #cccccc;">
			<td class="info-subject">
			  부서
			</td>
			<td class="info-value">
				<c:if test="${mode=='updateAdmin'}">
					<select class="selectField" id="departmentNum" name="departmentNum" >
					<option value="">선 택</option>
					<c:forEach var="map" items="${departmentList}">
					<option value="${map.DEPARTMENTNUM}" ${dto.departmentNum==map.DEPARTMENTNUM ? "selected='selected'" : ""}>${map.DEPARTMENTNAME}</option>
					</c:forEach>
					</select>
					</c:if>
				<c:if test="${mode!='updateAdmin'}">
				${dto.departmentName}
				</c:if>
			</td>
			<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.memberNum}">
			<td class="info-subject">
				기본급 
			</td>
			

			<td class="info-value">
					<c:if test="${mode!='updateAdmin'}">
					<span>${basicpay} 원</span>
					</c:if>
					<c:if test="${mode=='updateAdmin'}">
					<input type="text" name="basicpay" value="${dto.basicpay}"><span>&nbsp;원</span>
					</c:if>
			</td>
			</c:if>
		</tr>
		<tr style="border-bottom: 1px solid #cccccc;">
			<td class="info-subject">
			직급
			</td>
			<td class="info-value">
				<c:if test="${mode=='updateAdmin'}">
				<select class="selectField" id="positionNum" name="positionNum" >
				<option value="">선 택</option>
				<c:forEach var="map" items="${positionList}">
				<option value="${map.POSITIONNUM}" ${dto.positionNum==map.POSITIONNUM ? "selected='selected'" : ""}>${map.POSITIONNAME}</option>
				</c:forEach>
				</select>
				</c:if>
				<c:if test="${mode!='updateAdmin'}">
				${dto.positionName }
				</c:if>
			</td>
		   
			<td class="info-subject">
			 휴대전화
			</td>
			<td class="info-value">
			${dto.phone }
			</td>
		</tr>
		    
		<tr style="border-bottom: 1px solid #cccccc;">
			<td class="info-subject">
			E-mail
			</td>
			<td class="info-value">	
			${dto.email}
			</td>
			<td class="info-subject">
			 입사일
			</td>
			<td class="info-value">
			${dto.created}
			</td>
		</tr>
		<tr style="border-bottom: 1px solid #cccccc;">
			<td class="info-subject" style="border-bottom: 1px solid #cccccc;">
			주소
			</td>
			<td colspan="3" class="info-value">
			${dto.addr1}&nbsp;${dto.addr2}
			</td>
	    </tr>
	</table>
		
	<div>
		<table id="qualifytable" style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;" class="side-info">
			<tr>
				<th style="font-size: 20px;">자격정보</th>
			</tr>
			<tr style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; height:20px;">
				<td>
					자격/면허 명
				</td>
				<td>
					취득일자
				</td>
				<td>
					고유 코드
				</td>
				<td>
					식별번호
				</td>
				<c:if test="${mode=='updateAdmin'}">
				<td>
					추가
				</td>
				</c:if>
			</tr>
			

			<c:if test="${mode!='updateAdmin' && not empty qualifyList }">
				<c:forEach var="qualifyList" items="${qualifyList}">
				<tr style="border-bottom: 1px solid #cccccc; height:20px;">
					<td>
						${qualifyList.QUALIFYNAME}
					</td>
					<td>
						${qualifyList.GETDATE}
					</td>
					<td>
						${qualifyList.QUALIFYCODE}
					</td>
					<td>
						${qualifyList.SERIALNUM}
					</td>
			
				</tr>
				</c:forEach>
			</c:if>
			<c:if test="${mode=='updateAdmin' && not empty qualifyList }">
				<c:forEach var="qualifyList" items="${qualifyList}">
					<tr style="border-bottom: 1px solid #cccccc; height:20px;">
						<td>
							${qualifyList.QUALIFYNAME}
						</td>
						<td>
							${qualifyList.GETDATE}
						</td>
						<td>
							${qualifyList.QUALIFYCODE}
						</td>
						<td>
							${qualifyList.SERIALNUM}
						</td>
						<td>
							<button type="button" onclick="qualifyDelete()">삭제</button>
						</td>
					</tr>
				</c:forEach>
			<tr style="border-bottom: 1px solid #cccccc; height:20px;" >
				<td>
					<input type="text" name="qualifyName" >
				</td>
				<td>
					<input type="text" name="getDate" >
				</td>
				<td>
					<input type="text" name="qualifyCode" >
				</td>
				<td>
					<input type="text" name="serialNum" >
				</td>
				<td>
					<input type="button" id="addrows" name="addrows" value="+">
				</td>
			</tr>
			</c:if>

		</table>
	</div>
	
	<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
		<tr height="45">
			<td width="300" align="left">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="memberNum" value="${dto.memberNum}">
				
				<c:if test="${sessionScope.member.userId=='admin' && mode=='info'}">
					<button type="button" class="btn" onclick="updateMemberAdmin();">수정</button>
				</c:if>
				<c:if test="${sessionScope.member.userId=='admin' && mode=='updateAdmin'}">
					<button type="button" class="btn" onclick="submitMemberAdmin()">수정완료</button>
				</c:if>
				<c:if test="${mode=='updateAdmin'}">
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/member/memberinfo?page=${page}&memberNum=${dto.memberNum}';">수정취소</button>
				</c:if>
			</td>
			
			<td align="right">
				<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/member/main?${query}';">리스트</button>
			</td>
		</tr>
	</table>
	</form>
</div>
  
