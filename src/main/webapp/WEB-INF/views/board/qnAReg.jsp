<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.addHeader("Cache-control", "no-store");
%>
<%@include file="/WEB-INF/views/include/headerSub.jsp"%>
<!--글쓰기 js-->
<script src="/resources/dist/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/resources/dist/js/jquery.bootstrap.js" type="text/javascript"></script>

<!--  Plugin for the Wizard -->
<script src="/resources/dist/js/material-bootstrap-wizard.js"></script>

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
										<li><a href="#about" data-toggle="tab">QnA질문 등록</a></li>
									</ul>
								</div>

								<div class="tab-content">
									<div class="tab-pane" id="about">
										<div class="">
											<div class="form-horizontal">
												<div class="form-group label-floating">
													<div class="col-sm-12">
														<input type="hidden" class="form-control" name="qnAWriterNo" id="qnAWriterNo" value="${login.userNo }">
														<label class="control-label">QnA질문 작성자</label> <input type="text" class="form-control" name="qnAWriterNick" id="qnAWriterNick" value="${login.userNick }" readonly>
													</div>
													<div class="col-sm-12">
														<label class="control-label">QnA질문 제목</label> <input type="text" class="form-control" name="qnATitle" id="qnATitle" autofocus>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group area">
												<div class="col-sm-12">
													<label class="col-sm-2 control-label">QnA답변 내용</label>
													<div class="col-sm-10">
														<div class="col-sm-12">
															<textarea class="form-control" rows="10" name="qnAContent" id="qnAContent"></textarea>
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

<%@include file="/WEB-INF/views/include/footerSub.jsp"%>