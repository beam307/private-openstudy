<jsp:include page="../include/headerSub.jsp" flush="false"/>
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
					<input id="upCategory" type="hidden" value="${studyVO.studyUpCategory}" />
					<input id="studyWriter" type="hidden" value="${studyVO.studyWriter}" />
					<input id="userNick" type="hidden" value="${login.userNick}" />
					<input id="userNo" type="hidden" value="${login.userNo}" />
					<input id="userName" type="hidden" value="${userVO.userName}" />
					<input id="studyName" type="hidden" value="${studyVO.studyName}" />
					<input id="userBirth" type="hidden" value="${userVO.userBirth}" />
					<input id="userPhoneNumber" type="hidden" value="${userVO.userPhoneNumber}" />
					<input id="studyCurMemCnt" type="hidden" value="${studyVO.studyCurMemCnt}" />
					<input id="studyMaxMemCnt" type="hidden" value="${studyVO.studyMaxMemCnt}" />
					<input id="studyNo" type="hidden" value="${param.studyNo}" />
					</div>
				</div>
			</div>
		</div>
		</div>

		<!-- 쿼리스트링 값 받아오기(히든) -->
		<form role="form" action="studyModify" method="post">
			<input type="hidden" id='select-no' name='studyNo' value="${studyVO.studyNo }"> <input type="hidden" name='page' value="${cri.page }"> 
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
						<div class="textarea studyIntroduce" name="studyIntroduce" id="studyIntroduce">${studyVO.studyIntroduce}</div>
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
<script type="text/javascript" src="/resources/dist/js/study/studyView.js"></script>
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
</script>
<jsp:include page="../include/footerSub.jsp" flush="false"/>