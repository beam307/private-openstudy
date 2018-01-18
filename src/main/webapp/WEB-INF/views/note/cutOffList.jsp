<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sbang</title>
<!-- 부트스트랩 -->
<link href="/resources/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 폰트어썸 -->
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="/resources/dist/js/bootstrap.min.js"></script>
<!-- 스크롤 js -->
<script src="/resources/dist/js/scrolla.jquery.min.js"></script>
<script src="/resources/dist/js/main.js"></script>
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<!-- 스타일 css -->
<link href="/resources/dist/css/note.css" rel="stylesheet">

</head>

<body>
	<form role='form' action="#" id="noteAction">
		<div id='form-submit'>
			<input type='hidden' name='page' value="${cri.page}"> <input type='hidden' name='perPageNum' value="${cri.perPageNum}">
			<input type='hidden' name='keyword' value="${cri.keyword}"> <input type="hidden" name='noteFlag' value='cutOff' />
		</div>
	</form>
	<div class="userInfo">
		<div role="tabpanel">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation"><a href="/note/noteReg?noteTarget=">쪽지보내기</a></li>
				<li role="presentation"><a href="/note/noteList">받은 쪽지</a></li>
				<li role="presentation"><a href="/note/noteListSender">보낸 쪽지</a></li>
				<li role="presentation"><a href="/note/noteListToMe">내게 쓴 쪽지</a></li>
				<li role="presentation" class="active"><a href="/note/cutOffList">차단설정</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content note-in cutoff">
				<div class='list-all'>
					<c:if test="${empty list}">
						<h4>차단한 대상이 없습니다.</h4>
					</c:if>
					<c:if test="${not empty list}">
						<c:forEach items="${list}" varStatus="listIdx" var="cutOffVO">
							<div class="panel panel-default">
								<div class="panel-heading" role="tab" id="heading${listIdx.index }">
									<h4 class="panel-title">
										<input type="checkbox" class="check-remove" value="${cutOffVO.cutOffNo }" /> 
										<span data-toggle="collapse" class="collapsed"aria-expanded="false"> ${cutOffVO.userNick } </span> 
										<fmt:formatDate value="${cutOffVO.cutOffRegDate}"
											pattern="yyyy-MM-dd" var="regDate" /> 
											<span>${regDate}</span>
									</h4>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<div class="div-btn">
					<input type="button" class="btn btn-danger" id='removeBtn' value='수신허용' /> <input type="button" class="btn btn-danger" id='allCheckBtn'
						value='모두선택' /> <input type="button" class="btn btn-danger" id='allCheckFalBtn' value='모두해제' />
				</div>
			</div>
		</div>
	</div>

	<!-- 페이지네이션 -->
	<nav class="pagination-nav">
	<div class='pag'>
		<ul class="pagination">
			<c:if test="${pageMaker.prev }">
				<li><a href="cutOffList${pageMaker.makeNotice(pageMaker.startPage -1) }">&laquo;</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
				<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}" />><a href="cutOffList${pageMaker.makeNotice(idx) }">${idx }</a></li>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
				<li><a href="cutOffList${pageMaker.makeNotice(pageMaker.endPage + 1) }">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
	</nav>
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
				var cutArr = new Array();
				var str = "";
				$('.check-remove:checked').each(function(index) {
					var that = $(this)
					var cutOffNo = that.val();
					str += "<input type='hidden' name='cutOffArr' value='"+cutOffNo+"'>";
				})
				if (str == "")
					return;
				var con = confirm("정말 수신허용하시겠습니까??");
				if (con) {
					$('#form-submit').append(str);
					//formObj.noteArr=noteArr;
					formObj.attr("action", "/note/cutOffDelete");
					formObj.attr("method", "post");
					formObj.submit();
				}
			});
		})
	</script>
</body>
</html>
