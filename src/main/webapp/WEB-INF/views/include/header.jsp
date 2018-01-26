<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%@include file="../common/loading.jsp"%>
<%@include file="/WEB-INF/views/common/variable.jspf"%>
<script src="/resources/dist/js/header.js"></script>
<script src="/resources/dist/js/chatchat.js"></script>
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
							<li><a href="/login">로그인</a></li>
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
							<li class="mobile-none">
								<a data-target="#" id="alarm-btn" href="#" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">
									<i class="fa fa-bell" aria-hidden="true"></i> </a> <span id="countAlarm" class="badge bg-theme"></span>
								<ul class="dropdown-menu" id="alarm-list" role="menu" aria-labelledby="dLabel"></ul>
							</li>
							<li class="mobile-none">
								<a class='noteList' href="/note/noteList" onClick="window.open(this.href, '', 'location=no, width=670, height=460, left=800, top=50'); return false;">
									<i class="fa fa-envelope-o" aria-hidden="true"></i>
								</a>
								<span id="countNote" class="badge bg-theme"></span>
							</li>
							<li class="mobile-none"><p class="name">${login.userNick}님</p></li>
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