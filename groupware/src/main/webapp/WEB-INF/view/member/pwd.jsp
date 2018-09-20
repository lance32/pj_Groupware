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
function pwdOk() {
	var f = document.pwdForm;
	var str;

	str = f.memberNum.value;
	str = str.trim();
	if(!str) {
		alert("아이디를 입력하세요. ");
		f.memberNum.focus();
		return;
	}
	if(!/^[0-9]{4,8}$/i.test(str)) { 
		alert("아이디는 5~10자이며 첫글자는 영문자이어야 합니다.");
		f.memberNum.focus();
		return;
	}
	f.memberNum.value = str;

	
    str = f.name.value;
	str = str.trim();
    if(!str) {
        alert("이름을 입력하세요. ");
        f.name.focus();
        return;
    }
    f.name.value = str;

    str = f.birth.value;
	str = str.trim();
    if(!str) {
        alert("생년월일를 입력하세요[YYYY-MM-DD]. ");
        f.birth.focus();
        return;
    }
    
    
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

    str = f.email2.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email2.focus();
        return;
    }
	
    var mode="${mode}";
    
    if(mode=="created")
   		f.action = "<%=cp%>/member/member";
	else
   		f.action = "<%=cp%>/member/update";

    f.submit();
}

function changeEmail() {
    var f = document.memberForm;
	    
    var str = f.selectEmail.value;
    if(str!="direct") {
        f.email2.value=str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value="";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

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
        <h3><span style="font-family: Webdings">2</span> 비밀번호 변경 </h3>
    </div>
    
        <div>
			<form name="pwdForm" method="post">

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
			            <input type="password" name="pwdCheck" maxlength="15" class="boxTF"
			                       style="width: 95%;" placeholder="패스워드 확인">
			        </p>
			        <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
			      </td>
			  </tr>
			  
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" name="sendButton" class="btn" onclick="pwdOk();">비밀번호 변경</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/member/main';">변경 취소</button>
			      </td>
			    </tr>
			    <tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
			  </table>
			</form>
        </div>
</div>
