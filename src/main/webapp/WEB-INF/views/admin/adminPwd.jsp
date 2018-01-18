<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>암호를 입력하세요</title>
<!--=======Font Open Sans======-->
<link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<!--스크롤 효과 css-->
<link rel="stylesheet" href="/resources/dist/css/animate.min.css">
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- 스크롤 js -->
<script src="/resources/dist/js/scrolla.jquery.min.js"></script>

<style>
* {
	margin: 0;
	padding: 0;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

body {
	background: #f4f4f4;
	font-family: "Nanum Gothic", sans-serif;
}

.pwdbg {
	padding: 200px 0 289px;
}

.form-box {
	background: #fff;
	margin: 30px auto;
	max-width: 500px;
	box-shadow: 0 3px 6px 0px rgba(0, 0, 0, 0.16), 0 3px 6px 0px rgba(0, 0, 0, 0.23);
	border-radius: 10px;
}

form#login-form {
	overflow: hidden;
	position: relative;
	padding: 30px;
}

.head {
	color: #777;
	font-size: 17px;
	font-weight: normal;
	padding: 15px 0;
	text-align: center;
	text-transform: uppercase;
	border-radius: 10px;
}

.form-group {
	margin-bottom: 15px;
	position: relative;
	width: 100%;
	overflow: hidden;
}

.form-group .label-control {
	color: #888;
	display: block;
	font-size: 14px;
	position: absolute;
	top: 0;
	left: 0;
	padding: 0;
	width: 100%;
	pointer-events: none;
	height: 100%;
}

.form-group .label-control::before, .form-group .label-control::after {
	content: "";
	left: 0;
	position: absolute;
	bottom: 0;
	width: 100%;
}

.form-group .label-control::before {
	border-bottom: 1px solid #B9C1CA;
	transition: transform 0.3s;
	-webkit-transition: -webkit-transform 0.3s;
}

.form-group .label-control::after {
	border-bottom: 2px solid #620017;
	-webkit-transform: translate3d(-100%, 0, 0);
	transform: translate3d(-100%, 0, 0);
	-webkit-transition: -webkit-transform 0.3s;
	transition: transform 0.3s;
}

.form-control {
	border: none;
	border-radius: 10px;
	margin-top: 20px;
	padding: 12px 0;
	width: 100%;
	font-size: 14px;
}

.form-control:focus {
	outline: none;
	box-shadow: none;
}

.form-group .label-control .label-text {
	-webkit-transform: translate3d(0, 30px, 0) scale(1);
	-moz-transform: translate3d(0, 30px, 0) scale(1);
	transform: translate3d(0, 30px, 0) scale(1);
	-webkit-transform-origin: left top;
	-moz-transform-origin: left top;
	transform-origin: left top;
	-webkit-transition: 0.3s;
	-moz-transition: 0.3s;
	transition: 0.3s;
	position: absolute;
}

.active .label-control::after {
	-webkit-transform: translate3d(0%, 0, 0);
	transform: translate3d(0%, 0, 0);
}

.active .label-control .label-text {
	opacity: 1;
	-webkit-transform: scale(0.9);
	-moz-transform: scale(0.9);
	transform: scale(0.9);
	color: #620017 !important;
}

.input-field label:before {
	content: '';
	position: absolute;
	bottom: 0;
	left: 0;
	width: 100%;
	border-bottom: 1px solid #B9C1CA;
	transition: transform 0.3s;
	-webkit-transition: -webkit-transform 0.3s;
}

input[type="submit"] {
	background: #adadad;
	border: none;
	border-radius: 2px;
	color: #fff;
	cursor: pointer;
	font-size: 16px;
	font-weight: bold;
	letter-spacing: 3px;
	margin: 5px 0;
	outline: medium none;
	overflow: hidden;
	padding: 10px;
	text-transform: uppercase;
	transition: all 0.15s ease-in-out 0s;
	width: 100%;
	box-shadow: 0 1px 2px 0px rgba(0, 0, 0, 0.16), 0 1px 2px 0px rgba(0, 0, 0, 0.23);
}

input[type="submit"]:hover {
	background: #620017;
	box-shadow: 0 2px 4px 0px rgba(0, 0, 0, 0.16), 0 2px 4px 0px rgba(0, 0, 0, 0.23);
}

.text-p {
	font-size: 14px;
	text-align: center;
	margin: 10px 0;
}

.text-p a {
	color: #175690;
}

.pwdConfirmBtn {
	cursor: pointer;
}

@media ( max-width : 480px) {
	form#login-form {
		width: 90%;
		margin: 30px auto;
	}
}
</style>
</head>
<body>
	<div class="pwdbg">
		<div class="form-box animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
			<div class="head">관리자 2차 비밀번호를 입력하세요.</div>
			<form action="/adminPwdPost" method="post" id="login-form">
				<div class="form-group">
					<label class="label-control"> <span class="label-text"></span>
					</label>
				</div>
				<div class="form-group">
					<label class="label-control"> <span class="label-text">Password</span>
					</label> <input id="adminPwd" type="password" name="adminPwd" class="form-control" />
				</div>
				<input type="submit" class="form-control pwdConfirmBtn" value="확인" />
				<p class="text-p"></p>
			</form>
		</div>
	</div>
<script type="text/javascript">

	var adminPwd = $('#adminPwd'); // 현재 비밀번호 선택자

	$(window).load(function() {
		$('.form-group input').on('focus blur', function(e) {
			$(this).parents('.form-group').toggleClass('active', (e.type === 'focus' || this.value.length > 0));
		}).trigger('blur');
		$('.animate').scrolla();
	});
</script>
</body>
</html>