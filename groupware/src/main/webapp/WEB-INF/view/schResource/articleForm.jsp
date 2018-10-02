<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<table style="margin: 10px auto 0px; width: 100%; border-spacing: 0px;">
		  <tr height="40"> 
		      <td width="100"style="font-weight:600; padding-right:15px; text-align: right;">제&nbsp;&nbsp;목</td>
		      <td> 
                     <span id="resTitleArticle"></span>
              </td>
		  </tr>

		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">작성자</td>
		      <td> 
		             <span id="resNameArticle"></span>
		      </td>
		  </tr>
		
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">구 분</td>
		      <td> 
		        	<span id="resGroupArticle"></span>
		      </td>
		  </tr>
		  
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">항 목</td>
		      <td> 
		        	<span id="resResourceArticle"></span>
		      </td>
		  </tr>

		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">종일일정</td>
		      <td> 
		        	<span id="resAllDayArticle"></span>
		      </td>
		  </tr>
		  
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">시작일</td>
		      <td> 
		        	<span id="resStartDayArticle"></span>
		      </td>
		  </tr>
		  
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">종료일</td>
		      <td> 
		        	<span id="resEndDayArticle"></span>
		      </td>
		  </tr>
		  
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">인 원</td>
		      <td> 
		        	<span id="resInwonArticle"></span>
		      </td>
		  </tr>
		
</table>