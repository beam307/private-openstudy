<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>

        
<div class="chatBox">
    <div class="frame col-md-12">
    	<div class="chat-tit"><i class="fa fa-commenting" aria-hidden="true"></i>1:1 문의</div>
        <ul id="chatUl"></ul>
        <div>
            <div class="msj-rta macro" style="margin:auto">
                <div class="text text-r" style="background:whitesmoke !important">
                    <input class="mytext" placeholder="문의사항을 남겨주세요." autofocus/>
                </div>
            </div>
        </div>
    </div>
</div>



<script>
/*스트롤 상단이동*/
$(document).ready(function () {
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.chat').fadeIn();
        } else {
            $('.chat').fadeOut();
        }
    });
});
     <c:if test="${not empty login}">
	sockChat();
	sockChatAlarm();
	</c:if>
	function sockChat() {
		var wsUri = '/admin';
		sockChat = new SockJS(wsUri);
		sockChat.onopen = function(evt) {
		};
		
		sockChat.onmessage = function(evt) {//메시지가 올때 실시간으로 띄움
			var msgVO=JSON.parse(evt.data);
			console.log(typeof($("#chatBtn").attr("aria-expanded")))
			if($("#chatBtn").attr("aria-expanded")=='true'){
				$.ajax({//실시간 readDate업데이트
					type : 'put',
					url : '/chat/${login.userNo}',
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "PUT"
					},
					success : function(result) {
					}
				});
			}
			var date=formatAMPM(new Date(msgVO.msgSendDate));
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
			elmnt.scrollTop=elmnt.scrollHeight;
			sockChatAlarm.send("${login.userNo}");
		};
		sockChat.onclose=function(){
		}
		
		sockChat.onerror = function(evt) {
			alert("채팅에러: "+evt)
		};
		 
	} 
	function sockChatAlarm() {
		var wsUri = '/login';
		sockChatAlarm = new SockJS(wsUri);
		sockChatAlarm.onopen = function(evt) {
			sockChatAlarm.send("${login.userNo}");
		};

		sockChatAlarm.onmessage = function(evt) {
			var count=evt.data;
			if(count!=0)
				$("#new-message").html(count);
		};
		sockChatAlarm.onclose = function() {
		}

		sockChatAlarm.onerror = function(evt) {
		};
	}
	var chatFlag=false;
	$('#chatBtn').on('click',function(){
		
		$('#chatUl').html('');
		$('#new-message').html('');
		$.ajax({
			type : 'put',
			url : '/chat/${login.userNo}',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			success : function(result) {
			}
		});
		$.getJSON("/chat/chatView/1", function(list) {//chatBtn 클릭시 message 리스트 가져온다
			$(list).each(function(index, data){
				var message=data;
				var date = formatAMPM(new Date(message.msgSendDate));
				if(message.msgFrom=='${login.userNo}'){//내가 상대방에게 보낼때 채팅창 오른쪽에 뜸
					var control = '<li style="width:100%;">' +
					    '<div class="msj-rta macro">' +
					    '<div class="text text-r">' +
					    '<p>' + message.msgText + '</p>' +
					    '<p><small>' + date + '</small></p>' +
					    '</div>' +
					    '</li>';
						$("#chatUl").append(control);
				}else{									//상대방이 나에게 보낼때 채팅창 왼쪽에 뜸
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
				elmnt.scrollTop=elmnt.scrollHeight;
			})
		}); 

	})
	
	function formatAMPM(date) { // 출력시간 포멧
			var month = date.getMonth()+1;
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
		control = '<li style="width:100%;">' +
		    '<div class="msj-rta macro">' +
		    '<div class="text text-r">' +
		    '<p>' + text + '</p>' +
		    '<p><small>' + date + '</small></p>' +
		    '</div>' +
		    '</li>';
		var message={};
		message.msgTo=1;
		message.msgFrom='${login.userNo}';
		message.userProfileImgPath = '${login.userProfileImgPath}';
		message.msgSendDate=new Date();
		message.msgReadDate=new Date();
		message.msgText=text;
		message.msgRoom='${login.userNo}';
		$("#chatUl").append(control);
		sockChat.send(JSON.stringify(message));
		var elmnt = document.getElementById("chatUl");
		elmnt.scrollTop=elmnt.scrollHeight;
 	}


	$(".mytext").on("keyup", function (e) {//엔터 누를시 메시지전송
	     if (e.which == 13) {
	         var text = $(this).val();
	         if (text !== "") {
	             insertChat("1", text);
	             $(this).val('');
	         }
	     }
	});
 
	$('.frame').on('click',function(event){//채팅창 클릭시 이벤트 막음
	 	event.stopPropagation();
	});
    
</script>