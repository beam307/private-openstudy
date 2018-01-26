<jsp:include page="../include/headerSub.jsp" flush="false" />

<div class="mypage_bg">
	<div class="mypage container">
		<ul class="nav nav-tabs mypage_nav" role="tablist">
			<li role="presentation" class="active"><a href="/user/myPage">개인정보관리</a></li>
			<li role="presentation"><a href="/user/studyManage">스터디관리</a></li>
		</ul>

		<!-- Tab panes -->
		<div role="tabpanel" class="tab-pane active" id="myinfo">
			<div class="tabpanel-in" role="tabpanel">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li id="profileBtn" role="presentation" class="active profile"><a href="#profile" aria-controls="home" role="tab" data-toggle="tab">프로필</a></li>
					<li id="additionalInfoBtn" role="presentation" class="profile"><a href="#additionalInfo" aria-controls="additionalInfo" role="tab"
						data-toggle="tab">부가정보</a></li>
					<c:if test="${fn:contains(login.userEmail,'@')}">
						<li id="changePwdBtn" role="presentation" class="profile"><a href="#password" aria-controls="password" role="tab" data-toggle="tab">비밀번호변경</a></li>
					</c:if>
					<li id="withdrawalBtn" role="presentation" class="profile"><a href="#withdrawal" aria-controls="withdrawal" role="tab"
						data-toggle="tab">회원탈퇴</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
					<div role="tabpanel" class="tab-pane active" id="profile">
						<div class="col-xs-12">
							<h4>프로필 사진</h4>
							<div class="col-xs-12 tab-content-in">
								<div class="user-img col-md-2 col-xs-8" id="user-img-upload">
									<img id="profileImg" src="">
								</div>
								<div class="user-img-btn">
									<div>
										<i class="fa fa-upload" aria-hidden="true"></i>
									</div>
									<input type='file' id="userFile" name="file"> <input type="hidden" id="defaultImg" data-src='${UserVO.getUserProfileImgPath()}'>
								</div>
								<div class="col-md-10 col-xs-12 user-img-text">
									<div>
										회원님의 정면 사진을 올려주세요! <br /> 상대방이 신뢰를 갖고 연락 할 확률이 높아질 거예요.
									</div>
								</div>
							</div>
						</div>
						<form class="tab-content-in" action="/user/myPage" method="post" id="modifyForm">
							<div class="col-xs-12">
								<h4 class="user_info">계정정보</h4>
								<label class="control-label">이메일</label>
								<div class="form-group-box">
									<div class="form-group label-floating">
										<input id="userEmail" name="userEmail" type="text" class="form-control" value="${UserVO.getUserEmail()}" readonly>
									</div>
								</div>
								<label class="control-label">이름</label>
								<div class="form-group-box">
									<div class="form-group label-floating">
										<input id="userName" name="userName" type="text" class="form-control" value="${UserVO.getUserName()}">
									</div>
								</div>
								<label class="control-label">닉네임</label>
								<div class="form-group-box">
									<div class="col-xs-1 form-group label-floating">
										<input id="userNick" name="userNick" type="text" class="form-control" value="${UserVO.getUserNick()}">
									</div>
									<div class="col-xs-3 form-group label-floating">
										<button type="button" id="nickCheck" class="btn btn-default emailChkBtn">중복확인</button>
									</div>
								</div>
								<div class="form-group-box">
									<label class="control-label">생년월일</label>
									<div class="form-group label-floating">
										<input type="text" id="userBirth" class="form-control" name="userBirth" value="${UserVO.getUserBirth()}" maxlength="6">
									</div>
								</div>
								<label for="InputGender">성별</label>
								<div class="form-group label-floating">
									<div class="radio">
										<label> <input type="radio" id="userGenderMan" name="userGender" class="genderRadio" value="M" aria-label="남성"> 남성
										</label>
									</div>
									<div class="radio">
										<label> <input type="radio" id="userGenderWoman" name="userGender" class="genderRadio" value="F" aria-label="여성"> 여성
										</label>
									</div>
									<input type="hidden" id="userGender" value="${UserVO.userGender }">
									<input type="hidden" id="userFavCategory" value="${UserVO.userFavCategory }">
									<input type="hidden" id="userFavUpRegion" value="${UserVO.userFavUpRegion }">
									<input type="hidden" id="userFavDownRegion" value="${UserVO.userFavDownRegion }">
										<input type="hidden" id="target" value="${param.target }">
								</div>
								<c:set var="phoneArray" value="${fn:split(UserVO.getUserPhoneNumber(),',')}" />
								<label class="control-label">전화번호</label><label class="control-label" style="color: red">휴대폰 인증을 해야만 스터디 등록 및 신청이 가능합니다.</label>
								<div class="number">
									<div class="col-xs-1 phoneNum form-group label-floating">
										<input type="text" id="userPhone1" name="phoneNumber" class="form-control" value="${phoneArray[0]}" maxlength="4">
									</div>
									<div class="hyphen">-</div>
									<div class="col-xs-1 phoneNum form-group label-floating">
										<input type="text" id="userPhone2" name="phoneNumber" class="form-control" value="${phoneArray[1]}" maxlength="4">
									</div>
									<div class="hyphen">-</div>
									<div class="col-xs-1 phoneNum form-group label-floating">
										<input type="text" id="userPhone3" name="phoneNumber" class="form-control" value="${phoneArray[2]}" maxlength="4">
									</div>
									<input type="hidden" id="userCertification" value="${UserVO.getUserCertification()}">
									<c:if test="${UserVO.getUserCertification() eq true }">
										<div class="col-xs-12 timer">휴대폰 인증을 완료했습니다.</div>
									</c:if>
									<c:if test="${UserVO.getUserCertification() eq false }">
										<div class="col-xs-3">
											<button type="button" id="phoneCheck" class="btn btn-default">인증</button>
										</div>
									</c:if>
								</div>

								<div class="form-group number label-floating authCode">
									<div class="col-xs-3">
										<input type="text" class="form-control" id="authCode" placeholder="인증번호 입력">
									</div>
									<div class="col-xs-3">
										<button type="button" id="authCodeBtn" class="btn btn-default">확인</button>
									</div>
									<div class="col-xs-12 timer">
										인증번호가 발송되었습니다. ( 유효시간 : <span id="timerMinutes"></span> 분 <span id="timerSecond"></span> 초)
									</div>
								</div>
								<input type="hidden" id="resultNickCheck" value="">
								<div class="btn-group">
									<button type="submit" class="btn btn-danger">저장하기</button>
								</div>

							</div>
						</form>
					</div>


					<div role="tabpanel" class="tab-pane" id="additionalInfo">
						<div class="col-xs-12">
							<h4>부가정보 입력</h4>
							<div class="col-xs-12 tab-content-in">
								<form class="form-horizontal" action="/user/additionalInfo" method="post" id="additionalInfoForm">
									<div class="form-group-box">
										<label class="control-label">관심 카테고리</label>
										<div class="form-group-box">
											<%@include file="categoryData.jsp"%>
										</div>
										<label class="control-label">관심 지역</label>
										<div class="form-group-box">
											<%@include file="regionCategory.jsp"%>
										</div>
										<label class="control-label">자기소개</label>
										<div class="form-group-box userIntroduce-group">
											<textarea class="form-control userIntroduce" id="summernote" name="userIntroduce">${UserVO.userIntroduce}</textarea>
											<span id="counter">0</span>
										</div>
										<div class="btn-group">
											<button type="submit" class="btn btn-danger">저장하기</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>


					<div role="tabpanel" class="tab-pane" id="password">
						<div class="col-xs-12">
							<h4>비밀번호변경</h4>
							<div class="col-xs-12 tab-content-in">
								<form class="form-horizontal" action="/user/changePwd" method="post" id="changePwdForm">
									<div class="form-group-box">
										<label class="control-label">현재 비밀번호</label>
										<div class="form-group label-floating changePwd-group">
											<input id="userPwd" name="userPwd" type="password" class="form-control">
										</div>
									</div>
									<div class="form-group-box">
										<label class="control-label">새 비밀번호</label>
										<div class="form-group label-floating changePwd-group">
											<input id="newPwd" name="userNewPwd" type="password" class="form-control" placeholder="8자리 이상 20자리 이하 영문,숫자로만 설정해주세요">
										</div>
									</div>
									<div class="form-group-box">
										<label class="control-label">새 비밀번호 확인</label>
										<div class="form-group label-floating changePwd-group">
											<input id="newPwdChk" name="userCheckPwd" type="password" class="form-control" placeholder="비밀번호를 한번 더 입력해주세요.">
										</div>
									</div>
									<button type="submit" class="btn btn-danger f_right">변경하기</button>
								</form>
							</div>
						</div>
					</div>
					<div role="tabpanel" class="tab-pane" id="withdrawal">
						<div class="col-xs-12">
							<h4>회원탈퇴</h4>
							<div class="col-xs-12 tab-content-in">
								<button type="submit" class="btn btn-danger userLeave">탈퇴하기</button>
								<div class="form-group-box">
									<label class="control-label">탈퇴하시면 취소가 불가능합니다.</label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<a href="#" class="top"><i class="fa fa-angle-up" aria-hidden="true"></i></a>
<script type="text/javascript" src="/resources/dist/js/user/myPage.js"></script>
<jsp:include page="../include/footerSub.jsp" flush="false" />