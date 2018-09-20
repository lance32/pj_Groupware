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



.info-btn{
	border:1px solid black;
	background-color: white;
 	padding: 10px 15px;
 	border: 1px black;
 	color: black;
 	text-align: center;
 	text-decoration: none;
 	font-size: 16px;
 	display: inline-block;
 	cursor: pointer;
 	float: left;

}


</style>
<script type="text/javascript">
function deletemember() {
<c:if test="${sessionScope.member.userId=='admin'}">
	var memberNum = "${dto.memberNum}";
	var page = "${page}";
	var query = "memberNum="+memberNum+"&page="+page;
	var url = "<%=cp%>/bbs/delete?" + query;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
			location.href=url;
	}
</c:if>    

<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.memberNum}">
	alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updatemember() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.memberNum}">
	var  memberNum = "${dto.memberNum}";
	var page = "${page}";
	var query = "memberNum="+memberNum+"&page="+page;
	var url = "<%=cp%>/member/update?" + query;

	location.href=url;
</c:if>

}
</script>

<script type="text/javascript">
// 페이징 처리
$(function(){
	listPage(1);
});

</script>

    <div class="body-title">
        <h3><span style="font-family: Webdings">2</span> 사원 정보 </h3>
    </div>
    
    <div>
		
	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;" class="info-table">
    	<tr style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
          <td rowspan="4" style="width:270px; height:250px;">
             <img src="<%=cp%>/upload/member/${dto.saveFilename}"
             	style="width:270px; height:250px;">
          </td>
          <td class="info-subject">
        	 이름
          </td>
          <td class="info-value">
          	${dto.name }
          </td>
          <td class="info-subject">
          	근무구분
          </td>
          <td class="info-value">
          	<c:if test="${dto.status == 1}">
          		재직
          	</c:if>
          	<c:if test="${dto.status == 0}">
          		퇴사
          	</c:if>
         	<c:if test="${dto.status == 2}">
          		재직
          	</c:if>
          	<c:if test="${dto.status == 3}">
          		정직
          	</c:if>
          </td>
        </tr>
        
        <tr style="border-bottom: 1px solid #cccccc;">
          <td class="info-subject">
        	   부서
          </td>
          <td colspan="3" class="info-value">
         	${dto.departmentName}
          </td>
       	</tr>
        
        <tr style="border-bottom: 1px solid #cccccc;">
        	<td class="info-subject">
        	    직급
            </td>
            <td class="info-value">
        	    ${dto.positionName }
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
    </table>

	    <div style="margin-top:20px;">
        	<button type="button" class="info-btn" >개인정보</button>
            <button type="button" class="info-btn">학력사항</button>
            <button type="button" class="info-btn">경력사항</button>
            <button type="button" class="info-btn">자격면허</button>
        </div>
    <table style="margin-top:20px;">
    <tr>
		<td>
        </td>
        
    </tr>
  
    
	
			<tr>
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			     
			   </td>
			</tr>
			
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
			       <c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.memberNum}">				    
			          <button type="button" class="btn" onclick="updatemember();">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.member.userId=='admin'}">				    
			          <button type="button" class="btn" onclick="deletemember();">삭제</button>
			       </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/member/main?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
  
