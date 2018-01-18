<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/headerSub.jsp"%>
<link href="/resources/dist/css/AdminLTE.css" rel="stylesheet">

<style>
.form-group {
	margin: 0;
}
.form-control {
	padding: 0;
}
.form-group .form-control {
background-image:none;
width:100%;
}
.form-group.is-focused .form-control {
background-image:none;
}
</style>

<div class="view_bg">
	<div class="container view animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
		<!-- 밑에 썸네일 슬라이드야 -->
		<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators" id="img-slide-target">
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" id="img-slide" role="listbox"></div>

			<!-- Controls -->
			<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev"> <span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next"> <span class="sr-only">Next</span>
			</a>
			
			<div class="view-tit">
			<div class="col-xs-12 view-user">
				<div class="user-img col-md-1 col-xs-3">
					<img id="profileImg" src="/displayFile?fileName=${userVO.userProfileImgPath }">
				</div>
				<div class="col-md-6 col-xs-9 user-img-text">
					<h1>
						${studyVO.studyName}
						<!--요기에 카테고리 대분류 출력시킵니다.(js로)  -->
					</h1>
					<div class="user-name dropdown">
						<button class="dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">${userVO.userNick}</button>
						<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1" href="/note/noteReg?noteTarget=" onClick="window.open(this.href, '', 'location=no, width=600, height=700, left=800, top=50'); return false;">쪽지보내기</a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1" href="/user/userInfo?userNo=${studyVO.studyWriter}" onClick="window.open(this.href, 'userInfo', 'location=no, left=800, top=50, width=600px, height=700px'); return false">프로필보기</a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-5 col-xs-12">
					<div class="view-icon">
						<!--북마크 클릭후-->
						<c:if test="${favCheck > 0}">
							<div id="favStudy">
								<a style="cursor:pointer"><i id="favIcon" class="fa fa-heart" aria-hidden="true"></i></a>
							</div>
						</c:if>
						<!--북마크 클릭전-->
						<c:if test="${favCheck == 0}">
							<div id="favStudy">
								<a style="cursor:pointer"><i id="favIcon" class="fa fa-heart-o" aria-hidden="true"></i></a>
							</div>
						</c:if>
					</div>
					<div id="output-upCategory">
					</div>
				</div>
			</div>
		</div>
		</div>

		<!-- 쿼리스트링 값 받아오기(히든) -->
		<form role="form" action="studyModify" method="post">
			<input type="hidden" name='studyNo' value="${studyVO.studyNo }"> <input type="hidden" name='page' value="${cri.page }"> 
			<input type="hidden" name='perPageNum' value="${cri.perPageNum }"> <input type="hidden" name='searchType' value="${cri.searchType }">
			<input type="hidden" name='keyword' value="${cri.keyword }"> <input type="hidden" name='lineUp' value="${cri.lineUp}" />
			<input type="hidden" name='upRegion' value="${cri.upRegion }"> <input type="hidden" name='downRegion' value="${cri.downRegion }">
			<input type="hidden" name='upCategory' value="${cri.upCategory }"> <input type="hidden" name='Category' value="${cri.category }">
			<input type="hidden" id="goStudyManage" value="${param.studyManage}"> <input type="hidden" id="goStudyManageTap" value="${param.target}">
		</form>
		
		<div class="row">
			<div class="col-xs-12 view-info">
				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">카테고리</div>
					<div class="col-md-11 view-info-con">
						<p>${studyVO.studyCategory}</p>
					</div>
				</div>

				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">현재인원</div>
					<div class="col-md-11 view-info-con">
						<p>${studyVO.studyCurMemCnt}</p>
					</div>
				</div>

				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">최대인원</div>
					<div class="col-md-11 view-info-con">
						<p>${studyVO.studyMaxMemCnt}</p>
					</div>
				</div>

				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">지역</div>
					<div class="col-md-11 view-info-con">
						<p>${studyVO.studyUpRegion} ${studyVO.studyDownRegion}</p>
					</div>
				</div>

				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">대상</div>
					<div class="col-md-11 view-info-con">
						<p>${studyVO.studyTargetAge }</p>
					</div>
				</div>

				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">시작날짜</div>
					<div class="col-md-11 view-info-con">
						<!-- 날짜 형식을 년/월/일로 표시 -->
						<fmt:formatDate value="${studyVO.studyStartDate}" pattern="yyyy-MM-dd" var="date" />
						<p>${date}</p>
					</div>
				</div>

				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">일정</div>
					<div class="col-md-11 view-info-con">
						<%-- <c:forEach var="weekVO" items="${weekList}">
							<div> ${weekVO.weekDay} ${weekVO.weekStartDate} 부터 ${weekVO.weekEndDate} 까지 스터디 진행</div>	
						</c:forEach> --%>
						<table class="table">
						  <tr>
						  	<th>월요일</th>
						  	<th>화요일</th>
						  	<th>수요일</th>
						  	<th>목요일</th>
						  	<th>금요일</th>
						  	<th>토요일</th>
						  	<th>일요일</th>
						  </tr>
						  <tr>
						  	<td id='mon'></td>
						  	<td id='tue'></td>
						  	<td id='wed'></td>
						  	<td id='thu'></td>
						  	<td id='fri'></td>
						  	<td id='sat'></td>
						  	<td id='sun'></td>
						  </tr>
						</table>
						
					</div>
				</div>
				
				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">소개글</div>
					<div class="col-md-11 view-info-con">
						<p><textarea readonly="readonly" style="cursor: default;min-height: 100px;min-width: 150px;" class="form-control " name="studyIntroduce" id="studyIntroduce">${studyVO.studyIntroduce}</textarea></p>
					</div>
				</div>

				<!-- <ul class="mailbox-attachments clearfix uploadedList"></ul> -->

				<div class="view-btns">
					<button id="goListBtn" type="submit" class="view-btn btn btn-default">목록으로</button>
					<c:if test="${not empty login && login.userNo != studyVO.studyWriter}"> <!-- 로그인 한 유저이면서 글쓴이와 로그인유저와 다를 경우 -->
						<div id="applyDiv">
							<c:if test="${applyCheck == 0}"> <!-- 로그인유저가 스터디신청을 하지 않았을 경우 -->
								<button id="studyJoinBtn" type="submit" class="view-btn btn btn-primary">신청하기</button>
							</c:if>
							<c:if test="${applyCheck > 0}"> <!-- 로그인유저가 스터디신청을 한 경우 -->
								<button id="studyCancelBtn" type="submit" class="view-btn btn btn-primary">신청취소</button>
							</c:if>
						</div>
					</c:if>
					<c:if test="${not empty login && login.userNo == studyVO.studyWriter}"> <!-- 로그인유저와 글쓴이가 같을 경우 -->
						<button id="modifyBtn" type="submit" class="view-btn btn btn-default">수정</button>
						<button id="deleteBtn" type="submit" class="view-btn btn btn-default">삭제</button>
						<button id="studyEndBtn" type="button" class="view-btn btn btn-primary">스터디완료</button>
					</c:if>
				</div>
			</div>
			<!--댓글 추가  -->
			<c:if test="${not empty login}">
				<div class="box-body">
					<div class="reply-name">
						<label for="exampleInputEmail1">작성자</label> 
						<div class="form-group is-empty">
							<input class="reply-name-form" placeholder="USER ID" type="text" value="${login.userNick}" id="newReplyWriter" readonly> 
						</div>
					</div>
					
					<div class="reply-tit">
						<label for="exampleInputEmail1">댓글</label> 
						<input class="form-control" type="text" placeholder="댓글을 입력 해 주세요" id="newReplyText" maxlength="200">
					</div>
					
					<div class="reply-bot">
						<label> 
						<input type="checkbox" id="newReplySecret"><i class="fa fa-lock" aria-hidden="true"></i> 비밀글
						</label>
						<button type="button" class="btn btn-primary" id="replyAddBtn">작성하기</button>
					</div>

				</div>
			</c:if>
			<c:if test="${empty login}">
				<div class="box-body">
					<label for="exampleInputEmail1">로그인 해야 댓글을 쓸 수 있습니다.</label>
				</div>
			</c:if>
			<!-- 댓글 리스트 -->
			<ul class="timeline">
				<!-- timeline time label -->
				<li class="time-label" id="repliesDiv"></li>
			</ul>

			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">
				</ul>
			</div>
		</div>
	</div>
