<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록 연락처 등록</title>
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css?ver=12443" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css?ver=1" type="text/css">
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
function sendOk() {
    var f = document.boardForm;

	var str = f.subject.value;
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

	str = f.content.value;
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }

	f.action="<%=cp%>/bbs/${mode}";

    f.submit();
}

jQuery(function(){
	
	jQuery("#addAddressBtn").click(function(){
		var form=document.addAddressForm;
		
		form.action="<%=cp%>/addressBook/created";
		
		form.submit();
	});
	
});

</script>
</head>
<body>
연락처 등록
<%--
	private String name;
	private String tel;
	private String fax;
	private String email;
	private String belongto;	
	private String zip;	
	private String addr1, addr2;
 --%>
 <form name="addAddressForm" method="post">
	 이름* : <input type="text" name="name"><br>
	 전화번호* : <input type="text" name="tel"><br>
	 fax 번호 : <input type="text" name="fax"><br>
	 이메일 : <input type="text" name="email"><br>
	 우편번호 : <input type="text" name="zip"><br>
	 주소1 : <input type="text" name="addr1"><br>
	 주소2 : <input type="text" name="addr2"><br>
	 소속 : <input type="text" name="belongto"><br>
	 <button id="addAddressBtn" type="button">연락처 추가</button>
</form>
<br>
선택박스로 그룹구분 만들기


</body>
</html>