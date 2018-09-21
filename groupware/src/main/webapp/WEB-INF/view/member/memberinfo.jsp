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


</script>

    <div class="body-title">
        <h3><span style="font-family: Webdings">2</span> 사원 정보 </h3>
    </div>
    
    <div>
		
	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;" class="info-table">
    	<tr style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;">
          <td rowspan="5" style="width:270px; height:250px;">
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
          		휴직
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
        
        <tr>
        	<td class="info-subject">
        	주소
        	</td>
        	<td class="info-value">
        	${dto.addr1}&nbsp;${dto.addr2}
        	</td>
        </tr>
    </table>

	    <div>
	    	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;" class="side-info">
		    	<tr>
			    	<th>자격정보</th>
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
		    	</tr>
		    	
		    		
			    	<tr>
						<td>
							${dto.qualifyName}
						</td>
						<td>
							${dto.getDate}
						</td>
						<td>
							${dto.qualifyCode}
						</td>		    	
						<td>
							${dto.serialNum}
						</td>
			    	</tr>
	    	</table>
	 
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
  
