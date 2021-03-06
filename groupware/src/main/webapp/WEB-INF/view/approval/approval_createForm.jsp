<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<!-- 근태 신청서 페이지  -->



<script type="text/javascript">
	function Click_table(obj)
		

</script>
<script type="text/javascript">

function onChange() {
    var text = document.getElementById("urlid").value;
    document.getElementById("urlid_confirm").innerHTML=text;
   }

$(function() {
	$("#save").click(function() {
		submitContents();
		var vTitle = $("#title").val(); // title
		var vContents = $("#content").val(); // contents
		var vComments = $("#comments").val(); // comments
		var vWriter = $("#session").val(); // writer
		var vAppLine = $("#session").val() + "|"; // approval line
		for(var i = 0; i <  8; i++){
			if($("#toMember"+i).val() != ""){
				vAppLine += $("#toMember"+i).val() + "|";
			}
		}
		$.ajax({
			url:"<%=cp%>/approval/submit",
			type:"get",
			dataType:"json",
			data:{
				title : vTitle,
				contents : vContents,
				comments : vComments,
				author : vWriter,
				appLine : vAppLine				
			},
			
			success:function(data) {
				location.href="approval";
			},
			error:function(jqXHR) {
				console.log(jqXHR.resonseText);
			}
		});
	
	});
	$("#cancel").click(function(){
		location.href="approval";
	})
	$("#organizationChart").click(function() {
		var dialog;
		$.ajax({
			url:"<%=cp%>/member/organizationChart",
			type:"get",
			dataType:"json",
			success:function(data) {
				var h = "<table>";
				var preDeptName = "";
				var deptClass = "";
				$.each(data, function(idx, val) {
					var ws = "";
					if (val.deptOrder == 1) {
						deptClass = "dept" + val.deptNum + " ";
					} else {
						var deptArray = deptClass.split(" ");
						deptClass = deptArray[val.deptOrder - 2] + " ";
						deptClass+= "dept" + val.deptNum + " ";
					}

					for (var i = 1; i < val.deptOrder; i++) {
						ws += "&nbsp;&nbsp;&nbsp;&nbsp;";
					}

					if (preDeptName != val.deptName) {
						h += "<tr><td>";
						h += ws;
						//h += "<input type='checkbox' id='dept" + val.deptNum + "' class='" + deptClass + "' onclick='deptCheck(\"dept"+ val.deptNum +"\");'>";
						h += val.deptName;
						h += "</td></tr>";
						preDeptName = val.deptName;
					} 

					if(val.memberName != undefined) {
						h += "<tr><td>";
						ws += "&nbsp;&nbsp;&nbsp;&nbsp;"
						h += ws;
						h += "<input type='checkbox' id='" + val.memberNum + "' class='memberChk " + deptClass + "' data-member-num='" + val.memberNum + "'data-member-name='" + val.memberName + "'>";
						h += val.memberName; 
						h += "&nbsp;";
						h += val.positionName;
						h += "</td></tr>";
					}
				});
				h += "</table>";
				
				$("#organizationLayout").html(h);
				dialog = $("#organizationLayout").dialog({
					height: 400,
					width: 500,
					modal: true,
					open: function () {
						// 기존 선택된 멤버가 있을 경우, 로드시 조직도에서 체크 되도록 처리
						// <input type="text" id="toMember" name="toMember"> 에서 읽어옴
						var member = $("#toMember").val();		
						if (member.length > 0) {
							var memberList = member.split(";");
							for (var i = 0; i < memberList.length; i++) {
								if (memberList[i] == "") continue;
								$("#" + memberList[i]).attr("checked", true);
							}
						}
					},
					buttons: {
						"확인" : function() {
							// 조직도에서 선택된 값을 받을 input object에 넣도록 처리
							// 여기서는 <input type="text" id="toMember" name="toMember"..>
							var memberList = "";
							var memberNameList = "";
							$(".memberChk").each(function() {
								
								if (this.checked) {
									memberList += $(this).data("memberNum") + ";";
									memberNameList += $(this).data("memberName") + ";";
								} 
							});
							var member = memberList.split(';');
							var memberName = memberNameList.split(';');

							if(member.length > 8){
								alert("too much member");
							}
							else {							
							for(var i = 0; i <  member.length; i++){
								$("#toMember"+i).val(member[i]);
								$("#lbtoMember"+i).val(memberName[i]);
							}
							}
							
							//$("#toMember").val(memberList);
							$(this).dialog("close");
						},
						"취소" : function() {
							$(this).dialog("close");
						}	
					}
				});
			},
			error:function(jqXHR) {
				console.log(jqXHR.resonseText);
			}
		});
	});
});
</script>
<form id="editform" name="editform" method="post"
	action="/segio/works/approval/edit_format.php"
	enctype="multipart/form-data">
	<input type="hidden" id="session" name="session" value=${sessionScope.member.userId }>
	<input type="submit" title="" value="" style="display: none"> 
	<input type="hidden" name="mode" value="text_insert"> 
	<input type="hidden" name="no" value=""> 
	<input type="hidden" name="report"> 
	<input type="hidden" name="page" value="">
	<input type="hidden" name="format_no" value="18"> 
	<input type="hidden" name="urgent" value=""> 
	<input type="hidden" name="addtype" value=""> 
	<input type="hidden" name="addfile" id="addfile" value="">
	
	<input type="hidden" name="mobile_chk" value="0"> 
	<input type="hidden" name="navigator" value="Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36">
	<input type="hidden" name="auto_chk" value="off">

	<input type="hidden" name="doc_link_list" value="">
	<input type="hidden" name="auto_pass_receiver_list" value="">
	<input type="hidden" name="reference" value="">

	<div class="works_title">
		<span class="glyphicon glyphicon-folder-open"
			style="font-size: 28px; margin-left: 10px;">&nbsp;기안문서</span> 
			<div
			style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	<div class="gw_ltext">
		<span class="doc_left">[문서종류 : 근태신청서]</span>
	</div>
