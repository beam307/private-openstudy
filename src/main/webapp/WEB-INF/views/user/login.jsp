<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/headerSub.jsp"%>
<div class="login_bg">
	<div class="login animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
		<a href="https://kauth.kakao.com/oauth/authorize?client_id=e28b842cf3d2e3343f9bf0556066bb85&redirect_uri=http://localhost/login/kakaoLogin&response_type=code" class="kakao-login"> <img src="/resources/images/kakao-icon.jpg" alt=""> 카카오계정으로로그인
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
					<label> <input type="checkbox" name="rememberEmail"> 아이디저장</label>
				</c:if>
				<c:if test="${not empty cookie.rememberID}">
					<label> <input type="checkbox" name="rememberEmail" checked> 아이디저장</label>
				</c:if>
				<label> <input type="checkbox" name="useCookie"> 자동로그인 </label>
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

									<div class="modal-footer">
										<button type="submit" class="btn btn-default" >완료</button>
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
<script>
	jQuery(function($) {
		var chkEmail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; // 이메일 검사식
		var chkBirth = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))$/; // 생년월일 검사식
		var chkName = /^[가-힣]+$/; // 이름 검사식
		var chkPhone1 = /^[0-9]{2,3}$/; // 전화번호 앞 검사식
		var chkPhone2 = /^[0-9]{3,4}$/; // 중간자리 검사식
		var chkPhone3 = /^[0-9]{4}$/; // 마지막자리 검사식

		var loginForm = $('#loginForm'); // 로그인폼
		var userEmail = $('#exampleInputEmail1'); // 이메일
		var userPwd = $('#exampleInputPassword1'); // 패스워드

		var idForm = $('#findIdForm'); // 아이디찾기 폼
		var userPhone1 = $('#userPhone1'); // 폰 첫번째 선택자
		var userPhone2 = $('#userPhone2'); // 폰 두번째 선택자
		var userPhone3 = $('#userPhone3'); // 폰 세번째 선택자
		var idEmail = $('#idEmail'); // 임시이메일

		var pwdForm = $('#findPwdForm'); // 패스워드찾기 폼
		var pwdName = $('#pwdName'); // 이름
		var pwdBirth = $('#pwdBirth'); // 생일
		var pwdEmail = $('#pwdEmail'); //이메일

		loginForm.submit(function() {
			if (userEmail.val() == "") { // 아이디 NULL 유효성검사
				alert("아이디를 입력하십시요");
				userEmail.focus();
				return false;
			} else if (userEmail.val() != "admin" && chkEmail.test(userEmail.val()) != true) { // 이메일 형식 유효성검사
				alert("이메일 형식이 아닙니다.");
				userEmail.focus();
				return false;
			} else if (userPwd.val() == "") { // 비밀번호 NULL 유효성검사
				alert("비밀번호를 입력하십시요.");
				userPwd.focus();
				return false;
			}
			
		});

		idForm.submit(function() {
			if (userPhone1.val() == "") { // 전화번호 NULL 검사
				alert("전화번호를 입력하십시요");
				userPhone1.focus();
				return false;
			} else if (chkPhone1.test(userPhone1.val()) != true) { // 전화번호 유효성 검사
				alert("전화번호 형식이 아닙니다.");
				userPhone1.focus();
				return false;
			} else if (userPhone2.val() == "") { // 전화번호 NULL 검사
				alert("전화번호를 입력하십시요");
				userPhone2.focus();
				return false;
			} else if (chkPhone2.test(userPhone2.val()) != true) { // 전화번호 유효성 검사
				alert("전화번호 형식이 아닙니다.");
				userPhone2.focus();
				return false;
			} else if (userPhone3.val() == "") { // 전화번호 NULL 검사
				alert("전화번호를 입력하십시요");
				userPhone3.focus();
				return false;
			} else if (chkPhone3.test(userPhone3.val()) != true) { // 전화번호 유효성 검사
				alert("전화번호 형식이 아닙니다.");
				userPhone3.focus();
				return false;
			} else if (idEmail.val() == "") { // 이메일 NULL 유효성검사
				alert("이메일을 입력하십시요");
				idEmail.focus();
				return false;
			} else if (chkEmail.test(idEmail.val()) != true) { // 이메일 형식 유효성검사
				alert("이메일 형식이 아닙니다.");
				idEmail.focus();
				return false;
			} 
			
		});

		pwdForm.submit(function() {
			if (pwdName.val() == "") { // 이름 NULL 유효성검사
				alert("이름을 입력하십시요");
				pwdName.focus();
				return false;
			} else if (chkName.test(pwdName.val()) != true) { // 이름 형식 유효성검사
				alert("이름 형식이 아닙니다.");
				pwdName.focus();
				return false;
			} else if (pwdBirth.val() == "") { // 생년월일 NULL 유효성검사
				alert("생년 월일을 입력하십시요");
				pwdBirth.focus();
				return false;
			} else if (chkBirth.test(pwdBirth.val()) != true) { // 생년월일 형식 유효성검사
				alert("생년월일 형식이 아닙니다.");
				pwdBirth.focus();
				return false;
			} else if (pwdEmail.val() == "") { // 이메일 NULL 유효성검사
				alert("이메일을 입력하십시요");
				pwdEmail.focus();
				return false;
			} else if (chkEmail.test(pwdEmail.val()) != true) { // 이메일 형식 유효성검사
				alert("이름 형식이 아닙니다.");
				pwdEmail.focus();
				return false;
			}
		});

	});

	var result = '${findUser}';

	if (result == 'findIdSuccess'){
		alert("임시 이메일로 이메일(아이디)를 보내드렸습니다. 확인 하십시요");
		$.ajax({ // 아이디찾기 이메일 보내기
			type : 'POST',
			url : '/user/findIdSendEmail',
			data : { "toEmail" : "${toEmail}" , "userPhoneNumber" : "${userPhoneNumber}" }
		})
	}
	
	if (result == 'findIdFail') {
		alert("일치 하는 정보가 없습니다. 다시 입력하십시요.");
	}
	
	if (result == 'findPwdSuccess') {
		alert("이메일로 임시 비밀번호를 보내드렸습니다. 확인 하십시요");
		
		$.ajax({ // 비밀번호찾기 이메일 보내기
			type : 'POST',
			url : '/user/findPwdSendPwd',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			data : JSON.stringify ({
				userEmail : "${userVO.userEmail}",
				userName : "${userVO.userName}",
				userBirth : "${userVO.userBirth}"
			})
		})
	}
	
	if (result == 'findPwdFail') {
		alert("일치 하는 정보가 없습니다. 다시 입력하십시요.");
	}
	
	var abc = '${test}';
</script>
<%@include file="../include/footerSub.jsp"%>
