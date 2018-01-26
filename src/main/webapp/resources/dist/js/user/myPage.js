jQuery(function($) {
	
	/*서머노트*/
    $('#summernote').summernote({
    	toolbar: [
    	    // [groupName, [list of button]]
    	    ['style', ['bold', 'italic', 'underline', 'clear']],
    	    ['font', ['strikethrough', 'superscript', 'subscript']],
    	    ['fontsize', ['fontsize']],
    	    ['color', ['color']],
    	    ['para', ['ul', 'ol', 'paragraph']],
    	    ['height', ['height']]
    	],
    	placeholder: '자기 소개는500자 이내로 작성해 주세요.',
        tabsize: 4,
        height: 200,
        lang: 'ko-KR',
    });
    
    /*서머노트 텍스트제한*/
    $('#summernote').on('summernote.keyup',function (e) { 
		var tmpText=$(".note-editable").text();
        $('#counter').html($(".note-editable").text().length);
    })
    $('#summernote').on('summernote.paste',function (e) {
    	var tmpText=$(".note-editable").text();
        $('#counter').html($(".note-editable").text().length);
    })
    $(".note-editable").trigger('keyup');
    var chkBirth = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))$/; // 생년월일 검사식
    var chkName = /^[가-힣]+$/; // 이름 검사식
    var chkNick = /^[가-힣a-zA-Z0-9#]{1,20}$/; // 닉네임 검사식
    var chkPhone1 = /^[0-9]{2,3}$/; // 전화번호 앞 검사식
    var chkPhone2 = /^[0-9]{3,4}$/; // 중간자리 검사식
    var chkPhone3 = /^[0-9]{4}$/; // 마지막자리 검사식
    
    var chkPwd = /^[a-zA-Z0-9]{8,18}$/; // 비밀번호 검사식

    var ModiForm = $('#modifyForm'); // 프로필변경 폼 선택자
    var PwdForm = $('#changePwdForm'); // 비밀번호 변경 폼 선택자
    var userName = $('#userName'); // 이름 선택자
    var userNick = $('#userNick'); // 닉네임 선택자
    var userBirth = $('#userBirth'); // 생년월일 선택자
    var userPhone1 = $('#userPhone1'); // 폰 첫번째 선택자
    var userPhone2 = $('#userPhone2'); // 폰 두번째 선택자
    var userPhone3 = $('#userPhone3'); // 폰 세번째 선택자
    var checkNick = $('#resultNickCheck'); // 닉네임중복체크hidden

    var userPwd = $('#userPwd'); // 현재 비밀번호 선택자
    var userNewPwd = $('#newPwd'); // 새로운 비밀번호 선택자
    var userNewPwdChk = $('#newPwdChk'); // 새로운 비밀번호 선택자

    function validator() { // 새로운 비밀번호 값 비교
       if (userNewPwd.val() == userNewPwdChk.val())
          return true;
       else
          return false;
    }
    
    var nickModify = false;

    userNick.change(function() {
       checkNick.val("");
       nickModify = true;
    })
    
    function checkedRadio() {
       if ($('input:radio[name=userGender]').is(':checked'))
          return true;
       else
          return false;
    }
    
    /* 성별 정보 가져오기  */
    var userGender = $('#userGender').val();
    if(userGender == 'M'){
       $('input:radio[id=userGenderMan]').prop('checked', true);
    } else if(userGender == 'F') {
       $('input:radio[id=userGenderWoman]').prop('checked', true);
    }
    
    ModiForm.submit(function() { // 프로필 변경 유효성 검사
       if (chkName.test(userName.val()) != true) { // 이름 유효성 검사
          alert("이름 형식이 아닙니다.");
          userName.focus();
          return false;
       } else if (chkNick.test(userNick.val()) != true) { // 닉네임 유효성 검사
          alert("닉네임 형식이 아닙니다.");
          userNick.focus();
          return false;
       } else if (chkBirth.test(userBirth.val()) != true) { // 생년월일 유효성 검사
          alert("생년월일 형식이 아닙니다.");
          userBirth.focus();
          return false;
       } else if (checkedRadio() != true) { // 성별 NULL 유효성 검사
          alert("성별을 선택하세요");
          return false;
       }
    
       if (nickModify) {
          if (checkNick.val() == "") { // 닉네임 중복체크
             alert("닉네임 중복 확인을 해주세요");
             checkNick.focus();
             return false;
          } else if (checkNick.val() == "0") { // 닉네임 중복체크
             alert("중복된 닉네임 입니다. 닉네임을 다시 선택 하십시요");
             checkNick.focus();
             return false;
          }
       }
       
    });

    PwdForm.submit(function() { // 비밀번호 변경 유효성 검사
       if (userPwd.val() == "") {
          alert("현재 비밀번호를 입력하십시요.")
          userPwd.focus();
          return false;
       } else if (chkPwd.test(userPwd.val()) != true) { // 현재 비밀번호 유효성 검사
          alert("비밀번호 형식이 아닙니다.");
          userPwd.focus();
          return false;
       } else if (userNewPwd.val() == "") { // 새로운 비밀번호 유효성 검사
          alert("새로운 비밀번호를 입력하십시요.");
          userNewPwd.focus();
          return false;
       } else if (chkPwd.test(userNewPwd.val()) != true) { // 새로운 비밀번호 유효성 검사
          alert("비밀번호 형식이 아닙니다.");
          userNewPwd.focus();
          return false;
       } else if (userNewPwdChk.val() == "") { // 새로운 비밀번호 유효성 검사
          alert("새로운 비밀번호를 입력하십시요.");
          userNewPwdChk.focus();
          return false;
       } else if (validator() != true) { // 비밀번호 일치 검사
          alert("새로운 비밀번호가 일치하지 않습니다.");
          userNewPwdChk.focus();
          return false;
       }
    });
    
    $('#nickCheck').click(function() {
       var nickCheck = userNick.val(); // 아이디 값
       if ('${login.userNick}'!=nickCheck){
          if (chkNick.test(nickCheck) != true) { // 닉네임 유효성 검사
             alert("닉네임 형식이 아닙니다.");
             userNick.focus();
             return false;
          }

          $.ajax({
             type : 'POST',
             url : '/user/checkNick',
             data : {
                "userNick" : nickCheck
             },
             success : function(data) {
                if ($.trim(data) == 0) {
                   alert("사용 가능한 닉네임 입니다.");
                   checkNick.val('1');
                } else if ($.trim(data) == 1) {
                   alert("중복된 닉네임 입니다.");
                   checkNick.val('0');
                } else {
                   alert("닉네임을 입력하세요.")
                   checkNick.val('0');
                }
             }
          });
       }else
          alert("닉네임을 변경 후 중복확인 버튼을 눌러주세요.");
    });
 });

