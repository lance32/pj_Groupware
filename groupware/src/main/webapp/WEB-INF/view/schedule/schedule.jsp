<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/fullcalendar/fullcalendar.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/fullcalendar/fullcalendar.print.css" media='print' type="text/css">

<style type="text/css">
#calendar {
	margin: 20px auto 10px;
}

#schLoading {
	display: none;
	position: absolute;
	top: 10px;
	right: 10px;
}

.schTab {
	color: #555;
    cursor: default;
    background-color: #fff;
    border: 1px solid #ddd;
    border-bottom-color: transparent;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/lib/moment.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/fullcalendar.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/locale-all.js"></script>

<script type="text/javascript">
//-------------------------------------------------------
//달력
var calendar=null;
var group="all";
var tempContent;

$(function() {
		calendar = $('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay,listMonth'
			},
			locale: 'ko',
			selectable: true,
			selectHelper: true,
			select: function(start, end, allDay) {
				// start, end : moment 객체
				// 일정하나를 선택하는 경우 종일일정인경우 end는 start 보다 1일이 크다.
				//  캘런더에 start<=일정날짜또는시간<end 까지 표시함
				
				// 달력의 빈공간을 클릭하거나 선택할 경우 입력 화면
				insertForm(start, end);
				
			},
			eventClick: function(calEvent, jsEvent, view) {
				// 일정 제목을 선택할 경우 상세 일정
				articleForm(calEvent);
			},
			editable: true,
			eventLimit: true,
			events: function(start, end, timezone, callback){
				// 캘린더가 처음 실행되거나 월이 변경되면
				var startDay=start.format("YYYY-MM-DD");
				var endDay=end.format("YYYY-MM-DD");
		        
				var url="<%=cp%>/schedule/month";
                var query="start="+startDay+"&end="+endDay+"&group="+group+"&tmp="+new Date().getTime();
				$.ajax({
				    url: url,
				    data:query,
				    dataType: 'json',
				    success: function(data, text, request) {
				    	var events = eval(data.list);
				        callback(events);
				    },
				    beforeSend : function(jqXHR) {
				        jqXHR.setRequestHeader("AJAX", true);
				    },
				    error:function(jqXHR) {
				    	if(jqXHR.status==403) {
				    		location.href="<%=cp%>/login";
				    		return;
				    	}
				    }
				});
			},
			eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) {
				// 일정을 드래그 한 경우
				updateDrag(event);
			},
			eventResize: function(event, dayDelta, minuteDelta, allDay, revertFunc) {
				// 일정의 크기를 변경 한 경우
				updateDrag(event);
			},
			loading: function(bool) {
				$('#schLoading').toggle(bool);
			}
		});
		
		$("body").on("click", "#schPlace", function(){
			window.open("<%=cp%>/mapTest.jsp", "width=800,height=600");
		});
});

// 분류별 검색
function classification(kind, idx) {
	$("#calendarHeader li").each(function(){
		$(this).removeClass("schTab");
	});
	$("#calendarHeader a").each(function(){
		$(this).removeAttr('style');
	});
	
	$("#calendarHeader li:eq("+idx+")").addClass("schTab");
	$("#calendarHeader li a:eq("+idx+")").css("font-weight", "bold");
	$("#calendarHeader li a:eq("+idx+")").css("color", kind);

	group=kind;
	calendar.fullCalendar('refetchEvents');
}

