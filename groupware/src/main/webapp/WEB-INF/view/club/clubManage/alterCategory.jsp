<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>
.alterLi-separate{
	font-weight: 600;
	background: #424242;
	color: #FAFAFA;
	padding-left: 10px;
	cursor: pointer;
}
.alterLi-separate:hover{
	background: #6E6E6E;
	color: #FFFFFF;
}

.alterLi-items{
	padding-left: 20px;
	cursor: pointer;
}
.alterLi-items:hover{
	background: #E6E6E6;
}

</style>


<script type="text/javascript">
jQuery(function(){
	//카테고리 목록
	<c:forEach var="dto" items="${clubCategoryItem}">
		jQuery("#alterCategory${dto.categoryParent}").append("<li class='alterLi-items' value='${dto.categoryNum}'>${dto.categoryName}<input type='hidden' class='categoryParent' value='${dto.categoryParent}'></li>");
	</c:forEach>
	
	jQuery(".chooseParentCategory").hide();
	//2단계 선택시
	jQuery("#phase2").click(function(){
		jQuery(".chooseParentCategory").show();
	});
	//1단계 선택시
	jQuery("#phase1").click(function(){
		jQuery(".chooseParentCategory").hide();
	});
	
	//카테고리 목록에서 상위 카테고리 선택시
	jQuery(".alterLi-separate").click(function(){
		//카테고리 추가|선택한 상위 카테고리
		var categoryName = jQuery(this).text();
		var categoryNum = jQuery(this).val();
		jQuery("#choosingParentCategory").html(categoryName);
		jQuery("#parentCategoryNum").val(categoryNum);
		//카테고리 수정|정보
		jQuery("#categoryName").val(categoryName);
		jQuery("#parentCategoryName").val("-");
		jQuery("#choosingCategoryNum").val(categoryNum);
	});
	//하위 카테고리 선택시
	jQuery(".alterLi-items").click(function(){
		//카테고리 추가|선택한 상위 카테고리
		jQuery("#choosingParentCategory").html("선택한 상위 카테고리가 없습니다.");
		//카테고리 수정|정보
		var categoryNum = jQuery(this).val();
		var categoryName = jQuery(this).text();
		var parentCategoryNum = jQuery(this).children(".categoryParent").val();
		var parentCategoryName = jQuery("#alterCategory"+parentCategoryNum).children(".alterLi-separate").text();
		jQuery("#categoryName").val(categoryName);
		jQuery("#parentCategoryName").val(parentCategoryName);
		jQuery("#choosingCategoryNum").val(categoryNum);
	});
	
//---------
	//추가버튼 클릭시
	jQuery("#addCategoryButn").click(function(){
		if(! jQuery("input:radio[name=separate]").is(":checked")){
			alert("1단계 또는 2단계를 선택하세요.");
			return;
		}
		var f=document.createCategoryForm;
		
		var str=f.categoryName.value;
		if(!str){
			alert("카테고리 이름을 입력하세요.");
			f.categoryName.focus();
			return;
		}
		f.action="<%=cp%>/clubManage/createCategory";
		f.submit();
	});
	
	//삭제버튼 클릭시
	jQuery("#deleteCategoryButn").click(function(){
		var categoryNum=jQuery("#choosingCategoryNum").val();
		if(categoryNum==""||categoryNum=="0") {
	    		alert("삭제할 카테고리를 선택하세요.");
	    		return;
		}
		if(! confirm("카테고리를 삭제하면 카테고리와 관련된 모든 게시물도 삭제 됩니다.\n카테고리를 삭제 하시겠습니까 ? ")) {
			return;
		}
		location.href="<%=cp%>/clubManage/deleteCategory?categoryNum="+categoryNum+"&clubNum=${clubInfo.clubNum}";
		return;
	});
	
	jQuery("#updateDiv").hide();
	//수정하기 버튼 클릭시
	jQuery("#updateCategoryButn").click(function(){
		var categoryNum=jQuery("#choosingCategoryNum").val();
		if(categoryNum==""||categoryNum=="0") {
	    		alert("수정할 카테고리를 선택하세요.");
	    		return;
		}
		jQuery("#alterDiv").hide();
		jQuery("#updateDiv").show();
		jQuery("#categoryName").prop("readonly",false);
		jQuery("#parentCategoryName").css("background","#F2F2F2")
		
	});
	//수정완료 버튼 클릭시
	jQuery("#updateCategorySubmitButn").click(function(){
		var f=document.updateCategoryForm;
		var str=f.categoryName.value;
		if(!str){
			alert("카테고리 이름을 입력하세요.");
			f.categoryName.focus();
			return;
		}
		f.action="<%=cp%>/clubManage/updateCategory";
		f.submit();
	});
	
	//수정취소 버튼 클릭시
	jQuery("#updateCancleButn").click(function(){
		location.href="<%=cp%>/club/alterCategory?clubNum=${clubInfo.clubNum}";
		return;
	});
	
});

