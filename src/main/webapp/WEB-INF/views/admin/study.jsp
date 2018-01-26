<jsp:include page="../include/headerAdmin.jsp" />
<!--sidebar-menu-->
<div id="sidebar">
	<ul>
	    <li><a href="/admin/index"><i class="icon icon-signal"></i> <span>통계</span></a></li>
	    <li><a href="/admin/user"><i class="fa fa-users" aria-hidden="true"></i> <span>회원</span></a></li>
	    <li class="active"><a href="/admin/study"><i class="icon icon-pencil"></i> <span>스터디</span></a></li>
	    <li><a href="/board/noticeList"><i class="icon icon-info-sign"></i> <span>공지사항</span></a></li>
	    <li><a href="/board/qnAList"><i class="fa fa-quora" aria-hidden="true"></i> <span>FAQ</span></a></li>
	</ul>
</div>
<!--sidebar-menu-->
<div id="content">
    <div id="content-header">
        <div id="breadcrumb"> <a href="/admin/index" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="/admin/study" class="current">스터디</a> </div>
        <h1>스터디</h1>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
                        <form action="/admin/study" method="get" class="form-inline search">
                            <div class="form-group">
                                <input type="text" class="form-control" id="exampleInputEmail2" name="keyword" placeholder="스터디명을 입력 하세요" value="${cri.keyword}">
                            </div>
                            <button type="submit" class="btn btn-default">검색</button>
                        </form>
                    </div>
                    <div class="widget-content nopadding">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                	<th style="width:3%">번호</th>
									<th style="width:10%">스터디명</th>
									<th>대-카테고리</th>
									<th style="width:10%">소-카테고리</th>
									<th>지역</th>
									<th>작성자 번호</th>
									<th>작성자 닉네임</th>
									<th style="width:4%">인원</th>
									<th style="width:4%">조회 수</th>
									<th style="width:4%">댓글 수</th>
									<th style="width:5%">북마크 수</th>
									<th>시작 날짜</th>
									<th>완료 날짜</th>
									<th>등록 날짜</th>
									<th>수정 날짜</th>
									<th>상태</th>
									<th>스터디삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${studyList}" var="studyVO">
									<fmt:formatDate value="${studyVO.studyRegDate}" pattern="yyyy-MM-dd" var="studyRegDate" />
									<fmt:formatDate value="${studyVO.studyUpdateDate}" pattern="yyyy-MM-dd" var="studyUpdateDate" />
									<fmt:formatDate value="${studyVO.studyStartDate}" pattern="yyyy-MM-dd" var="studyStartDate" />
									<fmt:formatDate value="${studyVO.studyEndDate}" pattern="yyyy-MM-dd" var="studyEndDate" />
									<tr class="odd2 gradeX">
										<td id="studyNo">${studyVO.studyNo}</td>
										<td>${studyVO.studyName}</td>
										<td>${studyVO.studyUpCategory}</td>
										<td>${studyVO.studyCategory}</td>
										<td>${studyVO.studyUpRegion}${studyVO.studyDownRegion}</td>
										<td>${studyVO.studyWriter}</td>
										<td>${studyVO.userNick}</td>
										<td>${studyVO.studyCurMemCnt}/${studyVO.studyMaxMemCnt}</td>
										<td>${studyVO.studyViewCnt}</td>
										<td>${studyVO.studyReplyCnt}</td>
										<td>${studyVO.studyFavCnt}</td>
										<td>${studyStartDate}</td>
										<td>${studyEndDate}</td>
										<td>${studyRegDate}</td>
										<td>${studyUpdateDate}</td>
										<c:if test="${studyVO.studyDelete == '0' and empty studyEndDate}">
											<td>진행</td>
										</c:if>
										<c:if test="${studyVO.studyDelete == '1'}">
											<td>삭제</td>
										</c:if>
										<c:if test="${not empty studyEndDate}">
											<td>완료</td>
										</c:if>
										<td>
											<c:if test="${!(studyVO.studyDelete == '1') && empty studyEndDate}"> <!-- 개시중인 스터디 -->
												<span id="adminStudyDelete" class="label label-danger"><a>삭제</a></span>
											</c:if>
											<c:if test="${studyVO.studyDelete == '1'}"> <!-- 삭제된 스터디 -->
												<span id="adminStudyDeleteCancel" class="label label-danger"><a>삭제취소</a></span>
											</c:if>
											<c:if test="${not empty studyEndDate}">
												<span class="label label-danger"><a>삭제불가</a></span>
											</c:if>
										</td>
									</tr>
								</c:forEach>
                            </tbody>
                        </table>
                        <div class="paginationBox">
                            <ul class="pagination">
                            	<c:if test="${pageMaker.prev }">
                                	<li><a href="study${pageMaker.makeNotice(pageMaker.startPage -1) }" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                                </c:if>
                                <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
									<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}" />><a href="study${pageMaker.makeNotice(idx) }">${idx }</a></li>
								</c:forEach>
                                <c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
									<li><a href="study${pageMaker.makeNotice(pageMaker.endPage + 1) }" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
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