<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Expires", "Sat, 01 Jan 1970 22:00:00 GMT");
response.setHeader("Pragma", "no-cache");
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<link rel="icon" type="image/png"  href="/resources/images/favicon.png"/>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Open Study - 쉽고 빠른 매칭 서비스</title>

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
<!-- 타임피키 css -->
<link href="/resources/dist/css/jquery.timepicker.css" rel="stylesheet">
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
<!-- 업로드 js -->
<script type="text/javascript" src="/resources/dist/js/upload.js"></script>
<!-- 썸네일 js -->
<script type="text/javascript" src="/resources/dist/js/thumbInfo.js"></script>
<!-- 템플릿 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- 스크롤 js -->
<script src="/resources/dist/js/scrolla.jquery.min.js"></script>
<!-- 글쓰기 -->
<script src="/resources/dist/js/jquery.bootstrap.js" type="text/javascript"></script>
<!-- 글쓰기 및 수정 -->
<script src="/resources/dist/js/material-bootstrap-wizard.js"></script>
<!-- 글쓰기 및 수정 -->
<script src="/resources/dist/js/jquery.validate.min.js"></script>
<!-- 지역js -->
<script src="/resources/dist/js/subRegion.js"></script>
<!-- 타임피키js  -->
<script src="/resources/dist/js/jquery.timepicker.min.js"></script>
<!-- 소켓js  -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script>
	$(document).ready(function() {
		var category = [ "전체", "영어", "외국어", "IT", "교양", "공무원" ];

		$("#searchBox").autocomplete({
			source : category
		});

		var result = '${msg}';
		var userEmail = "${userEmail}";
		if (result == 'regSuccess')
			alert("[회원가입 완료] \n" + userEmail + "님 가입을 환영합니다.");

		$('#alarm-btn').on('click',function(event) {
			event.preventDefault();
			$('#alarm-list').css('display', '');
			alarmTarget = "${login.userNo}";
			if (alarmTarget != "") {
				$.getJSON("/alarm/all/" + alarmTarget, function(list) {
					$('#alarm-list').html("");
					if (list.length == 0) {
						$('#alarm-list').append("<li>알람이 없습니다.</li>");
						return;
					}
					$(list).each(
							function(index, data) {
								var alarmNo = data.alarmNo;
								var target = data.alarmTarget;
								var sender = data.userNick;
								var senderPRImgPath = data.userProfileImgPath;
								var regDate = data.alarmRegDate;
								var openDate = data.alarmOpenDate;
								var readState = data.alarmReadState;
								var studyNo = data.alarmTargetStudy;
								var studyName = data.studyName;
								var flag = data.alarmFlag;
								var aClass = "";
								if (!readState)
									aClass = "no-read"
								if (flag == 1) {// 스터디 신청
									$('#alarm-list').append(
											"<li>"
												+ "<a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage?target=2'>"
													+ "<div class='col-md-2'><img class='alarm-PR' src='/displayFile?fileName="+ senderPRImgPath + "'></img></div>"
													+ "<div class='col-md-10'><p><b>" + sender + "</b>님이<br/><b>" + studyName+ "</b>에 신청하였습니다.</p>"
													+ "<small>" + regDate + "</small></div>"
												+ "</a>"
											+"</li>");
								} else if (flag == 2) {// 스터디 신청취소
									$('#alarm-list').append(
											"<li>"
												+ "<a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage?target=2'>"
													+ "<div class='col-md-2'><img class='alarm-PR' src='/displayFile?fileName="+ senderPRImgPath + "'></img></div>"
													+ "<div class='col-md-10'><p><b>" + sender + "</b>님이<br/><b>" + studyName+ "</b>에 신청을 취소하였습니다.</p>"
													+ "<small>" + regDate + "</small></div>"
												+"</a>"
											+"</li>");
								} else if (flag == 3) {// 북마크등록
									$('#alarm-list').append(
											"<li>"
												+ "<a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage'>"
													+ "<div class='col-md-2'><img class='alarm-PR' src='/displayFile?fileName="+ senderPRImgPath + "'></img></div>"
													+ "<div class='col-md-10'><p><b>" + sender + "</b>님이<br/><b>" + studyName+ "</b>을 북마크에 등록하였습니다.</p>"
													+ "<small>" + regDate + "</small></div>"
												+"</a>"
											+"</li>");      
								} else if (flag == 4) {// 댓글 등록
									$('#alarm-list').append(
											"<li>"
												+ "<a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/study/studyView?&studyNo=" + studyNo +"'>"
													+ "<div class='col-md-2'><img class='alarm-PR' src='/displayFile?fileName="+ senderPRImgPath + "'></img></div>"
													+ "<div class='col-md-10'><p><b>" + sender + "</b>님이<br/><b>" + studyName+ "</b>스터디에 댓글을 남겼습니다.</p>"
													+ "<small>" + regDate + "</small></div>"
												+"</a>"
											+"</li>");   
								} else if (flag == 5) {// 참여신청 승인
									$('#alarm-list').append(
											"<li>"
												+ "<a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage?target=3'>"
													+ "<div class='col-md-2'><img class='alarm-PR' src='/displayFile?fileName="+ senderPRImgPath + "'></img></div>"
													+ "<div class='col-md-10'><p><b>" + sender + "</b>님이<br/><b>" + studyName+ "</b>에 참여신청이 승인되었습니다.</p>"
													+ "<small>" + regDate + "</small></div>"
												+"</a>"
											+"</li>");
								} else if (flag == 6) {// 참여신청 거절
									$('#alarm-list').append(
											"<li>"
												+ "<a data-alarmNo='"+alarmNo+"' class='check-alarm note-alarm "+aClass+"' href='/note/noteList'>"
													+ "<div class='col-md-2'><img class='alarm-PR' src='/displayFile?fileName="+ senderPRImgPath + "'></img></div>"
													+ "<div class='col-md-10'><p><b>" + sender + "</b>님이<br/><b>" + studyName+ "</b>에 참여신청을 거절하였습니다.</p>"
													+ "<small>" + regDate + "</small></div>"
												+"</a>"
											+"</li>");
								} else if (flag == 7) {// 스터디 완료
									$('#alarm-list').append(
											"<li>"
												+ "<a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/study/studyEndView?studyNo="+studyNo+"'>"
													+ "<div class='col-md-2'><img class='alarm-PR' src='/displayFile?fileName="+ senderPRImgPath + "'></img></div>"
													+ "<div class='col-md-10'><p><b>" + sender + "</b>님이<br/><b>" + studyName+ "</b>를 종료하였습니다</p>"
													+ "<small>" + regDate + "</small></div>"
												+"</a>"
											+"</li>");
								} else {
									alert('알람에러입니다');
								}
								if (regDate == openDate) {
									$.ajax({
										type : 'put',
										url : '/alarm/' + target,
										headers : {
											"Content-Type" : "application/json",
											"X-HTTP-Method-Override" : "PUT"
										},
										success : function(result) {
										}
									});
								}
							});
				});
				$('#countAlarm').html('');
			} else
				return;
		});

		$(document).on('click', '.check-alarm', function(event) {
			var alarmNo = $(this).attr('data-alarmNo');
			$.ajax({
				type : 'put',
				url : '/alarm/read/' + alarmNo,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				success : function(result) {
				}
			});
		});

		$(document).on('click', '.note-alarm', function(event) {
			window.open(this.href, 'alarmNote', 'location=no, width=670, height=700, left=800, top=50');
			return false;
		});

		/* $(window).scroll(function() {
			$('#alarm-list').fadeOut();
			$('#alarm-btn').attr('aria-expanded', false);
			$('#alarm-btn').parent().removeClass('open');
			$('#alarm-btn').blur();
		}); */
	});
	<c:if test="${not empty login}">
	sockNote();
	sockAlarm();
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
		};
	}

	function sockAlarm() {
		var wsUri = '/user';
		sockAlarm = new SockJS(wsUri);
		sockAlarm.onopen = function(evt) {
			sockAlarm.send("${login.userNo}")
		};

		sockAlarm.onmessage = function(evt) {
			console.log(evt.data);
			$('#countAlarm').html(evt.data);
			var alarmTarget="${login.userNo}";
			if(alarmTarget!=""){
				$.getJSON("/alarm/all/" + alarmTarget, function(list) {
					$('#alarm-list').html("");
					if(list.length == 0) {
						$('#alarm-list').append("<li>알람이 없습니다.</li>");
						return;
					}
					$(list).each(function(index,data){
						var alarmNo=data.alarmNo;
						var target=data.alarmTarget;
						var sender=data.userNick;
						var senderPRImgPath=data.userProfileImgPath;
						var regDate=data.alarmRegDate;
						var openDate=data.alarmOpenDate;
						var readState=data.alarmReadState;
						var studyNo=data.alarmTargetStudy;
						var studyName=data.studyName;
						var flag=data.alarmFlag;
						var aClass="";
						if(!readState)
							aClass="no-read"
						if(flag==1){// 스터디 신청
							$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
									+"<span> '"+studyName+"' </span>에 신청하였습니다.<small>"+regDate+"</small></a></li>");
						}else if(flag==2){// 스터디 신청취소
							$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
									+"<span> '"+studyName+"' </span>에 신청을 취소하였습니다.<small>"+regDate+"</small></a></li>");
						}else if(flag==3){// 북마크등록
							$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
									+"<span> '"+studyName+"' </span>을 북마크에 등록하였습니다.<small>"+regDate+"</small></a></li>")
						}else if(flag==4){// 댓글 등록
							$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/study/studyView?&studyNo="+studyNo+"'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
									+" 스터디에 댓글을 남겼습니다.<small>"+regDate+"</small></a></li>");
						}else if(flag==5){
							$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/study/studyView?&studyNo="+studyNo+"'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
									+"<span> '"+studyName+"' </span>에 참여신청이 승인되었습니다.<small>"+regDate+"</small></a></li>");
						}else if(flag==6){
							$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm note-alarm "+aClass+"' href='/note/noteList'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
									+"<span> '"+studyName+"' </span>에 참여신청을 거절하였습니다.(쪽지확인)<small>"+regDate+"</small></a></li>");
						}else if (flag == 7) {// 스터디 완료
							$('#alarm-list').append(
									"<li><a data-alarmNo='"+alarmNo+"' class='check-alarm note-alarm "+aClass+"' href='/study/studyEndView?studyNo="+studyNo+"'><img class='alarm-PR' src='/displayFile?fileName="
											+ senderPRImgPath + "'></img><span> '" + sender + "' </span>님이" + "<span> '" + studyName + "' </span>을 완료하였습니다<small>" + regDate + "</small></a></li>");
						}else{
							alert('알람에러입니다');
						}
					});
					
				});
			}
		};
		sockAlarm.onclose = function() {
		}

		sockAlarm.onerror = function(evt) {
		};
	}
	
	
