<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style>
#paginate {
	clear: both;
	text-align: center;
	height: 28px;
	white-space: nowrap;
}

#paginate a {
	border: 1px solid #ccc;
	height: 28px;
	color: #000000;
	text-decoration: none;
	padding: 4px 7px 4px 7px;
	margin-left: 3px;
	line-height: normal;
	vertical-align: middle;
	outline: none;
}

#paginate a:hover, a:active {
	border: 1px solid #147FCC;
	color: #0174DF;
	vertical-align: middle;
	line-height: normal;
}

#paginate .curBox {
	border: 1px solid #424242;
	background: #4e4e4e;
	color: #ffffff;
	font-weight: bold;
	height: 28px;
	padding: 4px 8px 4px 8px;
	margin-left: 3px;
	line-height: normal;
	vertical-align: middle;
}

#paginate .numBox {
	border: 1px solid #ccc;
	height: 28px;
	text-decoration: none;
	padding: 4px 7px 4px 7px;
	margin-left: 3px;
	line-height: normal;
	vertical-align: middle;
}
</style>

<div id="test" style="width: 100%; height: 600px;">

	<%-- 상단 대표글씨 --%>
	<div style="clear: both; margin: 10px 0px 15px 80px;">
		<span class="glyphicon glyphicon-pencil"
			style="font-size: 28px; margin-left: 10px;"></span> <span
			style="font-size: 30px;">&nbsp;새문서 작성</span><br>
		<div
			style="clear: both; width: 300px; height: 1px; border-bottom: 3px solid black;"></div>

		<div class="work_title">
			<div class="app_new_wrap1">
				<div class="app_new_wrap2">

					<div class="appnew_list">
						<div class="form_box">
								<h4>	문서 양식 선택</h4>
						</div>
					</div>

					<div class="appnew_con">
						<div class="appr_table">
							<table class="list" summary="문서양식 관리">
								<colgroup>
									<col style="width: 30%">
									<col style="width: 70%">
								</colgroup>
							<tbody>

									<tr>
										<td scope="row" class="td_left"><img
											src="<%=cp%>/resource/images/paper_icon.gif" alt="문서양식 아이콘">
											<span class="txtgray"> <a href="<%=cp%>/approval/approval_createform" title="근태신청서">근태신청서</a>
										</span></td>
										<td scope="row" class="td_left"><a href="edit_format.php?format_no=18&amp;rel_doc_no="></a></td>
									</tr>
									<tr>
										<td scope="row" class="td_left"><img src="<%=cp%>/resource/images/paper_icon.gif" alt="문서양식 아이콘">
											<span class="txtgray"> <a href="<%=cp%>/approval/approval_createform1" title="구매요청서">구매요청서</a>
										</span></td>
										<td scope="row" class="td_left"><a
											href="edit_format.php?format_no=15&amp;rel_doc_no="></a></td>
									</tr>
									
									<tr>
										<td scope="row" class="td_left"><img
											src="<%=cp%>/resource/images/paper_icon.gif"> <span
											class="txtgray"> <a href="#" title="기안서">기안서</a>
										</span></td>
										<td scope="row" class="td_left"><a href="#"></a></td>
									</tr>
									<tr>
										<td scope="row" class="td_left"><img
											src="<%=cp%>/resource/images/paper_icon.gif"> <span
											class="txtgray"> <a href="#" title="업무일지">업무일지</a>
										</span></td>
										<td scope="row" class="td_left"><a
											href="edit_format.php?format_no=3&amp;rel_doc_no="></a></td>
									</tr>
									<tr>
										<td scope="row" class="td_left"><img
											src="<%=cp%>/resource/images/paper_icon.gif" alt="문서양식 아이콘">
											<span class="txtgray"> <a
												href="edit_format.php?format_no=16&amp;rel_doc_no="
												title="출장/외근 보고서">출장/외근 보고서</a>
										</span></td>
										<td scope="row" class="td_left"><a
											href="edit_format.php?format_no=16&amp;rel_doc_no="></a></td>
									</tr>
									<tr>
										<td scope="row" class="td_left"><img
											src="<%=cp%>/resource/images/paper_icon.gif" alt="문서양식 아이콘">
											<span class="txtgray"> <a
												href="edit_format.php?format_no=17&amp;rel_doc_no="
												title="출장/외근 신청서">출장/외근 신청서</a>
										</span></td>
										<td scope="row" class="td_left"><a
											href="edit_format.php?format_no=17&amp;rel_doc_no="></a></td>
									</tr>

								</tbody>
							</table>
						</div>


					</div>

				</div>
			</div>
		</div>
	</div>
</div>
