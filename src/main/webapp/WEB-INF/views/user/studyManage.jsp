<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/headerSub.jsp"%>
<div class="mypage_bg">
	<div class="mypage container">

		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation"><a href="/user/myPage">개인정보관리</a></li>
			<li role="presentation" class="active"><a href="/user/studyManage">스터디관리</a></li>
		</ul>
		<!-- Tab panes -->
		<div role="tabpanel" class="tab-pane active" id="myinfo">
			<div class="tabpanel-in" role="tabpanel">

				<div role="tabpanel" class="tab-pane" id="study">
					<div class="" role="tabpanel">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
							<li id="bookmarkBtn" role="presentation" class="active study"><a href="#bookmark-study" aria-controls="bookmark-study" role="tab" data-toggle="tab">북마크</a></li>
							<li id="regBtn" role="presentation" class="study"><a href="#recruitment-study" aria-controls="recruitment-study" role="tab" data-toggle="tab">모집</a></li>
							<li id="applyBtn" role="presentation" class="study"><a href="#progress-study" aria-controls="progress-study" role="tab" data-toggle="tab" id="progressStudy">신청</a></li>
							<li id="endBtn" role="presentation" class="study"><a href="#complete-study" aria-controls="complete-study" role="tab" data-toggle="tab">완료</a></li>
						</ul>
						<!-- Tab panes -->
						<div class="tab-content animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
							<div role="tabpanel" class="tab-pane active" id="bookmark-study">

								<div class="sub-thumbnail">
									<div id="wish-thumbnail"></div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane" id="recruitment-study">
								<div class="sub-thumbnail">
									<div id="reg-thumbnail"></div>
									<div id="applyList"></div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane" id="progress-study">
								<div class="sub-thumbnail">
									<div id="cur-thumbnail"></div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane" id="complete-study">
								<div class="sub-thumbnail">
									<div id="finish-thumbnail"></div>
								</div>
							</div>
						</div>
						
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!-- 신청자목록 Modal -->
	<div class="modal fade" id="applyListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="login-modal-title">신청자목록 </h4>
					<div class="modal-body">
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 승인여부 Modal -->
	<div class="modal fade" id="ApproveCheck" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="login-modal-title">승인여부</h4>
					<div class="modal-body">
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 참여인원목록 Modal -->
	<div class="modal fade" id="studyMember" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="login-modal-title">스터디 참여자</h4>
					<div class="modal-body">
						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<a href="#" class="top"><i class="fa fa-angle-up" aria-hidden="true"></i></a>
