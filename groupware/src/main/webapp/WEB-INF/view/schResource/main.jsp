<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/fullcalendar/fullcalendar.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/fullcalendar/fullcalendar.print.css" media='print' type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/fullcalendar/scheduler/scheduler.css" type="text/css">

<style type="text/css">
/* 내용 */
.ui-widget-content {
   /* border: none; */
   border-color: #cccccc;
}

#calendar {
    max-width: 1000px;
	margin: 10px auto 10px;
}

#resLoading {
	display: none;
	position: absolute;
	top: 10px;
	right: 10px;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/lib/moment.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/fullcalendar.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/locale-all.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/scheduler/scheduler.js"></script>

<script type="text/javascript">
var calendar=null;

$(function() {
	calendar=$('#calendar').fullCalendar({
		editable: true, 
		selectable: true,
		selectHelper: true,
		locale: 'ko',
		aspectRatio: 1.8,
		scrollTime: '09:00',
		header: {
			left: 'today prev,next',
			center: 'title',
			right: 'timelineDay,timelineThreeDays,agendaWeek,month,list'
		},
		defaultView: 'timelineDay',
		views: {
			timelineThreeDays: {
				type: 'timeline',
				duration: { days: 3 }
			}
		},

		resourceGroupField: 'groupName',
		resources: {
			url: '<%=cp%>/scheduler/resources',
			type:'post',
			error: function() {
				console.log("error");
			}
		},
		
		events: function(start, end, timezone, callback){
			var startDay=start.format("YYYY-MM-DD");
			var endDay=end.format("YYYY-MM-DD");
			var url= '<%=cp%>/scheduler/events';
			var query="start="+startDay+"&end="+endDay;

			$.ajax({
			    url: url,
			    type:"post",
			    data: query,
			    dataType: 'json',
			    success: function(data, text, request) {
			        callback(data);
			    }
			});
		},
		
		select: function(start, end, jsEvent, view, resource) {
			insertForm(start, end, resource);
		},
		
		eventClick: function(calEvent, jsEvent, view) {
			// 일정 제목을 선택할 경우
			articleForm(calEvent);
		},
		
		eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) {
			// 일정을 드래그 한 경우
			updateDrag(event);
		},
		eventResize: function(event, dayDelta, minuteDelta, allDay, revertFunc) {
			// 일정의 크기를 변경 한 경우
			updateDrag(event);
		},
		
		// schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source'
		schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives' // 비영리기관라이선스
	});
});

// 입력 폼
function insertForm(start, end, resource) {
	var groupNum="";
	var resourceNum="";
	
	if(resource) {
		resourceNum = resource.id;
		var url="<%=cp%>/scheduler/readResourceList";
	    var query="resourceNum="+resourceNum;
	     $.ajax({
	        type:"post"
	        ,url:url
	        ,data:query
	        ,dataType:"json"
	        ,success:function(data) {
	        	   var state=data.state;
	        	   if(state=="false") {
	        		   return;
	        	   }
	        	   groupNum=data.dto.groupNum;
	          }
	          ,error:function(e) {
	        	  console.log(e.responseText);
	          }
	    });
	}
	
	var dlg = $("#resourceModal").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		      " 확인 " : function() {
		   	   insertOk();
		       },
		      " 닫기 " : function() {
		   	   $(this).dialog("close");
		       }
		  },
		  height: 810,
		  width: 700,
		  title: "스케쥴러 등록",
		  close: function(event, ui) {
		  }
	});
	
	$('#resourceModal').load("<%=cp%>/scheduler/inputForm", function() {
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
			$("#allDay4").prop("checked",true);
			$("#resStartTime").show();
			$("#resEndTime").show();

			$("input[name='startTime']").val(startTime);
			if(start.format()!=end.format()) {
				endDay=end.format("YYYY-MM-DD");
				endTime=end.format("HH:mm");
			
				$("input[name='endDay']").val(endDay);
				$("input[name='endTime']").val(endTime);
			}
			
		} else {
			// 하루종일 일정인 경우
			$("#allDay3").prop("checked",true);
			$("input[name='startTime']").val("");
			$("input[name='endTime']").val("");
			$("#resStartTime").hide();
			$("#resEndTime").hide();
			
			if(start.format()!=end.add("-1", "days").format()) {
				endDay=end.format("YYYY-MM-DD");
				$("input[name='endDay']").val(endDay);
			}
			end.add("1", "days")
		}
		
		// 분류에 따른 항목 가져오기
		changeGroup(groupNum, resourceNum);
	     
		dlg.dialog("open");

	});
}


