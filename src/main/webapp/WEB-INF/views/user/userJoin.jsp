<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/headerSub.jsp"%>
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
					<a href="/user/agreeUser" class="terms" onClick="window.open(this.href, '', 'location=no, width=700, height=800, left=640, top=100'); return false;">[약관보기]</a>
					</label>
				</div>
			</div>
			
			<div class="modal-footer">
				<button type="submit" class="btn btn-default">회원가입</button>
			</div> 
		</form>
	</div>
</div>
<script>
	jQuery(function($) {
		var chkEmail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; // 이메일 검사식
		var chkBirth = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))$/; // 생년월일 검사식
		var chkName = /^[가-힣]+$/; // 이름 검사식
		var chkPwd = /^[a-zA-Z0-9]{8,18}$/; // 비밀번호 검사식
		var chkNick = /^[가-힣a-zA-Z0-9]{1,20}$/; // 닉네임 검사식

		var form = $('#joinForm');
		var userEmail = $('#InputEmail');
		var userName = $('#InputName');
		var userPwd = $('#InputPassword');
		var userPwdChk = $('#InputPasswordChk');
		var userBirth = $('#InputBirthday');
		var userNick = $('#InputNickName');
		var userGender = $('.genderRadio');

		var checkEmail = $('#resultEmailCheck');
		var checkNick = $('#resultNickCheck');

		function validator() { // 비밀번호 값 비교
			if (userPwd.val() == userPwdChk.val())
				return true;
			else
				return false;
		}
		function checkedRadio() {
			if ($('input:radio[name=userGender]').is(':checked'))
				return true;
			else
				return false;
		}

		form.submit(function() {

			if (userEmail.val() == "") { // 이메일 NULL 유효성검사
				alert("이메일을 입력하십시요");
				userEmail.focus();
				return false;
			} else if (chkEmail.test(userEmail.val()) != true) { // 이메일 형식 유효성검사
				alert("이메일 형식이 아닙니다.");
				userEmail.focus();
				return false;
			} else if (userName.val() == "") { // 이름 NULL 유효성검사
				alert("이름을 입력하십시요");
				userName.focus();
				return false;
			} else if (chkName.test(userName.val()) != true) { // 이름 형식 유효성검사
				alert("이름 형식이 아닙니다.");
				userName.focus();
				return false;
			} else if (userPwd.val() == "") { // 비밀번호 NULL 유효성검사
				alert("비밀번호를 입력하십시요");
				userPwd.focus();
				return false;
			} else if (chkPwd.test(userPwd.val()) != true) { // 비밀번호 유효성 검사
				alert("비밀번호 형식이 아닙니다.");
				userPwd.focus();
				return false;
			} else if (userPwdChk.val() == "") { // 비밀번호확인 NULL 유효성검사
				alert("비밀번호 확인을 입력하십시요");
				userPwdChk.focus();
				return false;
			} else if (validator() != true) { // 비밀번호 확인 검사
				alert("비밀번호확인 값이 틀립니다.");
				userPwdChk.focus();
				return false;
			} else if (userNick.val() == "") { // 닉네임 NULL 유효성 검사
				alert("닉네임을 입력하십시요");
				userNick.focus();
				return false;
			} else if (chkNick.test(userNick.val()) != true) { // 닉네임 유효성 검사
				alert("닉네임 형식이 아닙니다.");
				userNick.focus();
				return false;
			} else if (userBirth.val() == "") { // 생년월일 NULL 유효성 검사
				alert("생년월일을 입력하십시요");
				userBirth.focus();
				return false;
			} else if (chkBirth.test(userBirth.val()) != true) { // 생년월일 유효성 검사
				alert("생년월일 형식이 아닙니다.");
				userBirth.focus();
				return false;
			} else if (checkedRadio() != true) { // 성별 NULL 유효성 검사
				alert("성별을 선택하세요");
				userGender.focus();
				return false;
			} else if (checkEmail.val() == "") { // 아이디 중복체크
				alert("아이디 중복 확인을 해주세요");
				checkEmail.focus();
				return false;
			} else if (checkEmail.val() == "0") { // 아이디 중복체크
				alert("중복된 아이디 입니다. 이메일을 다시 선택 하십시요");
				checkEmail.focus();
				return false;
			} else if (checkNick.val() == "") { // 닉네임 중복체크
				alert("닉네임 중복 확인을 해주세요");
				checkNick.focus();
				return false;
			} else if (checkNick.val() == "0") { // 닉네임 중복체크
				alert("중복된 닉네임 입니다. 닉네임을 다시 선택 하십시요");
				checkNick.focus();
				return false;
			}
		});

		$('#emailCheck').click(function() {
			var emailCheck = userEmail.val(); // 아이디 값

			if (userEmail.val() == "") { // 이메일 NULL 유효성검사
				alert("이메일을 입력하십시요");
				userEmail.focus();
				return false;
			} else if (chkEmail.test(emailCheck) != true) { // 이메일 형식 유효성검사
				alert("이메일 형식이 아닙니다.");
				userEmail.focus();
				return false;
			}

			$.ajax({
				type : 'POST',
				url : '/user/checkEmail',
				data : {
					"userEmail" : emailCheck
				},
				success : function(data) {
					if ($.trim(data) == 0) {
						alert("사용 가능한 이메일 입니다.");
						checkEmail.val('1');
					} else {
						alert("중복된 이메일 입니다.");
						checkEmail.val('0');
					}
				}
			});

		});

		$('#nickCheck').click(function() {
			var nickCheck = userNick.val(); // 아이디 값

			if (userNick.val() == "") { // 닉네임 NULL 유효성 검사
				alert("닉네임을 입력하십시요");
				userNick.focus();
				return false;
			} else if (chkNick.test(nickCheck) != true) { // 닉네임 유효성 검사
				alert("닉네임 형식이 아닙니다.");
				userNick.focus();
				return false;
			}

			$.ajax({
				type : 'POST',
				url : '/user/checkNick',
				data : {
					"userNick" : nickCheck
				},
				success : function(data) {
					if ($.trim(data) == 0) {
						alert("사용 가능한 닉네임 입니다.");
						checkNick.val('1');
					} else {
						alert("중복된 닉네임 입니다.");
						checkNick.val('0');
					}
				}
			});

		});

		userEmail.change(function() {
			checkEmail.val("");
		})
		userNick.change(function() {
			checkNick.val("");
		})

	});
</script>
<%@include file="../include/footerSub.jsp"%>
