$(document).ready(function() {
	var formObj = $("form[role='form']");

	/* 삭제버튼 클릭시  */
	$("#deleteBtn").on("click", function() {
		var arr = [];
		$("#img-slide img").each(function(index) {
			arr.push($(this).attr("data-src"));
		});

		if (arr.length > 0) {
			$.post("/deleteAllFiles", {
				files : arr
			});
		}
		formObj.attr("action", "/study/studyRemove");
		formObj.submit();
		alert('스터디를 삭제하였습니다.');
	});

	/* 수정버튼 클릭시  */
	$("#modifyBtn").on("click", function() {
		formObj.attr("action", "/study/studyModify");
		formObj.attr("method", "get");
		formObj.submit();
	});

	/* 목록으로버튼 클릭시  */
	$("#goListBtn").on("click", function() {
		if ($('#goStudyManage').val() != "") {
			if($('#goStudyManageTap').val() == 2)
				location.href = "/user/studyManage?target=2";
			else if ($('#goStudyManageTap').val() == 3)
				location.href = "/user/studyManage?target=3";
			else
				location.href = "/user/studyManage";
		}
		else {
			formObj.attr("method", "get");
			formObj.attr("action", "/study/studyList");
			formObj.submit();
		}
		
	});

	var studyNo = $('#select-no').val();

	var template = Handlebars.compile($("#templateAttach").html());

	/* 제이슨으로 이미지 파일 불러오기  */
	$.getJSON("/study/getImg/" + studyNo, function(list) {
		$(list).each(function(index) {
			var fileInfo = getFileInfo(this);
			if (index == 0) {
				$("#img-slide").append("<div class='item active'><img src="+fileInfo.imgsrc+" alt='스터디 이미지'></div>");
				$("#img-slide-target").append("<li data-target='#carousel-example-generic' data-slide-to="+index+" class='active'></li>");
			} else {
				$("#img-slide").append("<div class='item'><img src="+fileInfo.imgsrc+" alt='스터디 이미지'></div>");
				$("#img-slide-target").append("<li data-target='#carousel-example-generic' data-slide-to="+index+"></li>");
			}
			/* var html = template(fileInfo);
			$(".uploadedList").append(html); */
		});
	});

	/* upCategory 출력 */
	var upCategoryStr = $('#upCategory').val();
	var upCategoryArr = upCategoryStr.split(',');
	var uniq = upCategoryArr.slice().sort(function(a, b) { //복사본 생성
		return a - b;
	}).reduce(function(a, b) {
		if (a.slice(-1)[0] !== b)
			a.push(b); // slice(-1)[0] 을 통해 마지막 아이템을 가져온다.
		return a;
	}, []); //a가 시작될 때를 위한 비어있는 배열

	for (let i = 0; i < uniq.length; i++) {
		$("#output-upCategory").append("<div class='view-category'>" + uniq[i] + "</div>");
	}

	
	
	/* 댓글 로그인 사용자 구분 */
	Handlebars.registerHelper("eqReplyer", function(replyVO, block) {
		var accum = '';
		if (replyVO.userNick == $('#userNick').val())
			accum += block.fn(replyVO);
		return accum;
	});
	/* 댓글 로그인 사용자 구분else  */
	Handlebars.registerHelper("eqReplyerElse", function(replyVO, block) {
		var accum = '';
		if (replyVO.userNick != $('#userNick').val())
			accum += block.fn(replyVO);
		return accum;
	});

	/* 댓글 시간  */
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	/* 템플릿에 적용  */
	var printData = function(replyArr, target, templateObject) {
		var template = Handlebars.compile(templateObject.html());
		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);
	};

	var replyPage = 1;

	/* 댓글 페이징처리된 리스트 출력  */
	function getPage(pageInfo) {
		var login = $('#userNo').val();
		var writer = $('#studyWriter').val();
		$.getJSON(pageInfo, function(data) {
			if (login != '') {
				if (login != writer) {
					printData(data.list, $("#repliesDiv"), $('#template'));
					printPaging(data.pageMaker, $(".pagination"));
				} else {
					printData(data.list, $("#repliesDiv"), $('#template2'));
					printPaging(data.pageMaker, $(".pagination"));
				}
			} else {
				printData(data.list, $("#repliesDiv"), $('#template'));
				printPaging(data.pageMaker, $(".pagination"));
			}
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");
		});
	};

	/* 댓글 페이징 처리  */
	var printPaging = function(pageMaker, target) {
		var str = "";
		if (pageMaker.prev)
			str += "<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}
		if (pageMaker.next)
			str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
		target.html(str);
	};

	/* jsp에 댓글 출력  */
	if ($(".timeline li").size() > 1) {
		return;
	}
	getPage("/replies/" + studyNo + "/1");

	/* 댓글  페이징출력 */
	$(".pagination").on("click", "li a", function(event) {
		event.preventDefault();
		replyPage = $(this).attr("href");
		getPage("/replies/" + studyNo + "/" + replyPage);
	});

	/* 댓글 추가 */
	$("#replyAddBtn").on("click", function() {
		var replytextObj = $("#newReplyText");
		var replySecretObj = $("#newReplySecret");
		var writer = $('#studyWriter').val();
		
		var replyer = $('#userNo').val();
		var replyText = replytextObj.val();
		var replySecret = replySecretObj.is(':checked');
		if (replyText != "") {
			$.ajax({
				type : 'post',
				url : '/replies/',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					studyNo : studyNo,
					userNo : replyer,
					studyWriter : writer,
					replyText : replyText,
					replySecret : replySecret,
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						replyPage = 1;
						getPage("/replies/" + studyNo + "/" + replyPage);
						sockAlarm.send(writer);
						replytextObj.val("");
						replySecretObj.attr('checked', false);
					}
				}
			});
		} else {
			alert("댓글을 입력해주세요");
			return;
		}

	});

