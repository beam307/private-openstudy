<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/headerSub.jsp"%>

<div class="mypage_bg">
	<div class="mypage container">
		<ul class="nav nav-tabs mypage_nav" role="tablist">
			<li role="presentation" class="active"><a href="/user/myPage">개인정보관리</a></li>
			<li role="presentation"><a href="/user/studyManage">스터디관리</a></li>
		</ul>

		<!-- Tab panes -->
		<div role="tabpanel" class="tab-pane active" id="myinfo">
			<div class="tabpanel-in" role="tabpanel">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li id="profileBtn" role="presentation" class="active profile"><a href="#profile" aria-controls="home" role="tab" data-toggle="tab">프로필</a></li>
					<li id="additionalInfoBtn" role="presentation" class="profile"><a href="#additionalInfo" aria-controls="additionalInfo" role="tab" data-toggle="tab">부가정보</a></li>
					<c:if test="${fn:contains(login.userEmail,'@')}">
						<li id="changePwdBtn" role="presentation" class="profile"><a href="#password" aria-controls="password" role="tab" data-toggle="tab">비밀번호변경</a></li>
					</c:if>
					<li id="withdrawalBtn" role="presentation" class="profile"><a href="#withdrawal" aria-controls="withdrawal" role="tab" data-toggle="tab">회원탈퇴</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
					<div role="tabpanel" class="tab-pane active" id="profile">
						<div class="col-xs-12">
							<h4>프로필 사진</h4>
							<div class="col-xs-12 tab-content-in">
								<div class="user-img col-md-2 col-xs-8" id="user-img-upload">
									<img id="profileImg" src=""> 
								</div>
								<div class="user-img-btn">
									<div>
										<i class="fa fa-upload" aria-hidden="true"></i>
									</div>
									<input type='file' id="userFile" name="file"> 
									<input type="hidden" id="defaultImg" data-src='${UserVO.getUserProfileImgPath()}'>
								</div>
								<div class="col-md-10 col-xs-12 user-img-text">
									<div>
										회원님의 정면 사진을 올려주세요! <br/>
										상대방이 신뢰를 갖고 연락 할 확률이 높아질 거예요.
									</div>
								</div>
							</div>
						</div>
						<form class="tab-content-in" action="/user/myPage" method="post" id="modifyForm">
							<div class="col-xs-12">
								<h4 class="user_info">계정정보</h4>
								<label class="control-label">이메일</label>
								<div class="form-group-box">
									<div class="form-group label-floating">
										<input id="userEmail" name="userEmail" type="text" class="form-control" value="${UserVO.getUserEmail()}" readonly>
									</div>
								</div>
								<label class="control-label">이름</label>
								<div class="form-group-box">
									<div class="form-group label-floating">
										 <input id="userName" name="userName" type="text" class="form-control" value="${UserVO.getUserName()}">
									</div>
								</div>
								<label class="control-label">닉네임</label>
								<div class="form-group-box">
									<div class="col-xs-1 form-group label-floating">
										<input id="userNick" name="userNick" type="text" class="form-control" value="${UserVO.getUserNick()}">
									</div>
									<div class="col-xs-3 form-group label-floating">
										<button type="button" id="nickCheck" class="btn btn-default emailChkBtn">중복확인</button>
									</div>
								</div>
								<div class="form-group-box">
									<label class="control-label">생년월일</label>
									<div class="form-group label-floating">
										 <input type="text" id="userBirth" class="form-control" name="userBirth" value="${UserVO.getUserBirth()}" maxlength="6">
									</div>
								</div>
								<label for="InputGender">성별</label>
								<div class="form-group label-floating">
									<div class="radio">
										<label> <input type="radio" id="userGenderMan" name="userGender" class="genderRadio" value="M" aria-label="남성"> 남성
										</label>
									</div>
									<div class="radio">
										<label> <input type="radio" id="userGenderWoman" name="userGender" class="genderRadio" value="F" aria-label="여성"> 여성
										</label>
									</div>
								</div>
								<c:set var="phoneArray" value="${fn:split(UserVO.getUserPhoneNumber(),',')}" />
								<label class="control-label">전화번호</label><label class="control-label" style="color:red">휴대폰 인증을 해야만 스터디 등록 및 신청이 가능합니다.</label>
								<div class="number">
									<div class="col-xs-1 phoneNum form-group label-floating">
										<input type="text" id="userPhone1" name="phoneNumber" class="form-control" value="${phoneArray[0]}" maxlength="4">
									</div>
									<div class="hyphen">-</div>
									<div class="col-xs-1 phoneNum form-group label-floating">
										<input type="text" id="userPhone2" name="phoneNumber" class="form-control" value="${phoneArray[1]}" maxlength="4">
									</div>
									<div class="hyphen">-</div>
									<div class="col-xs-1 phoneNum form-group label-floating">
										<input type="text" id="userPhone3" name="phoneNumber" class="form-control" value="${phoneArray[2]}" maxlength="4">
									</div>
									<c:if test="${UserVO.getUserCertification() eq true }">
										<div class="col-xs-12 timer">
											휴대폰 인증을 완료했습니다.
										</div>
									</c:if>
									<c:if test="${UserVO.getUserCertification() eq false }">
										<div class="col-xs-3">
											<button type="button" id="phoneCheck" class="btn btn-default">인증</button>
										</div>
									</c:if>
								</div>
								
								<div class="form-group number label-floating authCode">
									<div class="col-xs-3">
										<input type="text" class="form-control" id="authCode" placeholder="인증번호 입력">
									</div>
									<div class="col-xs-3">
										<button type="button" id="authCodeBtn" class="btn btn-default">확인</button>
									</div>
									<div class="col-xs-12 timer">
					                                    인증번호가 발송되었습니다. ( 유효시간 : <span id="timerMinutes"></span> 분 <span id="timerSecond"></span> 초)
									</div>
								</div>
								<input type="hidden" id="resultNickCheck" value="">
								<div class="btn-group">
									<button type="submit" class="btn btn-danger">저장하기</button>
								</div>

							</div>
						</form>
					</div>
					
					
					<div role="tabpanel" class="tab-pane" id="additionalInfo">
						<div class="col-xs-12">
							<h4>부가정보 입력</h4>
							<div class="col-xs-12 tab-content-in">
								<form class="form-horizontal" action="/user/additionalInfo" method="post" id="additionalInfoForm">
									<div class="form-group-box">
										<label class="control-label">관심 카테고리</label>
										<div class="form-group-box">
											<%@include file="categoryData.jsp"%>
										</div>
										<label class="control-label">관심 지역</label>
										<div class="form-group-box">
											<%@include file="regionCategory.jsp"%>
										</div>											
										<label class="control-label">자기소개</label>
										<div class="form-group-box userIntroduce-group">
											<textarea class="form-control" rows="10" name="userIntroduce" id="userIntroduce" maxlength="500">${UserVO.userIntroduce}</textarea>
											<span id="counter">###</span>											
										</div>
										<div class="btn-group">
											<button type="submit" class="btn btn-danger">저장하기</button>
										</div>										
									</div>								
								</form>
							</div>
							

						</div>
					</div>


					<div role="tabpanel" class="tab-pane" id="password">
						<div class="col-xs-12">
							<h4>비밀번호변경</h4>
							<div class="col-xs-12 tab-content-in">
								<form class="form-horizontal" action="/user/changePwd" method="post" id="changePwdForm">

									<div class="form-group-box">
										<label class="control-label">현재 비밀번호</label>
										<div class="form-group label-floating changePwd-group">
											<input id="userPwd" name="userPwd" type="password" class="form-control">
										</div>
									</div>
									<div class="form-group-box">
										<label class="control-label">새 비밀번호</label>
										<div class="form-group label-floating changePwd-group">
											<input id="newPwd" name="userNewPwd" type="password" class="form-control" placeholder="8자리 이상 20자리 이하 영문,숫자로만 설정해주세요">
										</div>
									</div>
									<div class="form-group-box">
										<label class="control-label">새 비밀번호 확인</label>
										<div class="form-group label-floating changePwd-group">
											<input id="newPwdChk" name="userCheckPwd" type="password" class="form-control" placeholder="비밀번호를 한번 더 입력해주세요.">
										</div>
									</div>
									<button type="submit" class="btn btn-danger f_right">변경하기</button>
								</form>
							</div>
						</div>
					</div>


					<div role="tabpanel" class="tab-pane" id="withdrawal">
						<div class="col-xs-12">
							<h4>회원탈퇴</h4>
							<div class="col-xs-12 tab-content-in">
								<form action="/user/delete" method="post">
									<button type="submit" class="btn btn-danger" onclick="confirm('정말 탈퇴하시겠습니까?');">탈퇴하기</button>
									<div class="form-group-box">
										<label class="control-label">탈퇴하시면 취소가 불가능합니다.</label>
									</div>
								</form>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>

