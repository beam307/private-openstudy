<jsp:include page="../include/headerAdmin.jsp" />
<!--sidebar-menu-->
<div id="sidebar">
	<ul>
		<li><a href="/admin/index"><i class="icon icon-signal"></i> <span>통계</span></a></li>
		<li class="active"><a href="/admin/user"><i class="fa fa-users" aria-hidden="true"></i> <span>회원</span></a></li>
		<li><a href="/admin/study"><i class="icon icon-pencil"></i> <span>스터디</span></a></li>
		<li><a href="/board/noticeList"><i class="icon icon-info-sign"></i> <span>공지사항</span></a></li>
		<li><a href="/board/qnAList"><i class="fa fa-quora" aria-hidden="true"></i> <span>FAQ</span></a></li>
	</ul>
</div>
<!--sidebar-menu-->
<div id="content">
	<div id="content-header">
		<div id="breadcrumb">
			<a href="/admin/index" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="/admin/user" class="current">회원</a>
		</div>
		<h1>회원</h1>
	</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-th"></i>
						</span>
						<form class="form-inline search" action="/admin/user" method="get">
							<div class="form-group">
								<input type="text" class="form-control" id="exampleInputEmail2" name="keyword" placeholder="이름을 입력 하세요" value="${cri.keyword}">
							</div>
							<button type="submit" class="btn btn-default">검색</button>
						</form>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>번호</th>
									<th>이메일</th>
									<th>닉네임</th>
									<th>이름</th>
									<th>성별</th>
									<th>생년월일</th>
									<th>휴대폰번호</th>
									<th>가입일자</th>
									<th>수정일자</th>
									<th>외부로그인</th>
									<th>이메일인증</th>
									<th>정지기간</th>
									<th>회원상태</th>
									<th>회원관리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${userList}" var="userVO">
									<fmt:formatDate value="${userVO.userRegDate}" pattern="yyyy-MM-dd" var="userRegDate" />
									<fmt:formatDate value="${userVO.userUpdateDate}" pattern="yyyy-MM-dd" var="userUpdateDate" />
									<c:set var="phoneNumber" value="${fn:split(userVO.userPhoneNumber,',')}" />
									<c:set var="userPhoneNumber" value="${fn:join(phoneNumber,'-')}" />
									<tr class="odd gradeX">
										<td id="userNo">${userVO.userNo}</td>
										<td>${userVO.userEmail}</td>
										<td>${userVO.userNick}</td>
										<td>${userVO.userName}</td>
										<td>${userVO.userGender}</td>
										<td>${userVO.userBirth}</td>
										<td>${userPhoneNumber}</td>
										<td>${userRegDate}</td>
										<td>${userUpdateDate}</td>
										<c:if test="${not empty userVO.userKakao}">
											<td>카카오 가입</td>
										</c:if>
										<c:if test="${not empty userVO.userNaver}">
											<td>네이버 가입</td>
										</c:if>
										<c:if test="${empty userVO.userKakao && empty userVO.userNaver}">
											<td>자체 가입</td>
										</c:if>
										<td>${userVO.userCertification}</td>
										<td>${userVO.userHaltDate > 0 ? userVO.userHaltDate : 0 }</td>
										<c:if test="${userVO.userLeave == '0' and (userVO.userHaltDate <= 0 or empty userVO.userHaltDate)}">
											<td>활동</td>
										</c:if>
										<c:if test="${userVO.userLeave == '1'}">
											<td>탈퇴</td>
										</c:if>
										<c:if test="${userVO.userHaltDate > 0 }">
											<td>정지</td>
										</c:if>
										<td id="adminUserBtn"><c:if test="${!(userVO.userLeave == '1')}">
												<!-- 활동회원 -->
												<c:if test="${!(userVO.userHaltDate > 0) }">
												<span id="adminUserHalt" class="label label-default"><a>정지</a></span>
												</c:if>
											 	<c:if test="${userVO.userHaltDate > 0 }">
													<!-- 정지된 user -->
													<span id="adminUserHaltCancel" class="label label-default"><a>정지취소</a></span>
												</c:if>
												<span id="adminUserDelete" class="label label-danger"><a>탈퇴</a></span>
											</c:if> <c:if test="${!(userVO.userLeave == '0')}">
												<!-- 탈퇴회원 -->
												<span id="adminUserCancel" class="label label-danger"><a>철회</a></span>
											</c:if></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="paginationBox">
							<ul class="pagination">
								<c:if test="${pageMaker.prev }">
									<li><a href="user${pageMaker.makeNotice(pageMaker.startPage -1) }" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
								</c:if>
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
									<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}" />><a href="user${pageMaker.makeNotice(idx) }">${idx }</a></li>
								</c:forEach>
								<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
									<li><a href="user${pageMaker.makeNotice(pageMaker.endPage + 1) }" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footerAdmin.jsp" />
<script type="text/javascript" src="/resources/dist/js/admin/admin.js"></script>