/* 	$(document).on('click', '#replyModifyBtn', function() {
		if($(this).parents('.timeline-item').has('.fa-lock').length > 0) // 비밀 글 일 경우
			var input = '<input type="text" class="form-control reply-modify" value="" id="modifyInput" maxlength="200">'
				+'<label><input type="checkbox" id="modifyReplySecret" checked><i class="fa fa-lock" aria-hidden="true"></i> 비밀글</label>'; // input박스
				
		else // 비밀글이 아닐 경우
			var input = '<input type="text" class="form-control reply-modify" value="" id="modifyInput" maxlength="200">'
						+'<label><input type="checkbox" id="modifyReplySecret"><i class="fa fa-lock" aria-hidden="true"></i> 비밀글</label>'; // input박스
						
		var inputBtn = '<button class="btn btn-primary replyModifyBtn" type="button" id="replyModBtn">수정</button>' // 수정버튼
						+ '<button type="button" class="btn btn-default replyModifyBtn" id="replyCancel">취소</button>'; // 취소버튼
		
		var reply = $(this); // 현재 리플위치
		var replySelect = reply.parent().siblings('#changeInput'); // 리플 텍스트 div
		var replyText = reply.parent().parent().find('#changeInput').text(); // 리플 텍스트 안에 글

		if (replySelect.find('#modifyInput').length != 1) { // 리플이 input 박스가 아닐 경우
			replySelect.empty();
			replySelect.siblings('#replyModityBtn').empty();
			replySelect.append(input);
			replySelect.siblings('#replyModityBtn').append(inputBtn);
			replySelect.find('#modifyInput').attr("value", replyText);
		}
	});		 */

	/* 댓글 수정으로 변경  */
	$(document).on('click', '#replyModifyBtn', function() {
		var that = $(this);
		var target = that.parents('.replyLi').hide(); // 기존 리플 삭제
		var secretCheck; // 비밀글 체크
		if(that.parents('.replyLi').has('.fa-lock').length > 0)
			secretCheck = true;
		var template = Handlebars.compile($("#modifyTemplate").html()); // 댓글수정 템플릿
		var data = {
			replyNo : that.parents('.replyLi').attr('data-rno'),
			replyRegDate : that.parent().siblings('.time').html(),
			userNick : $('#userNick').val(),
			replyText : that.parent().siblings('#changeInput').html(),
			replySecret : secretCheck
		};
		if(that.parents('.timeline').has('.modifyReply').length > 0) {
			that.parents('.timeline').children().show(); // 
			that.parents('.replyLi').hide();
			that.parents('.timeline').children('.modifyReply').remove();
		}
		target.after(template(data)); // 바로옆에 리플 템플릿 추가하기
	});	
	
	/* 댓글 수정 */
	$(document).on("click", '#replyModBtn', function() {
		var replyNo = $(this).parents('.replyLi').attr("data-rno");
		var replyText = $(this).parents('#replyModityBtn').siblings('#changeInput').children('#modifyInput').val();
		var replySecret = $("#modifyReplySecret").is(':checked');
		
		$.ajax({
			type : 'put',
			url : '/replies/' + replyNo,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			data : JSON.stringify({
				replyText : replyText,
				replySecret : replySecret
			}),
			dataType : 'text',
			success : function(result) {
				if (result == 'SUCCESS')
					getPage("/replies/" + studyNo + "/" + replyPage);
			}
		});
	});

	/* 댓글 수정 취소 */
	$(document).on('click', '#replyCancel', function() {
		getPage("/replies/" + studyNo + "/" + replyPage); // 원래 페이지 복구
	});

	/* 댓글 삭제  */
	$(document).on("click", '#replyDeleteBtn', function() {
		var replyNo = $(this).parents('.replyLi').attr("data-rno");

		$.ajax({
			type : 'delete',
			url : '/replies/' + replyNo,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			data : JSON.stringify({studyNo : studyNo}),
			dataType : 'text',
			success : function(result) {
				if (result == 'SUCCESS') {
					alert("삭제 되었습니다.");
					getPage("/replies/" + studyNo + "/" + replyPage);
				}
			}
		});
	});
	
	
	
	var applyDiv = $('#applyDiv');
	/* 스터디 신청 클릭 */
	$(document).on("click", "#studyJoinBtn", function() {
		var curNum = parseInt($('#studyCurMemCnt').val());
		var maxNum = parseInt($('#studyMaxMemCnt').val());
		var userNick = $('#userNick').val();
		var writer = $('#studyWriter').val();
		var userName = $('#userName').val();
		var userBirth = $('#userBirth').val();
		var userPhoneNumber = $('#userPhoneNumber').val();

		if (!(curNum < maxNum)) {
			alert("최대신청인원을 초과했습니다.");
			return;
		} else if (userNick == writer)
			alert("자신의 클래스는 신청할 수 없습니다.")
		else {
			$.ajax({
				type : 'post',
				url : '/study/applyStudy',
				data : {
					"studyNo" : studyNo,
					"studyWriter" : writer	
				},
				success : function(data) {
					if ((data == 'success') && !(userName == null && userBirth == null && userPhoneNumber == null) ) {
						alert("[" + $('#studyName').val() + "] 스터디 신청을 하였습니다.");
						applyDiv.empty();
						applyDiv.append('<button id="studyCancelBtn" type="submit" class="view-btn btn btn-primary">신청취소</button>');
						sockAlarm.send(writer);
						location.href = '/user/studyManage?target=3';
					} else {
						alert("개인정보가 부족하여 스터디 신청을 할수 없습니다. \n마이페이지에서 개인정보를 입력해주세요.");
						location.href = '/user/myPage';
					}
				}
			});
		}
	});

	/* 신청취소 클릭시  */
	$(document).on("click", "#studyCancelBtn", function() {
		var writer = $('#studyWriter').val();
		$.ajax({
			type : 'post',
			url : '/study/cancelStudy',
			data : {
				"studyNo" : studyNo,
				"studyWriter" : writer
			},
			success : function(data) {
				alert("[" + $('#studyName').val() + "] 스터디를 취소 하였습니다.");
				applyDiv.empty();
				applyDiv.append('<button id="studyJoinBtn" type="submit" class="view-btn btn btn-primary">신청하기</button>');
				sockAlarm.send(writer);
			}
		});
	});

	/* 완료버튼 클릭시  */
	$("#studyEndBtn").on("click", function() {
		var result = confirm('정말 스터디를 완료 시키겠습니까? 완료시 취소는 불가 합니다.');
		var studyNo = $('#studyNo').val();
		
		if(result){
			$.ajax({
				type : 'post',
				url : '/study/endStudy',
				data : { "studyNo" : studyNo },
				success : function(data){
						for(let i=0; i<data.length;i++){
							sockAlarm.send(data[i]);
							}
						location.href="/user/studyManage?target=4";
				},
				error : function(data){
					console.log(data)
					if(data.status=='500')
						alert('시작날짜 이후로 완료를 할수 있습니다.');
					else
						alert('알수 없는오류가 발생하였습니다!');
				}
			});
		}
	});
	
	/* 즐겨찾기 버튼 클릭시 */
	$('#favStudy').on("click", function() {
		var writer = $('#studyWriter').val();
		
		$.ajax({
			type : 'post',
			url : '/study/favoriteStudy',
			data : { "studyNo" : studyNo, "studyWriter" : writer },
			success : function(data) {
				if ($.trim(data) == 0) {
					$('#favIcon').attr('class','fa fa-heart-o');
					alert("[" + $('#studyName').val() + "] 스터디를 즐겨 찾기를 삭제하였습니다.");
				} else {
					$('#favIcon').attr('class','fa fa-heart');
					sockAlarm.send(writer);
					alert("[" + $('#studyName').val() + "] 스터디를 즐겨 찾기를 추가하였습니다.");
				}

			}
		});
	});
	
	/*드롭다운*/
	$('.dropdown-toggle').dropdown();
	$('#myDropdown').on('show.bs.dropdown', function() {
		// do something…
	})
});