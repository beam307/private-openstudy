<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		var result = '${msg}'

		if (result == 'changePwd')
			alert("비밀번호 변경이 성공하였습니다. ")
		if (result == 'changeFail')
			alert("비밀번호 변경이 실패하였습니다. ")

		self.location = "/user/myPage?target=3";
	</script>
</body>
</html>