</div>

<script id="template" type="text/x-handlebars-template">
{{#each .}}
{{!-- 일반사용자가 보는 댓글 --}}
<li class="replyLi" data-rno={{replyNo}}>
	<i class="fa fa-comments"></i>
 	<div class="timeline-item" >
				<span class="time"><i class="fa fa-clock-o"></i>{{prettifyDate replyRegDate}}</span>
				<h3 class="timeline-header"><small>작성자</small>{{userNick}}</h3>
		{{#if replySecret}}
			{{#eqReplyer .}}
				<small><i class="fa fa-lock" aria-hidden="true"></i></small>
				<div class="timeline-body" id="changeInput">{{replyText}}</div>
			{{/eqReplyer}}
			{{#eqReplyerElse .}}
				<div class="timeline-body"><i class="fa fa-lock" aria-hidden="true"></i> 비밀 글 입니다.</div>
			{{/eqReplyerElse}}
		{{else}}
				<div class="timeline-body" id="changeInput">{{replyText}}</div>
		{{/if}}
				<div class="timeline-footer" id="replyModityBtn">
		{{#eqReplyer .}}
					<a class="btn btn-primary btn-xs" id="replyModifyBtn">수정</a>
					<a class="btn btn-primary btn-xs" id="replyDeleteBtn">삭제</a>
		{{/eqReplyer}}
				</div>
	</div>   
</li>
{{/each}}
</script>
<script id="template2" type="text/x-handlebars-template">
{{#each .}}
{{!-- 방장이 보는 댓글 --}}
<li class="replyLi" data-rno={{replyNo}}>
	<i class="fa fa-comments"></i>
 	<div class="timeline-item" >
		<span class="time"><i class="fa fa-clock-o"></i>{{prettifyDate replyRegDate}}</span>
		<h3 class="timeline-header"><small>작성자</small>{{userNick}}</h3>
		{{#if replySecret}}<small><i class="fa fa-lock" aria-hidden="true"></i></small>{{/if}}
		<div class="timeline-body" id="changeInput">{{replyText}}</div>
		<div class="timeline-footer" id="replyModityBtn">
	{{#eqReplyer .}}
		<a class="btn btn-primary btn-xs" id="replyModifyBtn">수정</a>
		<a class="btn btn-primary btn-xs" id="replyDeleteBtn">삭제</a>
	{{/eqReplyer}}
		</div>
	</div>   
</li>
{{/each}}
</script>
<script id="templateAttach" type="text/x-handlebars-template">
	<li data-src='{{fullName}}'>
		<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
		<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		</div>
	</li>
</script>
<script id="modifyTemplate" type="text/x-handlebars-template">
<li class="replyLi modifyReply" data-rno={{replyNo}}>
	<i class="fa fa-comments"></i>
 	<div class="timeline-item" >
		<span class="time"><i class="fa fa-clock-o"></i>{{prettifyDate replyRegDate}}</span>
		<h3 class="timeline-header"><small>작성자</small>{{userNick}}</h3>
		{{#replySecret}}
			<small><i class="fa fa-lock" aria-hidden="true"></i></small>
		{{/replySecret}}
		<div class="timeline-body" id="changeInput">
			<input type="text" class="form-control reply-modify" value="{{replyText}}" id="modifyInput">
		{{#if replySecret}}
			<label><input type="checkbox" id="modifyReplySecret" checked><i class="fa fa-lock" aria-hidden="true"></i> 비밀글</label>
		{{else}}
			<label><input type="checkbox" id="modifyReplySecret"><i class="fa fa-lock" aria-hidden="true"></i> 비밀글</label>
		{{/if}}
		</div>
		<div class="timeline-footer" id="replyModityBtn">
			<button class="btn btn-primary replyModifyBtn" type="button" id="replyModBtn">수정</button>
			<button type="button" class="btn btn-default replyModifyBtn" id="replyCancel">취소</button>
		</div>
	</div>   
</li>
</script>
<script>
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
				}, function() {
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

		var studyNo = "${studyVO.studyNo}";

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
		var upCategoryStr = "${studyVO.studyUpCategory}";
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
			if (replyVO.userNick == '${login.userNick}')
				accum += block.fn(replyVO);
			return accum;
		});
		/* 댓글 로그인 사용자 구분else  */
		Handlebars.registerHelper("eqReplyerElse", function(replyVO, block) {
			var accum = '';
			if (replyVO.userNick != '${login.userNick}')
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
			var login = '${login.userNo}';
			$.getJSON(pageInfo, function(data) {
				if (login != '') {
					if (login != "${studyVO.studyWriter}") {
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
			var writer='${studyVO.studyWriter}';

			var replyer = '${login.userNo}';
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
				userNick : "${login.userNick}",
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
			var curNum = parseInt('${studyVO.studyCurMemCnt}');
			var maxNum = parseInt('${studyVO.studyMaxMemCnt}');
			var userNick = '${login.userNick}';
			var writer = '${studyVO.studyWriter}';
			var userName = '${userVO.userName}';
			var userBirth = '${userVO.userBirth}';
			var userPhoneNumber = '${userVO.userPhoneNumber}';

			if (!(curNum < maxNum)) {
				alert("최대신청인원을 초과했습니다.");
				return;
			} else if (userNick == writer)
				alert("자신의 클래스는 신청할 수 없습니다.")
			else {
				$.ajax({
					type : 'post',
					url : '/user/applyStudy',
					data : {
						"studyNo" : studyNo,
						"studyWriter" : writer	
					},
					success : function(data) {
						if ((data == 'success') && !(userName == null && userBirth == null && userPhoneNumber == null) ) {
							alert("[" + '${studyVO.studyName}' + "] 스터디 신청을 하였습니다.");
							applyDiv.empty();
							applyDiv.append('<button id="studyCancelBtn" type="submit" class="view-btn btn btn-primary">신청취소</button>');
							sockAlarm.send(writer);
							location.href = '/user/studyManage?target=3';
						} else
							alert("개인정보가 부족하여 스터디 신청을 할수 없습니다. \n마이페이지에서 개인정보를 입력해주세요.");
							location.href = '/user/myPage';
					}
				});
			}
		});

		/* 신청취소 클릭시  */
		$(document).on("click", "#studyCancelBtn", function() {
			var writer = '${studyVO.studyWriter}';
			$.ajax({
				type : 'post',
				url : '/user/cancelStudy',
				data : {
					"studyNo" : studyNo,
					"studyWriter" : writer
				},
				success : function(data) {
					alert("[" + '${studyVO.studyName}' + "] 스터디를 취소 하였습니다.");
					applyDiv.empty();
					applyDiv.append('<button id="studyJoinBtn" type="submit" class="view-btn btn btn-primary">신청하기</button>');
					sockAlarm.send(writer);
				}
			});
		});

		/* 완료버튼 클릭시  */
		$("#studyEndBtn").on("click", function() {
			var result = confirm('정말 스터디를 완료 시키겠습니까? 완료시 취소는 불가 합니다.');
			var studyNo = '${param.studyNo}';
			
			if(result){
				$.ajax({
					type : 'post',
					url : '/user/endStudy',
					data : { "studyNo" : studyNo },
					success : function(data){
						for(let i=0; i<data.length;i++){
							sockAlarm.send(data[i]);
						}
						location.href="/user/studyManage?target=4";
					},
					error : function(data){
						alert('시작날짜 이후로 완료를 할수 있습니다.');
						return;
					}
				});
			}
		});
		
		/* 즐겨찾기 버튼 클릭시 */
		$('#favStudy').on("click", function() {
			var writer = '${studyVO.studyWriter}';
			
			$.ajax({
				type : 'post',
				url : '/user/favoriteStudy',
				data : { "studyNo" : studyNo, "studyWriter" : writer },
				success : function(data) {
					if ($.trim(data) == 0) {
						$('#favIcon').attr('class','fa fa-heart-o');
						alert("[" + '${studyVO.studyName}' + "] 스터디를 즐겨 찾기를 삭제하였습니다.");
					} else {
						$('#favIcon').attr('class','fa fa-heart');
						sockAlarm.send(writer);
						alert("[" + '${studyVO.studyName}' + "] 스터디를 즐겨 찾기를 추가하였습니다.");
					}

				}
			});
		});
		
		/* 주단위 일정 출력 */
		<c:forEach var="weekVO" items="${weekList}">
			if('${weekVO.weekDay}'=='월요일')
				$('#mon').html('${weekVO.weekStartDate} ~ ${weekVO.weekEndDate} ');
			else if('${weekVO.weekDay}'=='화요일')
				$('#tue').html('${weekVO.weekStartDate} ~ ${weekVO.weekEndDate} ');
			else if('${weekVO.weekDay}'=='수요일')
				$('#wed').html('${weekVO.weekStartDate} ~ ${weekVO.weekEndDate} ');
			else if('${weekVO.weekDay}'=='목요일')
				$('#thu').html('${weekVO.weekStartDate} ~ ${weekVO.weekEndDate} ');
			else if('${weekVO.weekDay}'=='금요일')
				$('#fri').html('${weekVO.weekStartDate} ~ ${weekVO.weekEndDate} ');
			else if('${weekVO.weekDay}'=='토요일')
				$('#sat').html('${weekVO.weekStartDate} ~ ${weekVO.weekEndDate} ');
			else if('${weekVO.weekDay}'=='일요일')
				$('#sun').html('${weekVO.weekStartDate} ~ ${weekVO.weekEndDate} ');
		</c:forEach>
	});
		
		
</script>
<!-- 드롭다운 -->
<script>
	$('.dropdown-toggle').dropdown();
	$('#myDropdown').on('show.bs.dropdown', function() {
		// do something…
	})
</script>

<%@include file="../include/footerSub.jsp"%>