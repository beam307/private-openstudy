var category = [ "전체", "영어", "외국어", "IT", "교양", "공무원" ];

$("#searchBox").autocomplete({ // 자동완성
	source : category
});

if (msg == 'regSuccess') // 회원가입 메시지
	alert("[회원가입 완료] \n" + userEmail + "님 가입을 환영합니다.");
if (msg == 'delete') // 회원탈퇴 메시지
	alert('회원탈퇴 하였습니다.');

/* 템플릿 컴파일  */
var template = Handlebars.compile($("#templateList").html());

$.ajax({ // 최신순 썸네일 리스트
	type : 'post',
	url : '/recentList',
	success : function(studyVO) {
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
			$("#studyList-thumbnail").append(template(result));
		};
	}
});

$.ajax({ // 베스트순 썸네일 리스트
	type : 'post',
	url : '/bestList',
	success : function(studyVO) {
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
			$("#studyList-thumbnail-Line").append(template(result));
		};
	}
});

if (loginState == "true") { // 로그인 했을 경우
	$.ajax({ // 관심카테고리 썸네일 리스트
		type : 'post',
		url : '/favAllList',
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
					$("#userRecommend").append(template(result));
				};
			} else
				$('#subInfoAdd').show();
		}
	});
} else { // 로그인 안한 경우
	$.ajax({ // 랜덤썸네일 리스트
		type : 'post',
		url : '/randomList',
		success : function(studyVO) {
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
				$("#userRecommend").append(template(result));
			};
		}
	})
};

/* userInfo 새창 띄우기  */
$(document).on("click", ".userNick_link", function(event) {
	event.preventDefault();
	var writerNo = $(this).attr('data-writer');
	window.open("/user/userInfo?userNo=" + writerNo, "userInfo", "location=no, left=400px, top=100px, width=600px, height=700px");
});
