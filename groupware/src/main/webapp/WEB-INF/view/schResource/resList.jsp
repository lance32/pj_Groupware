<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script>
$(function() {
	$("select[name=searchKey]").change(function(){
		var search = $("option:selected").val();
		if(search == 'start'){
			$("input[name=searchValue]").prop("readonly", true);
		} else {
			$("input[name=searchValue]").prop("readonly", false);
		}
	});
});

function searchList() {
	var f=document.searchResForm;
	f.submit();
}

$(function(){
	$("#addGroup").click(function(){
		var dlg = $("#insertModal").dialog({
			  autoOpen: false,
			  modal: true,
			  resizable : false,
			  buttons: {
			      " 확인 " : function() {
			   	   insertGroup();
			       },
			      " 닫기 " : function() {
			   	   $(this).dialog("close");
			       }
			  },
			  height: 200,
			  width: 500,
			  title: "자원 그룹 추가",
			  close: function(event, ui) {
			  }
		});
		
		$("#insertModal").load("<%=cp%>/scheduler/inputGroupForm", function(){
			dlg.dialog("open");
		});
	});
});

$(function(){
	$("#addResource").click(function(){
		var dlg = $("#insertModal").dialog({
			  autoOpen: false,
			  modal: true,
			  resizable : false,
			  buttons: {
			      " 확인 " : function() {
			   	   insertResource();
			       },
			      " 닫기 " : function() {
			   	   $(this).dialog("close");
			       }
			  },
			  height: 350,
			  width: 650,
			  title: "자원 항목 추가",
			  close: function(event, ui) {
			  }
		});
		
		$("#insertModal").load("<%=cp%>/scheduler/inputResourceForm", function(){
			dlg.dialog("open");
		});
	});
});

function insertGroup() {
	var gName = $("input[name=groupName]").val();
	if(! gName){
		alert("그룹명을 입력하세요!");
		return false;
	}
	
	var query = $("form[name=groupForm]").serialize();
	var url="<%=cp%>/scheduler/groupInsert";
	
    $.ajax({
        type:"post"
        ,url:url
        ,data:query
        ,dataType:"json"
        ,success:function(data) {
	      	   var state=data.state;
	      	   if(state=="true") {
	      		 $("#insertModal").dialog("close");
	      	   } else{
	      		   alert("그룹 추가 실패");
	      	   }
          }
          ,error:function(e) {
               console.log(e.responseText);
         }
    });
    $("#resourceModal").dialog("close");
}

function insertResource() {
	var rName = $("input[name=resourceName]").val();
	var color = $("input[name=color]").val();
	var occupancy = $("input[name=occupancy]").val();
	
	if(! rName){
		alert("항목명을 입력하세요!");
		return false;
	}
	
	if(! color){
		alert("사용할 색상을 입력하세요!");
		return false;
	}
	
	if(! /^(\d+)$/.test(occupancy)) {
		alert("최대 인원수(숫자)를 입력 하세요 !");
		$("input[name='inwon']").focus();
		return false;
	}
	
	var query = $("form[name=inputResourceForm]").serialize();
	var url="<%=cp%>/scheduler/resourceInsert";
	
    $.ajax({
        type:"post"
        ,url:url
        ,data:query
        ,dataType:"json"
        ,success:function(data) {
	      	   var state=data.state;
	      	   if(state=="true") {
	      		 $("#insertModal").dialog("close");
	      		 location.reload();
	      		 
	      	   } else{
	      		   alert("항목 추가 실패");
	      	   }
          }
          ,error:function(e) {
               console.log(e.responseText);
         }
    });
    $("#resourceModal").dialog("close");
}

$(function(){
	$("#chkAll").click(function(){
		if($("#chkAll").prop("checked")){
			$("input[name=chkbtn]").prop("checked", true);
		} else {
			$("input[name=chkbtn]").prop("checked", false);
		}
	});
});

$(function(){
	$("#delResource").click(function(){
		var chkNum="";
		$("input[name=chkbtn]:checked").each(function(){
			chkNum += $(this).val()+";";
		});
		chkNum = chkNum.substring(0,chkNum.lastIndexOf(";"));
		if(chkNum == ""){
			alert("삭제할 항목을 선택하세요!");
			return false;
		}
		var url = "<%=cp%>/scheduler/resourceDelete";
		query = "chkNum="+chkNum;
		if(confirm("게시물을 삭제 하시겠습니까?")){
			$.ajax({
				type:"post"
				,url:url
				,data:query
				,dataType:"json"
				,success:function(data) {
					var state=data.state;
					if(state=="true") {
						location.reload();
					} else if(state=="false") {
						alert("항목을 삭제하지 못했습니다.");
						location.reload();
					}
				}
				,beforeSend : function(jqXHR) {
			        jqXHR.setRequestHeader("AJAX", true);
			    }
			    ,error:function(jqXHR) {
			    	if(jqXHR.status==403) {
			    		location.href="<%=cp%>/login";
			    		return;
			    	}
			    	console.log(jqXHR.responseText);
			    }
			});
		}
	});
});
</script>
<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-calendar"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;자 원 관 리</span><br>
	<div
		style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
<table id="tb" style="width: 85%;">
	<tr style="height: 35px;">
		<td id="count" colspan="2">${dataCount }개(${page }/${total_page } 페이지)</td>
		<td></td>
		<td align="right">
			<button id="addGroup" type="button" class="butn">그 룹 추 가</button>
			<button id="addResource" type="button" class="butn">항 목 추 가</button>
			<button id="delResource" type="button" class="butn">선 택 삭 제</button>
		</td>
	</tr>

	<tr class="cf">
		<td width="70"><input id="chkAll" type="checkbox" value="all"></td>
		<td width="190">구 분</td>
		<td width="350" style="text-align: center;">항 목 명</td>
		<td width="250">최 대 인 원</td>
	</tr>
	<c:forEach var="dto" items="${list}">
		<tr class="tr">
			<td><input type="checkbox" name="chkbtn" value="${dto.resourceNum }"></td>
			<td>${dto.groupName }</td>
			<td>${dto.resourceName }</td>
			<td>${dto.occupancy }</td>
		</tr>
	</c:forEach>
</table>
<br>
${paging }

<div id="insertModal" style="display: none;"></div>