// 상세 일정 보기
function articleForm(calEvent) {
	var str;
	
	var num=calEvent.id;
	var title=calEvent.title;
	var name=calEvent.name;
	var color=calEvent.color;
	
	var classify="";
	
	if(color=="blue") classify="개인일정";
	else if(color=="black") classify="가족일정";
	else if(color=="green") classify="회사일정";
	else if(color=="red") classify="부서일정";
	
	var allDay=calEvent.allDay;
	var place = calEvent.place;
	
	var startDay="", startTime="", sday="";
	var endDay="", endTime="", eday="";
	
	var strDay;
	startDay=calEvent.start.format("YYYY-MM-DD");
	if(calEvent.start.hasTime()) {
	    startTime=calEvent.start.format("HH:mm");
	    if(calEvent.end!=null && calEvent.start.format()!=calEvent.end.format()) {
			endDay=calEvent.end.format("YYYY-MM-DD");
			endTime=calEvent.end.format("HH:mm");
		}	    
	} else {
		if(calEvent.end!=null && calEvent.start.format()!=calEvent.end.add("-1", "days").format()) {
			endDay=calEvent.end.format("YYYY-MM-DD");
		}
		if(calEvent.end!=null)
		    calEvent.end.add("1", "days");
	}
	// 종일일정이 아닐때
	if(allDay==false) {
		sday=startDay+" "+startTime;
		eday=endDay+" "+endTime;
		strDay="시간일정";
	//종일일정
	}else if(allDay == true && endDay=="") {
		sday=startDay;
		eday=startDay;
		//시작-종료 시간값 없음
		startTime="";
		endTime="";
		strDay="하루종일";
	} else {
		sday=startDay;
		eday=endDay;
		startTime="";
		endTime="";
		strDay="하루종일";
	}
	
	var content=calEvent.content;
	if(! content) content="";
	tempContent=content;
	
	var dlg = $("#scheduleModal").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
			  //작성자만 수정 가능
		       " 수정 " : function() {
		    	   if(name == "${sessionScope.member.userName}"){
		    		   updateForm(num,title,allDay,startDay,endDay,startTime,endTime,color,place);
		    	   } else {
					   alert("작성자 본인만 수정할 수 있습니다!");
					   return false;
				   }
		        },
		        // 작성자만 삭제 가능
			   " 삭제 " : function() {
				   if(name == "${sessionScope.member.userName}"){
					   deleteOk(num);				   
				   }
				   else{
					   alert("작성자 본인만 삭제할 수 있습니다!");
					   return false;
				   }
			   },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		        }
		  },
		  height: 480,
		  width: 550,
		  title: "상세 일정",
		  close: function(event, ui) {
		  }
	});	
	
	$('#scheduleModal').load("<%=cp%>/schedule/articleForm", function() {
		$("#articleTitle").html(title);
		$("#articleName").html(name);
		$("#articleClassify").html(classify);
		$("#articleAllDay").html(strDay);
		$("#articleStartDay").html(sday);
		$("#articleEndDay").html(eday);
		$("#articlePlace").html(place);
		$("#articleContent").html(content);
		
		dlg.dialog("open");
	});
}

// 일정 등록 폼
function insertForm(start, end) {
	var dlg = $("#scheduleModal").dialog({
		  autoOpen: false,
		  modal: true,
		  resizable : false,
		  buttons: {
		       " 확인 " : function() {
		    	   insertOk();
		        },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		        }
		  },
		  height: 590,
		  width: 700,
		  title: "일정 추가",
		  close: function(event, ui) {
		  }
	});
	
	$('#scheduleModal').load("<%=cp%>/schedule/inputForm", function() {
		var startDay="", startTime="";
		var endDay="", endTime="";
		
		startDay=start.format("YYYY-MM-DD");
		startTime=start.format("HH:mm");
		
		endDay=end.format("YYYY-MM-DD");
		endTime=end.format("HH:mm");
		
		$("input[name='startDay']").val(startDay);
		$("select[name='startTime']").val(startTime);
		
		$("input[name='endDay']").val(endDay);
		$("select[name='endTime']").val(endTime);

		if(start.hasTime()) {
			// 시간 일정인 경우
			$("#allDay2").prop("checked",true);
			// 시간 입력칸 표시
			$("#schStartTime").show();
			$("#schEndTime").show();
			
			$("input[name='startTime']").val(startTime);
			if(start.format()!=end.format()) {
				endDay=end.format("YYYY-MM-DD");
				endTime=end.format("HH:mm");
			
				$("input[name='endDay']").val(endDay);
				$("select[name='endTime']").val(endTime);
			}
			
		} else {
			// 하루종일 일정인 경우
			$("input[name='startTime']").val("");
			$("select[name='endTime']").val("");
			// 시간 입력칸 숨김
			$("#schStartTime").hide();
			$("#schEndTime").hide();
			
			if(start.format()!=end.add("-1", "days").format()) {
				endDay=end.format("YYYY-MM-DD");
				$("input[name='endDay']").val(endDay);
			}
			end.add("1", "days")
		}
		
		dlg.dialog("open");
		calendar.fullCalendar('unselect');
	});	
}

