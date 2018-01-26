$(document).ready(function() {
	var loginUserNo = userNo; // 로그인사용자 No
	var template = Handlebars.compile($("#templateList").html());
	
	$.ajax({
		type : 'post',
		url : '/user/favList',
		data : { "userNo" : userNo },
		success : function(studyVO) {
			if (studyVO != "") {
				for(var i = 0; i< studyVO.length; i++) {
					var thumbnail = {
						backgroundImg : studyVO[i].imagePath,
						studyName : studyVO[i].studyName,
						userNick : studyVO[i].userNick,
						studyRegion : studyVO[i].studyUpRegion + " " + studyVO[i].studyDownRegion,
						studyNo : studyVO[i].studyNo,
						profileImg : studyVO[i].userProfileImgPath,
						startDate : studyVO[i].studyStartDate,
						viewCnt : studyVO[i].studyViewCnt,
						curMemCnt : studyVO[i].studyCurMemCnt,
						writer : studyVO[i].studyWriter
					}
					var result = thumbnailInfo(thumbnail);
					$("#wish-thumbnail").append(template(result));
				}
			} else
				$("#wish-thumbnail").append("<div class='col-md-4'><p>즐겨찾기한 스터디가 없습니다.</p></div>");
		}
	});
	
	$.ajax({
		type : 'post',
		url : '/user/regList',
		data : { "userNo" : userNo },
		success : function(studyVO) {
			if (studyVO != "") {
				for(var i = 0; i< studyVO.length; i++) {
					var thumbnail = {
						backgroundImg : studyVO[i].imagePath,
						studyName : studyVO[i].studyName,
						userNick : studyVO[i].userNick,
						studyRegion : studyVO[i].studyUpRegion + " " + studyVO[i].studyDownRegion,
						studyNo : studyVO[i].studyNo,
						profileImg : studyVO[i].userProfileImgPath,
						startDate : studyVO[i].studyStartDate,
						viewCnt : studyVO[i].studyViewCnt,
						curMemCnt : studyVO[i].studyCurMemCnt,
						writer : studyVO[i].studyWriter
					}
					var result = thumbnailInfo(thumbnail, 'reg');
					$("#reg-thumbnail").append(template(result));
				}
			} else
				$("#reg-thumbnail").append("<div class='col-md-4'><p>등록 스터디가 없습니다.</p></div>");
		}
	});

	$.ajax({
		type : 'post',
		url : '/user/appList',
		data : { "userNo" : userNo },
		success : function(studyVO) {
			if (studyVO != "") {
				for(var i = 0; i< studyVO.length; i++) {
					var thumbnail = {
						backgroundImg : studyVO[i].imagePath,
						studyName : studyVO[i].studyName,
						userNick : studyVO[i].userNick,
						studyRegion : studyVO[i].studyUpRegion + " " + studyVO[i].studyDownRegion,
						studyNo : studyVO[i].studyNo,
						profileImg : studyVO[i].userProfileImgPath,
						startDate : studyVO[i].studyStartDate,
						viewCnt : studyVO[i].studyViewCnt,
						curMemCnt : studyVO[i].studyCurMemCnt,
						writer : studyVO[i].studyWriter
					}
					var result = thumbnailInfo(thumbnail, 'app');
					$("#cur-thumbnail").append(template(result));
				}
			} else
				$("#cur-thumbnail").append("<div class='col-md-4'><p>신청 스터디가 없습니다.</p></div>");
		}
	});
	
	$.ajax({
		type : 'post',
		url : '/user/endList',
		data : { "userNo" : userNo },
		success : function(studyVO) {
			if (studyVO != "") {
				for(var i = 0; i< studyVO.length; i++) {
					var thumbnail = {
						backgroundImg : studyVO[i].imagePath,
						studyName : studyVO[i].studyName,
						userNick : studyVO[i].userNick,
						studyRegion : studyVO[i].studyUpRegion + " " + studyVO[i].studyDownRegion,
						studyNo : studyVO[i].studyNo,
						profileImg : studyVO[i].userProfileImgPath,
						startDate : studyVO[i].studyStartDate,
						viewCnt : studyVO[i].studyViewCnt,
						curMemCnt : studyVO[i].studyCurMemCnt,
						writer : studyVO[i].studyWriter,
						studyLeader : studyVO[i].studyLeader
					}
					var result = thumbnailInfo(thumbnail, 'fin');
					$("#finish-thumbnail").append(template(result));
				}
			} else
				$("#finish-thumbnail").append("<div class='col-md-4'><p>완료 스터디가 없습니다.</p></div>");
		}
	});
	
	// 스터디장일 경우
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

	// 스터디원일 경우
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

	$('#ApproveCheck').on("hidden.bs.modal", function(){ // 승인여부 모달창 닫힐때
		$('#ApproveCheck .modal-body').empty();
	});

	/*userInfo 새창 띄우기  */
	$(document).on("click", ".userNick_link", function(event) {
		event.preventDefault();
		var writerNo = $(this).attr('data-writer');
		window.open("/user/userInfo?userNo=" + writerNo, "userInfo", "location=no, left=400px, top=100px, width=600px, height=700px");
	});
});
var target = $('#target').val();
window.onload = tabLoad(target);
function tabLoad(target) {
	if (target == 2) {
		$('#bookmarkBtn').removeClass('active');
		$('#bookmark-study').removeClass('active');
		$('#regBtn').addClass('active');
		$('#recruitment-study').addClass('active');
	} else if (target == 3) {
		$('#bookmarkBtn').removeClass('active');
		$('#bookmark-study').removeClass('active');
		$('#applyBtn').addClass('active');
		$('#progress-study').addClass('active');
	} else if (target == 4) {
		$('#bookmarkBtn').removeClass('active');
		$('#bookmark-study').removeClass('active');
		$('#endBtn').addClass('active');
		$('#complete-study').addClass('active');
	}
}