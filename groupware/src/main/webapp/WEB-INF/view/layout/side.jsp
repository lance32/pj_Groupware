<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%
   String cp=request.getContextPath();
%>


<h4 style="text-align: center;">2018-09-10</h4>
<table class="sidetable" border ="1">
<tr>
<td rowspan = "5" style="width:80px;"><img src = "<%=cp%>/resource/images/drawGit.png" width="100" height = "100"></td>
<td align="center">부서명</td>
</tr>
<tr>
<td align="center">직급<br>이름</td>
</tr>
<tr>
<td align="center">
   <a href = "#"><span class = "glyphicon glyphicon-envelope" aria-hidden="true"></span>(0)</a> <!-- 메일 -->
</td>
</tr>
<tr>
<td align="center">
	<a href = "#"><span class = "glyphicon glyphicon-comment" aria-hidden="true"></span>(0)</a><!-- 쪽지 -->
</td>
</tr>
<tr>
<td align="center"><a href="#">정보 수정</a></td>
</tr>
<tr>
<td align="center"><a href="#">주소록</a></td>
<td align="center"><a href="<%=cp%>/member/logout">로그아웃</a></td>
</tr>
</table>