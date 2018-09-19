<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
function deletemember() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.memberNum}">
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
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId==dto.memberNum}">
	var  memberNum = "${dto.memberNum}";
	var page = "${page}";
	var query = "memberNum="+memberNum+"&page="+page;
	var url = "<%=cp%>/bbs/update?" + query;

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
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td rowspan="3" align="center">
				  <img style="width:200px;height:200px;" src="<%=cp%>/upload/member/${dto.saveFilename}">
			    </td>
			    <td width="30px;">
			    	 이름 : ${dto.name} |
			    </td>
			    <td>
			    	부서 : ${dto.positionName}
			    </td>
			</tr>
						
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       이름 : ${dto.name}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			  		부서:${dto.positionName} | 직급:${dto.departmentName}
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
			       <c:if test="${sessionScope.member.userId=='admin' && sessionScope.member.userId==dto.memberNum}">				    
			          <button type="button" class="btn" onclick="updatemember();">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.member.userId==dto.name || sessionScope.member.userId=='admin'}">				    
			          <button type="button" class="btn" onclick="deletemember();">삭제</button>
			       </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/member/main?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
  
