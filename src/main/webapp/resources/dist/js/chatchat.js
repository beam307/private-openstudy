function insertChat(who, sender, text) { //메시지 전송
	var control = "";
	var date = formatAMPM(new Date());
	control = '<li style="width:100%;">' + 
	'<div class="msj-rta macro">' +
	'<div class="text text-r">' + 
	'<p>' + text + '</p>' +
	'<p><small>' + date+ '</small></p>' + 
	'</div>' + 
	'</li>';
	var message = {};
	message.msgTo = who;
	message.msgFrom = sender;
	message.userProfileImgPath = userProfileImgPath;
	message.msgSendDate = new Date();
	message.msgReadDate = new Date();
	message.msgText = text;
	var room='';
	if(sender==1)
		room=who;
	else
		room=sender;
	message.msgRoom = room;
	if(who==1)who='';
	$("#chatUl" + who).append(control);
	sockChat.send(JSON.stringify(message));
	var elmnt = document.getElementById("chatUl" + who);
	elmnt.scrollTop = elmnt.scrollHeight;
}

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