<div id="organizationLayout" title="조직도"></div>
	<!-- 결재자 정보 -->
	<input type="hidden" id="app_uid1" name="app_uid1" value="test6">
	<input type="hidden" id="app_order1" name="app_order1" value="1">

	<div class="app_table">
		<table class="aview" summary="결재선 등록" style="width: 100%;">
			<colgroup>
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
			</colgroup>
			<tbody>
				<tr>

					<th rowspan="2" scope="col" style="background-color: #FFF6F9;" class="ebtn1">
						<center>결재<br>
							<input type="button" id="organizationChart" value="&nbsp;결재선 추가&nbsp;">
						</br></center>
					</th>
					<th scope="col" class="ebtn1" style="padding-left: 5px;">
						<span><center><input type="text" id="toMember0" name="toMember" style="background-color:transparent; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></center></span>
						<div id="app_class1"></div>
					</th>
					<th scope="col" class="ebtn1">
						<span><center><input type="text" id="toMember1" name="toMember" style="background-color:transparent; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></center></span>
						<div id="app_class2"></div>
					</th>
					<th scope="col" class="ebtn1">
						<span><center><input type="text" id="toMember2" name="toMember" style="background-color:transparent; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></center></span>
						<div id="app_class3"></div>
					</th>
					<th scope="col" class="ebtn1">
						<span><center><input type="text" id="toMember3" name="toMember" style="background-color:transparent; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></center></span>
						<div id="app_class4"></div>
					</th>
					<th scope="col" class="ebtn1">
						<span><center><input type="text" id="toMember4" name="toMember" style="background-color:transparent; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></center></span>
						<div id="app_class5"></div>
					</th>
					<th scope="col" class="ebtn1">
						<span><center><input type="text" id="toMember5" name="toMember" style="background-color:transparent; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></center></span>
						<div id="app_class6"></div>
					</th>
					<th scope="col" class="ebtn1">
						<span><center><input type="text" id="toMember6" name="toMember" style="background-color:transparent; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></center></span>
						<div id="app_class7"></div>
					</th>
					<th scope="col" class="ebtn1">
						<span><center><input type="text" id="toMember7" name="toMember" style="background-color:transparent; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></center></span>
						<div id="app_class8"></div>
					</th>
				</tr>

				<tr>
					<td rowspan="2" class="esign" scope="row">
						<span><input type="label" id="lbtoMember0" name="lbtoMember" style="background-color:transparent; color: #333; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></span>
						<div id="app_name1"></div>
					</td>
					<td rowspan="2" class="esign" scope="row">
						<span><input type="label" id="lbtoMember1" name="lbtoMember" style="background-color:transparent; color: #333; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></span>
						<div id="app_name2"></div>
					</td>
					<td rowspan="2" class="esign" scope="row">
						<span><input type="label" id="lbtoMember2" name="lbtoMember" style="background-color:transparent; color: #333; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></span>
						<div id="app_name3"></div>
					</td>
					<td rowspan="2" class="esign" scope="row">
						<span><input type="label" id="lbtoMember3" name="lbtoMember" style="background-color:transparent; color: #333; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></span>
						<div id="app_name4"></div>
					</td>
					<td rowspan="2" class="esign" scope="row">
						<span><input type="label" id="lbtoMember4" name="lbtoMember" style="background-color:transparent; color: #333; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></span>
						<div id="app_name5"></div>
					</td>
					<td rowspan="2" class="esign" scope="row">
						<span><input type="label" id="lbtoMember5" name="lbtoMember" style="background-color:transparent; color: #333; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></span>
						<div id="app_name6"></div>
					</td>
					<td rowspan="2" class="esign" scope="row">
						<span><input type="label" id="lbtoMember6" name="lbtoMember" style="background-color:transparent; color: #333; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></span>
						<div id="app_name7"></div>
					</td>
					<td rowspan="2" class="esign" scope="row">
						<span><input type="label" id="lbtoMember7" name="lbtoMember" style="background-color:transparent; color: #333; width: 80%; border:none #d7d7d7; text-align:center;" readOnly="readOnly"></span>
						<div id="app_name8"></div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="app_table2">
		<div class="app_table">
			<table class="aview2" summary="내용">
				<caption>내용</caption>
				<colgroup>
					<col style="width: 13%">
					<col style="width: 20%">
					<col style="width: 13%">
					<col style="width: 20%">
					<col style="width: 14%">
					<col style="width: 20%">
				</colgroup>
				<tbody>
					<tr>
						<!-- 제목 -->
						<th scope="row" class="etitle"><span>제목</span></th>
						<td scope="row" class="eleft" colspan="5"><input type="text" id="title"
							name="title" value="" class="input_title" title="제목"></td>
					</tr>
					<tr id="context_view">
						<td scope="row" colspan="6" class="econtents">
						<textarea
								name="content" id="content" title="내용"
								style="width: 98%; height: 300px; padding: 0px; margin: 0px; visibility: hidden; display: none;">
								&lt;style type="text/css"&gt;
 <!-- table.tableStyle1 {width:100%; text-align:center; border-collapse:collapse}
