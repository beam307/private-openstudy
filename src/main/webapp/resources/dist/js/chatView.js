/*스트롤 상단이동*/
$(document).ready(function () {
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300)
            $('.chat').fadeIn();
        else
            $('.chat').fadeOut();
    });
});
if(loginState == "true") {
	sockChat();
	sockChatAlarm();
}
function sockChat() {
	var wsUri = '/admin';
	sockChat = new SockJS(wsUri);
	sockChat.onopen = function(evt) {
	};
	
	sockChat.onmessage = function(evt) { //메시지가 올때 실시간으로 띄움
		var msgVO = JSON.parse(evt.data);
	
		if($("#chatBtn").attr("aria-expanded") == 'true') {
			$.ajax({ //실시간 readDate업데이트
				type : 'put',
				url : '/chat/' + userNo,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				}
			});
		};
		
		var date = formatAMPM(new Date(msgVO.msgSendDate));
		var control = '<li style="width:100%">' +
		               '<div class="msj macro">' +
		               '<div class="chatAvatar"><img class="img-circle" style="width:100%;" src="/displayFile?fileName=' + msgVO.userProfileImgPath + '" /></div>' +
		               '<div class="text text-l">' +
		               '<p>' + msgVO.msgText + '</p>' +
		               '<p><small>' + date + '</small></p>' +
		               '</div>' +
		               '</div>' +
		               '</li>';
		$("#chatUl").append(control);
		var elmnt = document.getElementById("chatUl");
		elmnt.scrollTop = elmnt.scrollHeight;
		sockChatAlarm.send(userNo);
	};
	
	sockChat.onclose = function(){
	};
	
	sockChat.onerror = function(evt) {
		alert("채팅에러: "+evt)
	};
	 
};

function sockChatAlarm() {
	var wsUri = '/login';
	sockChatAlarm = new SockJS(wsUri);
	sockChatAlarm.onopen = function(evt) {
		sockChatAlarm.send(userNo);
	};

	sockChatAlarm.onmessage = function(evt) {
		var count = evt.data;
		if(count != 0)
			$("#new-message").html(count);
	};
	
	sockChatAlarm.onclose = function() {
	};

	sockChatAlarm.onerror = function(evt) {
	};
};

var chatFlag=false;
$('#chatBtn').on('click',function(){
	
	$('#chatUl').html('');
	$('#new-message').html('');
	
	$.ajax({
		type : 'put',
		url : '/chat/' + userNo,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		success : function(result) {
		}
	});
	
	$.getJSON("/chat/chatView/1", function(list) { //chatBtn 클릭시 message 리스트 가져온다
		$(list).each(function(index, data) {
			var message = data;
			var date = formatAMPM(new Date(message.msgSendDate));
			if (message.msgFrom == userNo) { //내가 상대방에게 보낼때 채팅창 오른쪽에 뜸
				var control = '<li style="width:100%;">' +
							    '<div class="msj-rta macro">' +
							    '<div class="text text-r">' +
							    '<p>' + message.msgText + '</p>' +
							    '<p><small>' + date + '</small></p>' +
							    '</div>' +
							    '</li>';
								$("#chatUl").append(control);
			} else { //상대방이 나에게 보낼때 채팅창 왼쪽에 뜸
				var date=formatAMPM(new Date(message.msgSendDate));
				var control = '<li style="width:100%">' +
				               '<div class="msj macro">' +
				               '<div class="avatar"><img class="img-circle" style="width:100%;" src="/displayFile?fileName='+message.userProfileImgPath +'" /></div>' +
				               '<div class="text text-l">' +
				               '<p>' + message.msgText + '</p>' +
				               '<p><small>' + date + '</small></p>' +
				               '</div>' +
				               '</div>' +
				               '</li>';
				$("#chatUl").append(control);
			}
			
			var elmnt = document.getElementById("chatUl");
			elmnt.scrollTop = elmnt.scrollHeight;
		});
	}); 
});

$(".mytext").on("keyup", function (e) { //엔터 누를시 메시지전송
	 if (e.which == 13) {
	     var text = $(this).val();
	     if (text !== "") {
	         insertChat(1, userNo, text);//받는사람 , 보내는사람, 텍스트
	         $(this).val('');
	     }
	 }
});
 
$('.frame').on('click',function(event){ //채팅창 클릭시 이벤트 막음
	event.stopPropagation();
});