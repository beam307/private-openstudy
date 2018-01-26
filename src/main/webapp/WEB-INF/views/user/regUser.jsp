<jsp:include page="../include/headerSub.jsp" flush="false"/>
<div class="join_bg">
	<div class="join animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
		<form action="/user/regUser" method="post" id="joinForm">

			<label class="control-label">이메일 주소</label>
			<div class="form-group label-floating">
				<div class="col-xs-9">
					<label class="control-label">이메일을 입력해주세요</label> <input name="userEmail" type="text" class="form-control" id="InputEmail">
				</div>
				<div class="col-xs-3">
					<button type="button" id="emailCheck" class="btn btn-default emailChkBtn">중복확인</button>
				</div>
			</div>

			<label class="control-label">이름</label>
			<div class="form-group label-floating">
				<label class="control-label">실명을 입력해주세요</label> <input name="userName" type="text" class="form-control" id="InputName">
			</div>

			<label class="control-label">비밀번호</label>
			<div class="form-group label-floating">
				<label class="control-label">8자리 이상 20자리 이하 영문, 숫자로만 설정해주세요</label> <input name="userPwd" type="password" class="form-control"
					id="InputPassword">
			</div>

			<label class="control-label">비밀번호확인</label>
			<div class="form-group label-floating">
				<label class="control-label">비밀번호를 한번 더 입력해주세요.</label> <input name="userPwdCheck" type="password" class="form-control"
					id="InputPasswordChk">
			</div>

			<label class="control-label">닉네임</label>
			<div class="form-group label-floating">
				<div class="col-xs-9">
					<label class="control-label">닉네임을 입력해주세요</label> <input name="userNick" type="text" class="form-control" id="InputNickName">
				</div>
				<div class="col-xs-3">
					<button type="button" id="nickCheck" class="btn btn-default emailChkBtn">중복확인</button>
				</div>
			</div>

			<label class="control-label">생년월일</label>
			<div class="form-group label-floating">
				<label class="control-label">주민번호 앞자리를 입력해주세요</label> <input name="userBirth" type="text" class="form-control" id="InputBirthday"
					maxlength="6">
			</div>

			<label for="InputGender">성별</label>
			<div class="form-group label-floating">
				<div class="radio">
					<label> <input type="radio" name="userGender" class="genderRadio" value="M" aria-label="남성"> 남성
					</label>
				</div>
				<div class="radio">
					<label> <input type="radio" name="userGender" class="genderRadio" value="F" aria-label="여성"> 여성
					</label>
				</div>
			</div>
			
			<div class="form-group label-floating">
				<div class="checkbox">
					<label> 
					<input type="checkbox" name="terms" class="terms" value="0" aria-label="동의"> <span>서비스 이용약관/개인 정보 보호 정책에 동의합니다.</span>
					<a href="/user/userAgree" class="terms" onClick="window.open(this.href, '', 'location=no, width=700, height=800, left=640, top=100'); return false;">[약관보기]</a>
					</label>
				</div>
			</div>
			
			<div class="modal-footer">
				<button type="submit" class="btn btn-default">회원가입</button>
			</div> 
		</form>
	</div>
</div>
<script type="text/javascript" src="/resources/dist/js/user/userJoin.js"></script>
<jsp:include page="../include/footerSub.jsp" flush="false"/>