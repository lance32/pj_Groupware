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
        <div>
			<form name="payForm" method="post">

			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">사번</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="memberNum" id="memberNum" value="${dto.memberNum}"
                         onchange="memberNumCheck();" style="width: 95%;" placeholder=""
                         ${mode=="update" ? "readonly='readonly' ":""}
                         maxlength="15" class="boxTF" placeholder="사원 번호">
			        </p>
			        <p class="help-block">사번은 8자 이며 모두 숫자로 구성되어야 합니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">이름</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="name" value="${dto.name}" maxlength="30" class="boxTF"
		                      style="width: 95%;"
		                      placeholder="이름">
			        </p>
			      </td>
			  </tr>
			  
		  <c:if test="${sessionScope.member.userId=='admin'}">
		  		<tr>
						<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
							<label style="font-weight: 900;">근무구분</label>
						</td>
						 <td style="padding: 0 0 15px 15px;">
						  <p style="margin-top: 1px; margin-bottom: 5px;">
							<select class="selectField" id="status" name="status">
							<option value="">선 택</option>
							<option value="0" ${dto.status==status ? "selected='selected'" : ""}>퇴사</option>
							<option value="1" ${dto.status==status ? "selected='selected'" : ""}>재직</option>
							<option value="2" ${dto.status==status ? "selected='selected'" : ""}>휴직</option>
							<option value="3" ${dto.status==status ? "selected='selected'" : ""}>정직</option>
							</select>
						  </p>
						</td>
					</tr>

			   <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">부서</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select class="selectField" id="departmentNum" name="departmentNum" >
			               <option value="">선 택</option>
			            <c:forEach var="map" items="${departmentList}">
			                <option value="${map.DEPARTMENTNUM}" ${dto.departmentNum==map.DEPARTMENTNUM ? "selected='selected'" : ""}>${map.DEPARTMENTNAME}</option>
			            </c:forEach>
			            </select>
			         </p>
			      </td>
			  </tr>
					
			   <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">직급</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select class="selectField" id="positionNum" name="positionNum" >
			                <option value="">선 택</option>
			               <c:forEach var="map" items="${positionList}">
			               	 <option value="${map.POSITIONNUM}" ${dto.positionNum==map.POSITIONNUM ? "selected='selected'" : ""}>${map.POSITIONNAME}</option>
			               </c:forEach>
			            </select>
			        </p>
			      </td>
			  </tr>
			</c:if>

			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">생년월일</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="birth" value="${dto.birth}" maxlength="10" 
			                       class="boxTF" style="width: 95%;" placeholder="생년월일">
			        </p>
			        <p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">이메일</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select name="selectEmail" onchange="changeEmail();" class="selectField">
			                <option value="">선 택</option>
			                <option value="groupware.com" ${dto.email2=="groupware.com" ? "selected='selected'" : ""}>회사메일</option>
			                <option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
			                <option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
			                <option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
			                <option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
			                <option value="direct">직접입력</option>
			            </select>
			            <input type="text" name="email1" value="${dto.email1}" size="13" maxlength="30"  class="boxTF">
			            @ 
			            <input type="text" name="email2" value="${dto.email2}" size="13" maxlength="30"  class="boxTF" readonly="readonly">
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">집 전화</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select class="selectField" id="tel1" name="tel1" >
			                <option value="">선 택</option>
			                <option value="02" ${dto.tel1=="02" ? "selected='selected'" : ""}>02</option>
			                <option value="031" ${dto.tel1=="031" ? "selected='selected'" : ""}>031</option>
			                <option value="032" ${dto.tel1=="032" ? "selected='selected'" : ""}>032</option>
			                <option value="033" ${dto.tel1=="033" ? "selected='selected'" : ""}>033</option>
			                <option value="041" ${dto.tel1=="041" ? "selected='selected'" : ""}>041</option>
			                <option value="042" ${dto.tel1=="042" ? "selected='selected'" : ""}>042</option>
			                <option value="043" ${dto.tel1=="043" ? "selected='selected'" : ""}>043</option>
			                <option value="044" ${dto.tel1=="044" ? "selected='selected'" : ""}>044</option>
			                <option value="051" ${dto.tel1=="051" ? "selected='selected'" : ""}>051</option>
			                <option value="052" ${dto.tel1=="052" ? "selected='selected'" : ""}>052</option>
			                <option value="053" ${dto.tel1=="053" ? "selected='selected'" : ""}>053</option>
			                <option value="054" ${dto.tel1=="054" ? "selected='selected'" : ""}>054</option>
			                <option value="055" ${dto.tel1=="055" ? "selected='selected'" : ""}>055</option>
			                <option value="061" ${dto.tel1=="061" ? "selected='selected'" : ""}>061</option>
			                <option value="062" ${dto.tel1=="062" ? "selected='selected'" : ""}>062</option>
			                <option value="063" ${dto.tel1=="063" ? "selected='selected'" : ""}>063</option>
			                <option value="064" ${dto.tel1=="064" ? "selected='selected'" : ""}>064</option>
			            </select>
			            -
			            <input type="text" name="tel2" value="${dto.tel2}" class="boxTF" maxlength="4">
			            -
			            <input type="text" name="tel3" value="${dto.tel3}" class="boxTF" maxlength="4">
			        </p>
			      </td>
			  </tr>
			  
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">휴대전화</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select class="selectField" id="phone1" name="phone1" >
			                <option value="">선 택</option>
			                <option value="010" ${dto.phone1=="010" ? "selected='selected'" : ""}>010</option>
			                <option value="011" ${dto.phone1=="011" ? "selected='selected'" : ""}>011</option>
			                <option value="016" ${dto.phone1=="016" ? "selected='selected'" : ""}>016</option>
			                <option value="017" ${dto.phone1=="017" ? "selected='selected'" : ""}>017</option>
			                <option value="018" ${dto.phone1=="018" ? "selected='selected'" : ""}>018</option>
			                <option value="019" ${dto.phone1=="019" ? "selected='selected'" : ""}>019</option>
			            </select>
			            -
			            <input type="text" name="phone2" value="${dto.phone2}" class="boxTF" maxlength="4">
			            -
			            <input type="text" name="phone3" value="${dto.phone3}" class="boxTF" maxlength="4">
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 2px;">
			            <label style="font-weight: 900;">우편번호</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="zip" id="zip" value="${dto.zip }"
			                       class="boxTF" readonly="readonly">
			            <button type="button" class="btn" onclick="daumPostcode();">우편번호</button>          
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">주소</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="addr1" id="addr1"  value="${dto.addr1}" maxlength="50" 
			                       class="boxTF" style="width: 95%;" placeholder="기본 주소" readonly="readonly">
			        </p>
			        <p style="margin-bottom: 5px;">
			            <input type="text" name="addr2" id="addr2" value="${dto.addr2}" maxlength="50" 
			                       class="boxTF" style="width: 95%;" placeholder="나머지 주소">
			        </p>
			      </td>
			      
			  </tr>
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px; margin-top:10px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" name="sendButton" class="btn" onclick="memberOk();">${mode=="created"?"사원 추가":"정보수정"}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/main';">${mode=="created"?"추가취소":"수정취소"}</button>
			      </td>
			    </tr>
			    <tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
			  </table>
			</form>
        </div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>
</div>
