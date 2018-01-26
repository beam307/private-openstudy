$(document).ready(function() {
		
		studyRegCnt=0;
		uploadCnt = 0;
		/* 핸들바 탬플릿 컴파일 */
		var template = Handlebars.compile($("#template").html());

		/* 취소버튼 클릭시  */
		$("#cancelBtn").on("click", function() {
			self.location = "/study/studyView${pageMaker.makeSearch(pageMaker.cri.page)}&studyNo=${studyVO.studyNo}";
		});
		//pageMaker로 수정함 "/study/studyList?page=${cri.page}&perPageNum=${cri.perPageNum}&searchType=${cri.searchType}&keyword=${cri.keyword}&lineUp=${cri.lineUp}"
		
		var studyVO={};
		
		/* 카테고리 체크된 상태 가져오기 */
		var studyCategory = $("#select-category").val();
		studyVO.studyCategory = studyCategory;
		callCategory(studyVO);
		 
		/* 카테고리 5개 제한 */
		categoryChkCnt();
		
		/* 지역 대분류 선택된 상태 가져오기 */
		var studyUpRegion = $("#select-upRegion").val();
		var studyDownRegion = $("#select-upRegion").val();
		
		studyVO.studyUpRegion=studyUpRegion;
		studyVO.studyDownRegion=studyDownRegion;
		callRegion(studyVO);

		/* 연령대 체크된 상태 가져오기 */
		var studyTargetAge = $("#select-targetAge").val();
		studyVO.studyTargetAge=studyTargetAge;
		callTargetAge(studyVO);
		
		/*대상연령체크 핸들러*/
		chkTargetAge();

		/* 등록된 주단위 일정 출력  */
		var studyNo = $("#select-no").val();
		callWeekTime(studyNo);

		/* 주단위 시간 설정  */
		selectWeek();
		
		/*주단위 시간설정sub*/
		selectWeekSub()

		/* 버튼클릭시 일정추가  */
		dayDuplCheck();
		
		/* 주단위일정 제거 */
		weekDelete();
		
		/* 최대인원 설정 핸들러 */
		maxMemCheckHandler();

		/* 업로드된 이미지 출력  */
		callImage(studyNo,template);
		
		/* input:file로 파일 업로드하기  */
		ImgUpload(template);
		
		 /*  대표이미지 드래그 설정 */
		imgMoveHandler();
		

	});//$(document).ready(function{})