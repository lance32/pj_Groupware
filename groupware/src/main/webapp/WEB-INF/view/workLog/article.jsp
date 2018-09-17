<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<div>
<table>
<tr>
<td>제목</td>
<td colspan="2">${dto.subject}</td>
<td>작성자</td>
<td colspan="2">${dto.name}</td>
</tr>
</table>
</div>

<table style="width: 500px;" border="2">
<tr>
<td colspan = "5" rowspan = "2">일일 업무 일지</td>
<td>작성</td>
<td>검토</td>
<td>승인</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
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
<td colspan = "4">금일 업무내용</td>
<td colspan = "4">명일 업무내용</td>
</tr>
<tr>
<td colspan = "4">
<textarea rows="20" cols="35">
${dto.todayWork}
</textarea>
</td>
<td colspan = "4">
<textarea rows="20" cols="35">
${dto.nextdayWork}
</textarea>
</td>
</tr>
<tr>
<td colspan = "8" rowspan = "2">
<textarea rows="5" cols="75">
비고
${dto.memo }
</textarea>
</td>
</tr>
</table>