// 새로운 일정 등록
function insertOk() {
	if(! validCheck())
		return;
	
	var query=$("form[name=schForm]").serialize();
	var url="<%=cp%>/schedule/created";

     $.ajax({
        type:"post"
        ,url:url
        ,data:query
        ,dataType:"json"
        ,success:function(data) {
	      	   var state=data.state;
	      	   if(state=="true") {
	      		   group="all";
	      		   calendar.fullCalendar('refetchEvents');
	
	      		    $("#calendarHeader li").each(function(){
	      				$(this).removeClass("schTab");
	      			});
	      			$("#calendarHeader li:eq(0)").addClass("schTab");
	          } else if(state=="false"){
	        	  alert("일정 등록 실패!");ㅇ
	        	  return false;
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
    
     $("#scheduleModal").dialog("close");
}

// 입력 값 유효성 체크
function validCheck() {
	var title=$.trim($("input[name='title']").val());
	var color=$.trim($("select[name='color']").val());
	var allDay=$("input[name=allDay]:checked").val();
	var startDay=$.trim($("input[name='startDay']").val());
	var endDay=$.trim($("input[name='endDay']").val());
	var startTime=$.trim($("select[name='startTime']").val());
	var endTime=$.trim($("select[name='endTime']").val());
	var content=$.trim($("textarea[name='content']").val());
	var place = $.trim($("input[name=place]").val());
	
	if(! title) {
		alert("제목을 입력 하세요 !!!");
		$("input[name='title']").focus();
		return false;
	}
	 
	 if((allDay == '0' && !startTime)){
		 alert("시작시간을 선택하세요!");
		 return false;
	 }
	 
	 if((allDay == '0' && !endTime)){
		 alert("종료시간을 선택하세요!");
		 return false;
	 }
	 
	 if(startDay > endDay) {
		 alert("시작일과 종료일을 다시 확인하세요!");
		 return false;
	 }
		 
	 if(! place){
		 alert("장소를 선택하세요!");
		 return false;
	 }

	// 종료 날짜는 종일일정인 경우 하루가 더 커야한다.
	// 캘런더에 start<=일정날짜또는시간<end 까지 표시함
    var end;
    if(endDay!="") {
    	if(endTime!="") {
        	end=moment(endDay+"T"+endTime);
			endDay=end.format("YYYY-MM-DD");
			endTime=end.format("HH:mm");
    	} else {
        	end=moment(endDay);
        	end=end.add("1", "days");
			endDay=end.format("YYYY-MM-DD");
    	}
    	$("input[name='endDay']").val(endDay);
    }
    
    if((startDay == endDay) && startTime >= endTime){
    	alert("시작시간과 종료시간을 다시 확인하세요!");
    	return false;
    }
    
	if(allDay=="true") {
		$("input[name='startTime']").val("");
		$("input[name='endTime']").val("");
	} else {
		$("input[name='endTime']").val(endTime);
	}
	
	return true;
}

// 수정 폼
function updateForm(num, title, allDay, startDay, endDay, startTime, endTime, color, place) {
	var dlg = $("#scheduleModal").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 확인 " : function() {
		    	   updateOk(num);
		        },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		        }
		  },
		  height: 650,
		  width: 700,
		  title: "일정 수정",
		  close: function(event, ui) {
		  }
	});
	
	$('#scheduleModal').load("<%=cp%>/schedule/inputForm", function() {
		$("input[name=title]").val(title);
		$("select[name=color]").val(color);
		$("input[name=startDay]").val(startDay);
		$("input[name=endDay]").val(endDay);
		$("select[name=startTime]").val(startTime);
		$("select[name=endTime]").val(endTime);
		$("textarea[name=content]").val(tempContent);
		$("input[name=place]").val(place);
		
		if(allDay==true || allDay=="true") {
			$("#allDay1").prop('checked', true);
			$("#allDay2").prop('checked', false);
			
			$("#schStartTime").hide();
			$("#schEndTime").hide();
		} else {
			$("#allDay1").prop('checked', false);
			$("#allDay2").prop('checked', true);
			
			$("#schStartTime").show();
			$("#schEndTime").show();
		}
		$("input[name='title']").focus();

		dlg.dialog("open");
	});	
}

