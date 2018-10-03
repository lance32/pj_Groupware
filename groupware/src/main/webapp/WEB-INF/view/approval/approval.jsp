<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script>

</script>


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
				<td width="100">순서</td>
				<td width="auto" style="text-align: left;">제목</td>
				<td width="100">결재상태</td>
				<td width="100">날짜</td>
			</tr>
		
		
		<%
		String driverName = "net.sf.log4jdbc.DriverSpy";
		String dburl = "jdbc:log4jdbc:oracle:thin:@211.238.142.190:1521:xe";
		
		Class.forName(driverName);
		Connection connection = DriverManager.getConnection(dburl, "groupware", "java$!");
		Statement stmt = connection.createStatement();
		
		String sql = "SELECT SUBJECT, DOCUMENTSTATE, CREATED, MEMBERNUM "+
				 " FROM APPROVALDOCUMENT "+
				 " WHERE DOCUNUM IN (SELECT DOCUNUM "+
				 "                     FROM APPROVAL "+
				 "                    WHERE APPROVALNUM IN (SELECT APPROVALNUM "+
				 "                                            FROM APPROVALPROCESS "+ 
				 "                                           WHERE 1 = 1 "+
				 "                                             AND APPROVALSTATE = 3 "+
				 "                                             AND MEMBERNUM = 123123)) "+
				 "   AND ROWNUM < 2";

		
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>" + rs.getString("ROWNUM") + "</td>");
			out.println("<td>" + rs.getString("SUBJECT") + "</td>");
			out.println("<td>" + rs.getString("DOCUMENTSTATE") + "</td>");
			out.println("<td>" + rs.getString("CREATED") + "</td>");			
			out.println("</tr>");
		}

				
		
		%>
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
				<td width="100">순서</td>
				<td width="auto" style="text-align: left;">제목</td>
				<td width="100">결재상태</td>
				<td width="100">날짜</td>
			</tr>
			
			<%
			sql = "SELECT ROWNUM, SUBJECT, DOCUMENTSTATE, CREATED, MEMBERNUM, DOCUNUM" +
					  " FROM APPROVALDOCUMENT"+
					  " WHERE DOCUNUM IN (SELECT DOCUNUM"+
					  "                    FROM APPROVAL"+
					  "                   WHERE APPROVALNUM IN (SELECT APPROVALNUM"+
					  "                                           FROM APPROVALPROCESS"+
					  "                                          WHERE 1=1"+
					  "                                           AND APPROVALSEQ = 0 "+
					  "                                           AND MEMBERNUM = 'test'))"+
					  "   AND DOCUMENTSTATE = 1"+
					  "   AND ROWNUM < 5"+
					  " ORDER BY DOCUNUM DESC";
			
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				out.println("<tr>");
				out.println("<td>" + rs.getString("ROWNUM") + "</td>");
				out.println("<td>" + rs.getString("SUBJECT") + "</td>");
				out.println("<td>" + rs.getString("DOCUMENTSTATE") + "</td>");
				out.println("<td>" + rs.getString("CREATED") + "</td>");			
				out.println("</tr>");
			}
			%>
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
				<td width="100">순서</td>
				<td width="auto" style="text-align: left;">제목</td>
				<td width="100">결재상태</td>
				<td width="100">날짜</td>
			</tr>
			
			<%
			sql = "SELECT ROWNUM, SUBJECT, DOCUMENTSTATE, CREATED, MEMBERNUM, DOCUNUM" +
					  " FROM APPROVALDOCUMENT"+
					  " WHERE DOCUNUM IN (SELECT DOCUNUM"+
					  "                    FROM APPROVAL"+
					  "                   WHERE APPROVALNUM IN (SELECT APPROVALNUM"+
					  "                                           FROM APPROVALPROCESS"+
					  "                                          WHERE 1=1"+
					  "                                           AND APPROVALSEQ = 0 "+
					  "                                           AND MEMBERNUM = 'admin'))"+
					  "   AND DOCUMENTSTATE = 2"+
					  "   AND ROWNUM < 2";
			
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				out.println("<tr>");
				out.println("<td>" + rs.getString("ROWNUM") + "</td>");
				out.println("<td>" + rs.getString("SUBJECT") + "</td>");
				out.println("<td>" + rs.getString("DOCUMENTSTATE") + "</td>");
				out.println("<td>" + rs.getString("CREATED") + "</td>");			
				out.println("</tr>");
			}
			%>
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
				<td width="100">순서</td>
				<td width="auto" style="text-align: left;">제목</td>
				<td width="100">결재상태</td>
				<td width="100">날짜</td>
			</tr>
			
			<%
			sql = "SELECT ROWNUM, SUBJECT, DOCUMENTSTATE, CREATED, MEMBERNUM, DOCUNUM" +
					  " FROM APPROVALDOCUMENT"+
					  " WHERE DOCUNUM IN (SELECT DOCUNUM"+
					  "                    FROM APPROVAL"+
					  "                   WHERE APPROVALNUM IN (SELECT APPROVALNUM"+
					  "                                           FROM APPROVALPROCESS"+
					  "                                          WHERE 1=1"+
					  "                                           AND APPROVALSEQ = 0 "+
					  "                                           AND MEMBERNUM = 'admin'))"+
					  "   AND DOCUMENTSTATE = 3"+
					  "   AND ROWNUM < 2";
			
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				out.println("<tr>");
				out.println("<td>" + rs.getString("ROWNUM") + "</td>");
				out.println("<td>" + rs.getString("SUBJECT") + "</td>");
				out.println("<td>" + rs.getString("DOCUMENTSTATE") + "</td>");
				out.println("<td>" + rs.getString("CREATED") + "</td>");			
				out.println("</tr>");
			}
			%>
		</table>
	</div>
