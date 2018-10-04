<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<form name="groupForm" class="form-horizontal">
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">그 룹 명</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" name="groupName">
		</div>
	</div>	
</form>
