<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sbang</title>
<!-- 부트스트랩 -->
<link href="/resources/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 폰트어썸 -->
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- 부트스트랩 -->
<script src="/resources/dist/js/bootstrap.min.js"></script>
<!-- 스크롤 js -->
<script src="/resources/dist/js/scrolla.jquery.min.js"></script>
<script src="/resources/dist/js/main.js"></script>
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<!-- 소켓js  -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- 스타일 css -->
<link href="/resources/dist/css/note.css" rel="stylesheet">

</head>
<script>
	<c:if test="${not empty login}">
		sockNote();
	</c:if>
	function sockNote() {
		var wsUri = '/note';
		sockNote = new SockJS(wsUri);
		sockNote.onopen = function(evt) {
			sockNote.send("${login.userNick}")
		};

		sockNote.onmessage = function(evt) {
			onMessage(evt);
		};
		sockNote.onclose = function() {
		}

		sockNote.onerror = function(evt) {
		};
	}
	function onMessage(evt) {
		$('#count').html(evt.data);
	}
</script>

<body>
	<form role='form' action="#" id="noteAction">
		<div id='form-submit'>
			<input type='hidden' name='page' value="${cri.page}"> <input type='hidden' name='perPageNum' value="${cri.perPageNum}">
			<input type='hidden' name='keyword' value="${cri.keyword}"> <input type="hidden" name='noteFlag' value='list' />
		</div>
	</form>
	<div class="userInfo">
		<div role="tabpanel">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation"><a href="/note/noteReg?noteTarget=">쪽지보내기</a></li>
				<li role="presentation" class="active"><a href="/note/noteList">받은 쪽지</a></li>
				<li role="presentation"><a href="/note/noteListSender">보낸 쪽지</a></li>
				<li role="presentation"><a href="/note/noteListToMe">내게 쓴 쪽지</a></li>
				<li role="presentation"><a href="/note/cutOffList">차단설정</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content note-in">
				<div class='list-all'>
					<c:if test="${empty list}">
						<h4>받은 쪽지가 없습니다.</h4>
					</c:if>
					<c:if test="${not empty list}">
						<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
							<c:forEach items="${list}" varStatus="listIdx" var="noteVO">
								<div class="panel panel-default">
									<div class="panel-heading" role="tab" id="heading${listIdx.index }">
										<h4 class="panel-title">
											<input type="checkbox" class="check-remove" value="${noteVO.noteNo }" />
											<c:choose>
												<c:when test="${noteVO.noteSendDate != noteVO.noteOpenDate }">
													<a data-toggle="collapse" class="noteList read collapsed" data-parent="#accordion" href="#collapse${listIdx.index }"
														aria-expanded="false" aria-controls="collapse${listIdx.index }"> ${noteVO.noteText } </a>
												</c:when>
												<c:otherwise>
													<a data-toggle="collapse" class="noteList collapsed" data-parent="#accordion" href="#collapse${listIdx.index }"
														aria-expanded="false" aria-controls="collapse${listIdx.index }"> ${noteVO.noteText } </a>
												</c:otherwise>
											</c:choose>
											<a href="#" data-cut='${noteVO.noteSender }' data-nick='${noteVO.userNick }' class="btn btn-danger cutOff-btn">차단</a> <input
												type="button" class="btn btn-danger answear-btn" data-target='${noteVO.noteSender }' value="답장" /> <small> <a href='#'
												data-no='${noteVO.noteSender }' class="userNick_link">${noteVO.userNick } </a> <fmt:formatDate value="${noteVO.noteSendDate}"
													pattern="yyyy-MM-dd" var="sendDate" /> <span>${sendDate}</span></small>

										</h4>

									</div>
									<div id="collapse${listIdx.index }" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${listIdx.index }">
										<div class="panel-body">
											${noteVO.noteText }
											<!--텍스트 전체출력  -->
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:if>
					<div class="div-btn">
						<input type="button" class="btn btn-danger" id='removeBtn' value='삭제' /> <input type="button" class="btn btn-danger" id='allCheckBtn'
							value='모두선택' /> <input type="button" class="btn btn-danger" id='allCheckFalBtn' value='모두해제' />
					</div>
				</div>
			</div>
		</div>
		<!-- 페이지네이션 -->
		<div class="pagination-nav">
			<div class='pag'>
				<ul class="pagination">
					<c:if test="${pageMaker.prev }">
						<li><a href="/note/noteList${pageMaker.makeNotice(pageMaker.startPage -1) }">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
						<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}" />><a href="/note/noteList${pageMaker.makeNotice(idx) }">${idx }</a></li>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
						<li><a href="/note/noteList${pageMaker.makeNotice(pageMaker.endPage + 1) }">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>


	<script>
		$(document).ready(function() {
			var formObj = $("form[role='form']");
			$('#allCheckFalBtn').on('click', function() {//쪽지 모두 해제
				$('.check-remove').prop('checked', false);
			})
			$('#allCheckBtn').on('click', function() {//쪽지 모두 선택
				$('.check-remove').prop('checked', true);
			})
			$('#removeBtn').on('click', function() { //삭제버튼누를시 checked에있는 쪽지 제거
				event.preventDefault();
				var noteArr = new Array();
				var str = "";
				$('.check-remove:checked').each(function(index) {
					var that = $(this)
					var noteNo = that.val();
					str += "<input type='hidden' name='noteArr' value='"+noteNo+"'>";
				})
				if (str == "")
					return;
				var con = confirm("정말 삭제하시겠습니까??");
				if (con) {
					$('#form-submit').append(str);
					//formObj.noteArr=noteArr;
					formObj.attr("action", "/note/noteRemove");
					formObj.attr("method", "post");
					formObj.submit();
				}
			});

			$(".userNick_link").on("click", function(event) {//userInfo 새창 띄우기  
				var userNo = $(this).attr('data-no');
				event.preventDefault();
				window.open("/user/userInfo?userNo=" + userNo, "userInfo", "location=no, left=400px, top=100px, width=600px, height=700px");
			});

			$('.answear-btn').on('click', function() {
				var target = $(this).attr('data-target');
				window.location.href = "/note/noteReg?noteTarget=" + target;
			})

			$('.cutOff-btn').on('click', function() {
				var noteSender = $(this).attr('data-cut');/*차단대상  */
				var noteSenderNick = $(this).attr('data-nick');
				$.ajax({
					type : 'post',
					url : '/note/noteCutOff',
					data : {
						noteSender : noteSender
					},
					success : function(result) {
						if (result == 'SUCCESS') {
							alert("[" + noteSenderNick + "] 님을 차단하였습니다")
						} else if (result == 'CUTOFF') {
							alert("이미 차단된 사용자입니다.");
						}
					},
					error : function(result) {
						alert('알 수 없는 오류로 차단을 실패히였습니다.')
					}
				});
			})

			$('.noteList').on('click', function() {
				var that = $(this);
				var noteNo = that.siblings('.check-remove').val();
				var loginUserNo = '${login.userNo}';
				$.ajax({
					type : 'post',
					url : '/note/noteRead',
					data : {
						noteNo : noteNo
					},
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
		})
	</script>
</body>
</html>
