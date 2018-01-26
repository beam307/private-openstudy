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
<link href="/resources/dist/css/admin.css" rel="stylesheet">
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
</body>
<script type="text/javascript" src="/resources/dist/js/admin/admin.js"></script>
</html>