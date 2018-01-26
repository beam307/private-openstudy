
/*등록된 스터디완료 이미지 불러오기*/
var callImageEnd = function(studyNo,template){
	$.getJSON("/study/getImgEnd/" + studyNo, function(list) {
		$(list).each(function() {
			var fileInfo = getFileInfo(this);
			var html = template(fileInfo);
			$(".thumnail").append(html);
			uploadCnt++;
		});
	});
}



var callWeekTimeEnd = function(studyNo){
	$.getJSON("/study/getWeekEnd/" + studyNo, function(weekVO) {
		for (let i = 0; i < weekVO.length; i++) {
			$("#Datepicker").append(
					"<div class='dayChk col-sm-12'>" + "<span class='day' data-src='" + weekVO[i].weekDay + "'>" + weekVO[i].weekDay
							+ "</span>" + " " + "<span class='start' data-src='" + weekVO[i].weekStartDate + "'>" + weekVO[i].weekStartDate
							+ "</span>" + "<span class='wave'>~</span>" + "<span class='end' data-src='" + weekVO[i].weekEndDate + "'>"
							+ weekVO[i].weekEndDate + "</span>까지"
							+ "<a data-src='' class='btn btn-xs pull-right delbtn'><i class='fa fa-fw fa-remove'></i></a></div>");
		}
	});
}


$(document).ready(function() {
	
	uploadCnt = 0; //파일업로드, 불러오기에도 사용
	studyRegCnt = $('#studyRegCnt').val(); // 유효성 체크에서도 사용
	/*스터디 등록갯수 체크*/
	(function(){
		if (studyRegCnt >= 3) {
			var result = confirm('모집중인 스터디가 최대 개수(3개)를 초과하셨습니다.\n스터디관리창으로 이동하시겠습니까?\n※ 등록창은 볼 수 있으나 등록이 불가합니다.');
			if (result)
				self.location = "/user/studyManage?target=2";
		};
	})();
	
	/* 화면에 업로드된 이미지 썸네일 출력 템플릿  */
	var template = Handlebars.compile($("#template").html());


	/* 취소버튼 클릭시  */
	$("#cancelBtn").on("click", function() {
		self.location = "/study/studyList";
	});

	/*파일 업로드하기  */
	ImgUpload(template);

	/*주단위 시간 출력*/
	selectWeek();

	// 시작시간 변경 시
	selectWeekSub();

	/* 버튼클릭시 일정추가  */
	dayDuplCheck();

	/* 일정제거  */
	weekDelete();

	/* 최대인원 설정  */
	maxMemCheckHandler();
	
	/* 대표이미지 드래그 설정  */
	imgMoveHandler();
	
	/* 카테고리 5개 체크 제한 */
	categoryChkCnt();
	
	/*이전 리스트 정보불러오기*/
	$("#exStudyList").on("change", function() {
		uploadCnt = 0;
		var studyNo = $("#exStudyList > option:selected").attr("data-studyNo") || 0;
		var endFlag = $("#exStudyList > option:selected").attr("data-endFlag");
		if(studyNo == 0){ // ---선택시 페이지 리로드
			window.location.reload();
		}else{
			if(endFlag!='true'){
				$.getJSON("/study/exStudyList/" + studyNo, function(studyVO) {
					$("#studyName").val(studyVO.studyName);
					$("#studyNameDiv").addClass('is-focused');
					// $("#testDatepicker").attr("value", studyVO.studyStartDate);
					$("#testDatepicker").val($.datepicker.formatDate('yy-mm-dd', new Date()));
					$("#studyMaxMemCnt").attr("value", studyVO.studyMaxMemCnt);
					$(".studyIntroduce").val(studyVO.studyIntroduce);
					
					/* 체크된 카테고리 가져오기  */
					callCategory(studyVO);
					/* 카테고리 5개 체크 제한 */
					categoryChkCnt();
					/* 지역 대분류 선택된 상태 가져오기 */
					callRegion(studyVO);
					/* 연령대 체크된 상태 가져오기 */
					callTargetAge(studyVO);
					chkTargetAge();
					/* 업로드된 이미지 출력  */
					$(".thumnail").empty();
					callImage(studyNo,template);
	
					/* 등록된 주단위 일정 출력  */
					$(".dayChk").empty();
					callWeekTime(studyNo);
					
				});
			}else{
				$.getJSON("/study/exStudyEndList/" + studyNo, function(studyVO) {
					$("#studyName").val(studyVO.studyName);
					$("#studyNameDiv").addClass('is-focused');
	
					// $("#testDatepicker").attr("value", studyVO.studyStartDate);
					$("#testDatepicker").val($.datepicker.formatDate('yy-mm-dd', new Date()));
					$("#studyMaxMemCnt").attr("value", studyVO.studyMaxMemCnt);
					$(".studyIntroduce").val(studyVO.studyIntroduce);
	
					/* 체크된 카테고리 가져오기  */
					callCategory(studyVO);
					/* 카테고리 5개 체크 제한 */
					categoryChkCnt();
					/* 지역 대분류 선택된 상태 가져오기 */
					callRegion(studyVO);
					/* 연령대 체크된 상태 가져오기 */
					callTargetAge(studyVO);
					chkTargetAge();
					/* 업로드된 이미지 출력  */
					$(".thumnail").empty();
					callImageEnd(studyNo,template);
					
					/* 등록된 주단위 일정 출력  */
					$(".dayChk").empty();
					callWeekTimeEnd(studyNo);
				})
			}			
		}
	});
	
});//$(document).ready(function{})