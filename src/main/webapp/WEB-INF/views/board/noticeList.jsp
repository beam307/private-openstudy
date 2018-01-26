<jsp:include page="../include/headerSub.jsp" flush="false"/>
<div class="notice container inner">
	<h1>공지사항</h1>
	<form action="/board/noticeList" method="get" class="searchForm">
		<div class="form-group col-md-12 label-floating">
			<label class="control-label">검색어를 입력해주세요.</label> <input type="text" class="form-control" name='keyword' id="keywordInput"
				value='${cri.keyword}'>
		</div>
		<button type="submit" class="btn btn-default" data-dismiss="modal">검색</button>

		<c:if test="${login.userAuth==1 }">
			<a class="btn btn-primary" href="/board/noticeReg">글쓰기</a>
		</c:if>
	</form>
	<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
		<c:if test="${empty list}">
			검색 결과가 존재하지않습니다.
		</c:if>
		<c:forEach items="${list }" var="noticeVO" varStatus="status">
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="heading${status.index + 1 }">
					<form role="form" action="/board/noticeMod" method="post">
						<input type="hidden" name="noticeNo" value="${noticeVO.noticeNo }">
					</form>
					<h4 class="panel-title">
						<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse${status.index + 1 }" aria-expanded="false"
							aria-controls="collapse${status.index + 1 }"> ${noticeVO.noticeTitle } <span class="date"> <fmt:formatDate
									pattern="yyyy-MM-dd HH:mm" value="${noticeVO.noticeRegDate }" />
						</span>
						</a>
						<c:if test="${login.userAuth==1 }">
							<a href='noticeMod?noticeNo=${noticeVO.noticeNo }' class="btn btn-danger" id="noticeModifyBtn">Modify</a>
							<a href='noticeRemove?noticeNo=${noticeVO.noticeNo }' class="btn btn-danger" id="noticeDeleteBtn">delete</a>
						</c:if>
					</h4>
				</div>
				<div id="collapse${status.index + 1 }" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${status.index + 1 }">
					<div class="panel-body">${noticeVO.noticeContent }</div>
				</div>
			</div>
		</c:forEach>
		<!-- 페이지네이션 -->
		<div class="pagination-nav">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li><a href="noticeList${pageMaker.makeNotice(pageMaker.startPage -1) }">&laquo;</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
					<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}" />><a href="noticeList${pageMaker.makeNotice(idx) }">${idx }</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
					<li><a href="noticeList${pageMaker.makeNotice(pageMaker.endPage + 1) }">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		
		/* 삭제버튼 클릭시  */
		$(document).on("click", '#noticeDeleteBtn', function() {
			formObj.attr("action", "/board/noticeRemove");
			formObj.submit();
		});

		/* 수정버튼 클릭시  */
		$(document).on("click", '#noticeModifyBtn', function() {
			formObj.attr("action", "/board/noticeMod");
			formObj.attr("method", "get");
			formObj.submit();
		});
	});
</script>
<jsp:include page="../include/footerSub.jsp" flush="false"/>