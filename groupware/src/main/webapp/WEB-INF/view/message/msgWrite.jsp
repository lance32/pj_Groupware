<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>
#paginate{clear:both;text-align:center;height:28px;white-space:nowrap;}
#paginate a {border:1px solid #ccc;height:28px;color:#000000;text-decoration:none;padding:4px 7px 4px 7px;margin-left:3px;line-height:normal;vertical-align:middle;outline:none;}
#paginate a:hover, a:active {border:1px solid #147FCC;color:#0174DF;vertical-align:middle;line-height:normal;}
#paginate .curBox{border:1px solid #424242; background: #4e4e4e; color:#ffffff; font-weight:bold;height:28px;padding:4px 8px 4px 8px;margin-left:3px;line-height:normal;vertical-align:middle;}
#paginate .numBox {border:1px solid #ccc;height:28px;text-decoration:none;padding:4px 7px 4px 7px;margin-left:3px;line-height:normal;vertical-align:middle;}

.note_edite_table {width:100%; border-top:2px solid #a1c9e4;}
.note_edite_table td {border-bottom:1px dotted #dfdfdf; padding:5px;}
.note_edite_table td.note_edite_title {background:#f7f7f7; color:#595959; text-align:center; width:15%;}
.note_edite_table td.note_edite_cont {background:#fff; width:85%;}

input.note_input {background:#fff; color:#333; height:16px; width:70%; border:1px solid #d7d7d7;}
input.note_input2 {background:#fff; color:#333; height:16px; width:75%; border:1px solid #d7d7d7;}
</style>

<div id="test" style="width:100%; height:600px; ">

	<%-- 상단 대표글씨 --%>
	<div style="clear: both; margin: 10px 0px 15px 10px;">
		<span class="glyphicon glyphicon-send" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;쪽지 쓰기</span><br>
		<div style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>
	</div>
	
	<form name="new_memo" method="post" action="action.php?shell=/segio/msg/note/note_work.shell" target="hidden_memo" enctype="multipart/form-data">
		<input type="hidden" name="mode" value="save">

  		<table class="note_edite_table" cellpadding="0" cellspacing="0">
		<tbody>
		<tr>
			<td class="note_edite_title">받는이</td>
			<td class="note_edite_cont">
				<span>
					<input type="text" id="users" name="users" class="note_input" value="">
				</span> 
				<span class="btn_pack large">
					<button type="button" title="검색" onclick="window.open('find_receiver.php','_blank', 'width=340px,height=400px', 'false');">	검색</button>
				</span>
					<span class="btn_pack large">
					<input type="button" title="조직도" value="조직도" id="open_groupware_tree">
				</span>
			</td>
		</tr>
		<tr>
		  <td class="note_edite_title">첨부파일 </td>
		  <td class="note_edite_cont">
		  	<span style="float:left; width:80%;">
				<div id="filediv0" style="display: block;">
					<input type="file" name="attach1" style="border:1px solid #D1D9E8;color:#4F6B9B;width:100%;">
				</div>
				<div id="filediv1" style="display:none;">
					<input type="file" name="attach2" style="border:1px solid #D1D9E8;color:#4F6B9B;width:100%;">
				</div>
				<div id="filediv2" style="display:none;">
					<input type="file" name="attach3" style="border:1px solid #D1D9E8;color:#4F6B9B;width:100%;">
				</div>
				<div id="filediv3" style="display:none;">
					<input type="file" name="attach4" style="border:1px solid #D1D9E8;color:#4F6B9B;width:100%;">
				</div>
				<div id="filediv4" style="display:none;">
					<input type="file" name="attach5" style="border:1px solid #D1D9E8;color:#4F6B9B;width:100%;">
				</div>
			</span> 
			<span style="float:left; padding:0 5px 0 0;">
				<button name="btn_plus" value="+" class="button2" onclick="show_filediv(1);return(false);">+</button>&nbsp;<button name="btn_minus" value="-" class="button2" onclick="show_filediv(-1);return(false);">-</button>
			</span>
		</td>
		</tr>
		<tr>
			 <td colspan="2" class="note_edite_context">
			 	<span><textarea name="content" rows="15" cols="45" style="width:99%;"></textarea></span>	
			 </td>
		</tr>
	   </tbody>
	   </table>
	</form>
</div>

