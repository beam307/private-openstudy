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
			return false;수경
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

var result = $('#findUser').val();

if (result == 'findIdSuccess') {
	alert("임시 이메일로 이메일(아이디)를 보내드렸습니다. 확인 하십시요");
	$.ajax({ // 아이디찾기 이메일 보내기
		type : 'POST',
		url : '/user/findIdSendEmail',
		data : {
			toEmail : $('#toEmail').val(),
			userPhoneNumber : $('#userPhoneNumber').val()
		}
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
		data : JSON.stringify({
			userEmail : $('#userEmail').val(),
			userName : $('#userName').val(),
			userBirth : $('#userBirth').val()
		})
	})
}

if (result == 'findPwdFail') {
	alert("일치 하는 정보가 없습니다. 다시 입력하십시요.");
}
