<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>
textarea {
	overflow: none;
	resize: none;
	border: none;
}
.worktable tr{
	height:20px;
	font-size: 15px;
	overflow: scroll;
	
}

</style>

<%-- 상단 대표글씨 --%>
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-book" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;업무 일지</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
<table style="width: 800px;" border="1" class="worktable" >
<tr>
<td colspan = "5" rowspan = "3" style="font-size: 25px; border: none;">일일 업무 일지</td>
<td width="33.3%" style="background-color: bisque">작성</td>
<td width="33.3%" style="background-color: bisque">검토</td>
<td width="33.3%" style="background-color: bisque">승인</td>
</tr>
<tr>
<td rowspan = "2">&nbsp;</td>
<td rowspan = "2">&nbsp;</td>
<td rowspan = "2">&nbsp;</td>
</tr>
<tr>
</tr>
<tr>
<td>보고번호</td>
<td colspan = "3"> 0000-abc-${dto.workLogNum}</td>
<td>작성일자</td>
<td colspan = "3"> ${dto.makeDate}</td>
</tr>
<tr>
<td>부서명</td>
<td colspan = "3">${dto.departmentName}</td>
<td>작성자</td>
<td colspan = "3">${dto.name}</td>
</tr>
<tr>
<td>제목</td>
<td colspan = "7">${dto.subject}</td>
</tr>
<tr>
<td colspan = "4" height="50px" style="background-color: bisque">금일 업무내용</td>
<td colspan = "4" height="50px" style="background-color: bisque">명일 업무내용</td>
</tr>
<tr>
<td colspan = "4">
<textarea rows="23" cols="67" readonly="readonly">
${dto.todayWork}
</textarea>
</td>
<td colspan = "4">
<textarea rows="23" cols="67" readonly="readonly">
${dto.nextdayWork}
</textarea>
</td>
</tr>
<tr>
<td colspan = "8" rowspan = "2" >
<textarea rows="5" cols="140" readonly="readonly">
비고
${dto.memo }
</textarea>
</td>
</tr>
</table>
