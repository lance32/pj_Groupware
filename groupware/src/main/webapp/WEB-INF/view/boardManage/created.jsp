<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>
label{
	font-size: 20px;
}
</style>

<script>
$(function(){
	$("#btnCreateBoard").click(function(){
		var str = $("input[name=boardName]").val().trim();
		if(! str){
			$("input[name=boardName]").focus();
			alert("게시판 제목을 입력하세요.");
			return;
		}
		
		var str = $("input[name=tableName]").val().trim();
		if(! str){
			$("input[name=tableName]").focus();
			alert("게시판 주소를 입력하세요.");
			return;
		}
		
    	if(! /^[a-z]{2,20}$/g.test(str)) { 
    		alert("게시판 주소는 2~20자의 영어 소문자만 가능합니다.");
    		$("input[name=tableName]").focus();
    		return;
    	}
		
		var str = $("input[name=permit]:checked").val().trim();
		if(! str){
			alert("글쓰기 권한을 선택하세요.");
			return;
		}
		
		var str = $("input[name=subMenu]").val().trim();
		if(! str){
			$("input[name=subMenu]").focus();
			alert("메뉴 위치를 입력하세요.");
			return;
		}
		
        if(!/^(\d+)$/.test(str)) {
            alert("숫자만 가능합니다. ");
            $("input[name=subMenu]").focus();
            return false;
        }
		
		$("form[name=boardManageForm]").attr("action","<%=cp%>/boardManage/${mode}");
        $("form[name=boardManageForm]").submit();
	});
});

</script>

<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-list-alt" style="font-size: 28px; margin-left: 10px;"></span> 
		<span style="font-size: 30px;">&nbsp;게 시 판 관 리</span><br>
	<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
<p style="color: red;">${msg }</p>
<div class="container">
  <form name="boardManageForm" method="post">
    <div class="form-group">
      <label for="boardName">게시판 제목</label>
      <input type="text" class="form-control" placeholder="게시판 제목으로, 필수 입력 사항 입니다." name="boardName" value="${dto.boardName }" style="width:70%;">
    </div>

    <div class="form-group">
      <label for="tableName">게시판 주소</label>
      <input type="text" class="form-control" placeholder="2~20자 이내의 영어 소문자만 가능하며, 필수 입력 사항 입니다." name="tableName" value="${dto.tableName }" style="width:70%;">
    </div>

    <div class="form-group">
      <label for="permit">글쓰기 권한</label><br>
      <input type="radio" name="permit" value="0" ${dto.writePermit==0?"checked='checked';":"" }>
      <span style="font-size: 17px;">관 리 자</span> &nbsp;&nbsp;&nbsp; 
      <input type="radio" name="permit" value="1" ${dto.writePermit==1?"checked='checked';":"" }>
      <span style="font-size: 17px;">회 원</span> &nbsp;&nbsp;&nbsp; 
    </div>
    
    <div class="form-group">
      <label for="subMenu">메 뉴 위 치</label>
      <input type="text" class="form-control" placeholder="숫자만 가능하며 화면 좌측의 메뉴 인덱스(1부터 시작) 입니다. 같은 인덱스가 존재할 경우 최근에 만들어진 게시판이 상단에 위치합니다." name="subMenu" value="${dto.subMenu }" style="width:70%;">
    </div>

   	<div class="form-group">
      <label for="tableName">게시판 옵션</label><br>
		<span><input type="checkbox" name="canAnswer" value="1" ${dto.canAnswer==1?"checked='checked';":"" }> 답변형</span>&nbsp;&nbsp;&nbsp;
		<span><input type="checkbox" name="canFile" value="1" ${dto.canFile==1?"checked='checked';":"" }> 파일첨부</span>&nbsp;&nbsp;&nbsp;
		<span><input type="checkbox" name="canLike" value="1" ${dto.canLike==1?"checked='checked';":"" }> 게시글 추천</span>&nbsp;&nbsp;&nbsp;
		<span><input type="checkbox" name="canReply" value="1" ${dto.canReply==1?"checked='checked';":"" }> 리플형</span>&nbsp;&nbsp;&nbsp;
    </div>
    
   	<c:if test="${mode=='update'}">
   		<input type="hidden" name="boardNum" value="${dto.boardNum}">
	</c:if>
    <button type="button" class="btn" id="btnCreateBoard">${mode=='update'?'수정완료':'생성하기'}</button>
    <button type="reset" class="btn">초 기 화</button>
    <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/boardManage/list';">돌 아 가 기</button>
  </form>
</div>