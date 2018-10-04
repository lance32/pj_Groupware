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
	
	str = f.upload.value;
	str = str.trim();
    if(!str) {
        alert("파일을 등록해 주세요. ");
        f.upload.focus();
        return;
    }

<c:if test="${mode=='created'}">
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
</c:if>
<c:if test="${mode=='update'}">
	str = f.pwd.value;
	str = str.trim();
	if(!str) {
		alert("비밀번호를 입력하세요. ");
		f.pwd.focus();
		return;
	}
	
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		alert("비밀번호는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.pwd.focus();
		return;
	}
	
	f.pwd.value = str;
	
	if(str!= f.pwdCheck.value) {
	    alert("비밀번호가 일치하지 않습니다. ");
	    f.pwdCheck.focus();
	    return;
	}
</c:if>
	
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
    
<c:if test="${sessionScope.member.userId=='admin'}">
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
</c:if> 

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
			if(p=="true") {
				var s="<span style='color:blue;font-weight:bold;'>"+str+"사원번호는 사용 가능합니다.</span><br>";
				
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
        <div>
			<form name="payForm" method="post">

			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">사원 번호</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="memberNum" id="memberNum" value="${dto.memberNum}"
                         onchange="memberNumCheck();" style="width: 95%;" placeholder=""
                         maxlength="15" class="boxTF" placeholder="사원 번호">
			        </p>
			        <p class="help-block"></p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">기본급</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="name" value="${dto.name}" maxlength="30" class="boxTF"
		                      style="width: 95%;"
		                      placeholder="기본급">
			        </p>
			      </td>
			  </tr>
			  
			   <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">기본급</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="name" value="${dto.name}" maxlength="30" class="boxTF"
		                      style="width: 95%;"
		                      placeholder="기본급">
			        </p>
			      </td>
			  </tr>
			  
			  
			  
			  
			  
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">수당</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="birth" value="${dto.birth}" maxlength="10" 
			                       class="boxTF" style="width: 95%;" placeholder="수당">
			        </p>
			        <p class="help-block"></p>
			      </td>
			  </tr>
			  
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px; margin-top:10px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" name="sendButton" class="btn" onclick="memberOk();">${mode=="insert"?"급여 추가":"급여 수정"}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/pay/adminMain';">${mode=="insert"?"추가 취소":"수정취소"}</button>
			      </td>
			    </tr>
			    <tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
			  </table>
			</form>
        </div>

</div>