table.tableStyle1 caption {text-align:right;}
table.tableStyle1 td {padding:7px 7px; border:1px solid #909090; background:#fff;}
table.tableStyle1 .alignRight {text-align:right;}
table.tableStyle1 .title {height:78px; text-align:center; font-size:16pt; font-weight:bold;} 
table.tableStyle1 td.tbth {background:#efefef;}
table.tableStyle1 td.tbth2 {background:#fafafa;}
div.form {position:relative;}
table.smallTable td {height:20px; background:#fff;}
table.tableStyle1 p.p5 {padding:5px;} -->  &lt;/style&gt;
&lt;table cellpadding="1" cellspacing="1" class="tableStyle1"&gt;
	&lt;colgroup&gt;
		&lt;col width="20%" /&gt;
		&lt;col width="30%" /&gt;
		&lt;col width="20%" /&gt;
		&lt;col width="30%" /&gt;
	&lt;/colgroup&gt;
	&lt;tbody&gt;
		&lt;tr&gt;
			&lt;td class="title" colspan="6"&gt;
				근태 신청서&lt;/td&gt;
		&lt;/tr&gt;
		&lt;tr&gt;
			&lt;td class="tbth"&gt;
				&lt;strong&gt;부 서&lt;/strong&gt;&lt;/td&gt;
			&lt;td&gt;
				&lt;p&gt;
					　&lt;/p&gt;
			&lt;/td&gt;
			&lt;td class="tbth"&gt;
				&lt;strong&gt;직위, 성명&lt;/strong&gt;&lt;/td&gt;
			&lt;td style="text-align: left;"&gt;
				&lt;p&gt;
					　&lt;/p&gt;
			&lt;/td&gt;
		&lt;/tr&gt;
		&lt;tr&gt;
			&lt;td class="tbth"&gt;
				&lt;strong&gt;연락처&lt;/strong&gt;&lt;/td&gt;
			&lt;td style="text-align: left;"&gt;
				&lt;p&gt;
					　&lt;/p&gt;
			&lt;/td&gt;
			&lt;td class="tbth"&gt;
				&lt;strong&gt;기 간&lt;/strong&gt;&lt;/td&gt;
			&lt;td style="text-align: left;"&gt;
				201 년 월 일 ~ 201 년 월 일&lt;/td&gt;
		&lt;/tr&gt;
		&lt;tr&gt;
			&lt;td class="tbth"&gt;
				&lt;strong&gt;사 유&lt;/strong&gt;&lt;/td&gt;
			&lt;td style="text-align: left;"&gt;
				&lt;p&gt;
					　&lt;/p&gt;
			&lt;/td&gt;
			&lt;td class="tbth"&gt;
				&lt;p&gt;
					&lt;strong&gt;구 분&lt;/strong&gt;&lt;/p&gt;
				&lt;p&gt;
					&lt;span style="font-size: 8pt;"&gt;( 연차, 반차, 조퇴, 공가, 외출, 결근, 지각,특별휴가 )&lt;/span&gt;&lt;/p&gt;
			&lt;/td&gt;
			&lt;td style="text-align: left;"&gt;
				&lt;p&gt;
					　&lt;/p&gt;
			&lt;/td&gt;
		&lt;/tr&gt;
		&lt;tr&gt;
			&lt;td colspan="4" style="text-align: left;"&gt;
				&lt;p class="p5" style="text-align: center;"&gt;
			&lt;/td&gt;
		&lt;/tr&gt;
	&lt;/tbody&gt;
&lt;/table&gt;
</textarea><span id="cke_context" class="cke_skin_kama cke_1 cke_editor_context"
							dir="ltr" title="" lang="ko" tabindex="0" role="application"
							aria-labelledby="cke_context_arialbl"><span
								id="cke_context_arialbl" class="cke_voice_label">Rich
									Text Editor</span><span class="cke_browser_webkit" role="presentation">
									<span class="cke_wrapper cke_ltr" role="presentation">
									<table class="cke_editor" border="0" cellspacing="0" cellpadding="0"
											role="presentation">
											<tbody>
												<tr role="presentation">
													<td id="cke_top_context" class="cke_top" role="presentation">
													<div class="cke_toolbox"
															role="group" aria-labelledby="cke_6"
															onmousedown="return false;">
															<span id="cke_6" class="cke_voice_label">Editor
																toolbars</span><span id="cke_7" class="cke_toolbar"
																role="toolbar"><span class="cke_toolbar_start"></span><span
																class="cke_toolgroup" role="presentation"><span
																	class="cke_button"><a id="cke_8"
																		class="cke_off cke_button_source"
																		"="" href="javascript:void('소스')" title="소스"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_8_label"
																		onkeydown="return CKEDITOR.tools.callFunction(4, event);"
																		onfocus="return CKEDITOR.tools.callFunction(5, event);"
																		onclick="CKEDITOR.tools.callFunction(6, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_8_label"
																			class="cke_label">소스</span></a></span></span><span
																class="cke_toolbar_end"></span></span><span id="cke_9"
																class="cke_toolbar" role="toolbar"><span
																class="cke_toolbar_start"></span><span
																class="cke_toolgroup" role="presentation"><span
																	class="cke_button"><a id="cke_10"
																		class="cke_button_undo cke_disabled"
																		"="" href="javascript:void('취소')" title="취소"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_10_label"
																		onkeydown="return CKEDITOR.tools.callFunction(7, event);"
																		onfocus="return CKEDITOR.tools.callFunction(8, event);"
																		onclick="CKEDITOR.tools.callFunction(9, this); return false;"
																		aria-disabled="true"><span class="cke_icon">&nbsp;</span><span
																			id="cke_10_label" class="cke_label">취소</span></a></span><span
																	class="cke_button"><a id="cke_11"
																		class="cke_button_redo cke_disabled"
																		"="" href="javascript:void('재실행')" title="재실행"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_11_label"
																		onkeydown="return CKEDITOR.tools.callFunction(10, event);"
																		onfocus="return CKEDITOR.tools.callFunction(11, event);"
																		onclick="CKEDITOR.tools.callFunction(12, this); return false;"
																		aria-disabled="true"><span class="cke_icon">&nbsp;</span><span
																			id="cke_11_label" class="cke_label">재실행</span></a></span><span
																	class="cke_separator" role="separator"></span><span
																	class="cke_button"><a id="cke_12"
																		class="cke_off cke_button_selectAll"
																		"="" href="javascript:void('전체선택')" title="전체선택"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_12_label"
																		onkeydown="return CKEDITOR.tools.callFunction(13, event);"
																		onfocus="return CKEDITOR.tools.callFunction(14, event);"
																		onclick="CKEDITOR.tools.callFunction(15, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_12_label"
																			class="cke_label">전체선택</span></a></span><span class="cke_button"><a
																		id="cke_13" class="cke_off cke_button_removeFormat"
																		"="" href="javascript:void('포맷 지우기')" title="포맷 지우기"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_13_label"
																		onkeydown="return CKEDITOR.tools.callFunction(16, event);"
																		onfocus="return CKEDITOR.tools.callFunction(17, event);"
																		onclick="CKEDITOR.tools.callFunction(18, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_13_label"
																			class="cke_label">포맷 지우기</span></a></span></span><span
																class="cke_toolbar_end"></span></span><span id="cke_14"
																class="cke_toolbar" role="toolbar"><span
																class="cke_toolbar_start"></span><span
																class="cke_toolgroup" role="presentation"><span
																	class="cke_button"><a id="cke_15"
																		class="cke_off cke_button_bold"
																		"="" href="javascript:void('진하게')" title="진하게"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_15_label"
																		onkeydown="return CKEDITOR.tools.callFunction(19, event);"
																		onfocus="return CKEDITOR.tools.callFunction(20, event);"
																		onclick="CKEDITOR.tools.callFunction(21, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_15_label"
																			class="cke_label">진하게</span></a></span><span class="cke_button"><a
																		id="cke_16" class="cke_off cke_button_italic"
																		"="" href="javascript:void('이텔릭')" title="이텔릭"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_16_label"
																		onkeydown="return CKEDITOR.tools.callFunction(22, event);"
																		onfocus="return CKEDITOR.tools.callFunction(23, event);"
																		onclick="CKEDITOR.tools.callFunction(24, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_16_label"
																			class="cke_label">이텔릭</span></a></span><span class="cke_button"><a
																		id="cke_17" class="cke_off cke_button_underline"
																		"="" href="javascript:void('밑줄')" title="밑줄"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_17_label"
																		onkeydown="return CKEDITOR.tools.callFunction(25, event);"
																		onfocus="return CKEDITOR.tools.callFunction(26, event);"
																		onclick="CKEDITOR.tools.callFunction(27, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_17_label"
																			class="cke_label">밑줄</span></a></span><span
																	class="cke_separator" role="separator"></span><span
																	class="cke_button"><a id="cke_18"
																		class="cke_off cke_button_subscript"
																		"="" href="javascript:void('아래 첨자')" title="아래 첨자"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_18_label"
																		onkeydown="return CKEDITOR.tools.callFunction(28, event);"
																		onfocus="return CKEDITOR.tools.callFunction(29, event);"
																		onclick="CKEDITOR.tools.callFunction(30, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_18_label"
																			class="cke_label">아래 첨자</span></a></span><span
																	class="cke_button"><a id="cke_19"
																		class="cke_off cke_button_superscript"
																		"="" href="javascript:void('위 첨자')" title="위 첨자"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_19_label"
																		onkeydown="return CKEDITOR.tools.callFunction(31, event);"
																		onfocus="return CKEDITOR.tools.callFunction(32, event);"
																		onclick="CKEDITOR.tools.callFunction(33, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_19_label"
																			class="cke_label">위 첨자</span></a></span></span><span
																class="cke_toolbar_end"></span></span><span id="cke_20"
																class="cke_toolbar" role="toolbar"><span
																class="cke_toolbar_start"></span><span
																class="cke_toolgroup" role="presentation"><span
																	class="cke_button"><a id="cke_21"
																		class="cke_off cke_button_numberedlist"
																		"="" href="javascript:void('순서있는 목록')" title="순서있는 목록"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_21_label"
																		onkeydown="return CKEDITOR.tools.callFunction(34, event);"
																		onfocus="return CKEDITOR.tools.callFunction(35, event);"
																		onclick="CKEDITOR.tools.callFunction(36, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_21_label"
																			class="cke_label">순서있는 목록</span></a></span><span
																	class="cke_button"><a id="cke_22"
																		class="cke_off cke_button_bulletedlist"
																		"="" href="javascript:void('순서없는 목록')" title="순서없는 목록"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_22_label"
																		onkeydown="return CKEDITOR.tools.callFunction(37, event);"
																		onfocus="return CKEDITOR.tools.callFunction(38, event);"
																		onclick="CKEDITOR.tools.callFunction(39, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_22_label"
																			class="cke_label">순서없는 목록</span></a></span><span
																	class="cke_button"><a id="cke_23"
																		class="cke_button_outdent cke_disabled"
																		"="" href="javascript:void('내어쓰기')" title="내어쓰기"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_23_label"
																		onkeydown="return CKEDITOR.tools.callFunction(40, event);"
																		onfocus="return CKEDITOR.tools.callFunction(41, event);"
																		onclick="CKEDITOR.tools.callFunction(42, this); return false;"
																		aria-disabled="true"><span class="cke_icon">&nbsp;</span><span
																			id="cke_23_label" class="cke_label">내어쓰기</span></a></span><span
																	class="cke_button"><a id="cke_24"
																		class="cke_off cke_button_indent"
																		"="" href="javascript:void('들여쓰기')" title="들여쓰기"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_24_label"
																		onkeydown="return CKEDITOR.tools.callFunction(43, event);"
																		onfocus="return CKEDITOR.tools.callFunction(44, event);"
																		onclick="CKEDITOR.tools.callFunction(45, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_24_label"
																			class="cke_label">들여쓰기</span></a></span></span><span
																class="cke_toolbar_end"></span></span><span id="cke_25"
																class="cke_toolbar" role="toolbar"><span
																class="cke_toolbar_start"></span><span
																class="cke_toolgroup" role="presentation"><span
																	class="cke_button"><a id="cke_26"
																		class="cke_off cke_button_justifyleft"
																		"="" href="javascript:void('왼쪽 정렬')" title="왼쪽 정렬"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_26_label"
																		onkeydown="return CKEDITOR.tools.callFunction(46, event);"
																		onfocus="return CKEDITOR.tools.callFunction(47, event);"
																		onclick="CKEDITOR.tools.callFunction(48, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_26_label"
																			class="cke_label">왼쪽 정렬</span></a></span><span
																	class="cke_button"><a id="cke_27"
																		class="cke_off cke_button_justifycenter"
																		"="" href="javascript:void('가운데 정렬')" title="가운데 정렬"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_27_label"
																		onkeydown="return CKEDITOR.tools.callFunction(49, event);"
																		onfocus="return CKEDITOR.tools.callFunction(50, event);"
																		onclick="CKEDITOR.tools.callFunction(51, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_27_label"
																			class="cke_label">가운데 정렬</span></a></span><span
																	class="cke_button"><a id="cke_28"
																		class="cke_off cke_button_justifyright"
																		"="" href="javascript:void('오른쪽 정렬')" title="오른쪽 정렬"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_28_label"
																		onkeydown="return CKEDITOR.tools.callFunction(52, event);"
																		onfocus="return CKEDITOR.tools.callFunction(53, event);"
																		onclick="CKEDITOR.tools.callFunction(54, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_28_label"
																			class="cke_label">오른쪽 정렬</span></a></span><span
																	class="cke_button"><a id="cke_29"
																		class="cke_off cke_button_justifyblock"
																		"="" href="javascript:void('양쪽 맞춤')" title="양쪽 맞춤"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_29_label"
																		onkeydown="return CKEDITOR.tools.callFunction(55, event);"
																		onfocus="return CKEDITOR.tools.callFunction(56, event);"
																		onclick="CKEDITOR.tools.callFunction(57, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_29_label"
																			class="cke_label">양쪽 맞춤</span></a></span></span><span
																class="cke_toolbar_end"></span></span>
															<div class="cke_break"></div>
															<span id="cke_31" class="cke_toolbar" role="toolbar"><span
																class="cke_toolbar_start"></span><span
																class="cke_rcombo" role="presentation"><span
																	id="cke_30" class="cke_format cke_off"
																	role="presentation"><span id="cke_30_label"
																		class="cke_label">포맷</span><a hidefocus="true"
																		title="포맷" tabindex="-1" href="javascript:void('포맷')"
																		role="button" aria-labelledby="cke_30_label"
																		aria-describedby="cke_30_text" aria-haspopup="true"
																		onkeydown="CKEDITOR.tools.callFunction( 59, event, this );"
																		onfocus="return CKEDITOR.tools.callFunction(60, event);"
																		onclick="CKEDITOR.tools.callFunction(58, this); return false;"><span><span
																				id="cke_30_text" class="cke_text cke_inline_label">포맷</span></span><span
																			class="cke_openbutton"><span class="cke_icon"></span></span></a></span></span><span
																class="cke_rcombo" role="presentation"><span
																	id="cke_32" class="cke_font cke_off"
																	role="presentation"><span id="cke_32_label"
																		class="cke_label">폰트</span><a hidefocus="true"
																		title="폰트" tabindex="-1" href="javascript:void('폰트')"
																		role="button" aria-labelledby="cke_32_label"
																		aria-describedby="cke_32_text" aria-haspopup="true"
																		onkeydown="CKEDITOR.tools.callFunction( 62, event, this );"
																		onfocus="return CKEDITOR.tools.callFunction(63, event);"
																		onclick="CKEDITOR.tools.callFunction(61, this); return false;"><span><span
																				id="cke_32_text" class="cke_text cke_inline_label">폰트</span></span><span
																			class="cke_openbutton"><span class="cke_icon"></span></span></a></span></span><span
																class="cke_rcombo" role="presentation"><span
																	id="cke_33" class="cke_fontSize cke_off"
																	role="presentation"><span id="cke_33_label"
																		class="cke_label">글자 크기</span><a hidefocus="true"
																		title="글자 크기" tabindex="-1"
																		href="javascript:void('글자 크기')" role="button"
																		aria-labelledby="cke_33_label"
																		aria-describedby="cke_33_text" aria-haspopup="true"
																		onkeydown="CKEDITOR.tools.callFunction( 65, event, this );"
																		onfocus="return CKEDITOR.tools.callFunction(66, event);"
																		onclick="CKEDITOR.tools.callFunction(64, this); return false;"><span><span
																				id="cke_33_text" class="cke_text cke_inline_label">글자
																					크기</span></span><span class="cke_openbutton"><span
																				class="cke_icon"></span></span></a></span></span><span
																class="cke_toolbar_end"></span></span><span id="cke_34"
																class="cke_toolbar" role="toolbar"><span
																class="cke_toolbar_start"></span><span
																class="cke_toolgroup" role="presentation"><span
																	class="cke_button"><a id="cke_35"
																		class="cke_off cke_button_textcolor"
																		"="" href="javascript:void('글자 색상')" title="글자 색상"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_35_label" aria-haspopup="true"
																		onkeydown="return CKEDITOR.tools.callFunction(67, event);"
																		onfocus="return CKEDITOR.tools.callFunction(68, event);"
																		onclick="CKEDITOR.tools.callFunction(69, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_35_label"
																			class="cke_label">글자 색상</span><span
																			class="cke_buttonarrow">&nbsp;</span></a></span><span
																	class="cke_button"><a id="cke_36"
																		class="cke_off cke_button_bgcolor"
																		"="" href="javascript:void('배경 색상')" title="배경 색상"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_36_label" aria-haspopup="true"
																		onkeydown="return CKEDITOR.tools.callFunction(70, event);"
																		onfocus="return CKEDITOR.tools.callFunction(71, event);"
																		onclick="CKEDITOR.tools.callFunction(72, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_36_label"
																			class="cke_label">배경 색상</span><span
																			class="cke_buttonarrow">&nbsp;</span></a></span></span><span
																class="cke_toolbar_end"></span></span><span id="cke_37"
																class="cke_toolbar" role="toolbar"><span
																class="cke_toolbar_start"></span><span
																class="cke_toolgroup" role="presentation"><span
																	class="cke_button"><a id="cke_38"
																		class="cke_off cke_button_link"
																		"="" href="javascript:void('링크 삽입/변경')"
																		title="링크 삽입/변경" tabindex="-1" hidefocus="true"
																		role="button" aria-labelledby="cke_38_label"
																		onkeydown="return CKEDITOR.tools.callFunction(73, event);"
																		onfocus="return CKEDITOR.tools.callFunction(74, event);"
																		onclick="CKEDITOR.tools.callFunction(75, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_38_label"
																			class="cke_label">링크 삽입/변경</span></a></span><span
																	class="cke_button"><a id="cke_39"
																		class="cke_button_unlink cke_disabled"
																		"="" href="javascript:void('링크 삭제')" title="링크 삭제"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_39_label"
																		onkeydown="return CKEDITOR.tools.callFunction(76, event);"
																		onfocus="return CKEDITOR.tools.callFunction(77, event);"
																		onclick="CKEDITOR.tools.callFunction(78, this); return false;"
																		aria-disabled="true"><span class="cke_icon">&nbsp;</span><span
																			id="cke_39_label" class="cke_label">링크 삭제</span></a></span></span><span
																class="cke_toolbar_end"></span></span><span id="cke_40"
																class="cke_toolbar" role="toolbar"><span
																class="cke_toolbar_start"></span><span
																class="cke_toolgroup" role="presentation"><span
																	class="cke_button"><a id="cke_41"
																		class="cke_off cke_button_image" "="" href="javascript:void('이미지')" title="이미지"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_41_label"
																		onkeydown="return CKEDITOR.tools.callFunction(79, event);"
																		onfocus="return CKEDITOR.tools.callFunction(80, event);"
																		onclick="CKEDITOR.tools.callFunction(81, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_41_label"
																			class="cke_label">이미지</span></a></span><span class="cke_button"><a
																		id="cke_42" class="cke_off cke_button_table"
																		"="" href="javascript:void('표')" title="표"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_42_label"
																		onkeydown="return CKEDITOR.tools.callFunction(82, event);"
																		onfocus="return CKEDITOR.tools.callFunction(83, event);"
																		onclick="CKEDITOR.tools.callFunction(84, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_42_label"
																			class="cke_label">표</span></a></span><span class="cke_button"><a
																		id="cke_43" class="cke_off cke_button_smiley"
																		"="" href="javascript:void('아이콘')" title="아이콘"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_43_label"
																		onkeydown="return CKEDITOR.tools.callFunction(85, event);"
																		onfocus="return CKEDITOR.tools.callFunction(86, event);"
																		onclick="CKEDITOR.tools.callFunction(87, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_43_label"
																			class="cke_label">아이콘</span></a></span><span class="cke_button"><a
																		id="cke_44" class="cke_off cke_button_specialchar"
																		"="" href="javascript:void('특수문자 삽입')" title="특수문자 삽입"
																		tabindex="-1" hidefocus="true" role="button"
																		aria-labelledby="cke_44_label"
																		onkeydown="return CKEDITOR.tools.callFunction(88, event);"
																		onfocus="return CKEDITOR.tools.callFunction(89, event);"
																		onclick="CKEDITOR.tools.callFunction(90, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_44_label"
																			class="cke_label">특수문자 삽입</span></a></span></span><span
																class="cke_toolbar_end"></span></span><span id="cke_45"
																class="cke_toolbar" role="toolbar"><span
																class="cke_toolbar_start"></span><span
																class="cke_toolgroup" role="presentation"><span
																	class="cke_button"><a id="cke_46"
																		class="cke_off cke_button_maximize"
																		"="" href="javascript:void('Maximize')"
																		title="Maximize" tabindex="-1" hidefocus="true"
																		role="button" aria-labelledby="cke_46_label"
																		onkeydown="return CKEDITOR.tools.callFunction(91, event);"
																		onfocus="return CKEDITOR.tools.callFunction(92, event);"
																		onclick="CKEDITOR.tools.callFunction(93, this); return false;"><span
																			class="cke_icon">&nbsp;</span><span id="cke_46_label"
																			class="cke_label">Maximize</span></a></span></span><span
																class="cke_toolbar_end"></span></span>
														</div>
														<a title="Collapse Toolbar" id="cke_47" tabindex="-1"
														class="cke_toolbox_collapser"
														onclick="CKEDITOR.tools.callFunction(94)"><span>▲</span></a></td>
												</tr>
												<!-- <tr role="presentation">
													<td id="cke_contents_context" class="cke_contents"
														style="height: 602px" role="presentation"><span
														id="cke_51" class="cke_voice_label">Press ALT 0 for
															help</span>
													<iframe style="width: 100%; height: 100%" frameborder="0"
															aria-describedby="cke_51"
															title="Rich text editor, context" src="" tabindex="-1"
															allowtransparency="true"></iframe></td>
												</tr>
												<tr role="presentation">
													<td id="cke_bottom_context" class="cke_bottom"
														role="presentation"><div
															class="cke_resizer cke_resizer_ltr"
															title="Drag to resize"
															onmousedown="CKEDITOR.tools.callFunction(3, event)"></div>
														<span id="cke_path_context_label" class="cke_voice_label">Elements
															path</span>
													<div id="cke_path_context" class="cke_path" role="group"
															aria-labelledby="cke_path_context_label">
															<span class="cke_empty">&nbsp;</span>
														</div></td>
												</tr>-->
											</tbody>
										</table>
										<style>
.cke_skin_kama {
	visibility: hidden;
}
</style></span></span></span></td>
					</tr>
					<tr>
						<th scope="row" class="etitle"><span>메모</span></th>
						<td scope="row" class="eleft" colspan="5">
							<input type="text" id="comments" name="comment" value="" class="input_title" title="메모"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<!-- 붙임 문서 -->
	<!-- end : 붙임 문서 -->

	<!-- 하단 버튼 -->
	<div class="h30 float_r">
		<span class="gw_btn_pack blue">
			<button type="button" id="save" title="저장">상신</button>
		</span> 
		<span class="gw_btn_pack red"> 
			<input type="button" id="cancel" title="취소" value="취소">
		</span>
	</div>
</form>
<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
 <script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "<%=cp%>/resource/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
		}
	},
	fOnAppLoad : function(){
	
		//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}
	
function submitContents() {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>