<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.btn{
	width:80px;
}

select{
	height:28px;
	border:1px solid e4e4e4;
	border-radius: 5px;
}

input{
	height:30px;
	border:1px solid e4e4e4;
	border-radius: 5px;
}

</style>



<script type="text/javascript">
function memberOk() {
	var f = document.memberForm;
	var str;

	
    str = f.pwd.value;
	str = str.trim();
    if(!str) {
        alert("비밀번호를 입력하세요. ");
        f.pwd.focus();
        return;
    }
    
    str = f.pwd.value;
	str = str.trim();
    if(!str) {
        alert("비밀번호를 입력하세요. ");
        f.pwd.focus();
        return;
    }
    
    
function pwdCheck() {
	var str = $("#pwd").val();
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
			if(p=="true") {
				var s="<span style='color:blue;font-weight:bold;'>"+str+"</span> 사원번호는 사용 가능합니다.";
				$("#memberNum").parent().next(".help-block").html(s);
			} else {
				var s="<span style='color:red;font-weight:bold;'>"+str+"</span> 사원번호는 사용할 수 없습니다.";
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
    <div class="body-title">
        <h3><span style="font-family: Webdings">2</span>비밀번호 변경</h3>
    </div>
    
        <div>
			<form name="memberForm" method="post">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			 <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">패스워드</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="password" name="pwd" maxlength="15" class="boxTF"
			                       style="width:95%;" placeholder="패스워드">
			        </p>
			        <p class="help-block">패스워드는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">패스워드 확인</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="password" name="pwdcheck" maxlength="15" class="boxTF"
			                       style="width: 95%;" placeholder="패스워드 확인">
			        </p>
			        <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
			      </td>
			  </tr>
			</table>
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" name="sendButton" class="btn" onclick="pwdCheck();">비밀번호 변경</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/member/logout';">변경취소</button>
			      </td>
			    </tr>
			    <tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
			  </table>
			</form>
        </div>

</div>