<script id="templateList" type="text/x-handlebars-template">
<div class="col-md-4">
	<div class="card hovercard">
		<div class="cardheaderbox">
			<div class="cardheaderboxIn">
				<div class="cardheader" style="background: url({{backgroundImg}}); background-size: cover;"></div>
				{{#fin}}
					<a href='/study/studyEndView?studyNo={{studyNo}}' class="card-name">{{studyName}}</a>
				{{else}}
					<a href='/study/studyView?studyNo={{studyNo}}&studyManage=true&target={{target}}' class="card-name">{{studyName}}</a>
				{{/fin}}
			</div>
		</div>
		<div class="avatar">
			<span class="mailbox-attachment-icon has-img"> 
			<img src="{{profileImg}}"></span>
		{{#fin}}
			{{#studyLeader}}
				<span class="m_icon"><i class="fa fa-user-o" aria-hidden="true"></i></span>
			{{/studyLeader}}
		{{/fin}}
		{{#reg}}
			<span class="m_icon"><i class="fa fa-user-o" aria-hidden="true"></i></span>
		{{/reg}}
			<span class="icon icon_1"><i class="fa fa-eye" aria-hidden="true"></i>{{viewCnt}}</span>
			<span class="icon icon_2">
				<i class="fa fa-user" aria-hidden="true"></i>{{curMemCnt}}</span>
		</div>
		<div class="info" data-sno={{studyNo}}>
			<div class="title">
				<a target="_blank" class="userNick_link" data-writer={{writer}} href="#">{{userNick}}</a>
			</div>
			<div class="desc">{{studyRegion}}</div>
			<div class="desc info-bold">스터디 시작일 - {{startDate}}</div>
		</div>
		{{#fin}}
			<a class="btn btn-primary btn-sm" href="/study/studyEndView?studyNo={{studyNo}}">자세히보기</a>
			{{#studyLeader}}
				<a class="btn btn-primary btn-sm" id="studyMemList" data-toggle="modal" href="#studyMember">참여자목록</a>
			{{/studyLeader}}
		{{else}}
			<a class="btn btn-primary btn-sm" href="/study/studyView?studyNo={{studyNo}}&studyManage=true&target={{target}}">자세히보기</a>
		{{/fin}}
		{{#reg}}
			<a class="btn btn-primary btn-sm" id="applyMemList" data-toggle="modal" href="#applyListModal">신청자목록</a>
		{{/reg}}
		{{#app}}
			<a class="btn btn-primary btn-sm" id="approveChkBtn" data-toggle="modal" href="#ApproveCheck">승인 여부</a>
		{{/app}}
		<div class="mailbox-attachment-info"></div>
	</div>
</div>
</script>
<script> // 템플릿 적용
	$(document).ready(function() {
		var template = Handlebars.compile($("#templateList").html());
		
		if ('${favList}'.length > 2){
			<c:forEach items="${favList}" varStatus="listIdx" var="studyVO"> // 스터디 즐겨찾기 페이지 출력
				<fmt:formatDate value="${studyVO.studyStartDate}" pattern="yyyy-MM-dd" var="date" />
				var studyRegion="${studyVO.studyUpRegion} " + "${studyVO.studyDownRegion}";
				var thumbnail={
					imagePath:"${studyVO.imagePath}",
					studyName:"${studyVO.studyName}",
					userNick:"${studyVO.userNick}",
					studyRegion:studyRegion,
					studyNo:"${studyVO.studyNo}",
					profileImgPath:"${studyVO.userProfileImgPath}",
					date:"${date}",
					viewCnt:"${studyVO.studyViewCnt}",
					curMemCnt:"${studyVO.studyCurMemCnt}",
					writer:"${studyVO.studyWriter}"
				};
				var thumbInfo = thumbnailInfo(thumbnail);
				var html = template(thumbInfo);
				$("#wish-thumbnail").append(html);
			</c:forEach>
		} else
			$("#wish-thumbnail").append("<div class='col-md-4'><p>즐겨찾기한 스터디가 없습니다.</p></div>");
		
		if ('${regList}'.length > 2){
			<c:forEach items="${regList}" varStatus="listIdx" var="studyVO"> // 스터디 등록 페이지 출력 
				<fmt:formatDate value="${studyVO.studyStartDate}" pattern="yyyy-MM-dd" var="date" />
				var studyRegion="${studyVO.studyUpRegion} " + "${studyVO.studyDownRegion}";
				var thumbnail={
					imagePath:"${studyVO.imagePath}",
					studyName:"${studyVO.studyName}",
					userNick:"${studyVO.userNick}",
					studyRegion:studyRegion,
					studyNo:"${studyVO.studyNo}",
					profileImgPath:"${studyVO.userProfileImgPath}",
					date:"${date}",
					viewCnt:"${studyVO.studyViewCnt}",
					curMemCnt:"${studyVO.studyCurMemCnt}",
					writer:"${studyVO.studyWriter}"
				};
				var thumbInfo = thumbnailInfo(thumbnail,'reg');
				var html = template(thumbInfo);
				$("#reg-thumbnail").append(html);
			</c:forEach>
		} else
			$("#reg-thumbnail").append("<div class='col-md-4'><p>등록 스터디가 없습니다.</p></div>");
		
		if ('${appList}'.length > 2){
			<c:forEach items="${appList}" varStatus="listIdx" var="studyVO"> // 스터디 신청 페이지 출력
				<fmt:formatDate value="${studyVO.studyStartDate}" pattern="yyyy-MM-dd" var="date" />
				var studyRegion="${studyVO.studyUpRegion} " + "${studyVO.studyDownRegion}";
				var thumbnail={
					imagePath:"${studyVO.imagePath}",
					studyName:"${studyVO.studyName}",
					userNick:"${studyVO.userNick}",
					studyRegion:studyRegion,
					studyNo:"${studyVO.studyNo}",
					profileImgPath:"${studyVO.userProfileImgPath}",
					date:"${date}",
					viewCnt:"${studyVO.studyViewCnt}",
					curMemCnt:"${studyVO.studyCurMemCnt}",
					writer:"${studyVO.studyWriter}"
				};
				var thumbInfo = thumbnailInfo(thumbnail,'app');
				var html = template(thumbInfo);
				$("#cur-thumbnail").append(html);
			</c:forEach>
		} else
			$("#cur-thumbnail").append("<div class='col-md-4'><p>신청 스터디가 없습니다.</p></div>");
		
		if ('${endList}'.length > 2) {
			<c:forEach items="${endList}" varStatus="listIdx" var="studyVO"> // 스터디 완료 페이지 출력
				<fmt:formatDate value="${studyVO.studyStartDate}" pattern="yyyy-MM-dd" var="date" />
				var studyRegion="${studyVO.studyUpRegion} " + "${studyVO.studyDownRegion}";
				var thumbnail={
					imagePath:"${studyVO.imagePath}",
					studyName:"${studyVO.studyName}",
					userNick:"${studyVO.userNick}",
					studyRegion:studyRegion,
					studyNo:"${studyVO.studyNo}",
					profileImgPath:"${studyVO.userProfileImgPath}",
					date:"${date}",
					viewCnt:"${studyVO.studyViewCnt}",
					curMemCnt:"${studyVO.studyCurMemCnt}",
					writer:"${studyVO.studyWriter}"
				};
				var thumbInfo = thumbnailInfo(thumbnail, 'finL');
				var html = template(thumbInfo);
				$("#finish-thumbnail").append(html);
			</c:forEach>
		}	
		if ('${endListMem}'.length > 2) {
			<c:forEach items="${endListMem}" varStatus="listIdx" var="studyVO"> // 스터디 완료 페이지 출력
			<fmt:formatDate value="${studyVO.studyStartDate}" pattern="yyyy-MM-dd" var="date" />
				var studyRegion="${studyVO.studyUpRegion} " + "${studyVO.studyDownRegion}";
				var thumbnail={
					imagePath:"${studyVO.imagePath}",
					studyName:"${studyVO.studyName}",
					userNick:"${studyVO.userNick}",
					studyRegion:studyRegion,
					studyNo:"${studyVO.studyNo}",
					profileImgPath:"${studyVO.userProfileImgPath}",
					date:"${date}",
					viewCnt:"${studyVO.studyViewCnt}",
					curMemCnt:"${studyVO.studyCurMemCnt}",
					writer:"${studyVO.studyWriter}"
				};
				var thumbInfo = thumbnailInfo(thumbnail, 'finM');
				var html = template(thumbInfo);
				$("#finish-thumbnail").append(html);
			</c:forEach>
		} 
		if(!('${endList}'.length > 2 || '${endListMem}'.length > 2))
			$("#finish-thumbnail").append("<div class='col-md-4'><p>완료 스터디가 없습니다.</p></div>");
		
	});
</script>
<script> // 스터디장 일 경우
	$(document).on("click", "#applyMemList", function(){ // 신청자리스트 클릭
		var studyNo = $(this).siblings('.info').attr("data-sno");
		
		$.ajax({
			type : 'post',
			url : '/user/applyMemList',
			data : {"studyNo" : studyNo},
			success : function(data) {
				if(data[0] != null) // 데이터가 있으면
					for(var i = 0; i<data.length; i++){
						var userName = data[i].userName; // 신청자 이름
						var temp = data[i].userPhoneNumber.split(',');
						var userPhone = temp[0] + "-" + temp[1] + "-" + temp[2]; // 신청자 폰번호
						var userprofileImgPath = data[i].userProfileImgPath; // 신청자 프로필 이미지
						
						if(data[i].userApprove == 0) // 승인 대기중
							$('#applyListModal .modal-body').append("<div class='applyList'>" 
																	+ "<span id='dataSpan' data-sno="+studyNo+" data-uno="+data[i].userNo+">" 
																		+ "<div class='avatar'>" 
																			+ "<span class='mailbox-attachment-icon has-img'>" 
																				+ "<img src='/displayFile?fileName="+data[i].userProfileImgPath+"'>" 
																			+ "</span>" 
																		+ "</div>" 
																		+ "<div class='applyListInfo'><span data-writer='"+data[i].userNo+"' class='userNick_link'>" + data[i].userNick + "</span>" 
																			+ "<a id='applyNo'>거부</a>" 
																			+ "<a id='applyOk'>승인</a>"
																		+ "</div>"
																	+ "</span>"
																+ "</div>");
						else if(data[i].userApprove == 1) // 승인 거부시
							$('#applyListModal .modal-body').append("<div class='applyList'>" 
																	+ "<span id='dataSpan' data-sno="+studyNo+" data-uno="+data[i].userNo+">" 
																	+ "<div class='avatar'>" 
																		+ "<span class='mailbox-attachment-icon has-img'>" 
																			+ "<img src='/displayFile?fileName="+data[i].userProfileImgPath+"'>" 
																		+ "</span>" 
																	+ "</div>" 
																	+ "<div class='applyListInfo'><span data-writer='"+data[i].userNo+"' class='userNick_link'>" + data[i].userNick + "</span>" 
																		+"<span class='applyListInfo2'> 님을 거절 하였습니다.</span>"
																	+ "</div>"
																	
																+ "</span>"
															+ "</div>");
						else // 승인 수락시
							$('#applyListModal .modal-body').append("<div class='applyList'>" 
																	+ "<span id='dataSpan' data-sno="+studyNo+" data-uno="+data[i].userNo+">" 
																	+ "<div class='avatar'>" 
																		+ "<span class='mailbox-attachment-icon has-img'>" 
																			+ "<img src='/displayFile?fileName="+data[i].userProfileImgPath+"'>" 
																		+ "</span>" 
																	+ "</div>" 
																	+ "<div class='applyListInfo'><span data-writer='"+data[i].userNo+"' class='userNick_link'>" + data[i].userNick+ "</span>" 
																		 + "<span class='applyListInfo2'> [이름 : " + userName + " / 전화번호 : " + userPhone + "] </span>"
																	+ "</div>"
																+ "</span>"
															+ "</div>");
					}
				else
					$('#applyListModal .modal-body').append("<p>신청자가 없습니다.</p>");
			}
		});
	});
	
	$('#applyListModal').on("hidden.bs.modal", function(){ // 신청자리스트 모달창 닫힐때
		$('#applyListModal .modal-body').empty();
	});
	
	$(document).on("click", "#applyOk", function() { // 승인 클릭
		var userNo = $(this).parents('#dataSpan').attr("data-uno"); // 유저No
		var studyNo = $(this).parents('#dataSpan').attr("data-sno"); // 스터디No
		var changeBtn = $(this).parent('div');
		var loginUserNo='${login.userNo}';
		$.ajax({
			type : 'post',
			url : '/user/applyApprove',
			data : {
				"userNo" : userNo,
				"studyNo" : studyNo,
				"studyWriter" : loginUserNo
				},
			success : function(data) {
				var userName = data.userName; // 신청자 이름
				var temp = data.userPhoneNumber.split(',');
				var userPhone = temp[0] + "-" + temp[1] + "-" + temp[2]; // 신청자 폰번호
				
				changeBtn.children('a').remove();
				changeBtn.append('<span> [이름 : ' + userName + ' / 전화번호 : ' + userPhone + '] </span>');
			}
		});
	});
	
	$(document).on("click", "#applyNo", function(){ // 거부 클릭
		var changeBtn = $(this).parent('div');
		
		changeBtn.children().css('display','none');
		changeBtn.append('<div class="denyboxDiv">'
							+'<span class="denybox"><small>거절사유 :</small> </span>'
							+'<input class="denybox" id="denyMsg" type="text" value="죄송합니다 다음에 연락드리겠습니다.">'
							+'<a class="denybox" id="denyNo">취소</a><a class="denybox" id="denyOk">확인</a>'
						+'</div>');
	});
	
	$(document).on("click", "#denyOk", function(){ // 거부 -> 확인 클릭시
		var userNo = $(this).parents('#dataSpan').attr("data-uno"); // 유저No
		var studyNo = $(this).parents('#dataSpan').attr("data-sno"); // 스터디No
		var denyMsg = $('#denyMsg').val(); // 거절메시지
		var changeBtn = $(this).parent('div').parent('.applyListInfo');
		var loginUserNo='${login.userNo}';
		$.ajax({
			type : 'post',
			url : '/user/applyDeny',
			data : {
				"userNo" : userNo, 
				"studyNo" : studyNo, 
				"denyMsg" : denyMsg,
				"studyWriter" : loginUserNo
				},
			success : function(data) {
				$('.userNick_link').show();
				changeBtn.children('.denyboxDiv').remove();
				changeBtn.children('a').remove();
				changeBtn.append('<span> 님을 거절 하였습니다.</span>');
				sockNote.send(userNo);
			}
		});
	});
	
	$(document).on("click", "#studyMemList", function(){ // 스터디 멤버 리스트
		var studyNo = $(this).siblings('.info').attr("data-sno"); // 스터디No
		
		$.ajax({
			type : 'post',
			url : '/user/studyMemList',
			data : {"studyNo" : studyNo},
			success : function(data) {
				if(data.length > 0) // 데이터가 있으면
					for(var i = 0; i<data.length; i++){
						var userName = data[i].userName; // 신청자 이름
						var userprofileImgPath = data[i].userProfileImgPath; // 신청자 프로필 이미지
						
						$('#studyMember .modal-body').append("<div class='applyList'>" 
																+ "<span id='dataSpan' data-sno="+studyNo+" data-uno="+data[i].userNo+">" 
																	+ "<div class='avatar'>" 
																		+ "<span class='mailbox-attachment-icon has-img'>" 
																			+ "<img src='/displayFile?fileName="+data[i].userProfileImgPath+"'>" 
																		+ "</span>" 
																	+ "</div>" 
																	+ "<div class='applyListInfo'>" + "<span data-writer='"+data[i].userNo+"' class='userNick_link'>" + data[i].userNick + "</span>" 
																	+ "</div>"
																+ "</span>"
															+ "</div>");
					}
				}
		});
	});
	
	
	
	$('#studyMember').on("hidden.bs.modal", function(){ // 승인여부 모달창 닫힐때
		$('#studyMember .modal-body').empty();
	});
	
	
	$(document).on("click", "#denyNo", function(){ // 거부 -> 취소 클릭시
		$(this).parent('div').parent('.applyListInfo').children().css('display','inline-block');
		$(this).parent('div').parent('.applyListInfo').children('.denyboxDiv').remove();
	});
</script>
<script> // 스터디 원 일경우
	$(document).on("click", "#approveChkBtn", function(){ // 신청자리스트 클릭
		var studyNo = $(this).siblings('.info').attr("data-sno");
		
		$.ajax({
			type : 'post',
			url : '/user/approveCheck',
			data : {"studyNo" : studyNo},
			success : function(data){
				var userStudyVO = data.userStudyVO; // 스터디 승인 여부
				
				if(userStudyVO.userApprove == 0)
					$('#ApproveCheck .modal-body').append("<div><span>현재 스터디장의 수락을 기다리고 있습니다.</span></div>");
				else if(userStudyVO.userApprove == 2){
					var userVO = data.userVO; // 스터디장 정보
					var temp = userVO.userPhoneNumber.split(',');
					var userPhone = temp[0] + "-" + temp[1] + "-" + temp[2]; // 신청자 폰번호
					$('#ApproveCheck .modal-body').append("<div><p>스터디장이 신청을 수락하였습니다.</p><p>스터디장 정보 : [" + userVO.userName + " : " + userPhone + "]</p></div>");
				}
					
			}
		});
	});
	
	$(document).on("click", "#applyDenyCancel", function(){ // 거부당한 스터디 취소 클릭
		var studyNo = $(this).siblings('#dataP').attr("data-sno");
	
		$.ajax({
			type : 'post',
			url : '/user/applyDenyCancel',
			data : {"studyNo" : studyNo},
			success : function(data){
				alert("거부 당한 스터디를 취소 하였습니다.");
				location.reload();
			}
		});
	});
	
	$('#ApproveCheck').on("hidden.bs.modal", function(){ // 승인여부 모달창 닫힐때
		$('#ApproveCheck .modal-body').empty();
	});
	
	/*userInfo 새창 띄우기  */
	$(document).on("click", ".userNick_link", function(event) {
		event.preventDefault();
		var writerNo = $(this).attr('data-writer');
		window.open("/user/userInfo?userNo=" + writerNo, "userInfo", "location=no, left=400px, top=100px, width=600px, height=700px");
	});
</script>
<script>
var target = ${param.target}
window.onload = tabLoad(target);
function tabLoad(target){
	if (target==2) {
		$('#bookmarkBtn').removeClass('active');
		$('#bookmark-study').removeClass('active');
		$('#regBtn').addClass('active');
		$('#recruitment-study').addClass('active');
	} else if (target==3) {
		$('#bookmarkBtn').removeClass('active');
		$('#bookmark-study').removeClass('active');
		$('#applyBtn').addClass('active');
		$('#progress-study').addClass('active');
	} else if(target==4) {
		$('#bookmarkBtn').removeClass('active');
		$('#bookmark-study').removeClass('active');
		$('#endBtn').addClass('active');
		$('#complete-study').addClass('active');
	}
}
</script>
<%@include file="../include/footerSub.jsp"%>