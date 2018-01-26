$(document).ready(function() {
	var formObj = $("form[role='form']");
	
	$('#allCheckFalBtn').on('click', function() { // 쪽지 모두 해제
		$('.check-remove').prop('checked', false);
	})
	$('#allCheckBtn').on('click', function() { // 쪽지 모두 선택
		$('.check-remove').prop('checked', true);
	})
	$('#removeBtn').on('click', function() { // 삭제버튼 클릭시 체크된 쪽지 제거
		event.preventDefault();
		var noteArr = new Array();
		var str = "";
		$('.check-remove:checked').each(function(index) {
			var that = $(this)
			var noteNo = that.val();
			str += "<input type='hidden' name='noteArr' value='" + noteNo + "'>";
		})
		if (str == "")
			return;
		
		var url = location.pathname;
		if(url.indexOf("cutOff") != -1)
			var con = confirm("정말 수신허용 하시겠습니까??");
		else
			var con = confirm("정말 삭제하시겠습니까??");
		if (con) {
			$('#form-submit').append(str);
			formObj.attr("action", "/note/noteRemove");
			formObj.attr("method", "post");
			formObj.submit();
		}
	});

	$(".userNick_link").on("click", function(event) {// userInfo 새창 띄우기
		var userNo = $(this).attr('data-no');
		event.preventDefault();
		window.open("/user/userInfo?userNo=" + userNo, "userInfo", "location=no, left=400px, top=100px, width=600px, height=700px");
	});

	$('.answear-btn').on('click', function() { // 답장 버튼 클릭시
		var target = $(this).attr('data-target');
		window.location.href = "/note/noteReg?noteTarget=" + target;
	})

	$('.cutOff-btn').on('click', function() { // 차단 버튼 클릭시
		var noteSender = $(this).attr('data-cut');/* 차단대상 */
		var noteSenderNick = $(this).attr('data-nick');
		$.ajax({
			type : 'post',
			url : '/note/noteCutOff',
			data : {noteSender : noteSender},
			success : function(result) {
				if (result == 'SUCCESS') {
					alert("[" + noteSenderNick + "] 님을 차단하였습니다")
				} else if (result == 'CUTOFF') {
					alert("이미 차단된 사용자입니다.");
				}
			},
			error : function(result) {
				alert('알 수 없는 오류로 차단을 실패하였습니다.')
			}
		});
	})

	$('.noteList').on('click', function() { // 쪽지 클릭시
		var that = $(this);
		var noteNo = that.siblings('.check-remove').val();
		var loginUserNo = userNo;
		$.ajax({
			type : 'post',
			url : '/note/noteRead',
			data : {noteNo : noteNo},
			success : function(result) {
				if (result == "SUCCESS") {
					sockNote.send(loginUserNo);
					that.css('color', 'darkgray');
				}
			},
			error : function(result) {
				alert('알 수 없는 오류가 발생했습니다.')
			}
		});
	})
	
	$("#meSend").change(function() { // 내게쓰기 클릭시
		if ($("#meSend").is(":checked")) {
			$("#noteTarget").val(userNick);
		}
		else
			$("#noteTarget").val("");
	});
	
	$("#sendNote").on("click", function() { // 쪽지보내기 클릭시
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
})