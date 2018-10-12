<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style>
#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: center;
    color: black;
    
}
</style>
<script type="text/javascript"
	src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>


<div class="body-title">
	<h3>
		<span style="font-family: Webdings">2</span> 급여정보
	</h3>
</div>
<div>
	<table id="customers">
		<tr>
			<th colspan="8">2018년 9월 김영욱님의 급여 명세표입니다.</th>
		</tr>
		<tr align="center">
			<td>성명 : ${dto.name}</td>
			<td>부서 : ${dto.departmentName}</td>

			<td>직책 : ${dto.positionName }</td>

			<td>지급일 : ${dto.year}년 ${dto.month}월  ${dto.day}일</td>
		</tr>
		<tr>
			<th>지급항목</th>
			<th>지급액</th>
			<th>공제항목</th>
			<th>공제액</th>
		</tr>
		<tr>
			<td>기본급</td>
			<td align="right"><fmt:formatNumber value="${dto.basicpay }" pattern="#,###"/>원</td>
			<td>소득세</td>
			<td align="right"><fmt:formatNumber value="${dto.incomeTax}" pattern="#,###"/>원</td>
		</tr>
		<tr>
			<td>수당</td>
			<td align="right"><fmt:formatNumber value="${dto.extrapay}" pattern="#,###"/> 원</td>
			<td>고용보험</td>
			<td align="right"><fmt:formatNumber value="${dto.employTax}" pattern="#,###"/>원</td>
		</tr>
		<tr>
			<td colspan="2"></td>
			<td>국민연금</td>
			<td align="right"><fmt:formatNumber value="${dto.pensionTax}" pattern="#,###"/>원</td>
		</tr>
		<tr>
			<td colspan="2"></td>
			<td>건강보험</td>
			<td align="right"><fmt:formatNumber value="${dto.healthTax}" pattern="#,###"/>원</td>
		</tr>
		<tr>
			<td colspan="2"></td>
			<td>공제합계</td>
			<td align="right"><fmt:formatNumber value="${allTax}" pattern="#,###"/>원</td>
		</tr>
		<tr>
			<td>급여계</td>
			<td align="right"><fmt:formatNumber value="${allPay}" pattern="#,###"/>원</td>
			<td>차감수령액</td>
			<td colspan="2" align="right"><fmt:formatNumber value="${dto.realPay}" pattern="#,###"/>원</td>
		</tr>
		<tr>
			<td colspan="2" align="center">귀하의 노고에 감사드립니다.</td>
			<td colspan="2" align="center">TJ company</td>
		</tr>
	</table>
</div>

<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
	<tr height="45">
		<td align="right">
			<button type="button" class="btn"
				onclick="javascript:location.href='<%=cp%>/pay/main?${query}';">리스트</button>
		</td>
	</tr>
</table>

