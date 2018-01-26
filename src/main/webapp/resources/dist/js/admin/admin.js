var adminPwd = $('#adminPwd'); // 현재 비밀번호 선택자

$(window).load(function() {
	$('.form-group input').on('focus blur', function(e) {
		$(this).parents('.form-group').toggleClass('active', (e.type === 'focus' || this.value.length > 0));
	}).trigger('blur');
	$('.animate').scrolla();
});
	
	
	
	
var adminPwd = $('#adminPwd'); // 현재 비밀번호 선택자
var adminNewPwd = $('#adminNewPwd'); // 새로운 비밀번호 선택자
var adminCheckPwd = $('#adminCheckPwd'); // 새로운 비밀번호 선택자
   
function validator() { // 새로운 비밀번호 값 비교
   if (adminNewPwd.val() == adminCheckPwd.val())
      return true;
   else
      return false;
}
	   
$(window).load(function() {
   $('.form-group input').on('focus blur', function(e) {
      $(this).parents('.form-group').toggleClass('active', (e.type === 'focus' || this.value.length > 0));
   }).trigger('blur');
   $('.animate').scrolla();
});
	      
	     
	      
			
				
$(document).on("click", "#adminStudyDelete", function() {
	var studyNo = $(this).parent().siblings('#studyNo').html();

	var result = confirm("정말 삭제 시키겠습니까?");
	
	if (result == true) {
		$.ajax({
			type : 'post',
			url : '/admin/studyDelete',
			data : {'studyNo' : studyNo},
			success : function() {
				location.reload();
			}
		});
	} else
		return;
});

$(document).on("click", "#adminStudyDeleteCancel", function() {
	var studyNo = $(this).parent().siblings('#studyNo').html();

	var result = confirm("정말 삭제취소 하시겠습니까?");

	if (result == true) {
		$.ajax({
			type : 'post',
			url : '/admin/studyDeleteCancel',
			data : {'studyNo' : studyNo},
			success : function() {
				location.reload();
			}
		});
	} else
		return;
});
				
				
				
				
				
$(document).on("click", "#adminUserDelete", function() { // 탈퇴 버튼 클릭시 
	var userNo = $(this).parent().siblings('#userNo').html();

	var result = confirm("정말 탈퇴 시키겠습니까?");

	if (result == true) {
		$.ajax({
			type : 'post',
			url : '/admin/userDelete',
			data : {
				'userNo' : userNo
			},
			success : function() {
				location.reload();
			}
		});
	} else
		return;
});

$(document).on("click", "#adminUserCancel", function() { // 철회 버튼 클릭시 
	var userNo = $(this).parent().siblings('#userNo').html();

	var result = confirm("정말 탈퇴를 철회 하시겠습니까?");

	if (result == true) {
		$.ajax({
			type : 'post',
			url : '/admin/userDeleteCancel',
			data : {
				'userNo' : userNo
			},
			success : function() {
				location.reload();
			}
		});
	} else
		return;
});

$(document).on("click", "#adminUserHalt", function() { // 정지 버튼 클릭시 
	var userNo = $(this).parent().siblings('#userNo').html();
	var adminUserHalt = $('#adminUserHalt');
	var result = prompt("정지 기간을 일수로 설정 해주세요. (0 이하로 입력시 정지 해제)");
	if (result) {
		result = parseInt(result); // 정수 반환

		if (isNaN(Number(result))) {
			alert('숫자를 입력하세요');
			return;
		}
		$.ajax({
			type : 'post',
			url : '/admin/userHalt',
			data : {
				'userNo' : userNo,
				'haltTime' : result
			},
			success : function() {
				location.reload();
			}
		});
	};
});

$(document).on("click", "#adminUserHaltCancel", function() { // 정지 버튼 클릭시 
	var userNo = $(this).parent().siblings('#userNo').html();
		$.ajax({
			type : 'post',
			url : '/admin/userHalt',
			data : {
				'userNo' : userNo,
				'haltTime' : 0
			},
			success : function() {
				location.reload();
			}
		});
});