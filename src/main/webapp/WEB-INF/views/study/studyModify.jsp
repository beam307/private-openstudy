<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/headerSub.jsp"%>

<!-- <form class="form-horizontal" id="registerForm" action="/study/studyReg" method="post"> -->
<div class="write_bg">
	<div class="write animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<!--      Wizard container        -->
					<div class="wizard-container">
						<div class="card wizard-card" data-color="red" id="wizardProfile">
							<form class="form-horizontal" id="registerForm" action="/study/studyModify" method="post">
								<!-- 쿼리스트링 값 받아오기 -->
								<input type="hidden" name='studyNo' value="${studyVO.studyNo }">
								<input type="hidden" name='page' value="${cri.page }">
								<input type="hidden" name='perPageNum' value="${cri.perPageNum }">
								<input type="hidden" name='searchType' value="${cri.searchType }">
								<input type="hidden" name='keyword' value="${cri.keyword }">
								<input type="hidden" name='lineUp' value="${cri.lineUp }">
								<input type="hidden" name='upRegion' value="${cri.upRegion }">
								<input type="hidden" name='downRegion' value="${cri.downRegion }">
								<input type="hidden" name='upCategory' value="${cri.upCategory }">
								<input type="hidden" name='Category' value="${cri.category }">
								
								<div class="wizard-navigation">
									<ul>
										<li><a href="#about" data-toggle="tab">기본정보</a></li>
										<li><a href="#account" data-toggle="tab">상세정보</a></li>
										<li><a href="#address" data-toggle="tab">소개</a></li>
									</ul>
								</div>

								<div class="tab-content">
									<div class="tab-pane" id="about">
										<div class="">
											<div class="form-horizontal">

												<%@include file="categoryData.jsp"%> <!--카테고리 데이터 -->

												<div class="form-group label-floating">
													<div class="col-sm-12">
														<label class="control-label">스터디명</label> <input type="text" class="form-control" name="studyName" id="studyName"
															value="${studyVO.studyName}"  maxlength="40">
													</div>
												</div>
												<div class="form-group area">
													<div class="col-sm-12">
														<label class="col-sm-1 control-label">지역</label>
														<%@include file="regionCategory.jsp"%> <!-- 지역 카테고리 데이터 -->
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="tab-pane" id="account">
										<div class="">
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">대상</label>
													<div class="col-sm-10">

														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="studyTargetAge" value="10대"> 10대
															</label>
														</div>

														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="studyTargetAge" value="20대"> 20대
															</label>
														</div>
														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="studyTargetAge" value="30대"> 30대
															</label>
														</div>
														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="studyTargetAge" value="40대"> 40대
															</label>
														</div>
														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="studyTargetAge" value="50대이상"> 50대 이상
															</label>
														</div>
														<div class="checkbox col-sm-2">
															<label> <input class="all" type="checkbox" name="studyTargetAge" id="studyTargetAge" value="무관"> 무관
															</label>
														</div>
														<!-- 연령대 스크립트 -->
														<script> 
															$(".all").click(function() {
																$("input[class=age]:checkbox").each(function() {
																	$(this).attr("checked", false);
																});
															});

															$(".age").click(function() {
																$("input[class=all]:checkbox").each(function() {
																	$(this).attr("checked", false);
																});
															});
														</script>

													</div>
												</div>
											</div>
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">시작날짜</label>
													<div class="col-sm-10">
														<div class="col-sm-7">
															<fmt:formatDate value="${studyVO.studyStartDate}" pattern="yyyy-MM-dd" var="date" />
															<input type="text" id="testDatepicker" class="form-control" name="studyStartDate" value="${date }">
															<script>
																$(function() {
																	$("#testDatepicker").datepicker({
																		minDate : -0,
																		dateFormat : "yy-mm-dd"
																	});
																});
															</script>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">요일</label>
													<div class="col-sm-10">
														<div class="col-sm-3">
															<select id="single" class="form-control">
																<option>월요일</option>
																<option>화요일</option>
																<option>수요일</option>
																<option>목요일</option>
																<option>금요일</option>
																<option>토요일</option>
																<option>일요일</option>
															</select>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">시작시간</label>
													<div class="col-sm-10">
														<div class="col-sm-3 form-group">
															<select id="startTime" class="form-control">
															</select>
														</div>
														<div class="col-sm-3 form-group">
															<select id="startMinute" class="form-control">
															</select>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">끝나는시간</label>
													<div class="col-sm-10">
														<div class="col-sm-3 form-group">
															<select id="endTime" class="form-control">
															</select>
														</div>
														<div class="col-sm-3 form-group">
															<select id="endMinute" class="form-control">
															</select>
														</div>
														<div class="col-sm-3">
															<button id="copyBtn" class="btn dayChkBtn" type="button">추가</button>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">추가된 시간</label>
													<div class="col-sm-10">
														<div class="col-sm-8">
															<div id="Datepicker"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">최대인원</label>
													<div class="col-sm-10">
														<div class="col-sm-5">
															<input type="number" id="studyMaxMemCnt" class="form-control" name="studyMaxMemCnt" value="${studyVO.studyMaxMemCnt}">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="tab-pane" id="address">
										<div class="row">
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">스터디소개</label>
													<div class="col-sm-10">
														<div class="col-sm-12">
															<textarea class="form-control" rows="10" name="studyIntroduce" id="studyIntroduce">${studyVO.studyIntroduce}</textarea>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">이미지업로드</label>
													<div class="col-sm-10">
														<div class="col-sm-12">
															<div class="btn btn-default area-btn">이미지 업로드</div><br/>
															<label for="exampleInputFile" class="fileUp">스터디를 잘 표현해주는 이미지를 업로드해주세요.(최대 5장) 첫이미지가 대표이미지 입니다.사진을 드래그하여 순서를 바꿀 수 있습니다.</label> <input type="file" id="exampleInputFile">
														</div>
														<div class="col-sm-12 thumnail" id='thumb-list'>
															<!--요기에    -->
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="wizard-footer">
									<div class="pull-right">
										<input type='button' class='btn btn-next btn-fill btn-success btn-wd' name='next' value='다음' /> <input type='submit'
											class='btn btn-finish btn-fill btn-success btn-wd' name='finish' value='완료' />
									</div>

									<div class="pull-left">
										<input type='button' class='btn btn-previous btn-fill btn-default btn-wd' name='previous' value='이전' />
									</div>
									<div class="clearfix"></div>
								</div>
							</form>
						</div>
					</div>
					<!-- wizard container -->
				</div>
			</div>
			<!-- end row -->
		</div>
		<!--  big container -->
	</div>
