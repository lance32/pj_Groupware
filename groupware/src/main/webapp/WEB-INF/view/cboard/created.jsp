<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script>
$(function(){
	$("#btnSend").click(function(){
		var subVal = $('input[name=title]').val();
		var contentVal = $('textarea').val();
		
		if(!subVal || !contentVal){
			alert("입력하지 않은 영역이 있습니다.");
			return;
		}
        $("form[name=boardForm]").attr("action","<%=cp%>/${cb.tableName}/${mode}");
        $("form[name=boardForm]").submit();
	});
	
	$(".btnReset").click(function(){
		$(".moreFile").remove();
	});
});


<c:if test="${mode=='update' && cb.canFile=='1'}">
function deleteFile(fileNum) {
		var url="<%=cp%>/${cb.tableName}/deleteFile";
		var query = "fileNum="+fileNum;
		
		$.ajax({
			type : "post",
			url : url,
			data : query,
			dataType : "json",
			success:function(data) {
				var state=data.state;
				if(state=="true") {
					$("#f"+fileNum).remove();
					window.location.reload();
				} else if(state=="false") {
					alert("파일 삭제 실패!!!");
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
}
</c:if>

<c:if test="${cb.canFile=='1'}">
$(function(){
  	$("body").on("change", "input[name=upload]", function(){
  		if(! $(this).val()) {
  			return;	
  		}
  		
  		var b=false;
  		$("input[name=upload]").each(function(){
  			if(! $(this).val()) {
  				b=true;
  				return;
  			}
  		});
  		if(b)
  			return;
  			
  		if($("input[name=upload]").length > 2){
  			alert("파일은 최대 3개까지만 등록할 수 있습니다.");
  			return;
  		}
  		
  		var $tr, $td, $input;
  		
  	    $tr=$("<tr height='40' class='moreFile'>");
  	    $td=$("<td>", {width:"100", style:"text-align: left;", html:""});
  	    $tr.append($td);
  	    $td=$("<td>");
  	    $input=$("<input>", {type:"file", name:"upload", class:"boxTF", style:"width: 98%; height: 25px;"});
  	    $td.append($input);
  	    $tr.append($td);
  	    
  	    $("#tb").append($tr);
  	    
  	});
});
</c:if>
 
</script>
<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-bullhorn"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;${cb.boardName }</span><br>
	<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>

<div class="container">
	<form name="boardForm" method="post" enctype="multipart/form-data">
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label for="name">작성자</label>
					<input type="text" class="form-control" name="name" readonly="readonly" value="${sessionScope.member.userName}">
				</div>
			</div>

		</div>

		<div class="form-group">
			<label for="subject">제 목</label>
			<input type="text" class="form-control" name="title" placeholder="제목을 입력하세요." value="${dto.title}">
		</div>


		<div class="form-group">
			<label for="content">내 용</label>
			<textarea class="form-control" rows="20" name="content" style="resize: none;">${dto.content }</textarea>
		</div>
		
		<c:if test="${cb.canFile == '1'}">
			<div class="form-group" id="tb">
				<label for="File">파 일 첨 부</label> <input type="file" name="upload"><br>
			</div>
		</c:if>
		
		<c:if test="${mode=='update'}">
			<c:forEach var="vo" items="${listFile}">
				  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;" id="f${vo.fileNum}">
				      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
				      <td style="padding-left:10px;"> 
				          ${vo.originalFilename}
				          <c:if test="${not empty vo.saveFilename}">
				          		| <a href="javascript:deleteFile('${vo.fileNum}');">파일삭제</a>&nbsp;
				          </c:if>
				       </td>
				  </tr>
			</c:forEach>
		</c:if>

		<div class="center-block" style='width: 300px'>
			<button type="button" class="btn" id="btnSend">${mode=='update'?'수 정 완 료':'등 록 하 기'}</button>
			<button type="reset" class="btn btnReset">다 시 쓰 기</button>
			<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/${cb.tableName}/list';">${mode=='update'?'수 정 취 소':'뒤 로 가 기'}</button>
		</div>
		
		<c:if test="${mode=='update'}">
			<input type="hidden" name="num" value="${dto.num}">		
			<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
			<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
			<input type="hidden" name="page" value="${page}">
		</c:if>
		
		<c:if test="${mode=='answer'}">
			<input type="hidden" name="page" value="${page}">
			<input type="hidden" name="groupNum" value="${dto.groupNum}">
			<input type="hidden" name="orderNo" value="${dto.orderNo}">
			<input type="hidden" name="depth" value="${dto.depth}">
			<input type="hidden" name="parent" value="${dto.num}">
		</c:if>
	</form>
</div>