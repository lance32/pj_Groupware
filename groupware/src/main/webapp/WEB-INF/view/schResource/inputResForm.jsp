<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<form name="inputResourceForm" class="form-horizontal">	
	<div class="form-group">
		<label class="col-sm-2 control-label">구   분</label>
		<div class="col-sm-10" style="padding-top: 5px;">
			<select name="groupNum" class="form-control selectField">
				<c:forEach var="vo" items="${groupList}">
					<option value="${vo.groupNum}">${vo.groupName}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">제  목</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" name="resourceName">
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">색 상</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" name="color">
		</div>
	</div>
	
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">최 대 인 원</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" name="occupancy">
		</div>
	</div>
</form>