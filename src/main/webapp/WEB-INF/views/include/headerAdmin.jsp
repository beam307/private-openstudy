<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>Open Study - 쉽고 빠른 매칭 서비스</title>
<link rel="icon" type="image/png"  href="/resources/images/favicon.png"/>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/resources/dist/admin/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/dist/admin/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/resources/dist/admin/css/matrix-style.css" />
<link rel="stylesheet" href="/resources/dist/admin/css/matrix-media.css" />
<link href="/resources/dist/admin/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<!-- 메인 css -->
<link href="/resources/dist/css/main.css" rel="stylesheet">
<script src="/resources/dist/admin/js/jquery.min.js"></script>
<script src="/resources/dist/admin/js/jquery.ui.custom.js"></script>
<script src="/resources/dist/admin/js/bootstrap.min.js"></script>
<script src="/resources/dist/admin/js/jquery.uniform.js"></script>
<script src="/resources/dist/admin/js/select2.min.js"></script>
<script src="/resources/dist/admin/js/jquery.dataTables.min.js"></script>
<script src="/resources/dist/admin/js/matrix.tables.js"></script>
<!-- 메인 js -->
<script src="/resources/dist/js/main.js"></script>
<!-- 스타일 js -->
<script src="/resources/dist/js/style.js"></script>
<!-- 템플릿 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- 스크롤 js -->
<script src="/resources/dist/js/scrolla.jquery.min.js"></script>
<!-- 소켓js  -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
</head>
<%@include file="../common/loading.jsp"%>
<%@include file="/WEB-INF/views/common/variable.jspf"%>
<script src="/resources/dist/js/headerAdmin.js"></script>
<script src="/resources/dist/js/chatchat.js"></script>
<script id="template" type="text/x-handlebars-template">
<div class="chatBox">
<div class="userNick">{{userNick}}
<div class="removeChat-btn"><a href='#'><i class="fa fa-times" aria-hidden="true"></i></a></div>
</div>
    <div class="frame admin-frame col-md-12">
        <ul data-chat="{{msgRoom}}" class="chk-msgFrom" id="chatUl{{msgRoom}}"></ul>
        <div>
            <div class="msj-rta macro" style="margin:auto">
                <div class="text text-r" style="background:whitesmoke !important">
                    <input type='text' class="mytext" placeholder="문의사항을 남겨주세요." autofocus/>
                </div>
            </div>
        </div>
    </div>
</div>
</script>
<body>

    <!--Header-part-->
    <div id="header">
        <h1><a href="/admin/index"><span>Open Study</span> Admin</a></h1>
    </div>
    <!--close-Header-part-->

    <!--top-Header-menu-->
    <div id="user-nav" class="navbar navbar-inverse">
        <ul class="nav chat-nav">
            <li class="dropdown" id="menu-messages"><a href="#" id="question-btn" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle"><i class="icon icon-envelope"></i> <span class="text">메세지</span> <span id="countAlarmChat" class="label label-important"></span> <b class="caret"></b></a>
                <ul class="dropdown-menu" id="question-list" role="menu" aria-labelledby="dLabel">
							 
				</ul>
            </li>
            <li class=""><a title="" href="/"><i class="icon-home"></i> <span class="text">홈으로 가기</span></a></li>
            <li class=""><a title="" href="/login/logout"><i class="icon icon-share-alt"></i> <span class="text">로그아웃</span></a></li>
            <li class=""><a title="" href="/changeAdminPwd"><i class="icon icon-share-alt"></i> <span class="text">관리자 2차 비밀번호 변경</span></a></li>
        </ul>
    </div>
    <!--close-top-Header-menu-->
    <!--close-top-serch-->