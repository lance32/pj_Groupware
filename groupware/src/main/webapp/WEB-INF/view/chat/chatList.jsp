<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
	String wsURL = "ws://"+request.getServerName()+":"+request.getServerPort()+cp+"/chat.msg";
%>

<style type="text/css">
.chatRoom_ListItem{
	height: 50px; 
	border: 2px solid #BDBDBD; 
	background: #E6E6E6;
	font-size: 17px;
}
	.chatRoom_ListItem:hover{
		background: #D4E3EE;
		cursor: pointer;
		border: 2px solid #819FF7;
	}
.chatListItem_subject{
	padding-left: 10px; 
	width: 250px;
}
.chatListItem_founder{
	width: 150px; 
	text-align: center;
}
.chatListItem_number{
	width: 48px;
}
</style>
<script type="text/javascript">
jQuery(function(){
	jQuery(".chatInfoBox").hide();
	var sessionUserId = "${sessionScope.member.userId}";
	var sessionUserName = "${sessionScope.member.userName}";
	if (! sessionUserId) {
		location.href="<%=cp%>/login";
		return;
	}
	var socket=null;
	var host="<%=wsURL%>";

	if ('WebSocket' in window) {
		socket = new WebSocket(host);
    } else if ('MozWebSocket' in window) {
    	socket = new MozWebSocket(host);
    } else {
    	jQuery("#messageBox").html('브라우저가 채팅을 지원 안합니다.');
        return false;
    }
	socket.onopen = function(evt) { onOpen(evt) };
	socket.onclose = function(evt) { onClose(evt) };
	socket.onmessage = function(evt) { onMessage(evt) };
	socket.onerror = function(evt) { onError(evt) };
	
	//서버접속 성공
	function onOpen(evt) {
		var obj = {};
	    var jsonStr;
	    obj.type="conn";
	    obj.guestId=sessionUserId;
	    obj.userName=sessionUserName;
	    jsonStr = JSON.stringify(obj);
	    socket.send(jsonStr);
	    
	    jQuery("#messageBox").html('서버 연결. 채팅방에 입장하거나 개설하여 채팅을 시작하세요.');
	}
	//연결 끊김
	function onClose(evt) {
		jQuery("#messageBox").html('서버 연결끊김. 재접속하세요.');
	}
	//메시지를 받음
	function onMessage(evt) {
		var data=JSON.parse(evt.data);
    	var type = data.type;
    	
    	if(type=="room") {
    		roomProcerss(data);
    	} else if(type=="talk") {
    		talkProcerss(data);
    	} 
	}
	//기타에러 발생시
	function onError(evt) {
		jQuery("#messageBox").html('에러발생. 재접속하세요.');
	}
	
	//개설된 채팅방이 없을경우
	if(jQuery(".chatRoom_ListItem").length<=0){
		jQuery("#chatRoom_List").append("<tr style='width:100%; height:50px; text-align:center; font-size: 17px; padding-top: 10px;'><td>개설된 채팅방이 없습니다.</td></tr>");
	}
	
	//새로고침 버튼 클릭시
	jQuery("#refreshRoomListBtn").click(function(){
		jQuery("#chatRoom_List").empty();
	    	var obj = {};
	    	var jsonStr;
	   	obj.type="refresh";
	   	jsonStr = JSON.stringify(obj);
	    	socket.send(jsonStr);
	  	//개설된 채팅방이 없을경우
		if(jQuery(".chatRoom_ListItem").length<=0){
			jQuery("#chatRoom_List").append("<tr style='width:100%; height:50px; text-align:center; font-size: 17px; padding-top: 10px;'><td>개설된 채팅방이 없습니다.</td></tr>");
		}
	});
	

	
	//채팅방 개설버튼 클릭시
	jQuery("#addChatRoomBtn").click(function(){
		jQuery("#addChatRoom-dialog").dialog({
			modal: true,
			  height: 320,
			  width: 450,
			  title: '채팅방 개설',
			  buttons: {
			       " 만들기 " : function() {
						addChatRoom();		//채팅방 개설
			        },
			       " 닫기 " : function() {
			    	   jQuery(this).dialog("close");
			        }
			  },
			  close: function(event, ui) {
				  jQuery("#roomSubject").val("");
				  jQuery("#roomMaxNumber").val("");
			  }
		});
	});
	
	//채팅방 개설
	function addChatRoom(){
		var subject=jQuery("#roomSubject").val().trim();
		if(! subject) {
			jQuery("#roomSubject").focus();
			jQuery("#addErrorMsg").html("");
			jQuery("#addErrorMsg").html("제목을 입력 하세요.");
			return;
		}
		var maxNumber=jQuery("#roomMaxNumber").val().trim();
		if(! maxNumber) {
			jQuery("#roomMaxNumber").focus();
			jQuery("#addErrorMsg").html("");
			jQuery("#addErrorMsg").html("최대인원을 입력 하세요.");
			return;
		}
		if(! /^(\d){1,2}$/g.test(maxNumber)) {
			jQuery("#roomMaxNumber").focus();
			jQuery("#addErrorMsg").html("");
			jQuery("#addErrorMsg").html("최대인원은 숫자이어야 합니다.");
			return;
		}
		if(parseInt(maxNumber)<2||parseInt(maxNumber)>20) {
			jQuery("#roomMaxNumber").focus();
			jQuery("#addErrorMsg").html("");
			jQuery("#addErrorMsg").html("최대인원 2~20사이 입니다.");
			return;
		}
		var obj = {};
	    var jsonStr;
	    obj.type="room";
	    obj.cmd="add";
	    obj.subject=subject;
	    obj.maxNumber=maxNumber;
	    obj.roomId=sessionUserId;
	    obj.founderName=sessionUserName;
	    jsonStr = JSON.stringify(obj);
	    socket.send(jsonStr);
	}

	//type:room을 전송받음.
	function roomProcerss(data) {
		var cmd=data.cmd;
		
		if(cmd=="add-ok") {
			// 채팅방 개설 성공
			var roomId=data.roomId;
			var subject=data.subject;
			jQuery("#addChatRoom-dialog").dialog("close");
			alert("채팅방이 개설되었습니다.");
			
			chatMsgProcerss(roomId, subject);
			jQuery("#refreshRoomListBtn").click();
			
		}else if(cmd=="room-list") {
		// 채팅방 목록을 받음 (메인 채팅방 목록에 리스트를 띄움.)
			jQuery("#chatRoom_List").empty();
			var roomId = data.roomId;
			var founderName = data.founderName;
			var subject = data.subject;
			var maxNumber=data.maxNumber;
			var number=data.number;
			
			jQuery("#chatRoom_List").append("<tr class='chatRoom_ListItem' data-roomId='"+roomId+"'><td class='chatListItem_subject'>"+subject+"</td><td class='chatListItem_founder'>"+founderName+"</td><td class='chatListItem_number'>"+number+"/"+maxNumber+"</td></tr><tr height='15px;'></tr>");
			
		}else if(cmd=="info") {
		// 채팅방 상세정보를 받음
			var roomId=data.roomId;
			var founderName=data.founderName;
			var number=data.number;
			var maxNumber=data.maxNumber;
			var subject=data.subject;
			var guestList=data.guestList;
			jQuery("#chatRoom_join").attr("value",roomId);
			if(maxNumber<=number) {
				jQuery("#chatRoom_join").prop("disabled", true);
			}
			var s="채팅방 개설자 : " + founderName + "<br>"
			s+="채팅방 제목 : "+subject+"<br>"
			s+="최대접속인원 : " + maxNumber + "<br>";
			s+="현재접속인원 : " + number + "<br>";
			s+="접속자 리스트 <br>";
			
			jQuery.each(guestList, function(index, value){
				var a=value.split(":");
				 s+="&nbsp;&nbsp;- "+a[1]+"<br>";
			});
			
			jQuery("#chatRoom_Info").html(s);
			jQuery(".chatInfoBox").show();
			
		} else if(cmd=="join-ok") {
			// 게스트의 채팅방에 들어가기
			var roomId=data.roomId;
			var subject=data.subject;
			
			chatMsgProcerss(roomId, subject);
			
		} else if(cmd=="join-fail") {
			var roomId=data.roomId;
			var subject=data.subject;
			alert(subject+" 채팅방에 입장이 불가능 합니다.");
			
		} else if(cmd=="closed") {
			// 채팅방이 종료 된경우 채팅방 리스트 정보 지우기
			var roomId=data.roomId;
			var subject=data.subject;
			
			jQuery("#chatRoom_Info").empty();
			jQuery(".chatInfoBox").hide();
			jQuery(".chatRoom_List tr[data-roomId="+roomId+"] td").remove();
			jQuery(".chatRoom_List tr[data-roomId="+roomId+"]").remove();
			jQuery("#refreshRoomListBtn").click();
		}
	}
	
	//채팅방 클릭시
	jQuery("body").on("click",".chatRoom_ListItem", function(){
		jQuery("#chatRoom_Info").html("");
		var roomId = $(this).attr("data-roomId");
		if(! roomId) {
			alert("채팅방의 정보가 없습니다.");
			return;
		}
		var obj = {};
	    var jsonStr;
	    obj.type="room";
	    obj.cmd="info";
	    obj.roomId=roomId;
	    jsonStr = JSON.stringify(obj);
	    socket.send(jsonStr);
	});
	
	//채팅방 입장하기 버튼 클릭시
	jQuery("#chatRoom_join").click(function(){
		var roomId=jQuery(this).val();
		
		var obj = {};
	    var jsonStr;
	    obj.type="room";
	    obj.cmd="join";
	    obj.roomId=roomId;
	    obj.userName=sessionUserName;
	    jsonStr = JSON.stringify(obj);
	    socket.send(jsonStr);
	});
	
	// 채팅방 띄우기
	function chatMsgProcerss(roomId, subject) {
		jQuery("#chatMsgContainer").empty();
		jQuery("#chatRoomJoinList").empty();
		jQuery("#chatMsgContainer").append("<p>"+sessionUserName+" 님이 입장했습니다.</p>");
		jQuery("#chatRoomJoinList").append("<p style='color: #58ACFA'>&nbsp;&nbsp;"+sessionUserName+"</p>");
	
		jQuery('#chatting-dialog').dialog({
			  modal: true,
			  minHeight: 670,
			  minWidth: 630,
			  maxHeight: 670,
			  maxWidth: 630,
			  title: subject,
			  close: function(event, ui) {
				  chatMsgClose(roomId);
			  }
		  });
		
		//엔터가 눌리면 메시지 전송
		jQuery("#chatRoomMsg").on("keydown",function(event) {
		        if (event.keyCode == 13) {
		            sendRoomMessage();
		        }
		  });
		
		// 귓속말,  엔터가 눌리면 메시지 전송
		jQuery("#chatOneMsg").on("keydown",function(event) {
		        if (event.keyCode == 13) {
		            sendOneMessage();
		        }
		  });
		
		//채팅방 나가기 버튼 클릭시
		jQuery("#closeChatBtn").on("click",function(){
			jQuery("#chatting-dialog").dialog("close");
		});
		
		//채팅내용 지우기 버튼 클릭시
		jQuery("#cleanChatBtn").on("click",function(){
			jQuery("#chatMsgContainer").empty();
		});
	}
	
	// type:talk를 전송 받은 경우
	function talkProcerss(data) {
		var cmd=data.cmd;
		
		if(cmd=="join-list") {
			// 채팅방에 처음 입장 할 때 채팅 참여자 리스트를 전송 받음
			var guestList=data.guestList;
			$.each(guestList, function(index, value){
				var a=value.split(":");
				$("#chatRoomJoinList").append("<p data-guestId='"+a[0]+"' style='cursor:pointer;'>&nbsp;&nbsp;"+a[1]+"</p>");
			});
			
		} else if(cmd=="join-add") {
		// 채팅방에 새로운 게스트가 입장한 경우
			var guestId=data.guestId;
			var userName=data.userName;
			$("#chatRoomJoinList").append("<p data-guestId='"+guestId+"' style='cursor:pointer;'>&nbsp;&nbsp;"+userName+"</p>");
			
    		var s=userName+" 님이 입장했습니다.";
    		writeToScreen(s);
			
		} else if(cmd=="chatMsg") {
		// 채팅메시지를 받은 경우
			var to=data.to;
			var msg=data.message;
			var senderName=data.senderName;
			
			var s="";
			if(to=="one") {
				s="<span style='color: #BE81F7'>[귓속말]</span> ";
			}
			s+=senderName+"> "+msg;
			
			writeToScreen(s);
			
		} else if(cmd=="leave") {
			// 접속자가 채팅방을 나가면 다른사용자에게 전송
			var guestId=data.guestId;
			var userName=data.userName;
			
    			var s=userName+" 님이 나가셨습니다.";
    			writeToScreen(s);
    		
			$("#chatRoomJoinList p[data-guestId="+guestId+"]").remove();
		}else if(cmd=="closed"){
			var roomId=data.roomId;
			
			var obj = {};
	      	var jsonStr;
	     		obj.type="room";
	      	obj.cmd="closed";
	      	obj.roomId=roomId;
	        	jsonStr = JSON.stringify(obj);
	        	socket.send(jsonStr);
	        	
	        	alert("채팅방을 종료합니다.");
		}
	}
	
	// 채팅문자열 전송
	function sendRoomMessage() {
		var msg=$("#chatRoomMsg").val().trim();
		if(! msg) {
			$("#chatRoomMsg").focus();
			return;
		}
		
        var obj = {};
        var jsonStr;
        obj.type="talk";
        obj.cmd="chatMsg";
        obj.to="all";
        obj.message=msg;
        jsonStr = JSON.stringify(obj);
        socket.send(jsonStr);
        
        writeToScreen("<span style='color: #58ACFA'>보냄></span> "+msg);
        
        $("#chatRoomMsg").val("");
        $("#chatRoomMsg").focus();
	}
	
	// 채팅방 참여자 리스트를 클릭한 경우 위스퍼(귓속말) 대화상자 열기
	$("body").on("click", "#chatRoomJoinList p", function(){
		$("#chatRoomJoinList p").each(function(){
			$(this).removeClass("selection");
		});
			
		$(this).addClass("selection");
		var guestName = $(this).text();
		if(! guestName) return;
		
		// 귓속말 대화상자 열기
		  $('#whisper-dialog').dialog({
			  modal: true,
			  height: 120,
			  width: 300,
			  title: '귓속말-'+guestName,
			  close: function(event, ui) {
				  $("#chatOneMsg").val("");
			  }
		  });		
	});
	

	// 귓속말 전송
	function sendOneMessage() {
		var msg=$("#chatOneMsg").val().trim();
		if(! msg) {
			$("#chatOneMsg").focus();
			return;
		}
		
		var $p = $("#chatRoomJoinList .selection");
		var guestId = $p.attr("data-guestId");
		var guestName = $p.text();
		
        var obj = {};
        var jsonStr;
        obj.type="talk";
        obj.cmd="chatMsg";
        obj.to="one";
        obj.message=msg;
        obj.receiveId=guestId;
        jsonStr = JSON.stringify(obj);
        socket.send(jsonStr);
        
        writeToScreen("<span style='color: #BE81F7'>[귓속말] 보냄</span> - "+guestName+"> "+msg);
        
        $("#chatOneMsg").val("");
        $('#whisper-dialog').dialog("close");
	}
	

	// 채팅창을 종료 한 경우
	function chatMsgClose(roomId) {
		$("#chatRoomMsg").on("keydown",null);
		$("#chatOneMsg").on("keydown",null);
		
	      var obj = {};
	      var jsonStr;
	      obj.type="talk";
	      obj.cmd="leave";
	      obj.roomId=roomId;
	      jsonStr = JSON.stringify(obj);
	      socket.send(jsonStr);
	}

});

