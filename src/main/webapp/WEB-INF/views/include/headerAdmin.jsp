<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true"%>
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
<script>
	<c:if test="${not empty login}">
		sockChat();
		sockChatAlarm();
	</c:if>
	function sockChatAlarm() {
		var wsUri = '/login';
		sockChatAlarm = new SockJS(wsUri);
		
		sockChatAlarm.onopen = function(evt) {
			sockChatAlarm.send("${login.userNo}");
		};
		sockChatAlarm.onmessage = function(evt) {
			var alarmSum=null;
			var countMap=JSON.parse(evt.data);
			console.log(countMap)
			for(let i=0;i<countMap.length;i++){
				
				var msgFrom=countMap[i].msgFrom;
				var msgCnt=countMap[i].countChat; 
				
				$("#countAlarmChat"+msgFrom).text(msgCnt);
				alarmSum+=countMap[i].countChat;
			}
			$('#countAlarmChat').html(alarmSum);
		
		};
		sockChatAlarm.onclose = function() {
		}
		
		sockChatAlarm.onerror = function(evt) {
			alert("채팅알람에러")
		};
	}
	
	function sockChat() {
	var wsUri = '/admin';
	sockChat = new SockJS(wsUri);
	sockChat.onopen = function(evt) {
		/*채팅목록 출력  */
		var admin = "${login.userNo}";
		if(admin!="" && admin == '1'){
			$.getJSON("/chat/senderList", function(list) {
				$('#question-list').html("");
				if(list.length == 0) {
					$('#question-list').append("<li>대화 흔적이 없습니다.</li>");
					return;
				}
				$(list).each(function(index, data){
					var aClass = "";
					var sendDate = formatAMPM(new Date(data.msgSendDate));
					var readDate = formatAMPM(new Date(data.msgReadDate));
					if(data.msgSendDate == data.msgReadDate)
						aClass="no-read";
					//var html = template(data);/* <ul class='dropdown-menu' role='menu'>"+html+"</ul> */
					$('#question-list').append(
							"<li class='q-list-li'><span class='q-list badge' id='countAlarmChat"+data.msgRoom+"'></span>"
							+"<a data-chatRoom='"+data.msgRoom+"' data-no='"+data.msgNo+"' class='check-question "+aClass+"' href='#' data-target='#' data-nick='"+data.userNick+"' data-toggle='dropdown' aria-haspopup='true' role='button' aria-expanded='false'>"
							+"<img class='question-PR' src='/displayFile?fileName="+data.userProfileImgPath+"'>"
							+"</img><div class='question-list-text'><div class='user-name'>"+data.userNick+"</div>"
							+"<div class='message'>"+data.msgText+"</div><small> "+sendDate+"</small></div></a></li>");
				});
				sockChatAlarm.send("${login.userNo}");
			});
		} else
			return;
		
	};
	sockChat.onmessage = function(evt) {
		
		/* 실시간 메시지 수신  */
		var msgVO = JSON.parse(evt.data);
		if($(document).has('#chatUl'+msgVO.msgRoom).length>0){
			var sendDate = formatAMPM(new Date(msgVO.msgSendDate));
			var readDate = formatAMPM(new Date(msgVO.msgReadDate));
			var control = '<li class="admin-li">' +
		       '<div class="msj macro">' +
		       '<div class="chatAvatar"><img class="img-circle" src="/displayFile?fileName=' + msgVO.userProfileImgPath + '" /></div>' +
		       '<div class="text text-l">' +
		       '<p>' + msgVO.msgText + '</p>' +
		       '<p><small>' + sendDate + '</small></p>' +
		       '</div>' +
		       '</div>' +
		       '</li>';
			$("#chatUl"+msgVO.msgRoom).append(control);
			$.ajax({//실시간 readDate업데이트
				type : 'put',
				url : '/chat/' + msgVO.msgRoom,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				success : function(result) {
				}
			});
			var elmnt = document.getElementById("chatUl"+msgVO.msgRoom);
			elmnt.scrollTop=elmnt.scrollHeight;
		}
		
		/*채팅 목록 새로고침  */
		var admin = "${login.userNo}";
		if(admin!="" && admin == '1'){
			$.getJSON("/chat/senderList", function(list) {
				$('#question-list').html("");
				if(list.length == 0) {
					$('#question-list').append("<li>대화 흔적이 없습니다.</li>");
					return;
				}
				$(list).each(function(index, data){
					var aClass = "";
					var sendDate = formatAMPM(new Date(data.msgSendDate));
					var readDate = formatAMPM(new Date(data.msgReadDate));
					if(data.msgSendDate == data.msgReadDate)
						aClass="no-read";
					//var html = template(data);/* <ul class='dropdown-menu' role='menu'>"+html+"</ul> */
					$('#question-list').append(
							"<li class='q-list-li'><span class='q-list badge' id='countAlarmChat"+data.msgRoom+"'></span>"
							+"<a data-chatRoom='"+data.msgRoom+"' data-no='"+data.msgNo+"' class='check-question "+aClass+"' href='#' data-target='#' data-nick='"+data.userNick+"' data-toggle='dropdown' aria-haspopup='true' role='button' aria-expanded='false'>"
							+"<img class='question-PR' src='/displayFile?fileName="+data.userProfileImgPath+"'>"
							+"</img><div class='question-list-text'><div class='user-name'>"+data.userNick+"</div>"
							+"<div class='message'>"+data.msgText+"</div><small> "+sendDate+"</small></div></a></li>");
				});
				sockChatAlarm.send("${login.userNo}");
			});
		} else
			return;
		
	};
	
	sockChat.onclose=function(){};
	sockChat.onerror = function(evt) {
		alert("채팅에러: "+evt)
	};
	} 

	$(document).ready(function(){
		
		/* $('#question-btn').on('click', function() {//채팅목록 조회
			if($('#question-list').css('display')=='none')
				$('#question-list').css('display','block');
			else
				$('#question-list').css('display','none');
			
		}); */
		
		$(document).on("click",".removeChat-btn",function(event){
			event.preventDefault();
			$(this).parents(".chatBox").remove();
		})
		
		$(window).scroll(function() {//스크롤 내릴시 채팅목록 사라짐
			$('#question-list').fadeOut();
			$('#question-btn').attr('aria-expanded',false);
			$('#question-btn').parent().removeClass('open');
			$('#question-btn').blur();
		}); 
	});
	
	$(document).on('click','#question-list .check-question',function(event){
		event.preventDefault();
		var msgRoom = $(this).attr('data-chatRoom');
		var userNick = $(this).attr('data-nick');
		var that=$(this);
		var data = {};
		data.msgRoom = msgRoom;
		data.userNick = userNick;
		if ($("#user-nav .chatBox").length != 4) {
			if ($("#user-nav").has("#chatUl" + msgRoom).length == 0) {
				var html = template(data);
				$('#user-nav').append(html);
				$.ajax({
					type : 'put',
					url : '/chat/' + msgRoom,
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "PUT"
					},
					success : function(result) {
					}
				});
				$.getJSON("/chat/chatView/" + msgRoom, function(list) {// 클릭시 message 리스트 가져온다
					$("#countAlarmChat"+msgRoom).html('');
					sockChatAlarm.send("${login.userNo}");
					$(list).each(function(index, data) {
						var message = data;
						if (message.msgFrom == '${login.userNo}') {

							var date = formatAMPM(new Date(message.msgSendDate)); //내가 상대방에게 보낼때 채팅창 오른쪽에 뜸
							var control = '<li class="admin-li">' + '<div class="msj-rta macro">' + '<div class="text text-r">'
									+ '<p class="message">' + message.msgText + '</p>' + '<p><small>' + date + '</small></p>' + '</div>'
									+ '</li>';
							$("#chatUl" + message.msgRoom).append(control);
						} else {
							var date = formatAMPM(new Date(message.msgSendDate));//상대방이 나에게 보낼때 채팅창 왼쪽에 뜸
							var control = '<li class="admin-li">' + '<div class="msj macro">'
									+ '<div class="avatar"><img class="img-circle" src=/displayFile?fileName='
									+ message.userProfileImgPath + ' /></div>' + '<div class="text text-l">' + '<p>' + message.msgText
									+ '</p>' + '<p><small>' + date + '</small></p>' + '</div>' + '</div>' + '</li>';
							$("#chatUl" + message.msgRoom).append(control);
						}

						var elmnt = document.getElementById("chatUl" + message.msgRoom);
						elmnt.scrollTop = elmnt.scrollHeight;
					})
					that.removeClass('no-read');
				});
				

			} else
				alert("이미 열려있는 채팅방입니다.");
		} else {
			alert("채팅창은 최대 4개까지 열수 있습니다.")
		}

	})

	function formatAMPM(date) { // 출력시간 포멧
		var month = date.getMonth() + 1;
		var day = date.getDay();
		var hours = date.getHours();
		var minutes = date.getMinutes();
		var ampm = hours >= 12 ? '오후' : '오전';
		hours = hours % 12;
		hours = hours ? hours : 12; // the hour '0' should be '12'

		month = month < 10 ? '0' + month : month;
		day = day < 10 ? '0' + day : day;
		hours = hours < 10 ? '0' + hours : hours;
		minutes = minutes < 10 ? '0' + minutes : minutes;
		var strTime = month + '월' + day + '일' + ' ' + ampm + ' ' + hours + ':' + minutes;
		return strTime;
	}
	//-- No use time. It is a javaScript effect.
	function insertChat(who, text, time) { //메시지 전송
		var control = "";
		var date = formatAMPM(new Date());
		control = '<li style="width:100%;">' + '<div class="msj-rta macro">' + '<div class="text text-r">' + '<p>' + text + '</p>' + '<p><small>' + date
				+ '</small></p>' + '</div>' + '</li>';
		var message = {};
		message.msgTo = who;
		message.msgFrom = '${login.userNo}';
		message.msgText = text;
		message.userProfileImgPath = '${login.userProfileImgPath}';
		message.msgSendDate = new Date();
		message.msgRoom = who;
		$("#chatUl" + who).append(control);
		sockChat.send(JSON.stringify(message));
		sockChatAlarm.send(message.msgTo);
		var elmnt = document.getElementById("chatUl" + who);
		elmnt.scrollTop = elmnt.scrollHeight;
	}

	$(document).on("keyup", ".mytext", function(e) {//엔터 누를시 메시지전송
		if (e.which == 13) {
			var text = $(this).val();
			var msgFrom = $(this).parents('.chatBox').find('.chk-msgFrom').attr('data-chat');
			if (text !== "") {
				insertChat(msgFrom, text);
				$(this).val('');
			}
		}

	});

	$('.frame').on('click', function(event) {//채팅창 클릭시 이벤트 막음
		event.stopPropagation();
	});

	var template = Handlebars.compile($("#template").html());
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