if(loginState == "true") {
		sockChat();
		sockChatAlarm();
}
function sockChatAlarm() {
	var wsUri = '/login';
	sockChatAlarm = new SockJS(wsUri);
	
	sockChatAlarm.onopen = function(evt) {
		sockChatAlarm.send(userNo);
	};
	sockChatAlarm.onmessage = function(evt) {
		var alarmSum=null;
		var countMap=JSON.parse(evt.data);
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
		var admin = userNo;
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
							+"<a data-chatRoom='"+data.msgRoom+"' data-no='"+data.msgNo+"' class='check-question' href='#' data-target='#' data-nick='"+data.userNick+"' data-toggle='dropdown' aria-haspopup='true' role='button' aria-expanded='false'>"
							+"<img class='question-PR' src='/displayFile?fileName="+data.userProfileImgPath+"'>"
							+"</img><div class='question-list-text'><div class='user-name'>"+data.userNick+"</div>"
							+"<div class='message'>"+data.msgText+"</div><small> "+sendDate+"</small></div></a></li>");
				});
				sockChatAlarm.send(userNo);
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
		var admin = userNo;
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
					//var html = template(data);/* <ul class='dropdown-menu' role='menu'>"+html+"</ul> */
					$('#question-list').append(
							"<li class='q-list-li'><span class='q-list badge' id='countAlarmChat"+data.msgRoom+"'></span>"
							+"<a data-chatRoom='"+data.msgRoom+"' data-no='"+data.msgNo+"' class='check-question' href='#' data-target='#' data-nick='"+data.userNick+"' data-toggle='dropdown' aria-haspopup='true' role='button' aria-expanded='false'>"
							+"<img class='question-PR' src='/displayFile?fileName="+data.userProfileImgPath+"'>"
							+"</img><div class='question-list-text'><div class='user-name'>"+data.userNick+"</div>"
							+"<div class='message'>"+data.msgText+"</div><small> "+sendDate+"</small></div></a></li>");
				});
				sockChatAlarm.send(userNo);
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

	$('#question-btn').on("click",function(){
		if(userNo!="" && userNo == '1'){
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
					
					//var html = template(data);/* <ul class='dropdown-menu' role='menu'>"+html+"</ul> */
					$('#question-list').append(
							"<li class='q-list-li'><span class='q-list badge' id='countAlarmChat"+data.msgRoom+"'></span>"
							+"<a data-chatRoom='"+data.msgRoom+"' data-no='"+data.msgNo+"' class='check-question' href='#' data-target='#' data-nick='"+data.userNick+"' data-toggle='dropdown' aria-haspopup='true' role='button' aria-expanded='false'>"
							+"<img class='question-PR' src='/displayFile?fileName="+data.userProfileImgPath+"'>"
							+"</img><div class='question-list-text'><div class='user-name'>"+data.userNick+"</div>"
							+"<div class='message'>"+data.msgText+"</div><small> "+sendDate+"</small></div></a></li>");
				});
				sockChatAlarm.send(userNo);
			});
		} else
			return;
	})
	
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
	var template = Handlebars.compile($("#template").html());
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
				sockChatAlarm.send(userNo);
				$(list).each(function(index, data) {
					var message = data;
					if (message.msgFrom == userNo) {

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



$(document).on("keyup", ".mytext", function(e) {//엔터 누를시 메시지전송
	if (e.which == 13) {
		var text = $(this).val();
		var msgTo = $(this).parents('.chatBox').find('.chk-msgFrom').attr('data-chat');
		if (text !== "") {
			insertChat(msgTo, userNo, text);
			$(this).val('');
		}
	}

});

$('.frame').on('click', function(event) {//채팅창 클릭시 이벤트 막음
	event.stopPropagation();
});