</div>
<!-- 업로드된 리스트 템플릿  -->
<script id="template" type="text/x-handlebars-template">
<li class="col-sm-4" id="thumb-imgList">
	<span class="mailbox-attachment-icon has-img">
		<div class="thumbnail-wrapper">
			<div class="thumbnail">
				<div class="centered">
					<img src={{imgsrc}} alt="Attachment">
				</div>
			</div>
		</div>
	</span>
	<div class="mailbox-attachment-info">
    	<a data-src="{{fullName}}" class="btn btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</div>
</li>
</script>
<script>
	$(document).ready(function() {
		/* 핸들바 탬플릿 컴파일 */
		var template = Handlebars.compile($("#template").html());

		var formObj = $("form[role='form']");

		/* 취소버튼 클릭시  */
		$("#cancelBtn").on("click", function() {
			self.location = "/study/studyView${pageMaker.makeSearch(pageMaker.cri.page)}&studyNo=${studyVO.studyNo}";
		});
		//pageMaker로 수정함 "/study/studyList?page=${cri.page}&perPageNum=${cri.perPageNum}&searchType=${cri.searchType}&keyword=${cri.keyword}&lineUp=${cri.lineUp}"

		/* 완료버튼 클릭시  */
		$("#confirmBtn").on("click", function() {
			formObj.submit();
		});

		/* 카테고리 체크된 상태 가져오기 */
		var names = document.getElementsByName('studyCategory');

		var tmp = '${studyVO.studyCategory }';
		var cat_values = tmp.split(',');

		for (let i = 0; i < names.length; i++) {
			for (let j = 0; j < cat_values.length; j++) {
				if (names[i].value == cat_values[j]) {
					names[i].setAttribute('checked', 'checked');
				}
			}
		}
		
		/* 체크된 카테고리 보이기  */
		 $("[name='studyCategory']").each(function(index){
			 if($(this).prop('checked')){
				 var upCategory=$(this).parents('.list').attr('id');
				 var downCategory=$(this).parents('.list');
				 var aUpCategory=$('.'+upCategory).children('a');
				 aUpCategory.removeClass('collapsed');
				 aUpCategory.attr('aria-expanded',true);
				 downCategory.attr('aria-expanded',true);
				 downCategory.addClass('in');
			 }
		 })
		 
		/* 카테고리 5개 제한 */
		if($("input:checkbox[name=studyCategory]:checked").length >= 5)
			$("input:checkbox[name=studyCategory]:not(:checked)").attr("disabled", "disabled");
		$("input:checkbox[name=studyCategory]").change(function(){
			if($("input:checkbox[name=studyCategory]:checked").length >= 5)
				$("input:checkbox[name=studyCategory]:not(:checked)").attr("disabled", "disabled");
			else
				$("input:checkbox[name=studyCategory]").removeAttr("disabled");
		}); 
		
		/* 지역 대분류 선택된 상태 가져오기 */
		var upRegions = document.getElementsByName('upRegion');
		var studyUpRegion = '${studyVO.studyUpRegion}';
		var studyDownRegion = '${studyVO.studyDownRegion}';

		for (let i = 0; i < upRegions.length; i++) {
			if (upRegions[i].value == studyUpRegion) {
				upRegions[i].setAttribute('selected', 'selected');
				/* 지역 소분류 선택된 상태 가져오기 */
				subRegion(studyUpRegion); 
				var downRegions = document.getElementsByName('subRegion');
				for(let j = 0; j< downRegions.length; j++) {
					if(downRegions[j].value == studyDownRegion)
						downRegions[j].setAttribute('selected', 'selected');
				}
			} 
				
		}

		/* 연령대 체크된 상태 가져오기 */
		var targets = document.getElementsByName('studyTargetAge');

		var tmp2 = '${studyVO.studyTargetAge }';
		var tar_values = tmp2.split(',');

		for (let i = 0; i < targets.length; i++) {
			for (let j = 0; j < tar_values.length; j++) {
				if (targets[i].value == tar_values[j]) {
					targets[i].setAttribute('checked', 'checked');
				}
			}
		}

		/* 등록된 주단위 일정 출력  */
		<c:forEach items="${weekList}" varStatus="listIdx" var="weekVO">
		$("#Datepicker").append(
				"<div class='dayChk col-sm-12'>" + "<span class='day' data-src='${weekVO.weekDay}'>${weekVO.weekDay}</span>" + " "
						+ "<span class='start' data-src='${weekVO.weekStartDate}'>${weekVO.weekStartDate}</span>" + "<span class='wave'>~</span>"
						+ "<span class='end' data-src='${weekVO.weekEndDate}'>${weekVO.weekEndDate}</span>까지"
						+ "<a data-src='' class='btn btn-xs pull-right delbtn'><i class='fa fa-fw fa-remove'></i></a></div>");
		</c:forEach>

		/* 주단위 시간 설정  */
		function displayVals() {
			// 시작 기본값 세팅
			for (let i = 1; i < 25; i++)
				$("#startTime").append("<option value='" + i + "시'> " + i + "시" + " </option> ");

			$("#startMinute").append("<option value=00분>00분</option>");
			$("#startMinute").append("<option value=30분>30분</option>");
			// 완료 기본값 세팅
			for (let j = 1; j < 25; j++)
				$("#endTime").append("<option value='" + j + "시'> " + j + "시" + " </option> ");

			$("#endMinute").append("<option value=30분>30분</option>");

		}
		 displayVals();
		
		// 시작시간 변경 시
		$("#startTime").change(function() { // 시작 시간이 선택될 때, 완료 시간을 세팅
			let startTime = $("#startTime").val(); // 값 받아오기
			let startTime2 = parseInt(startTime);
			let endTime = $("#endTime").val();
			let endTime2 = parseInt(endTime);
			let startMinute = $("#startMinute").val();
			let endMinute = $("#endMinute").val();

			if (startTime2 >= endTime2) { // 시작시간 > 종료시간
				$("#endTime").empty(); // 종료 리프레쉬 후
				$("#endMinute").empty();

				for (var j = startTime2; j < 25; j++)// 선택된 시작시간부터 종료시간 반복문
					$("#endTime").append("<option value='" + j + "시'> " + j + "시" + " </option> ");

				$("#endMinute").append("<option value=30분>30분</option>");

				$("#startMinute").empty(); // 시작분을 리프레쉬 후 시작분 00, 30
				$("#startMinute").append("<option value=00분>00분</option>");
				$("#startMinute").append("<option value=30분>30분</option>");

			} else { // 시작시간 < 종료시간 : 종료분 00,30
				$("#endTime").empty();
				for (var j = startTime2; j < 25; j++)// 선택된 시작시간부터 종료시간 반복문
					$("#endTime").append("<option value='" + j + "시'> " + j + "시" + " </option> ");
				
				$("#endTime").val(endTime).attr("selected", "selected"); // 전에 선택되어 있던 값으로 select되어 있게 하기

				$("#endMinute").empty();
				$("#endMinute").append("<option value=00분>00분</option>");
				$("#endMinute").append("<option value=30분>30분</option>");
				$("#endMinute").val(endMinute).attr("selected", "selected");
			}
		});

		// 시작분 변경 시
		$("#startMinute").change(function() {
			let startTime = $("#startTime").val(); // 값 받아오기
			let startTime2 = parseInt(startTime);
			let endTime = $("#endTime").val();
			let endTime2 = parseInt(endTime);
			let startMinute = $("#startMinute").val();
			let endMinute = $("#endMinute").val();

			if (startTime2 == endTime2 && startMinute == endMinute) { // 시작 = 종료
				$("#endTime").empty(); // 종료 리프레쉬 후
				$("#endMinute").empty();

				startTime2 += 1; // 선택된 시작시간+1부터 종료시간 반복문
				for (var j = startTime2; j < 25; j++)
					$("#endTime").append("<option value='" + j + "시'> " + j + "시" + " </option> ");
				
				$("#endMinute").empty();	
				$("#endMinute").append("<option value=00분>00분</option>");
				$("#endMinute").append("<option value=30분>30분</option>");
			}
		});

		// 종료시간 변경 시
		$("#endTime").change(function() { // 완료 시간이 변경될 때, 완료 분을 세팅
			$("#endMinute").empty();
			$("#endMinute").append("<option value=00분>00분</option>");
			$("#endMinute").append("<option value=30분>30분</option>");
		});

		/* 버튼클릭시 일정추가  */
		$("#copyBtn").click(function() {
			var singleValues = $("#single option:selected").val();
			var startTime = $("#startTime option:selected").val();
			var endTime = $("#endTime option:selected").val();
			var startMinute = $("#startMinute option:selected").val();
			var endMinute = $("#endMinute option:selected").val();
			var weekStartDate = startTime + " " + startMinute;
			var weekEndDate = endTime + " " + endMinute;
			var Datepicker = document.getElementById('Datepicker');
			
			var test = false;
			
			$('.day').each(function(index){
				if($(this).data("src") == singleValues){
					
					test = true;	 
					alert("같은날 하나밖에 안돼~~~~~~~~~");
				
					
					$(this).parent().remove();
						singleCheck();
				}
			});
			
			if(test != true) 
				singleCheck();
			
			function singleCheck() {
				$("#Datepicker").append(
						"<div class='dayChk col-sm-12'>" + "<span class='day' data-src='"+singleValues+"'>" + singleValues + "</span>" + " "
								+ "<span class='start' data-src='"+weekStartDate+"'>" + weekStartDate + "</span>" + "<span class='wave'>~</span>"
								+ "<span class='end' data-src='"+weekEndDate+"'>" + weekEndDate + "</span>까지"
								+ "<a data-src='' class='btn btn-xs pull-right delbtn'><i class='fa fa-fw fa-remove'></i></a></div>");
			};
			
			if($('#Datepicker').children('div').length == 0){
				$("#Datepicker").append(
						"<div class='dayChk col-sm-12'>" + "<span class='day' data-src='"+singleValues+"'>" + singleValues + "</span>" + " "
								+ "<span class='start' data-src='"+weekStartDate+"'>" + weekStartDate + "</span>" + "<span class='wave'>~</span>"
								+ "<span class='end' data-src='"+weekEndDate+"'>" + weekEndDate + "</span>까지"
								+ "<a data-src='' class='btn btn-xs pull-right delbtn'><i class='fa fa-fw fa-remove'></i></a></div>");
			}
			$("#startTime").empty();
			$("#startMinute").empty();
			$("#endTime").empty();
			$("#endMinute").empty();
			displayVals();
		});
		
		/* 일정 제거 */
		$("#Datepicker").on("click", "a", function() {
			var that = $(this);
			that.parent("div").remove();
		});
		
		/* 최대인원 설정  */
		$('#studyMaxMemCnt').on("click", function() {
			var tempNum = $(this).val();
			if (tempNum < 0 || tempNum.indexOf('.') != -1) {
				$(this).val(0);
				alert("양수를 입력해주세요");
			}
			if (tempNum > 99) {
				$(this).val(99);
				alert("최대인원을 초과하였습니다(99명)");
			}
		});
		/* 최대인원 설정  */
		$('#studyMaxMemCnt').keyup(function(e) {
			var tempNum = $(this).val();
			if (e.keyCode == 189 || tempNum < 0 || tempNum.indexOf('.') != -1) {
				$(this).val(0);
				alert("양수를 입력해주세요");
			}
			if (tempNum > 99) {
				$(this).val(99);
				alert("최대인원을 초과하였습니다(99명)");
			}
		});

		/* 업로드된 이미지 출력  */
		var studyNo = "${studyVO.studyNo}";
		$.getJSON("/study/getImg/" + studyNo, function(list) {
			$(list).each(function() {
				var fileInfo = getFileInfo(this);
				var html = template(fileInfo);
				$(".thumnail").append(html);
				uploadCnt++;
			});
		});
		
		/* input:file로 파일 업로드하기  */
		var uploadCnt = 0;
		$("#exampleInputFile").on("change", function(event) {
			if(uploadCnt==0){
				$(".thumnail").append("<div class=''");
			}
			if (uploadCnt < 5) {
				event.preventDefault();
				var file = $("input[id=exampleInputFile]")[0].files[0];
				var fileName = file.name;
				var formatName = (fileName.substring(fileName.lastIndexOf('.') + 1, fileName.length)).toUpperCase();
				if ((file == null) || checkImageType(formatName) == null) {
					$("#exampleInputFile").val("");
					alert("이미지 파일을 선택해주세요");
					return;
				}
				
				var formData = new FormData();
				formData.append("file", file);

				/* 컨트롤러로 파일명을 보낸후 콜백으로 만들어진 이미지파일명을 받은후 템플릿에 출력시킨다.  */
				$.ajax({
					url : '/uploadAjax',
					data : formData,
					dataType : 'text',
					processData : false,
					contentType : false,
					type : 'POST',
					success : function(data) {
						var fileInfo = getFileInfo(data);
						var html = template(fileInfo);
						$(".thumnail").append(html);
						uploadCnt++;
						$("#exampleInputFile").val("");
					}
				});
			} else {
				alert("최대 5장의 사진만 등록가능합니다.");
				return;
			}
		});

		/* 				
		 // 파일 드랍시 업로드(ajax)
		 $(".fileDrop").on("dragenter dragover", function(event) {
		 event.preventDefault();
		 });

		 $(".fileDrop").on("drop", function(event) {
		 event.preventDefault();

		 var files = event.originalEvent.dataTransfer.files;

		 var file = files[0];

		 var formData = new FormData();
		 formData.append("file", file);

		 $.ajax({
		 url : '/uploadAjax',
		 data : formData,
		 dataType : 'text',
		 processData : false,
		 contentType : false,
		 type : 'POST',
		 success : function(data) {

		 var fileInfo = getFileInfo(data);

		 var html = template(fileInfo);

		 $(".uploadedList").append(html);
		 }
		 });
		 });

		 */
		/* x버튼 클릭시 로컬에서 파일제거  */
		$(".thumnail").on("click", "a", function(event) {
			var that = $(this);

			$.ajax({
				url : "/deleteFile",
				type : "post",
				data : {
					fileName : $(this).attr("data-src")
				},
				dataType : "text",
				success : function(result) {
					if (result == 'deleted') {
						that.parent("div").parent("li").remove();
						uploadCnt--;
					}
				}
			});
		});
		 
		 /*  대표이미지 드래그 설정 */
		 $( "#thumb-list" ).sortable({
	      revert: true
	    });
	    $( "#thumb-list, #thumb-imgList" ).disableSelection();
		 

	    
		//유효성 체크해봅시다
		var chkstudyMaxMemCnt = /^[0-9]+$/;
		var chkstudyStartDate = /^(\d{4})\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[0-1])$/;

		var studyCategory = document.getElementsByName('studyCategory');
		var studyTargetAge = document.getElementsByName('studyTargetAge');
		var form = $('#registerForm');
		var studyName = $('#studyName');
		var studyStartDate = $('#testDatepicker');
		var studyWeekVO = $('#Datepicker');
		var studyMaxMemCnt = $('#studyMaxMemCnt');
		var studyIntroduce = $('#studyIntroduce');
		var studyImage = $('.thumnail');
		var studyUpRegion = $('#upRegion');
		var studyDownRegion = $('#downRegion');
		var studyAge = $('.age');

		function startDateValidator() { // 시작날짜가 오늘보다 이후 날짜인지 검사
			var d = new Date();
			var today = new Date(d.getFullYear(), d.getMonth(), d.getDate());
			var inputDate = new Date(parseInt(studyStartDate.val().substr(0, 4)), parseInt(studyStartDate.val().substr(5, 2))-1, parseInt(studyStartDate.val().substr(8, 2)));
			if (inputDate >= today)
				return true;
			else
				return false;
		}

		// has("li").length로 참거짓을 판별해야 함
		function studyWeekVOValidator() {
			if (studyWeekVO.has(".dayChk").length)
				return true;
			else
				return false;
		}

		function studyCategoryValidator() {
			let cnt = 0;
			for (let i = 0; i < studyCategory.length; i++) {
				if (studyCategory[i].checked == true)
					cnt++;
			}

			if (cnt >= 1)
				return true;
			else
				return false;
		}

		function studyTagetAgeValidator() {
			let cnt = 0;
			for (let i = 0; i < studyTargetAge.length; i++) {
				if (studyTargetAge[i].checked == true)
					cnt++;
			}

			if (cnt >= 1)
				return true;
			else
				return false;
		}

		form.submit(function(event) {
			if (studyCategoryValidator() != true) {// 카테고리 NULL 유효성 검사
				alert("카테고리를 한 개 이상 선택하세요.");
				$('#regTabBtn1').trigger('click');
				return false;
			} else if (studyName.val() == "") { // 스터디명 NULL 유효성 검사
				alert("스터디명을 입력하십시오.");
				$('#regTabBtn1').trigger('click');
				studyName.focus();
				return false;
			} else if (studyUpRegion.val() == "n") { // 지역대분류 NULL 유효성 검사
				alert("지역을 입력하십시오.")
				$('#regTabBtn1').trigger('click');
				studyUpRegion.focus();
				return false;
			} else if (studyDownRegion.val() == "n") { // 지역소분류 NULL 유효성 검사
				alert("지역을 입력하십시오.")
				$('#regTabBtn1').trigger('click');
				studyDownRegion.focus();
				return false;
			} else if (studyStartDate.val() == "") { // 시작날짜 NULL 유효성 검사
				alert("시작날짜를 입력하십시오.")
				$('#regTabBtn2').trigger('click');
				studyStartDate.focus();
				return false;
			} else if (chkstudyStartDate.test(studyStartDate.val()) != true) { // 시작날짜 유효성 검사
				alert("시작날짜 형식이 올바르지 않습니다.");
				$('#regTabBtn2').trigger('click');
				studyStartDate.focus();
				return false;
			} else if (startDateValidator() != true) { // 시작날짜 유효성 검사
				alert("오늘 이후의 날짜를 입력하십시오.");
				$('#regTabBtn2').trigger('click');
				studyStartDate.focus();
				return false;
			} else if (studyWeekVOValidator() != true) { // 요일  NULL 유효성 검사
				alert("요일 및 시간을 추가하십시오.");
				$('#regTabBtn2').trigger('click');
				studyWeekVO.focus();
				return false;
			} else if (studyTagetAgeValidator() != true) {// 대상 NULL 유효성 검사
				alert("대상을 한명이상 지정하세요.");
				$('#regTabBtn2').trigger('click');
				studyAge.focus();
				return false;
			} else if (studyMaxMemCnt.val() == "") { // 인원수 NULL 유효성 검사
				alert("인원수를 입력하십시오.");
				$('#regTabBtn2').trigger('click');
				studyMaxMemCnt.focus();
				return false;
			} else if (chkstudyMaxMemCnt.test(studyMaxMemCnt.val()) != true) { // 인원수 유효성 검사
				alert("인원수에 숫자만 입력하세요.");
				$('#regTabBtn2').trigger('click');
				studyMaxMemCnt.focus();
				return false;
			} else if (studyIntroduce.val() == "") { // 스터디소개 NULL 유효성 검사
				alert("스터디소개를 입력하십시오.");
				$('#regTabBtn3').trigger('click');
				studyIntroduce.focus();
				return false;
			} else if (studyImage.find("li").length == 0) { // 사진 NULL 유효성 검사
				alert("사진을 입력하십시오.");
				$('#regTabBtn3').trigger('click');
				studyImage.focus();
				return false;
			}

			/* db에 들어가는 형식으로 다시 변경 2018-01-11-> */
			var dbInputDate = new Date(parseInt(studyStartDate.val().substr(0, 4)), parseInt(studyStartDate.val().substr(5, 2))-1, parseInt(studyStartDate.val().substr(8, 2)));
			studyStartDate.val(dbInputDate);			
			
			/* input:hidden 으로 현재 업로드된 파일, 주단위 시간, 카테고리 대분류 목록을 저장한다. */
			var that = $(this);

			var str = "";

			/* 파일 업로드  */
			$(".thumnail .delbtn").each(function(index) {
				str += "<input type='hidden' name='files[" + index + "]' value='" + $(this).attr("data-src") + "'>";
			});

			/* 주단위 시간  */
			$("#Datepicker .day").each(function(index) {
				str += "<input type='hidden' name='weekVO[" + index + "].weekDay' value='" + $(this).attr("data-src") + "'>";
			});
			$("#Datepicker .start").each(function(index) {
				str += "<input type='hidden' name='weekVO[" + index + "].weekStartDate' value='" + $(this).attr("data-src") + "'>";
			});
			$("#Datepicker .end").each(function(index) {
				str += "<input type='hidden' name='weekVO[" + index + "].weekEndDate' value='" + $(this).attr("data-src") + "'>";
			});
			
			/* 카테고리 대분류  */
			if($(".content0 input[type=checkbox]").is(':checked')) {
				str += "<input type='hidden' name='studyUpCategory' value='영어'>";
			}
			if($(".content1 input[type=checkbox]:checked").is(':checked')) {
				str += "<input type='hidden' name='studyUpCategory' value='외국어'>";
			}
			if($(".content2 input[type=checkbox]:checked").is(':checked')) {
				str += "<input type='hidden' name='studyUpCategory' value='IT'>";
			}
			if($(".content3 input[type=checkbox]:checked").is(':checked')) {
				str += "<input type='hidden' name='studyUpCategory' value='교양'>";
			}
			if($(".content4 input[type=checkbox]:checked").is(':checked')) {
				str += "<input type='hidden' name='studyUpCategory' value='공무원'>";
			}
			that.append(str);
			that.get(0).submit();

		});
	});
</script>
<%@include file="../include/footerSub.jsp"%>