//채팅 메시지를 출력하기 위한 함수
function writeToScreen(message) {
    var $chatContainer = $("#chatMsgContainer");
    $chatContainer.append("<p>");
    $chatContainer.find("p:last").css("wordWrap","break-word"); // 강제로 끊어서 줄 바꿈
    $chatContainer.find("p:last").html(message);

    // 추가된 메시지가 50개를 초과하면 가장 먼저 추가된 메시지를 한개 삭제
    while ($chatContainer.find("p").length > 50) {
    	$chatContainer.find("p:first").remove();
	}

    // 스크롤을 최상단에 있도록 설정
    $chatContainer.scrollTop($chatContainer.prop("scrollHeight"));
}
</script>

<div style="clear: both; margin: 10px 0px 40px 10px;">
	<span class="glyphicon glyphicon-transfer" style="font-size: 28px; margin-left: 10px;"></span> 
	<span style="font-size: 30px;">&nbsp;채팅</span><br>
	<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
</div>

<div style="clear:both; width: 100%; min-width:1000px; padding-left: 10%">
	<div id="messageBox" style="clear:both; width: 100%; height: 40px; font-size: 20px; padding-left: 10px;"></div>
		
	<div style="width: 490px; height: 600px; float: left;">
		<div style="width:480px; height: 55px; padding-top: 10px; padding-left: 5px;">
			<button type="button" id="refreshRoomListBtn" class="butn" style="font-size: 16px; margin-right: 5px;">새로고침</button>
			<button type="button" id="addChatRoomBtn" class="butn" style="font-size: 16px;">채팅방 개설</button>
		</div>
		
		<div style="clear:both; width: 490px; height: 500px; padding: 5px 0px 5px 10px; border: 1px solid #F2F2F2; overflow-y: scroll;">
			<table  id="chatRoom_List" style="width: 100%;"></table>
		</div>
	</div>
	
	<div class="chatInfoBox" style="width: 480px; height: 545px; border: 1px solid #BDBDBD; float: left; background: #FAFAFA; margin: 10px 0px 0px 50px;">
		<div style="float: left; width: 470px; height: 440px; padding-left: 10px;">
			<p style="height: 40px; line-height: 40px; font-size: 18px; text-align: center; border-bottom: 1px solid #D8D8D8;">채팅방 정보</p>
			<div id="chatRoom_Info" style="width: 100%; font-size: 16px;"></div>
		</div>
		<div style="width: 100%; height: 100px; text-align: center; float: left;">
			<button id="chatRoom_join" class="butn" value="" type="button" style="width: 350px; height: 60px; margin-top: 20px; font-size: 20px;">채팅방 입장하기</button>
		</div>
	</div> 