<a href="#" class="top"><i class="fa fa-angle-up" aria-hidden="true"></i></a>

<script>
	jQuery(function($) {
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
		var userGender = '${UserVO.userGender}';
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
</script>
<script>
	$(document).ready(function() {
		var imgPath = '${UserVO.getUserProfileImgPath()}';
		var fileInfo = getFileInfo(imgPath);
		
		var authCheck = "${UserVO.getUserCertification() eq true }";
		if(authCheck == 'true') // 인증했을경우 휴대폰번호 잠금
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
		
		
		$(function() {
			$('#userIntroduce').keyup(function(e) {
				var content = $(this).val();
				$(this).height(((content.split('\n').length + 1) * 3.5) + 'em');
				$('#counter').html(content.length + '/500');

				if ($(this).val().length > 500)
					$(this).val($(this).val().substring(0, 500));

			});
			$('#userIntroduce').keyup();
		});
		
		
		$('#user-img-upload').on('click',function(){
			$('#userFile').trigger('click');
		});
		
		
		var additionalInfoForm = $('#additionalInfoForm'); // 부가정보 폼 선택자
		
		additionalInfoForm.submit(function() {
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
		
		var tmp = '${UserVO.userFavCategory}';
		var cat_values = tmp.split(',');

		for (let i = 0; i < names.length; i++) {
			for (let j = 0; j < cat_values.length; j++) {
				if (names[i].value == cat_values[j]) {
					names[i].setAttribute('checked', 'checked');
				}
			}
		}
		
		$("[name='userFavCategory']").each(function(index){
			 if($(this).prop('checked')){
				 var upCategory=$(this).parents('.list').attr('id');
				 var downCategory=$(this).parents('.list');
				 var aUpCategory=$('.'+upCategory).children('a');
				 aUpCategory.removeClass('collapsed');
				 aUpCategory.attr('aria-expanded',true);
				 downCategory.attr('aria-expanded',true);
				 downCategory.addClass('in');
			 }
		 })
		 
		/* 카테고리 5개 체크 제한 */
		if($("input:checkbox[name=userFavCategory]:checked").length >= 5)
			$("input:checkbox[name=userFavCategory]:not(:checked)").attr("disabled", "disabled");
		$("input:checkbox[name=userFavCategory]").change(function() {
			if ($("input:checkbox[name=userFavCategory]:checked").length >= 5)
				$("input:checkbox[name=userFavCategory]:not(:checked)").attr("disabled", "disabled");
			else
				$("input:checkbox[name=userFavCategory]").removeAttr("disabled");
		});
		
		/* 지역 대분류 선택된 상태 가져오기 */
		var upRegions = document.getElementsByName('upRegion');
		var studyUpRegion = '${UserVO.userFavUpRegion}';
		var studyDownRegion = '${UserVO.userFavDownRegion}';

		for (let i = 0; i < upRegions.length; i++) {
			if (upRegions[i].value == studyUpRegion) {
				upRegions[i].setAttribute('selected', 'selected');
				/* 지역 소분류 선택된 상태 가져오기 */
				subRegion(studyUpRegion); 
				var downRegions = document.getElementsByName('subRegion');
				for(let j = 0; j< downRegions.length; j++) {
					if(downRegions[j].value == studyDownRegion)
						downRegions[j].setAttribute('selected', 'selected');
				}
			} 
		}
		
		var phoneCheck = false;
		var timer;
		$('#phoneCheck').on("click", function() { // 휴대폰 인증
			var userPhone = $("#userPhone1").val() +","+ $("#userPhone2").val() +","+ $("#userPhone3").val(); // 휴대폰번호 전체
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
				data : {"userPhoneNumber" : userPhone},
				success : function(data) {
					if($.trim(data) == "success"){
						phoneAuth(userPhoneSMS);
						phoneCheck = true;
						$('#phoneCheck').attr("disabled", true);
					}
					else
						alert("이미 인증된 휴대폰 번호 입니다. \n다른 휴대폰번호를 입력하세요.");
				}
			});
			
		});
		
		$("#authCodeBtn").on("click", function() { // 인증번호 체크
			var userPhoneSMS = $("#userPhone1").val() + $("#userPhone2").val() + $("#userPhone3").val(); // 문자보낼때 휴대폰번호
			var userPhone = $("#userPhone1").val() +","+ $("#userPhone2").val() +","+ $("#userPhone3").val(); // 휴대폰번호 전체
			var authCode = $("#authCode").val();
			
			if(phoneCheck == true) {
				$.ajax({
					type : 'POST',
					url : '/user/authCodeCheck',
					data : {"phoneCheck" : userPhoneSMS, "authCode" : authCode, "userPhoneNumber" : userPhone},
					success : function(data) {
						if($(this).parent().parent().has('.finish').length > 0 )
							alert("시간이 초과되었습니다. 인증이 불가합니다.");
						else if($.trim(data) == "success") {
							alert("인증을 성공하였습니다.");
							$("#authCode").attr("readonly", true);
							$('.timer').empty().addClass('timer').text('인증을 완료 했습니다.');
							$('#authCodeBtn').attr('disabled', true);
							clearInterval(timer); // 타이머 종료 
						}
						else
							alert("인증번호가 다릅니다. 다시 입력해주세요.");
					}
				});
			}
			else { alert("잘못된 접근입니다."); };
		});
		
		function phoneAuth(userPhone) {
			$.ajax({
				type : 'POST',
				url : '/user/sendSMS',
				data : {"userPhoneNumber" : userPhone},
				success : function(data) {
				}
			});
			
			$(".authCode").show();
			$(".number input[name=phoneNumber]").attr("readonly", true);
			
			var minute = 3;
	        var second = 0;
	        $('#timerMinutes').text(minute);
            $('#timerSecond').text(second);
	        timer = setInterval(function () {
	            if (second == 0 && minute == 0) {
	                $('.timer').empty().addClass('finish').text('시간이 종료되었습니다. 새로고침 후 다시 시도해주세요.');
	                $('#authCodeBtn').attr('disabled', false);
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
</script>
<script>
var target = ${param.target}
window.onload = tabLoad(target);
function tabLoad(target){
	if (target==2) {
		$('#profileBtn').removeClass('active');
		$('#profile').removeClass('active');
		$('#additionalInfoBtn').addClass('active');
		$('#additionalInfo').addClass('active');
	} else if (target==3) {
		$('#profileBtn').removeClass('active');
		$('#profile').removeClass('active');
		$('#changePwdBtn').addClass('active');
		$('#password').addClass('active');
	}
}
</script>
<%@include file="../include/footerSub.jsp"%>