function changeGroup(groupNum, resourceNum) {
	if(groupNum==undefined || groupNum=="") {
		groupNum=$("form[name=resForm] select[name=groupNum]").val();
	}
	
	if(groupNum==undefined || groupNum==""){
		return;
	}
	
	var url="<%=cp%>/scheduler/listResourceList";
    var query="groupNum="+groupNum;
    
     $.ajax({
        type:"post"
        ,url:url
        ,data:query
        ,dataType:"json"
        ,success:function(data) {
        	$("select[name=resourceNum] option").each(function() {$("select[name=resourceNum] option:eq(0)").remove(); });
        	
        	for(var idx=0; idx<data.list.length; idx++) {
        		var num=data.list[idx].resourceNum;
        		var name=data.list[idx].resourceName;
        		var occupancy = data.list[idx].occupancy;
        		$("select[name=resourceNum]").append("<option value='"+num+"' data-occupancy='"+occupancy+"'>"+name+"</option>");
        	}
        	
        	$("select[name=groupNum]").val(groupNum);

        	if(resourceNum!=undefined && resourceNum!="") {
        	    $("select[name=resourceNum]").val(resourceNum);
        	    var occu = $("select[name=resourceNum] option:selected").attr("data-occupancy");
        		$("#resOccupancy").text(occu);       	
        	}
        	
        }
        ,error:function(e) {
        	console.log(e.responseText);
        }
    });
}

$(function(){
	$("body").on("change", "select[name=resourceNum]", function(){
		var occu = $("select[name=resourceNum] option:selected").attr("data-occupancy");
		$("#resOccupancy").text(occu);
	});
});

// 새로운 일정 등록
function insertOk() {
	if(! validCheck())
		return;
	var resourceName = $("select[name=resourceNum] option:selected").text();
	var query=$("form[name=resForm]").serialize();
	var url="<%=cp%>/scheduler/reservationInsert?resourceName="+resourceName;
    
     $.ajax({
        type:"post"
        ,url:url
        ,data:query
        ,dataType:"json"
        ,success:function(data) {
	      	   var state=data.state;
	      	   if(state=="true") {
	      		   calendar.fullCalendar('refetchEvents');
	          }
          }
          ,error:function(e) {
               console.log(e.responseText);
         }
    });
    $("#resourceModal").dialog("close");
}

// 일정 등록 및 수정에서 검사
function validCheck() {
	// 최대인원, 입력 인원 비교 필요함.
	var groupNum=$.trim($("select[name='groupNum']").val());
	var resourceNum=$.trim($("select[name='resourceNum']").val());
	var title=$.trim($("input[name='title']").val());
	var content=$.trim($("textarea[name=content]").val());
	var allDay=$("input[name='allDay']:checked").val();
	var startDay=$.trim($("input[name='startDay']").val());
	var endDay=$.trim($("input[name='endDay']").val());
	var startTime=$.trim($("select[name='startTime']").val());
	var endTime=$.trim($("select[name='endTime']").val());
	var inwon=$.trim($("input[name='inwon']").val());
	var alarm=$.trim($("input[name=alarm]:checked").val());
	var alarmTime=$.trim($("input[name=alarmTime]:checked").val());
	var toMember = $.trim($("input[name='toMember']").val());
	var occupancy = $("#resOccupancy").text();
	
	if(! groupNum) {
		alert("구분을 선택 하세요 !!!");
		$("select[name='groupNum']").focus();
		return false;
	}

	if(! resourceNum) {
		alert("항목을 선택 하세요 !!!");
		$("select[name='resourceNum']").focus();
		return false;
	}
	
	if(! title) {
		alert("제목을 입력 하세요 !!!");
		$("input[name='title']").focus();
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
    } else {
    	end=moment(startDay);
    	end=end.add("1", "days");
		endDay=end.format("YYYY-MM-DD");
    }
    
    if((startDay == endDay) && startTime >= endTime){
    	alert("시작시간과 종료시간을 다시 확인하세요!");
    	return false;
    }
    
	if(! /^(\d+)$/.test(inwon)) {
		alert("사용 인원수를 입력 하세요 !!! ");
		$("input[name='inwon']").focus();
		return false;
	}
	
	if(parseInt(inwon) > parseInt(occupancy)){
		alert("최대 인원보다 많은 사용자를 입력할 수 없습니다.");
		return false;
	}
	
	if(! content) {
		alert("내용을 입력 하세요 !!!");
		$("textarea[name='content']").focus();
		return false;
	}
	
    $("input[name='endDay']").val(endDay);
    
    if(! alarm) {
    	alert("알림 여부를 선택하세요!");
    	return false;
    }
    
    if((alarm == '1') && (! alarmTime)) {
    	alert("알림 시간을 선택하세요!");
    	return false;
    }
    
    if((alarm == '1') && (! toMember)) {
    	alert("알림 메시지를 보낼 대상자를 선택하세요!");
    	return false;
    }
	return true;
}