</div>

<%--  --%>

<div id="addChatRoom-dialog" style="display: none; margin: 0px; padding: 0px; overflow: inherit;">
	<table style="margin: 10px auto 0px; width: 100%; border-spacing: 0px;">
		<tr height="50">
			<td width="80"
				style="font-weight: 600; padding-right: 15px; text-align: right;">방제목</td>
			<td><input id='roomSubject' type='text' class='boxTF'
				style="width: 98%;" placeholder='채팅방 제목'></td>
		</tr>
		<tr height="50">
			<td width="80"
				style="font-weight: 600; padding-right: 15px; text-align: right;">최대인원</td>
			<td><input id='roomMaxNumber' type='text' class='boxTF'
				style="width: 98%;" placeholder='접속 최대인원(2~20)'></td>
		</tr>
		<tr style="padding-top: 30px; height: 80px;"><td colspan="2" style="padding-left: 20px;">
			<span id="addErrorMsg" style="color: #DF0101"></span>
		</td></tr>
	</table>
</div>

<div id="chatting-dialog" style="display: none; min-width: 600px; height: 550px; margin: 10px; padding: 0px;">
	<div style="width:400px; clear: both; float: left; height: 550px; border: 2px solid #D8D8D8">
		<div style="width: 100%; height: 30px; padding-top: 5px; clear: both; border-bottom: 1px solid #E6E6E6">
			<span style="font-weight: 600;">＞</span>
	        	<span style="font-weight: 600; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">채팅 메시지</span>
	    	</div>
		<div id="chatMsgContainer" style="width: 100%; height: 460px; border-bottom: 1px solid #E6E6E6; overflow-y: scroll; padding: 3px;"></div>
		<div style="clear: both; padding-top: 15px; text-align: center;">
	    	<input type="text" id="chatRoomMsg" style="width: 95%; height:30px; border: none; border: 1.4px solid #81BEF7; border-radius: 1.5px; padding-left: 3px; " placeholder="채팅 메시지를 입력 하세요...">
	    </div>
	</div>
	<div style="float: left; width: 14px; height: 550px;">&nbsp;</div>
	<div style="width:180px; float: left; height: 550px; border: 1px solid #D8D8D8">
		<div style="clear: both; height: 30px; padding-top: 5px; border-bottom: 1px solid #E6E6E6;">
	       	<span style="font-weight: 600;">＞</span>
         		<span style=" font-family: 나눔고딕, 맑은 고딕, 돋움; font-weight: 600; color: #424951;">접속자 리스트</span>
	    </div>
	    <div id="chatRoomJoinList" style="padding-top: 5px;"></div>
	</div>
	<div style="clear: both; width: 600px; height: 40px; padding: 10px 10px 0px 3px;">
		<button type="button" id="cleanChatBtn" class="butn">채팅내용 지우기</button>
		<button type="button" id="closeChatBtn" class="butn" style="float: right;">채팅방 나가기</button>
	</div>
</div>

<div id="whisper-dialog" style="display: none">
	<div style="clear: both; padding-top: 5px;">
		<input type="text" id="chatOneMsg" class="boxTF"  style="width: 99%;"  placeholder="귓속말을 입력 하세요...">
	</div>
</div>   


    