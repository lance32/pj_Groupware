<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.body-container {
    clear:both;
    box-sizing: border-box;  /* padding과 border는 크기에 포함되지 않음 */
    margin: 0px auto 15px;
    min-height: 500px;
    padding-top: 20px;
}

.messageBox {
  margin-top: 20px;
  width: 420px; min-height: 150px;
  line-height : 100px;
  border: 1px solid #DAD9FF;
  padding: 5px;
  color:#333333;
  font-size:14px;
  text-align: center;
  border-radius:4px;
}

.btnConfirm {
    font-size: 15px; 
    border:none;
    color:#ffffff;
    background:#507CD1;
    width: 360px;
    height: 50px;
    line-height: 50px;
    border-radius:4px;
}
</style>

<div class="body-container">

    <div style="margin: 0px auto; padding-top:90px; width:420px;">
    	<div style="text-align: center;">
        	<span style="font-weight: bold; font-size:27px; color: #424951;">메일 전송</span>
        </div>
        
        <div class="messageBox">
            <div style="line-height: 150%; padding-top: 35px;">
				${message}            
            </div>
            <div style="margin-top: 20px;">
				<button type="button" onclick="javascript:location.href='<%=cp%>/mail/mailWrite';" class="btnConfirm">확인</button>
            </div>
        </div>
     </div>   

</div>
