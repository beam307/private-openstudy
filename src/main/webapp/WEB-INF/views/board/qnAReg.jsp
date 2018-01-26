<jsp:include page="../include/headerSub.jsp" flush="false"/>

<!--  More information about jquery.validate here: http://jqueryvalidation.org/	 -->
<script src="/resources/dist/js/jquery.validate.min.js"></script>
<!--   Big container   -->

<!-- <form class="form-horizontal" id="registerForm" action="/study/studyReg" method="post"> -->
<div class="write_bg">
	<div class="write animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<!--      Wizard container        -->
					<div class="wizard-container">
						<div class="card wizard-card" data-color="red" id="wizardProfile">
							<form class="form-horizontal" id="registerForm" method="post">
								<div class="wizard-navigation">
									<ul>
										<li><a href="#about" data-toggle="tab">FAQ질문 등록</a></li>
									</ul>
								</div>

								<div class="tab-content">
									<div class="tab-pane" id="about">
										<div class="">
											<div class="form-horizontal">
												<div class="form-group label-floating">
													<div class="col-sm-12">
														<input type="hidden" class="form-control" name="qnAWriterNo" id="qnAWriterNo" value="${login.userNo }">
														<label class="control-label">FAQ질문 작성자</label> <input type="text" class="form-control" name="qnAWriterNick" id="qnAWriterNick" value="${login.userNick }" readonly>
													</div>
													<div class="col-sm-12">
														<label class="control-label">FAQ질문 제목</label> <input type="text" class="form-control" name="qnATitle" id="qnATitle" autofocus>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">FAQ답변 내용</label>
													<div class="col-sm-10">
														<div class="col-sm-12">
															<!-- <textarea class="form-control" rows="10" name="qnAContent" id="qnAContent"></textarea> -->
															<textarea class="form-control" rows="10" id="summernote" name="qnAContent"></textarea>
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
<!-- </form> -->
<script>
	$(document).ready(function() {
        $('#summernote').summernote({
        	toolbar: [
        	    // [groupName, [list of button]]
        	    ['style', ['bold', 'italic', 'underline', 'clear']],
        	    ['font', ['strikethrough', 'superscript', 'subscript']],
        	    ['fontsize', ['fontsize']],
        	    ['color', ['color']],
        	    ['para', ['ul', 'ol', 'paragraph']],
        	    ['height', ['height']],
        	    ['insert', ['link', 'picture', 'hr']]
        	],
            tabsize: 4,
            height: 200,
            lang: 'ko-KR',
          });
    });
</script>
<jsp:include page="../include/footerSub.jsp" flush="false"/>