<jsp:include page="../include/headerSub.jsp" flush="false"/>
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
								<input type="hidden" name="studyWriter" value="${studyVO.studyWriter}" />
								<input type="hidden" name='page' value="${cri.page }">
								<input type="hidden" name='perPageNum' value="${cri.perPageNum }">
								<input type="hidden" name='searchType' value="${cri.searchType }">
								<input type="hidden" name='keyword' value="${cri.keyword }">
								<input type="hidden" name='lineUp' value="${cri.lineUp }">
								<input type="hidden" name='upRegion' value="${cri.upRegion }">
								<input type="hidden" name='downRegion' value="${cri.downRegion }">
								<input type="hidden" name='upCategory' value="${cri.upCategory }">
								<input type="hidden" name='Category' value="${cri.category }">
								<input type="hidden" id='select-no' value="${studyVO.studyNo }" />
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
												<input type="hidden" id="select-category" value="${studyVO.studyCategory }" />
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
														<input type="hidden" id="select-upRegion" value="${studyVO.studyUpRegion}" />
														<input type="hidden" id="select-downRegion" value="${studyVO.studyDownRegion}" />
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
													<input type="hidden" id="select-targetAge" value="${studyVO.studyTargetAge}" />
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
														<div class="col-sm-12 wrap">
															<textarea class="form-control studyIntroduce" id="summernote" name="studyIntroduce">${studyVO.studyIntroduce}</textarea>
															<span id="counter">0</span>
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
<script src="/resources/dist/js/study/studyModify.js"></script>
<script src="/resources/dist/js/study/studyCommon.js"></script>

<jsp:include page="../include/footerSub.jsp" flush="false"/>