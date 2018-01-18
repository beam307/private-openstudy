<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/headerSub.jsp"%>
<div class="view_bg endStudy_bg">
	
	<div id="finishContainer"class="container view animate endStudy" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
	<div class="finishStudy">
		완료
	</div>
		<!-- 밑에 썸네일 슬라이드야 -->
		<div id="carousel-example-generic" class="carousel slide studyEndImg" data-ride="carousel">
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
		
		<div class="row studyEndContent">
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
						<c:forEach var="weekVO" items="${weekList}">
							<div>요일: ${weekVO.weekDay}, 시작시간: ${weekVO.weekStartDate}, 끝나는시간:${weekVO.weekEndDate}</div>
						</c:forEach>
					</div>
				</div>

				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">대상</div>
					<div class="col-md-11 view-info-con">
						<p>${studyVO.studyTargetAge }</p>
					</div>
				</div>

				<div class="col-xs-12">
					<div class="col-md-1 view-info-tit">소개글</div>
					<div class="col-md-11 view-info-con">
						<p>${studyVO.studyIntroduce }</p>
					</div>
				</div>

				<div class="view-btns">
					<button id="goListBtn" type="button" class="view-btn btn btn-default">목록으로</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script id="templateAttach" type="text/x-handlebars-template">
	<li data-src='{{fullName}}'>
		<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
		<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		</div>
	</li>
</script>
<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");

		/* 목록으로버튼 클릭시  */
		$("#goListBtn").on("click", function() {
			location.href = "/user/studyManage?target=4";
		});

		var studyNo = "${studyVO.studyNo}";

		var template = Handlebars.compile($("#templateAttach").html());

		/* 제이슨으로 이미지 파일 불러오기  */
		$.getJSON("/study/getImgEnd/" + studyNo, function(list) {
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
	});
</script>
<%@include file="../include/footerSub.jsp"%>