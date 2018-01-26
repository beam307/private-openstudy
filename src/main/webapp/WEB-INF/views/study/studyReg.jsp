<jsp:include page="../include/headerSub.jsp" flush="false"/>
<div id="respond"></div>
<div class="write_bg">
	<div class="write animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<!--      Wizard container        -->
					<div class="wizard-container">
						<div class="card wizard-card" data-color="red" id="wizardProfile">
							<form class="form-horizontal" id="registerForm" action="/study/studyReg" method="post">
							<input type="hidden" id='studyRegCnt' value='${studyRegCnt}' />
								<div class="wizard-navigation">
									<ul>
										<li><a href="#about" data-toggle="tab" id="regTabBtn1">기본정보</a></li>
										<li><a href="#account" data-toggle="tab" id="regTabBtn2">상세정보</a></li>
										<li><a href="#address" data-toggle="tab" id="regTabBtn3">소개</a></li>
									</ul>
								</div>

								<div class="tab-content">
									<div class="tab-pane" id="about">
										<div class="">
											<div class="form-horizontal">

												<div class="form-group area">
													<div class="col-sm-12">
														<label class="col-sm-3 control-label">이전스터디 불러오기</label>
														<div class="col-sm-8">
															<select class="col-sm-3 form-control" id="exStudyList">
																<option>---</option>
																<c:forEach items="${list }" var="studyVO" varStatus="status">
																	<fmt:formatDate value="${studyVO.studyRegDate}" pattern="yyyy-MM-dd" var="date" />
																	<option data-studyNo="${studyVO.studyNo}">${date} l ${studyVO.studyName }</option>
																</c:forEach>
																<c:forEach items="${listEnd }" var="studyVO" varStatus="status">
																	<fmt:formatDate value="${studyVO.studyRegDate}" pattern="yyyy-MM-dd" var="date" />
																	<option data-endFlag='true' data-studyNo="${studyVO.studyNo}">${date} l ${studyVO.studyName } (완료된 스터디)</option>
																</c:forEach>
															</select>
														</div>
													</div>
												</div>

												<%@include file="categoryData.jsp"%>
												<!-- 모임 카테고리 데이터 -->

												<div class="form-group label-floating" id="studyNameDiv">
													<div class="col-sm-12">
														<label class="control-label">스터디명</label> <input type="text" class="form-control" name="studyName" id="studyName" maxlength="30">
													</div>
												</div>
												<div class="form-group area">
													<div class="col-sm-12">
														<label class="col-sm-1 control-label">지역</label>
														<%@include file="regionCategory.jsp"%>
														<!-- 지역 카테고리 데이터 -->
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="tab-pane" id="account">
										<div class="">
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">연령</label>
													<div class="col-sm-10">

														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="" value="10대"> 10대
															</label>
														</div>
														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="" value="20대"> 20대
															</label>
														</div>
														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="" value="30대"> 30대
															</label>
														</div>
														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="" value="40대"> 40대
															</label>
														</div>
														<div class="checkbox col-sm-2">
															<label> <input class="age" type="checkbox" name="studyTargetAge" id="" value="50대이상"> 50대 이상
															</label>
														</div>
														<div class="checkbox col-sm-2">
															<label> <input class="all" type="checkbox" name="studyTargetAge" id="" value="무관"> 무관
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
															<input type="text" id="testDatepicker" class="form-control" name="studyStartDate">
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
												<!-- 추가된 시간 -->
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
															<input type="number" id="studyMaxMemCnt" class="form-control" name="studyMaxMemCnt">
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
														<!-- <textarea class="form-control" rows="10" name="studyIntroduce" id="studyIntroduce" maxlength="500"></textarea> 
														<span id="counter">###</span> -->
														<textarea class="form-control studyIntroduce" id="summernote" name="studyIntroduce"></textarea>
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
															<label for="exampleInputFile" class="fileUp">스터디를 잘 표현해주는 이미지를 업로드해주세요(최대 5장) 
															<br/>첫이미지가 대표이미지 입니다.사진을 드래그하여 순서를 바꿀 수 있습니다.</label> <input type="file" id="exampleInputFile">
														</div>
														<div class="col-sm-12 thumnail" id='thumb-list'></div>
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
<!-- </form> -->
<script src="/resources/dist/js/study/studyReg.js"></script>
<script src="/resources/dist/js/study/studyCommon.js"></script>
<!-- 업로드된 리스트 템플릿  -->
<script id="template" type="text/x-handlebars-template">
<li class="col-sm-4" id="thumb-imgList">
	<span class="mailbox-attachment-icon has-img">
		<div class="thumbnail-wrapper">
			<div class="thumbnail">
				<div class="centered"><img src={{imgsrc}} alt="Attachment"></div>
			</div>
		</div>
	</span>
	<div class="mailbox-attachment-info">
		<a data-src="{{fullName}}" class="btn btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</div>
</li>
</script>

<jsp:include page="../include/footerSub.jsp" flush="false"/>