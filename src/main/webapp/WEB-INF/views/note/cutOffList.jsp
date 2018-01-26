<jsp:include page="../include/headerNote.jsp" flush="false"/>
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
										<fmt:formatDate value="${cutOffVO.cutOffRegDate}" pattern="yyyy-MM-dd" var="regDate" /> 
										<span>${regDate}</span>
									</h4>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<div class="div-btn">
					<input type="button" class="btn btn-danger" id='removeBtn' value='수신허용' />
					<input type="button" class="btn btn-danger" id='allCheckBtn' value='모두선택' />
					<input type="button" class="btn btn-danger" id='allCheckFalBtn' value='모두해제' />
				</div>
			</div>
		</div>
	</div>

	<!-- 페이지네이션 -->
	<div class="pagination-nav">
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
	</div>
</body>
<script type="text/javascript" src="/resources/dist/js/note.js"></script>
</html>
