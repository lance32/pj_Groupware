<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

	<div style=" width: 45%; margin: 10px 0px 15px 10px; float: left;" >
		<a href="#"><span class="glyphicon glyphicon-folder-open" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;결재 문서함</span></a><br><!--본인이 중간 결재자일때 앞:결재해야할 문서 개수, 뒤:결재하고 진행중인 문서 -->
			
		<table id="tb" style="margin-left:0px; width: 500px;"><%-- 테이블 길이 수정 가능 --%>
			<tr>
				<td id="count" colspan="2" >
				</td>
				<td></td><td></td>
			</tr>
			
			<tr class="cf">
				<%-- 구분 폭 수정 가능 --%>
				<td width="100">구분1</td>
				<td width="auto" style="text-align: left;">구분2</td>
				<td width="100">구분3</td>
				<td width="100">구분4</td>
			</tr>
			
			<tr class="tr">
				<td>항목1</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr class="tr">
				<td>항목2</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr class="tr">
				<td>항목3</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
		</table>
	</div>
	
     <div style=" width: 45%;margin: 10px 0px 15px 10px; float: left;">
		<a href="#" ><span class="glyphicon glyphicon-folder-open" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;진행 문서함</span></a><br><!--본인이 상신한 문서만  -->
		
	    <table id="tb" style="margin-left:0px; width: 500px;"><%-- 테이블 길이 수정 가능 --%>
			<tr>
				<td id="count" colspan="2">
				</td>
				<td></td><td></td>
			</tr>
			
			<tr class="cf">
				<%-- 구분 폭 수정 가능 --%>
				<td width="100">구분1</td>
				<td width="auto" style="text-align: left;">구분2</td>
				<td width="100">구분3</td>
				<td width="100">구분4</td>
			</tr>
			
			<tr class="tr">
				<td>항목1</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr class="tr">
				<td>항목2</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr class="tr">
				<td>항목3</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
		</table>
	</div>
	
	<div style=" width: 45%; margin: 10px 0px 15px 10px; float: left;">
		<a href="#" ><span class="glyphicon glyphicon-folder-open" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;완료 문서함</span></a><br><!--본인이 상신한 문서 완료함  -->
			
		<table id="tb" style="margin-left:0px; width: 500px;"><%-- 테이블 길이 수정 가능 --%>
			<tr>
				<td id="count" colspan="2" >
				</td>
				<td></td><td></td>
			</tr>
			
			<tr class="cf">
				<%-- 구분 폭 수정 가능 --%>
				<td width="100">구분1</td>
				<td width="auto" style="text-align: left;">구분2</td>
				<td width="100">구분3</td>
				<td width="100">구분4</td>
			</tr>
			
			<tr class="tr">
				<td>항목1</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr class="tr">
				<td>항목2</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr class="tr">
				<td>항목3</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
		</table>
	</div>
	
     <div style=" width: 45%;margin: 10px 0px 15px 10px; float: left;">
		<a href="#" ><span class="glyphicon glyphicon-folder-open" style="font-size: 28px; margin-left: 10px;"></span>
		<span style="font-size: 30px;">&nbsp;반려 문서함</span></a><br><!--본인이 상신한 문서 반려  -->

    	<table id="tb" style="margin-left:0px; width: 500px;"><%-- 테이블 길이 수정 가능 --%>
			<tr>
				<td id="count" colspan="2">
				</td>
				<td></td><td></td>
			</tr>
			
			<tr class="cf">
				<%-- 구분 폭 수정 가능 --%>
				<td width="100">구분1</td>
				<td width="auto" style="text-align: left;">구분2</td>
				<td width="100">구분3</td>
				<td width="100">구분4</td>
			</tr>
			
			<tr class="tr">
				<td>항목1</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr class="tr">
				<td>항목2</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr class="tr">
				<td>항목3</td>
				<td style="text-align: left;">1</td>
				<td>2</td>
				<td>3</td>
			</tr>
		</table>
	</div>
