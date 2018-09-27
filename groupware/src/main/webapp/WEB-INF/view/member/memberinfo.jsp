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

}
</script>
<script type="text/javascript">
function memberOk() {
	var f = document.memberForm;
	var str;
	
    str = f.tel1.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요.");
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요.");
        f.tel2.focus();
        return;
    }
    
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다.");
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요.");
        f.tel3.focus();
        return;
    }
    
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다.");
        f.tel3.focus();
        return;
    }
    
<c:if test="${sessionScope.member.userId=='admin'}">
    str = f.departmentNum.value;
	str = str.trim();
    if(!str) {
        alert("부서를 선택해주세요");
        f.departmentNum.focus();
        return;
    }
    
    str = f.positionNum.value;
	str = str.trim();
    if(!str) {
        alert("직급을 선택해주세요");
        f.positionNum.focus();
        return;
    }
</c:if> 

    str = f.phone1.value;
	str = str.trim();
    if(!str) {
        alert("휴대전화번호를 입력하세요.");
        f.phone1.focus();
        return;
    }

    str = f.phone2.value;
	str = str.trim();
    if(!str) {
        alert("휴대전화번호를 입력하세요. ");
        f.phone2.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.phone2.focus();
        return;
    }

    str = f.phone3.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.phone3.focus();
        return;
    }
    
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.phone3.focus();
        return;
    }
    
    str = f.email1.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }

    var mode="${mode}";
    
    if(mode=="updateAdmin")
   		f.action = "<%=cp%>/member/updateAdmin";
	else
   		f.action = "<%=cp%>/member/memberinfo";

    f.submit();
}
function plusqualify(){
	
}


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
          	${dto.name}
          </td>
          <td class="info-subject">
          	근무구분
          </td>
          <td class="info-value">
          	<c:if test="${mode=='updateAdmin'}">
	          	<select class="selectField" id="status" name="status">
					<option value="">선 택</option>
					<option value="0">퇴사</option>
					<option value="1">재직</option>
					<option value="2">휴직</option>
					<option value="3">정직</option>
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
          <td colspan="3" class="info-value">
           <c:if test="${mode=='updateAdmin'}">
	          	<select class="selectField" id="departmentNum" name="departmentNum" >
	            <c:forEach var="map" items="${departmentList}">
	                <option value="${map.DEPARTMENTNUM}" ${dto.departmentNum==map.DEPARTMENTNUM ? "selected='selected'" : ""}>${map.DEPARTMENTNAME}</option>
	            </c:forEach>
	            </select>
	          </c:if>
	          <c:if test="${mode!='updateAdmin'}">
         		${dto.departmentName}
	          </c:if>
          </td>
       	</tr>
        
        <tr style="border-bottom: 1px solid #cccccc;">
        	<td class="info-subject">
        	    직급
            </td>
            <td class="info-value">
            <c:if test="${mode=='updateAdmin'}">
	          	<select class="selectField" id="positionNum" name="positionNum" >
	               <c:forEach var="map" items="${positionList}">
	               	 <option value="${map.POSITIONNUM}" ${dto.departmentNum==map.POSITIONNUM ? "selected='selected'" : ""}>${map.POSITIONNAME}</option>
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
        
        <tr>
        	<td class="info-subject" style="border-bottom: 1px solid #cccccc;">
        	주소
        	</td>
        	<td colspan="3" class="info-value">
        	${dto.addr1}&nbsp;${dto.addr2}
        	</td>
        </tr>
    </table>

	    <div>
	    	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;" class="side-info">
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
		    		<td>
		    			추가
		    		</td>
		    	</tr>
		    		<c:if test="${mode=='updateAdmin'}">
		    	<tr style="border-bottom: 1px solid #cccccc; height:20px;">
			    		<td>
			    			<input type="text">
			    		</td>
			    		<td>
			    			<input type="text">
			    		</td>
			    		<td>
			    			<input type="text">
			    		</td>
			    		<td>
			    			<input type="text">
			    		</td>
			    		<td>
			    			<button type="button" onclick="plusqualify();">+</button>
			    		</td>
		    		</c:if>
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
			       <c:if test="${sessionScope.member.userId=='admin'}">				    
			          <button type="button" class="btn" onclick="updateMemberAdmin();">${mode=="updateAdmin"?"수정완료":"수정"}</button>
			       </c:if>
			       <c:if test="${mode=='updateAdmin'}">
			          <button type="reset" class="btn">다시입력</button>
			          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/member/memberinfo?page=${page}&memberNum=${dto.memberNum}';">수정취소</button>
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
  
