<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
  $(function(){
	  $.ajax({
		  type:"get"
		  ,url:"<%=cp%>/approval/approvalCount"
		  ,dataType:"json"
		  ,success:function(data){
			  $("#progress").text("진행 문서함 ("+ data.progress +")");
			  $("#complete").text("완료 문서함 ("+ data.complete +")");
			  $("#reject").text("반려 문서함 ("+ data.reject +")");
		  },
		  error:function(jqXHR){
			  console.log(jqXHR.responseTexst);
		  }
	  })
  })

</script>

<table class="tabs">
	<tr>
    	<th>결재 문서</th>
    </tr>
    <tr>
    	<td><a href="<%=cp%>/approval/approval_create">새문서 작성</a></td>
    </tr>
    <tr>
    	<td><a href="#" >결재 문서함 ( 0 | 0 )</a></td><!--본인이 중간 결재자일때 앞:결재해야할 문서 개수, 뒤:결재하고 진행중인 문서 -->
    </tr>
    <tr>
    	<td><a href="#" id="progress">진행문서함</a></td><!--본인이 상신한 문서만  -->
    </tr>
    <tr>
    	<td><a href="#" id="complete">완료문서함</a></td><!--본인이 상신한 문서 완료함  -->
    </tr>
    <tr>
    	<td><a href="#" id="reject">반려문서함</a></td><!-- 본인이 상신한 문서 반려함  -->
    </tr>
	
</table>