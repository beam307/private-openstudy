<jsp:include page="../include/headerSub.jsp" flush="false"/>
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
						${studyVO.studyIntroduce }
					</div>
				</div>

				<div class="view-btns">
					<button id="goListBtn" type="button" class="view-btn btn btn-default">목록으로</button>
				</div>
				
				<input type="hidden" id="studyNo" value="${studyVO.studyNo}" />
				<input type="hidden" id="studyUpCategory" value="${studyVO.studyUpCategory}" />
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/resources/dist/js/study/studyEndView.js"></script>
<script id="templateAttach" type="text/x-handlebars-template">
	<li data-src='{{fullName}}'>
		<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
		<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		</div>
	</li>
</script>
<jsp:include page="../include/footerSub.jsp" flush="false"/>