// 상세 일정 보기
function articleForm(calEvent) {
	var num=calEvent.id;
	var resourceNum=calEvent.resourceId;
	var start=calEvent.start.format();
	
	var allDay=true;
	var allDayTitle="종일일정";
	if(calEvent.start.hasTime()) {
		allDay=false;
		allDayTitle="시간일정";
	}
	
    var end="";
    if(calEvent.end!=null)
    	end=calEvent.end.format();
	var title=calEvent.title;
	var resourceName=calEvent.resourceName;
	var groupNum=calEvent.groupNum;
	var groupName=calEvent.groupName;
	var userId=calEvent.memberNum;
	var userName=calEvent.name;
	var occupancy = calEvent.occupancy;
	var inwon=calEvent.inwon;
	var startDay=calEvent.startDay;
	var startTime=calEvent.startTime;
	if(startTime!=null)
		startTime=startTime.substr(0, 5);
	else
		startTime="";
	var endDay=calEvent.endDay;

	var endTime=calEvent.endTime;
	if(endTime!=null) {
		endTime=endTime.substr(0, 5);
	} else {
		if(startDay!=endDay)
		    endDay=calEvent.end.add("-1", "days").format("YYYY-MM-DD");
		endTime="";
	}

	var dlg = $("#resourceModal").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 수정 " : function() {
		    	   if(userName == "${sessionScope.member.userName}"){
		    		   updateForm(num, groupNum, resourceNum, title, allDay, startDay, startTime, endDay, endTime, inwon);
		    	   } else {
		    		   alert("작성자 본인만 수정할 수 있습니다!");
		    	   }
		        },
			   " 삭제 " : function() {
				   if(userName == "${sessionScope.member.userName}" || userName =="admin"){
					   deleteOk(num);
				   } else {
					   alert("작성자 본인만 삭제할 수 있습니다!");
				   }
			   },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		        }
		  },
		  height: 500,
		  width: 550,
		  title: "상세 스케쥴러",
		  close: function(event, ui) {
		  }
	});	
	
	$('#resourceModal').load("<%=cp%>/scheduler/articleForm", function() {
		$("#resGroupArticle").html(groupName);
		$("#resResourceArticle").html(resourceName);
		$("#resTitleArticle").html(title);
		$("#resNameArticle").html(userName);
		$("#resAllDayArticle").html(allDayTitle);
		$("#resStartDayArticle").html(startDay+" "+startTime);
		$("#resEndDayArticle").html(endDay+" "+endTime);
		$("#resInwonArticle").html(inwon);
		
		dlg.dialog("open");
	});
}

function updateForm(num, groupNum, resourceNum, title, allDay, startDay, startTime, endDay, endTime, inwon) {
	var dlg = $("#resourceModal").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 확인 " : function() {
		    	   updateOk();
		        },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		        }
		  },
		  height: 810,
		  width: 700,
		  title: "스케쥴러 수정",
		  close: function(event, ui) {
		  }
	});
	
	$('#resourceModal').load("<%=cp%>/scheduler/inputForm", function() {
		$("select[name='groupNum']").val(groupNum);
		$("input[name='title']").val(title);
		$("input[name='startDay']").val(startDay);
		$("select[name='startTime']").val(startTime);
		$("input[name='endDay']").val(endDay);
		$("select[name='endTime']").val(endTime);
		$("input[name='inwon']").val(inwon);
		$("input[name='reserveNum']").val(num);
		
		if(allDay==true) {
			$("#allDay3").prop('checked', true);
			$("#resStartTime").hide();
			$("#resEndTime").hide();
		} else {
			$("#allDay4").prop('checked', true);
			$("#resStartTime").show();
			$("#resEndTime").show();
		}
		$("input[name='title']").focus();

		changeGroup(groupNum, resourceNum);
		
		dlg.dialog("open");
	});	
}

