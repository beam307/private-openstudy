<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sbang - 쉽고 빠른 매칭 서비스</title>

<!-- 부트스트랩 -->
<link href="/resources/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 폰트어썸 -->
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- 초기화 css -->
<link href="/resources/dist/css/setting.css" rel="stylesheet">
<!-- jQuery-Ui css-->
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.0/themes/smoothness/jquery-ui.css">
<!-- 스타일 css -->
<link href="/resources/dist/css/style.css" rel="stylesheet">
<!-- 메인 css -->
<link href="/resources/dist/css/main.css" rel="stylesheet">
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- jQUery-Ui -->
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.0/jquery-ui.min.js"></script>
<!-- 부트스트랩 -->
<script src="/resources/dist/js/bootstrap.min.js"></script>
<!-- 메인 js -->
<script src="/resources/dist/js/main.js"></script>
<!-- 스타일 js -->
<script src="/resources/dist/js/style.js"></script>
<!-- 스크롤 js -->
<script src="/resources/dist/js/scrolla.jquery.min.js"></script>
<!-- 글쓰기 -->
<script src="/resources/dist/js/jquery.bootstrap.js" type="text/javascript"></script>
<!-- 글쓰기 및 수정 -->
<script src="/resources/dist/js/material-bootstrap-wizard.js"></script>
<!-- 소켓js  -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	<c:if test="${not empty login}">
		sockNote();
	</c:if>
	function sockNote() {
		var wsUri = '/note';
		sockNote = new SockJS(wsUri);
		sockNote.onopen = function(evt) {
			sockNote.send("${login.userNo}")
		};

		sockNote.onmessage = function(evt) {
			$('#countNote').html(evt.data);
		};
		sockNote.onclose = function() {

		}

		sockNote.onerror = function(evt) {
			alert("쪽지에러: " + evt)
		};
	}
</script>
<style>
.userInfo .nav-tabs>li>a {
	color: #620017;
}

.userInfo .panel-body {
	height: 200px;
	overflow-y: scroll;
}

.userInfo .panel-title {
	font-size: 13px;
}

.userInfo h4 small {
	font-size: 82%;
}

.userInfo .btn-default {
	background-color: #620017;
	border-color: #620017;
	color: #fff;
	font-size: 12px;
	padding: 10px 30px;
	line-height: 1;
	display: block;
	margin: 20px auto;
}

.userInfo .form-control {
	color: #000;
}

#noteText {
	width: 100%;
}

.text-area {
	width: 100%;
	padding: 10px 30px;
	resize: none;
}

.userInfo .checkbox label, .userInfo .radio label, .userInfo label {
	width: 100%;
	padding-left: 30px;
	font-size: 12px;
}

.userInfo .form-group {
	padding-bottom: 7px;
	margin: 0;
}

.userInfo .form-control, .userInfo .form-group .form-control {
	width: 94.7%;
}
</style>
</head>

<body>
	<div class="userInfo">
		<div role="tabpanel">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="/note/noteReg?noteTarget=">쪽지보내기</a></li>
				<li role="presentation"><a href="/note/noteList">받은 쪽지</a></li>
				<li role="presentation"><a href="/note/noteListSender">보낸 쪽지</a></li>
				<li role="presentation"><a href="/note/noteListToMe">내게 쓴 쪽지</a></li>
				<li role="presentation"><a href="/note/cutOffList">차단설정</a></li>
			</ul>
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="home">
					<label for="noteTarget">받는 이<input type="text" class="form-control" id="noteTarget" name="noteTargetNick" value="${noteTargetNick}" placeholder="받는 이의 닉네임을 입력해주세요." /></label>
					<div class="text-area">
						<textarea name="noteText" id="noteText" rows="10"></textarea>
					</div>
					<div class="checkbox">
						<label> <input type="checkbox" id="meSend"> 내게쓰기 </label>
					</div>
					<div>
						<input type="button" class="btn btn-default" id="sendNote" value="보내기" />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>

	$("#meSend").change(function() {
		if ($("#meSend").is(":checked")) {
			$("#noteTarget").val("${login.userNick}");
		} else {
			$("#noteTarget").val("");
		}
	});

	$("#sendNote").on("click", function() {

		var target = $("#noteTarget");
		var sender = $("#noteSender");
		var text = $("#noteText");

		var noteTargetNick = target.val();
		var noteSenderNick = sender.val();
		var noteText = text.val();
		if (noteText != "" && noteTargetNick != "") {
			$.ajax({
				type : 'post',
				url : '/note/noteReg',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				data : JSON.stringify({
					noteTargetNick : noteTargetNick,
					noteSenderNick : noteSenderNick,
					noteText : noteText
				}),
				success : function(result) {
					if (result == 'CUTOFF') {
						alert("[" + noteTargetNick + "] 님이 수신거부 상태 입니다.");
					} else if (result == 'NOTFIND') {
						target.val('');
						alert('닉네임이 존재하지 않습니다.')
					} else {
						alert("전송완료")
						text.val('');
						sockNote.send(result);
					}
				}
			});
		} else {
			alert("내용을 입력해주세요");
			return;
		}
	});
</script>
</html>