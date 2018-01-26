$(document).ready(function() {
	
	$('#alarm-btn').on('click', function(event) { // 알람 버튼 클릭시
		event.preventDefault();
		$('#alarm-list').css('display', '');
		alarmTarget = userNo;
		if (alarmTarget != "") {
			$.getJSON("/alarm/all/" + alarmTarget, function(list) {
				$('#alarm-list').html("");
				if (list.length == 0) {
					$('#alarm-list').append("<li>알람이 없습니다.</li>");
					return;
				}
				$(list).each(function(index, data) {
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
										+ "<div class='col-md-10'><p><b>" + sender + "</b>님이<br/><b class='studyName'>" + studyName+ "</b>에 신청하였습니다.</p>"
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
									+ "<a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"'>"
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

	$(document).on('click', '.check-alarm', function(event) { // 각각 알림창 클릭시 읽기상태 변경
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

	$(document).on('click', '.note-alarm', function(event) { // 알림창중 쪽지알림 클래스있으면 쪽지보내기창 띄우기
		window.open(this.href, 'alarmNote', 'location=no, width=670, height=700, left=800, top=50');
		return false;
	});
});
if(loginState == "true") {
	sockNote(); 
	sockAlarm();
}

function sockNote() {
	var wsUri = '/note';
	sockNote = new SockJS(wsUri);
	sockNote.onopen = function(evt) {
		sockNote.send(userNo);
	};
	
	sockNote.onmessage = function(evt) {
		$('#countNote').html(evt.data);
	};
	sockNote.onclose = function(){
		
	}
	
	sockNote.onerror = function(evt) {
	    alert(evt);
	};
};

function sockAlarm() {
	var wsUri = '/user';
	sockAlarm = new SockJS(wsUri);
	sockAlarm.onopen = function(evt) {
		sockAlarm.send(userNo);
	};
	
	sockAlarm.onmessage = function(evt) {
		$('#countAlarm').html(evt.data);
		var alarmTarget = userNo;
		if(alarmTarget != "") {
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
						$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage\?target=2'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
								+"<span> '"+studyName+"' </span>에 신청하였습니다.<small>"+regDate+"</small></a></li>");
					}else if(flag==2){// 스터디 신청취소
						$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage\?target=2'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
								+"<span> '"+studyName+"' </span>에 신청을 취소하였습니다.<small>"+regDate+"</small></a></li>");
					}else if(flag==3){// 북마크등록
						$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
								+"<span> '"+studyName+"' </span>을 북마크에 등록하였습니다.<small>"+regDate+"</small></a></li>")
					}else if(flag==4){// 댓글 등록
						$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/study/studyView?&studyNo="+studyNo+"'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
								+" 스터디에 댓글을 남겼습니다.<small>"+regDate+"</small></a></li>");
					}else if(flag==5){// 참여 신청
						$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm "+aClass+"' href='/user/studyManage?target=3'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
								+"<span> '"+studyName+"' </span>에 참여신청이 승인되었습니다.<small>"+regDate+"</small></a></li>");
					}else if(flag==6){// 참여신청 거절
						$('#alarm-list').append("<li><a data-alarmNo='"+alarmNo+"' class='check-alarm note-alarm "+aClass+"' href='/note/noteList'><img class='alarm-PR' src='/displayFile?fileName="+senderPRImgPath+"'></img><span> '"+sender+"' </span>님이"
								+"<span> '"+studyName+"' </span>에 참여신청을 거절하였습니다.(쪽지확인)<small>"+regDate+"</small></a></li>");
					}else if(flag==7){// 스터디 완료
						$('#alarm-list').append(
								"<li><a data-alarmNo='"+alarmNo+"' class='check-alarm note-alarm "+aClass+"' href='/study/studyEndView?studyNo="+studyNo+"'><img class='alarm-PR' src='/displayFile?fileName="
										+ senderPRImgPath + "'></img><span> '" + sender + "' </span>님이" + "<span> '" + studyName + "' </span>을 완료하였습니다<small>" + regDate + "</small></a></li>");
					}else{
						alert('알람에러입니다');
					}
				});
			});
		};
	};
	
	sockAlarm.onclose=function(){
	};
	
	sockAlarm.onerror = function(evt) {
	};
}