// 수정 완료
function updateOk(num) {
	if(! validCheck())
		return;
	
	$("form[name=schForm] input[name=scheduleNum]").val(num);
	var url="<%=cp%>/schedule/update";
	var query=$("form[name=schForm]").serialize();
       
    $.ajax({
         type:"post"
         ,url:url
         ,data:query
         ,dataType:"json"
         ,success:function(data) {
        	 var state = data.state;
        	 if(state == 'true'){
        		 group="all";
            	 calendar.fullCalendar('refetchEvents', num);
            	 
       			$("#calendarHeader li").each(function(){
      				$(this).removeClass("schTab");
      			});
      			$("#calendarHeader li:eq(0)").addClass("schTab"); 
        	 } else {
        		 alert("일정 수정 실패!");
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
    
    $("#scheduleModal").dialog("close");
}

// 일정을 드래그하거나 일정의 크기를 변경할 때 일정 수정
function updateDrag(e) {
	var num=e.id;
	var title=e.title;
	var color=e.color;
	var allDay=e.allDay;
	var startDay="", startTime="";
	var endDay="", endTime="";
	
	startDay=e.start.format("YYYY-MM-DD");
	if(e.start.hasTime()) {
		// 시간 일정인 경우
		startTime=e.start.format("HH:mm");
		
		if(e.end) {
		    endDay=e.end.format("YYYY-MM-DD");
		    endTime=e.end.format("HH:mm");
		    if(e.start.format()==e.end.format()) {
			    endDay="";
			    endTime="";
		    }
		}
	} else {
		// 하루종일 일정인 경우
		if(e.end) {
			endDay=e.end.format("YYYY-MM-DD");
			if(e.start.format()==e.end.add("-1", "days").format()) {
				endDay="";
			}
			e.end.add("1", "days")
		}
	}
	
	if(startTime=="" && endTime=="") {
		allDay="true";
	} else {
		allDay="false";
	}
	
	var content=e.content;
	if(!content)
		content="";

	var query="num="+num
           +"&title="+title
           +"&color="+color
           +"&allDay="+allDay
           +"&startDay="+startDay
           +"&endDay="+endDay
           +"&startTime="+startTime
           +"&endTime="+endTime
           +"&content="+content;
	
	var url="<%=cp%>/schedule/update";
	$.ajax({
         type:"post"
         ,url:url
		 ,data:query
		 ,dataType:"json"
		 ,success:function(data) {
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

// 일정 삭제
function deleteOk(num) {
	if(confirm("삭제 하시겠습니까 ?")) {
		
		var url="<%=cp%>/schedule/delete";
		var query="scheduleNum="+num;
		$.ajax({
	         type:"post"
	         ,url:url
			 ,data:query
			 ,dataType:"json"
			 ,success:function(data) {
				 var state = data.state;
				 if(state == 'true')
					 calendar.fullCalendar('removeEvents', num);
				 else
					 alert("일정삭제 실패!");
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
	 $("#scheduleModal").dialog("close");
}

// -------------------------------------------------
// 입력 및 수정 화면에서 일정 분류를 선택 한 경우
function classifyChange(classify) {
	$("#scheduleModal input[name='color']").val(classify);
}

</script>

<div class="body-container" style="width: 75%;">
<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-calendar"
		style="font-size: 28px; margin-left: 10px;"></span> <span
		style="font-size: 30px;">&nbsp;일 정 관 리</span><br>
	<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
<div id="calendarHeader" style="height: 35px; line-height: 35px;">
	<div style="text-align: left;">
		<div class="container">
			<ul class="nav nav-tabs">
				<li class="schTab"><a href="javascript:classification('all', 0)">전 체 일 정</a></li>
				<li><a href="javascript:classification('blue', 1)">개 인 일 정</a></li>
				<li><a href="javascript:classification('black', 2)">가 족 일 정</a></li>
				<li><a href="javascript:classification('red', 3)">부 서 일 정</a></li>
				<li><a href="javascript:classification('green', 4)">회 사 일 정</a></li>
			</ul>
			<br>
		</div>
	</div>
</div>
<br>
<div id="calendar" style="width: 95%;"></div>
<div id='schLoading'>loading...</div>

</div>
<div id="scheduleModal" style="display: none;"></div>