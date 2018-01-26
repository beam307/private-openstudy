<jsp:include page="../include/headerSub.jsp" flush="false"/>
<div class="login_bg">
	<div class="login animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
		<a href="https://kauth.kakao.com/oauth/authorize?client_id=e28b842cf3d2e3343f9bf0556066bb85&redirect_uri=http://localhost/login/kakaoLogin&response_type=code"
			class="kakao-login"> <img src="/resources/images/kakao-icon.jpg" alt=""> 카카오계정으로로그인
		</a> <a href="/login/naverLogin" class="naver-login"> <img src="/resources/images/naver-icon.jpg" alt=""> 네이버계정으로로그인
		</a>
		<form action="/login/loginPost" method="post" id="loginForm">
			<div class="form-group label-floating">
				<label class="control-label">이메일 주소</label> <input name="userEmail" type="text" id="exampleInputEmail1" class="form-control"
					value="${cookie.rememberID.value}">
			</div>
			<div class="form-group label-floating">
				<label class="control-label">비밀번호</label> <input name="userPwd" type="password" id="exampleInputPassword1" class="form-control">
			</div>
			<div class="checkbox">
				<c:if test="${empty cookie.rememberID}">
					<label> <input type="checkbox" name="rememberEmail"> 아이디저장
					</label>
				</c:if>
				<c:if test="${not empty cookie.rememberID}">
					<label> <input type="checkbox" name="rememberEmail" checked> 아이디저장
					</label>
				</c:if>
				<label> <input type="checkbox" name="useCookie"> 자동로그인
				</label>
			</div>
			<button type="submit" class="btn btn-default">로그인</button>
		</form>
		<div class="find-user">
			<!-- Button trigger modal -->
			아이디/비밀번호를 잊으셨나요?<a class="" data-toggle="modal" href="#findId">아이디찾기</a>
			<!-- Modal -->
			<div class="modal fade" id="findId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="login-modal-title" id="loginModalLabel">아이디찾기</h4>
						</div>
						<form action="/user/findId" method="post" id="findIdForm">
							<div class="modal-body">
								<label class="control-label">전화번호</label>
								<div class="number">
									<div class="col-xs-3 form-group label-floating">
										<input type="text" id="userPhone1" name="userPhoneNumber" class="form-control" maxlength="4">
									</div>
									<div class="hyphen">-</div>
									<div class="col-xs-3 form-group label-floating">
										<input type="text" id="userPhone2" name="userPhoneNumber" class="form-control" maxlength="4">
									</div>
									<div class="hyphen">-</div>
									<div class="col-xs-3 form-group label-floating">
										<input type="text" id="userPhone3" name="userPhoneNumber" class="form-control" maxlength="4">
									</div>
								</div>
								<label class="control-label">임시 이메일</label>
								<div class="col-xs-12 form-group label-floating">
									<input id="idEmail" name="toEmail" type="text" class="form-control">
								</div>

								<div class="modal-footer">
									<button type="submit" class="btn btn-default">완료</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>

			<a class="" data-toggle="modal" href="#findPwd">비밀번호찾기</a>
			<!-- Modal -->
			<div class="modal fade" id="findPwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="login-modal-title" id="loginModalLabel">비밀번호찾기</h4>
						</div>
						<form action="/user/findPwd" method="post" id="findPwdForm">
							<div class="modal-body">
								<div class="form-group label-floating">
									<label class="control-label">이메일</label> <input id="pwdEmail" name="userEmail" type="text" class="form-control">
								</div>

								<div class="form-group label-floating">
									<label class="control-label">이름</label> <input id="pwdName" name="userName" type="text" class="form-control">
								</div>

								<div class="form-group label-floating">
									<label class="control-label">생년월일</label> <input id="pwdBirth" name="userBirth" type="text" class="form-control">
								</div>
										<input type="hidden" id="toEmail" value="${toEmail }">
										<input type="hidden" id="userPhoneNumber" value="${userPhoneNumber }">
										<input type="hidden" id="userEmail" value="${userVO.userEmail }">
										<input type="hidden" id="userName" value="${userVO.userName }">
										<input type="hidden" id="userBirth" value="${userVO.userBirth }">
										<input type="hidden" id="findUser" value="${findUser }">
								<div class="modal-footer">
									<button type="submit" class="btn btn-default">완료</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="find-user">
			아직 오픈스터디 계정이 없으신가요? <a href="/user/regUser">회원가입</a>
		</div>
	</div>
</div>
<script type="text/javascript" src="/resources/dist/js/user/login.js"></script>
<jsp:include page="../include/footerSub.jsp" flush="false"/>