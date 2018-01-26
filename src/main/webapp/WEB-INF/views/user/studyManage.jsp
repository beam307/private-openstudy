<jsp:include page="../include/headerSub.jsp" flush="false"/>
<div class="mypage_bg">
	<div class="mypage container">
		<input type="hidden" id="target" value="${param.target}">
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation"><a href="/user/myPage">개인정보관리</a></li>
			<li role="presentation" class="active"><a href="/user/studyManage">스터디관리</a></li>
		</ul>
		<!-- Tab panes -->
		<div role="tabpanel" class="tab-pane active" id="myinfo">
			<div class="tabpanel-in" role="tabpanel">

				<div role="tabpanel" class="tab-pane" id="study">
					<div class="" role="tabpanel">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
							<li id="bookmarkBtn" role="presentation" class="active study"><a href="#bookmark-study" aria-controls="bookmark-study" role="tab" data-toggle="tab">북마크</a></li>
							<li id="regBtn" role="presentation" class="study"><a href="#recruitment-study" aria-controls="recruitment-study" role="tab" data-toggle="tab">모집</a></li>
							<li id="applyBtn" role="presentation" class="study"><a href="#progress-study" aria-controls="progress-study" role="tab" data-toggle="tab" id="progressStudy">신청</a></li>
							<li id="endBtn" role="presentation" class="study"><a href="#complete-study" aria-controls="complete-study" role="tab" data-toggle="tab">완료</a></li>
						</ul>
						<!-- Tab panes -->
						<div class="tab-content animate" data-animate="fadeInUp" data-duration="1.0s" data-delay="0.1s">
							<div role="tabpanel" class="tab-pane active" id="bookmark-study">

								<div class="sub-thumbnail">
									<div id="wish-thumbnail"></div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane" id="recruitment-study">
								<div class="sub-thumbnail">
									<div id="reg-thumbnail"></div>
									<div id="applyList"></div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane" id="progress-study">
								<div class="sub-thumbnail">
									<div id="cur-thumbnail"></div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane" id="complete-study">
								<div class="sub-thumbnail">
									<div id="finish-thumbnail"></div>
								</div>
							</div>
						</div>
						
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!-- 신청자목록 Modal -->
	<div class="modal fade" id="applyListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="login-modal-title">신청자목록 </h4>
					<div class="modal-body">
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 승인여부 Modal -->
	<div class="modal fade" id="ApproveCheck" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="login-modal-title">승인여부</h4>
					<div class="modal-body">
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 참여인원목록 Modal -->
	<div class="modal fade" id="studyMember" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="login-modal-title">스터디 참여자</h4>
					<div class="modal-body">
						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<a href="#" class="top"><i class="fa fa-angle-up" aria-hidden="true"></i></a>
<script id="templateList" type="text/x-handlebars-template">
<div class="col-md-4">
	<div class="card hovercard">
		<div class="cardheaderbox">
			<div class="cardheaderboxIn">
				<div class="cardheader" style="background: url({{backgroundImg}}); background-size: cover;"></div>
				{{#fin}}
					<a href='/study/studyEndView?studyNo={{studyNo}}' class="card-name">{{studyName}}</a>
				{{else}}
					<a href='/study/studyView?studyNo={{studyNo}}&studyManage=true&target={{target}}' class="card-name">{{studyName}}</a>
				{{/fin}}
			</div>
		</div>
		<div class="avatar">
			<span class="mailbox-attachment-icon has-img"> 
			<img src="{{profileImg}}"></span>
		{{#fin}}
			{{#studyLeader}}
				<span class="m_icon"><i class="fa fa-user-o" aria-hidden="true"></i></span>
			{{/studyLeader}}
		{{/fin}}
		{{#reg}}
			<span class="m_icon"><i class="fa fa-user-o" aria-hidden="true"></i></span>
		{{/reg}}
			<span class="icon icon_1"><i class="fa fa-eye" aria-hidden="true"></i>{{viewCnt}}</span>
			<span class="icon icon_2">
				<i class="fa fa-user" aria-hidden="true"></i>{{curMemCnt}}</span>
		</div>
		<div class="info" data-sno={{studyNo}}>
			<div class="title">
				<a target="_blank" class="userNick_link" data-writer={{writer}} href="#">{{userNick}}</a>
			</div>
			<div class="desc">{{studyRegion}}</div>
			<div class="desc info-bold">스터디 시작일 - {{startDate}}</div>
		</div>
		{{#fin}}
			<a class="btn btn-primary btn-sm" href="/study/studyEndView?studyNo={{studyNo}}">자세히보기</a>
			{{#studyLeader}}
				<a class="btn btn-primary btn-sm" id="studyMemList" data-toggle="modal" href="#studyMember">참여자목록</a>
			{{/studyLeader}}
		{{else}}
			<a class="btn btn-primary btn-sm" href="/study/studyView?studyNo={{studyNo}}&studyManage=true&target={{target}}">자세히보기</a>
		{{/fin}}
		{{#reg}}
			<a class="btn btn-primary btn-sm" id="applyMemList" data-toggle="modal" href="#applyListModal">신청자목록</a>
		{{/reg}}
		{{#app}}
			<a class="btn btn-primary btn-sm" id="approveChkBtn" data-toggle="modal" href="#ApproveCheck">승인 여부</a>
		{{/app}}
		<div class="mailbox-attachment-info"></div>
	</div>
</div>
</script>
<script type="text/javascript" src="/resources/dist/js/user/studyManage.js"></script>
<jsp:include page="../include/footerSub.jsp" flush="false"/>