$(document).ready(function() {
	var imgPath = $('#defaultImg').attr('data-src');
	var fileInfo = getFileInfo(imgPath);

	var authCheck = $('#userCertification').eq(true); 
	if (authCheck == 'true') // 인증했을경우 휴대폰번호 잠금
		$("input[name=phoneNumber]").attr("readonly", true);

	$("#profileImg").attr("src", fileInfo.imgsrc); //db에서 불러오는 값

	$("#userFile").change(function(event) {
		var formData = new FormData();
		var fileName = $("input[name=file]")[0].files[0].name;
		var formatName = (fileName.substring(fileName.lastIndexOf('.') + 1, fileName.length)).toUpperCase();
		if ((($("#userFile")[0].files[0]) == null) || checkImageType(formatName) == null) {
			$("#userFile").val("");
			alert("이미지 파일을 선택해주세요");
			return;
		}
		formData.append("file", $("input[name=file]")[0].files[0]);//파일의 정보를 formData에 삽입 
		formData.append("profileFlag", "profileFlag");
		if (imgPath != "s_user.jpg") {
			$.ajax({ //resources 파일 폴더에 삭제
				type : "post",
				url : "/deleteFile",
				data : {
					'fileName' : $("#profileImg").attr("src")
				},
				success : function(result) {

				}
			});
		}

		$.ajax({ //resources 파일 폴더에 생성
			type : "post",
			url : "/uploadAjax",
			dataType : "text",
			data : formData,
			processData : false,
			contentType : false,
			success : function(result) { //result는 파일명
				if (result) { //폴더에 사진 업로드가 성공하면 사진 경로가 
					$("#profileImg").attr("src", "/displayFile?fileName=" + result); //미리보기 이미지
				} else {
					alert("Image File please");
				}
			}
		});
	});

	$('.userLeave').on("click", function() { // 회원탈퇴
		
		var result = confirm("정말 탈퇴 하시겠습니까? \n탈퇴 후 복구는 불가능합니다.");
		
		if (result) {
			$.ajax({
				type : 'POST',
				url : '/user/delete',
				success : function(data) {
					location.reload();
				}
			});
		} else
			return;
	});

	$('#user-img-upload').on('click', function() {
		$('#userFile').trigger('click');
	});

	var additionalInfoForm = $('#additionalInfoForm'); // 부가정보 폼 선택자

	additionalInfoForm.submit(function() {
		if ($(".note-editable").text().length>500){
			alert("자기소개는 500자 이내로 적어주세요");
			$(".note-editable").focus();
			return false;
		}
		var that = $(this);
		
		var str = "";
			
		/* 카테고리 대분류  */
		if ($(".content0 input[type=checkbox]").is(':checked')) {
			str += "<input type='hidden' name='userFavUpCategory' value='영어'>";
		}
		if ($(".content1 input[type=checkbox]:checked").is(':checked')) {
			str += "<input type='hidden' name='userFavUpCategory' value='외국어'>";
		}
		if ($(".content2 input[type=checkbox]:checked").is(':checked')) {
			str += "<input type='hidden' name='userFavUpCategory' value='IT'>";
		}
		if ($(".content3 input[type=checkbox]:checked").is(':checked')) {
			str += "<input type='hidden' name='userFavUpCategory' value='교양'>";
		}
		if ($(".content4 input[type=checkbox]:checked").is(':checked')) {
			str += "<input type='hidden' name='userFavUpCategory' value='공무원'>";
		}

		that.append(str);
		that.get(0).submit();
	});

	/* 카테고리 체크된 상태 가져오기 */
	var names = document.getElementsByName('userFavCategory');

	var tmp = $('#userFavCategory').val();
	var cat_values = tmp.split(',');

	for (let i = 0; i < names.length; i++) {
		for (let j = 0; j < cat_values.length; j++) {
			if (names[i].value == cat_values[j]) {
				names[i].setAttribute('checked', 'checked');
			}
		}
	}

	$("[name='userFavCategory']").each(function(index) {
		if ($(this).prop('checked')) {
			var upCategory = $(this).parents('.list').attr('id');
			var downCategory = $(this).parents('.list');
			var aUpCategory = $('.' + upCategory).children('a');
			aUpCategory.removeClass('collapsed');
			aUpCategory.attr('aria-expanded', true);
			downCategory.attr('aria-expanded', true);
			downCategory.addClass('in');
		}
	})

	/* 카테고리 5개 체크 제한 */
	if ($("input:checkbox[name=userFavCategory]:checked").length >= 5)
		$("input:checkbox[name=userFavCategory]:not(:checked)").attr("disabled", "disabled");
	$("input:checkbox[name=userFavCategory]").change(function() {
		if ($("input:checkbox[name=userFavCategory]:checked").length >= 5)
			$("input:checkbox[name=userFavCategory]:not(:checked)").attr("disabled", "disabled");
		else
			$("input:checkbox[name=userFavCategory]").removeAttr("disabled");
	});

	/* 지역 대분류 선택된 상태 가져오기 */
	var upRegions = document.getElementsByName('upRegion');
	var studyUpRegion = $('#userFavUpRegion').val();
	var studyDownRegion = $('#userFavDownRegion').val();

	for (let i = 0; i < upRegions.length; i++) {
		if (upRegions[i].value == studyUpRegion) {
			upRegions[i].setAttribute('selected', 'selected');
			/* 지역 소분류 선택된 상태 가져오기 */
			subRegion(studyUpRegion);
			var downRegions = document.getElementsByName('subRegion');
			for (let j = 0; j < downRegions.length; j++) {
				if (downRegions[j].value == studyDownRegion)
					downRegions[j].setAttribute('selected', 'selected');
			}
		}
	}

	var phoneCheck = false;
	var timer;
	$('#phoneCheck').on("click", function() { // 휴대폰 인증
		var userPhone = $("#userPhone1").val() + "," + $("#userPhone2").val() + "," + $("#userPhone3").val(); // 휴대폰번호 전체
		var userPhoneSMS = $("#userPhone1").val() + $("#userPhone2").val() + $("#userPhone3").val(); // 문자보낼때 휴대폰번호
		var userPhone1 = $('#userPhone1'); // 휴대폰번호 앞자리
		var userPhone2 = $('#userPhone2'); // 휴대폰번호 중간자리
		var userPhone3 = $('#userPhone3'); //휴대폰번호 뒷자리
		var chkPhone1 = /^[0-9]{2,3}$/; // 전화번호 앞 검사식
		var chkPhone2 = /^[0-9]{3,4}$/; // 중간자리 검사식
		var chkPhone3 = /^[0-9]{4}$/; // 마지막자리 검사식

		if (userPhone1.val() == "") { // 전화번호 NULL 검사
			alert("전화번호를 입력하십시요");
			userPhone1.focus();
			return false;
		} else if (chkPhone1.test(userPhone1.val()) != true) { // 전화번호 유효성 검사
			alert("전화번호 형식이 아닙니다.");
			userPhone1.focus();
			return false;
		} else if (userPhone2.val() == "") { // 전화번호 NULL 검사
			alert("전화번호를 입력하십시요");
			userPhone2.focus();
			return false;
		} else if (chkPhone2.test(userPhone2.val()) != true) { // 전화번호 유효성 검사
			alert("전화번호 형식이 아닙니다.");
			userPhone2.focus();
			return false;
		} else if (userPhone3.val() == "") { // 전화번호 NULL 검사
			alert("전화번호를 입력하십시요");
			userPhone3.focus();
			return false;
		} else if (chkPhone3.test(userPhone3.val()) != true) { // 전화번호 유효성 검사
			alert("전화번호 형식이 아닙니다.");
			userPhone3.focus();
			return false;
		}

		$.ajax({ // 휴대폰인증
			type : 'POST',
			url : '/user/phoneDuplicate',
			data : {
				"userPhoneNumber" : userPhone
			},
			success : function(data) {
				if ($.trim(data) == "success") {
					phoneAuth(userPhoneSMS);
					phoneCheck = true;
					$('#phoneCheck').attr("disabled", true);
				} else
					alert("이미 인증된 휴대폰 번호 입니다. \n다른 휴대폰번호를 입력하세요.");
			}
		});

	});

	$("#authCodeBtn").on("click", function() { // 인증번호 체크
		var userPhoneSMS = $("#userPhone1").val() + $("#userPhone2").val() + $("#userPhone3").val(); // 문자보낼때 휴대폰번호
		var userPhone = $("#userPhone1").val() + "," + $("#userPhone2").val() + "," + $("#userPhone3").val(); // 휴대폰번호 전체
		var authCode = $("#authCode").val();

		if (phoneCheck == true) {
			$.ajax({
				type : 'POST',
				url : '/user/authCodeCheck',
				data : {
					"phoneCheck" : userPhoneSMS,
					"authCode" : authCode,
					"userPhoneNumber" : userPhone
				},
				success : function(data) {
					if ($.trim(data) == "success") {
						alert("인증을 성공하였습니다.");
						$("#authCode").attr("readonly", true);
						$('.timer').empty().addClass('timer').text('인증을 완료 했습니다.');
						$('#authCodeBtn').attr('disabled', true);
						clearInterval(timer); // 타이머 종료 
					} else
						alert("인증번호가 다릅니다. 다시 입력해주세요.");
				}
			});
		} else {
			alert("잘못된 접근입니다.");
		}
		;
	});

	function phoneAuth(userPhone) {
		$.ajax({
			type : 'POST',
			url : '/user/sendSMS',
			data : {
				"userPhoneNumber" : userPhone
			},
			success : function(data) {
			}
		});

		$(".authCode").show();
		$(".number input[name=phoneNumber]").attr("readonly", true);

		var minute = 3;
		var second = 0;
		$('#timerMinutes').text(minute);
		$('#timerSecond').text(second);
		timer = setInterval(function() {
			if (second == 0 && minute == 0) {
				$('.timer').empty().addClass('finish').text('시간이 종료되었습니다. 새로고침 후 다시 시도해주세요.');
				$('#authCodeBtn').attr('disabled', true);
				clearInterval(timer); // 타이머 종료 
			} else {
				second--; // 분처리
				if (second < 0) {
					minute--;
					second = 59;
				}
			}
			$('#timerMinutes').empty().text(minute);
			$('#timerSecond').empty().text(second);
		}, 1000);
	}

});

var target = $('#target').val();
window.onload = tabLoad(target);
function tabLoad(target) {
	if (target == 2) {
		$('#profileBtn').removeClass('active');
		$('#profile').removeClass('active');
		$('#additionalInfoBtn').addClass('active');
		$('#additionalInfo').addClass('active');
	} else if (target == 3) {
		$('#profileBtn').removeClass('active');
		$('#profile').removeClass('active');
		$('#changePwdBtn').addClass('active');
		$('#password').addClass('active');
	}
}