</script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-111547991-1"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag() {
		dataLayer.push(arguments);
	}
	gtag('js', new Date());

	gtag('config', 'UA-111547991-1');
</script>

</head>

<body>
	<header>
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/">Open<span>Study</span></a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

					<ul class="nav navbar-nav navbar-left">
						<li><a href="/study/studyList${pageMaker.makeUpCategory('n') }">전체</a></li>
						<li><a href="/study/studyList${pageMaker.makeUpCategory('0') }">영어</a></li>
						<li><a href="/study/studyList${pageMaker.makeUpCategory('1') }">외국어</a></li>
						<li><a href="/study/studyList${pageMaker.makeUpCategory('2') }">IT</a></li>
						<li><a href="/study/studyList${pageMaker.makeUpCategory('3') }">교양</a></li>
						<li><a href="/study/studyList${pageMaker.makeUpCategory('4') }">공무원</a></li>
					</ul>
					
					<ul class="nav navbar-nav navbar-right">
						<c:if test="${empty login}">
							<!-- 로그인 안됐을 경우 -->
							<li><a href="/login/loginGet">로그인</a></li>
							<li><a href="/user/regUser">회원가입</a></li>
						</c:if>
						<c:if test="${login.userAuth eq '1'}">
							<!-- 관리자 페이지 -->
							<li><p class="name">${login.userNick}님</p></li>
							<li><a href="/admin/index">관리자페이지</a></li>
							<li><a href="/login/logout">로그아웃</a></li>
						</c:if>
						<c:if test="${not empty login && login.userAuth eq '0'}">
							<!-- 로그인된 경우 -->
							<li><a data-target="#" id="alarm-btn" href="#" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false"><i
									class="fa fa-bell" aria-hidden="true"></i> </a> <span id="countAlarm" class="badge bg-theme"></span>
								<ul class="dropdown-menu" id="alarm-list" role="menu" aria-labelledby="dLabel">
								</ul>
							</li>
							<li>
								<a class='noteList' href="/note/noteList"
								onClick="window.open(this.href, '', 'location=no, width=670, height=460, left=800, top=50'); return false;">
									<i class="fa fa-envelope-o" aria-hidden="true"></i>
								</a>
								<span id="countNote" class="badge bg-theme"></span>
							</li>
							<li><p class="name">${login.userNick}님</p></li>
							<li><a href="/user/myPage">마이페이지</a></li>
							<li><a href="/login/logout">로그아웃</a></li>
						</c:if>
						<li><a href="/study/studyReg">스터디등록</a></li>
						<li><a href="/board/qnAList">FAQ</a></li>
						<li><a href="/board/noticeList">공지사항</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>
	</header>