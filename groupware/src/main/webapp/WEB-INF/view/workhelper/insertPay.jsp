<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
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

input{
	width:90%;
}
#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {}

#customers th {
width:20%;
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
}

.realTax input{
	width:85%;
}
.ymd input{
	width:85%;
}
</style>

<script type="text/javascript">
function payOk() {
	var f = document.payForm;
	var str;
	
<c:if test="${mode=='created'}">
	str = f.memberNum.value;
	str = str.trim();
	if(!str) {
		alert("사원번호를 입력하세요. ");
		f.memberNum.focus();
		return;
	}
</c:if>

    f.submit();
}
function mathPay(){
	var basicpay=($("#basicpay").val());
	basicpay = basicpay.trim();
	if(!basicpay){
		alert("기본급을 입력해주세요");
		$("#basicpay").focus();
		return;
	}
	
	var url="<%=cp%>/pay/mathPay";
	var q="basicpay="+basicpay;
	$.ajax({
		type:"get"
		,url:url
		,data:q
		,dataType:"json"
		,success:function(data){
			var healthTax=basicpay*$("#건강보험").val();
			var employTax=basicpay*$("#고용보험").val();
			var accidentTax=basicpay*$("#산재보험").val();
			var pensionTax=basicpay*$("#국민연금").val();
			var incomeTax=basicpay*$("#소득세").val();
			var totalTax=healthTax+employTax+accidentTax+pensionTax+incomeTax;
			var realPay=basicpay-totalTax;
			$("#healthTax").val(healthTax);
			$("#employTax").val(employTax);
			$("#accidentTax").val(accidentTax);
			$("#pensionTax").val(pensionTax);
			$("#incomeTax").val(incomeTax);
			$("#totalTax").val(totalTax);
			$("#realPay").val(realPay);
		}
	
		,error:function(e) {
	    	console.log(e.responseText);
	    }
	});
	
}

//사원의 존재여부 체크
function memberNumCheck() {
	var str = $("#memberNum").val();
	str = str.trim();
	if(!/^[0-9]{4,8}$/i.test(str)) { 
		$("#memberNum").focus();
		return;
	}
	
	var url="<%=cp%>/member/memberNumCheck";
	var q="memberNum="+str;
	
	$.ajax({
		type:"post"
		,url:url
		,data:q
		,dataType:"json"
		,success:function(data) {
			var p=data.passed;
			if(p=="false") {
				var s="<span style='color:blue;font-weight:bold;'>"+str+"재직중인 사원 입니다.</span><br>";
				
				$("#memberNum").parent().next(".help-block").html(s);
			} else {
				var s="<span style='color:red;font-weight:bold;'>"+str+"</span> 재직중인 사원정보가 없습니다.";
				$("#memberNum").parent().next(".help-block").html(s);
				$("#memberNum").val("");
				$("#memberNum").focus();
			}
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	});
	
}

</script>
<div class="body-container" style="width: 700px;">
        <div>
			<form name="payForm" method="post">
				<table id="customers">
				  <tr>
				    <th>사원 번호</th>
				    <td colspan="4">
				    <p>
				    <input type="text" name="memberNum" id="memberNum" value=""
                         onchange="memberNumCheck();" placeholder="재직중인 사원의 사원 번호">
				    </p>
                         	<p class="help-block"></p>
                         </td>
				  </tr>
				  <tr>
				    <th>기본급</th>
				    <td colspan="4"><input type="text" name="basicpay" id="basicpay" onchange="mathPay();"
				    	placeholder="기본급">
				    </td>
				  </tr>
				  <tr class="ymd">
				  	<th>지급일</th>
				  	<td>
				  		<input type="text" name="year" id="year" placeholder="0000년">년
				  	</td>
				  	<td>
				  		<input type="text" name="year" id="year" placeholder="00월">월
				  	</td>
				  	<td>
				  		<input type="text" name="year" id="year" placeholder="00일">일
				  	</td>
				  	<td>
				  	</td>
				  </tr>
				  <tr>
				    <th colspan="5">세율</th>
				  </tr>
				  <tr>
				    <c:forEach var="taxList" items="${taxList}" >
				    <td>${taxList.deductName}</td>
				  </c:forEach>
				  </tr>
				  
				  
				  <tr>
				  <c:forEach var="taxList" items="${taxList}" >
				    <td><input type="text" name="${taxList.deductName}" id="${taxList.deductName}" readonly="readonly" value="${taxList.rate}">
				    	(<fmt:formatNumber value="${taxList.rate*100}" type="%" pattern="0.00" />)</td>
				  </c:forEach>
				  </tr>
				  
				   <tr>
				    <th colspan="5">공제금액</th>
				  </tr>
				  <tr>
				   	<tr>
				  	 <c:forEach var="taxList" items="${taxList}" >
				   	 <td>${taxList.deductName}</td>
				  	 </c:forEach>
				  </tr>
				  
				   <tr class="realTax">
			   	 	<td>
			   	 		<input type="text" name="healthTax" id="healthTax" readonly="readonly">원
			   	 	</td>
				    <td>
				    	<input type="text" name="employTax" id="employTax" readonly="readonly">원
				    </td>
				    <td>
				    	<input type="text" name="accidentTax" id="accidentTax" readonly="readonly">원
				    </td>
				    <td>
				    	<input type="text" name="pensionTax" id="pensionTax" readonly="readonly">원
				    </td>
				    <td>
						<input type="text" name="incomeTax" id="incomeTax" readonly="readonly">원
				    </td>
				  </tr>
				  <tr class="realTax">
				  	<th>총 공제액</th>
				  	<td>
				  		<input type="text" name="totalTax" id="totalTax" readonly="readonly">원
				  	</td>
				  	<th>지급액</th>
				  	<td colspan="2">
				  		<input type="text" name="realPay" id="realPay" readonly="readonly">원
				  	</td>
				  </tr>
				</table>
				
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px; margin-top:10px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" name="sendButton" class="btn" onclick="payOk();">급여 입력</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/pay/adminMain';">수정취소</button>
			      </td>
			    </tr>
			  </table>
			</form>
        </div>

</div>
