<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<form>
<table style="width: 500px; border: 1px solid black;" >
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
<td colspan = "3"> 0000-abc-0000</td>
<td>작성일자</td>
<td colspan = "3"> &nbsp;</td>
</tr>
<tr>
<td>부서명</td>
<td colspan = "3">&nbsp;</td>
<td>작성자</td>
<td colspan = "3">&nbsp;</td>
</tr>
<tr>
<td>제목</td>
<td colspan = "7">20180914-test</td>
</tr>
<tr>
<td colspan = "4">금일 업무내용</td>
<td colspan = "4">명일 업무내용</td>
</tr>
<tr>
<td colspan = "4">
<textarea rows="20" cols="35">
1.출장보고서

2.납품건 마무리 작업
	-견적서 재발송

3.크라샤 형식승인

4.재고파악 및 업무 흐름도 숙지

5.자체 네트워크망 구축개획

6.

</textarea>
</td>
<td colspan = "4">
<textarea rows="20" cols="35">
&nbsp;
</textarea>
</td>
</tr>
<tr>
<td colspan = "8" rowspan = "2">
<textarea rows="5" cols="75">
비고
</textarea>
</td>
</tr>
</table>
</form>