</script>

<ul class="nav nav-tabs" style="margin-top: 30px;">
  <li role="presentation"><a href="<%=cp%>/club/alterClubInfo?clubNum=${clubInfo.clubNum}">동호회 정보</a></li>
  <li role="presentation" class="active"><a>게시판 카테고리 설정</a></li>
  <li role="presentation" style="float: right;"><a href="<%=cp%>/club/deleteClub?clubNum=${clubInfo.clubNum}" style="color: #B40404;">동호회 삭제</a></li>
</ul>

<div style="width:1100; height: 700px; clear: both; margin: 0px; padding: 0px; padding: 40px 0px 0px 80px; ">
	<p>&nbsp;카테고리 목록</p>
	<div style="float: left; width: 260px; height: 600px; border: 1px solid #A4A4A4; overflow-y: auto; padding: 15px 10px;">
		<c:forEach var="dto" items="${clubCategory}">
			<div style="text-align: left;">
				<ul id="alterCategory${dto.categoryNum}" class="ul-list">
					<li class="alterLi-separate" value="${dto.categoryNum}">${dto.categoryName}</li>
				</ul>
			</div>
		</c:forEach>
	</div>
	
	<div style="float: left; width: auto; height: 600px; padding-left: 80px;">
		<div style="clear: both;">
			<span style="font-size: 19px;">카테고리 추가</span><br>
			<div style="clear: both; width: 270px; height: 1px; border-bottom: 2px solid black;"></div>
		</div>
		<div style="clear: both; padding:20px 0px 70px 10px; height: 210px;">
			<form name="createCategoryForm">&nbsp;
				<label><input type="radio" name="separate" id="phase1" value="1">&nbsp;1단계</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<label><input type="radio" name="separate" id="phase2" value="2">&nbsp;2단계</label><br>
				<input name="categoryName" type="text" style="border: none; border:1px solid #848484; border-radius: 3px; height: 28px; padding-left: 5px;">
				<button id="addCategoryButn" class="clubButn">추가</button><br><br>
				<div class="chooseParentCategory" style="margin-bottom: 10px;">
					<span style="font-weight: 600; color: #6E6E6E;">상위 카테고리 :&nbsp;&nbsp;</span>
					<span id="choosingParentCategory" style="border-bottom: 0.3px solid #BDBDBD; padding: 0px 5px;">선택한 상위 카테고리가 없습니다.</span>
				</div>
				<span class="chooseParentCategory" style="font-size: 13px; color: #A4A4A4;">&nbsp;※ 왼쪽 목록에서 상위 카테고리를 선택하여 주세요.</span>
				<input type="hidden" id="parentCategoryNum" name="categoryParent">
				<input type="hidden" name="clubNum" value="${clubInfo.clubNum}">
			</form>
		</div>
		
		<div style="clear: both;">
			<span style="font-size: 19px;">카테고리 수정</span><br>
			<div style="clear: both; width: 270px; height: 1px; border-bottom: 2px solid black;"></div>
		</div>
		<div style="clear: both; padding:20px 0px 0px 10px;">
			<span style="font-size: 13px; color: #A4A4A4;">※ 왼쪽 목록에서 카테고리를 선택하면 밑에 정보가 표시됩니다.</span>
			<form name="updateCategoryForm">
				<table style="border-spacing: 0px; margin:20px 0px 10px 0px;">
					<tr height="40">
						<td width="100">카테고리 이름</td>
						<td><input id="categoryName" name="categoryName" type="text" style="border:1px solid #848484; border-radius: 3px; height: 25px; padding-left: 5px;" readonly="readonly"></td>
					</tr>
					<tr height="40">
						<td>상위 카테고리</td>
						<td><input id="parentCategoryName" type="text" style="border:1px solid #848484; border-radius: 3px; height: 25px; padding-left: 5px;" readonly="readonly"></td>
					</tr>
					<tr height="40">
						<td colspan="2">댓글, 답변형, 좋아요 등..</td>
					</tr>
				</table>
				<input type="hidden" id="choosingCategoryNum" name="categoryNum">
				<input type="hidden" name="clubNum" value="${clubInfo.clubNum}">
			</form>
			<div id="alterDiv" style="width: 100%;">
				<button id="deleteCategoryButn" class="clubButn">삭제</button>
				<button id="updateCategoryButn" class="clubButn" style="float: right;">수정 하기</button>
			</div>
			<div id="updateDiv" style="width: 100%;">
				<button id="updateCancleButn" class="clubButn" style="float: right;">수정취소</button>
				<button id="updateCategorySubmitButn" class="clubButn" style="float: right; margin-right: 7px;">수정완료</button>
			</div>
			
		</div>
		
		
	</div>
	
</div>