function updateOk() {
	if(! validCheck())
		return;
	var resourceName = $("select[name=resourceNum]").text();
	var query=$("form[name=resForm]").serialize();
	var url="<%=cp%>/scheduler/updateReservation?resourceName="+resourceName;
    
     $.ajax({
        type:"post"
        ,url:url
        ,data:query
        ,dataType:"json"
        ,success:function(data) {
	      	   var state=data.state;
	      	   if(state=="true") {
	      		   calendar.fullCalendar('refetchEvents');
	          } else {
	        	  alert("게시글을 수정할 수 있는 권한이 없습니다.");
	          }
          }
          ,error:function(e) {
               console.log(e.responseText);
         }
    });
    $("#resourceModal").dialog("close");
}

function deleteOk(num) {
	if(confirm("삭제 하시겠습니까 ?")) {
		$.post("<%=cp%>/scheduler/deleteReservation", {num:num}, function(data){
			var state=data.state;
			if(state=="false") {
				alert("게시글을 삭제할 수 있는 권한이 없습니다.");	
			} else {
				calendar.fullCalendar('removeEvents', num);
			}
		}, "json");
	}
	 $("#resourceModal").dialog("close");
}

// 일정을 드래그하거나 일정의 크기를 변경할 때 일정 수정
function updateDrag(calEvent) {
	var num=calEvent.id;
	var resourceNum=calEvent.resourceId;
	var allDay=true;
	var startDay=calEvent.start.format("YYYY-MM-DD");
	var startTime="";
	if(calEvent.start.hasTime()) {
		allDay=false;
		startTime=calEvent.start.format("HH:mm");
	}
	var endDay="";
	if(calEvent.end!=null) {
	   endDay=calEvent.end.format("YYYY-MM-DD");
	} else {
		var end=moment(startDay);
    	end=end.add("1", "days");
		endDay=end.format("YYYY-MM-DD");
	}
	var endTime="";
	if(calEvent.end!=null && calEvent.end.hasTime()) {
		endTime=calEvent.end.format("HH:mm");
	}
	
	var title=calEvent.title;
	var content = calEvent.content;
	var resourceName=calEvent.resourceName;
	var groupNum=calEvent.groupNum;
	var groupName=calEvent.groupName;
	var userId=calEvent.userId;
	var userName=calEvent.userName;
	var inwon=calEvent.inwon;
	var alarm = calEvent.alarm;
	var alarmTime = calEvent.alarmTime;
	var alarmTitle = calEvent.alarmTitle;
	var alarmContent = calEvent.alarmContent;
	var toMember = calEvent.toMember;
	
	var query="reserveNum="+num
        +"&groupNum="+groupNum
        +"&resourceNum="+resourceNum
        +"&resourceName="+resourceName
        +"&title="+title
        +"&content="+content
        +"&allDay="+allDay
        +"&startDay="+startDay
        +"&startTime="+startTime
        +"&endDay="+endDay
        +"&endTime="+endTime
        +"&alarm="+alarm
        +"&alarmTime="+alarmTime
        +"&alarmTitle="+alarmTitle
        +"&alarmContent="+alarmContent
        +"&toMember="+toMember
        +"&inwon="+inwon;
	
	var url="<%=cp%>/scheduler/updateReservation";

	$.ajax({
      type:"POST"
      ,url:url
	  ,data:query
	  ,dataType:"json"
	  ,success:function(data) {
	      var state=data.state;
	      
	      if(state=="true") {
	    	  calendar.fullCalendar('refetchEvents');
	      } else {
	    	  alert("게시글을 수정할 수 있는 권한이 없습니다.");
	    	  return false;
	      }
      }
      ,error:function(e) {
          console.log(e.responseText);
       }
	});
}
</script>

<div class="body-container" style="width: 1100px;">
<div style="clear: both; margin: 10px 0px 15px 10px;">
	<span class="glyphicon glyphicon-credit-card"
		style="font-size: 28px; margin-left: 10px;"></span> 
		<span style="font-size: 30px;">&nbsp;자 원 예 약</span><br>
	<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>
<br>
    <div>
        <div id='resLoading'>loading...</div>
        <div id='calendar'></div>
    </div>
 
</div>

<div id="resourceModal" style="display: none;"></div>