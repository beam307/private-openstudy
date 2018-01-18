<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.addHeader("Cache-control", "no-store");
%>
<%@include file="../include/headerSub.jsp"%>
<div class="qnA container inner">
	<h1>자주 묻는 질문</h1>
	<form action="/board/qnAList" method="get" class="searchForm">
		<div class="form-group col-md-12 label-floating">
			<label class="control-label">검색어를 입력해주세요.</label> <input type="text" class="form-control" name='keyword' id="keywordInput"
				value='${cri.keyword}'>
		</div>
		<button type="submit" class="btn btn-default" data-dismiss="modal">검색</button>
		<c:if test="${login.userAuth==1 }">
			<a class="btn btn-primary" href="/board/qnAReg">글쓰기</a>
		</c:if>
	</form>
	<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
		<c:if test="${empty list}">
			검색 결과가 존재하지않습니다.
		</c:if>
		<c:forEach items="${list }" var="qnAVO" varStatus="status">
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="heading${status.index + 1 }">
					<form role="form" action="/board/qnAMod" method="post">
						<input type="hidden" name="qnANo" value="${qnAVO.qnANo }">
					</form>
					<h4 class="panel-title">
						<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse${status.index + 1 }" aria-expanded="false"
							aria-controls="collapse${status.index + 1 }">${qnAVO.qnATitle } <span class="name"> ${qnAVO.qnAWriterNick }</span>
						</a>
						<c:if test="${qnAVO.qnAWriterNo == login.userNo }">
							<a href='qnAMod?qnANo=${qnAVO.qnANo }' class="btn btn-danger" id="qnAModifyBtn">Modify</a>
							<a href='qnARemove?qnANo=${qnAVO.qnANo }' class="btn btn-danger" id="qnADeleteBtn">delete</a>
						</c:if>
					</h4>
				</div>
				<div id="collapse${status.index + 1 }" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${status.index + 1 }">
					<div class="panel-body">
						<p><textarea readonly="readonly" style="cursor: default; min-height: 150px; min-width: 1100px;" class="form-control " name="studyIntroduce" id="studyIntroduce">${qnAVO.qnAContent }</textarea></p>
						<!-- <div class="table-responsive reply m_t_20">
						</div> -->
					</div>
				</div>
			</div>
		</c:forEach>
		<!-- 페이지네이션 -->
		<nav class="pagination-nav">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li><a href="qnAList${pageMaker.makeNotice(pageMaker.startPage -1) }">&laquo;</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
					<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}" />><a href="qnAList${pageMaker.makeNotice(idx) }">${idx }</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
					<li><a href="qnAList${pageMaker.makeNotice(pageMaker.endPage + 1) }">&raquo;</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</div>
<script>
	$(document).ready(function() {
		/* 삭제버튼 클릭시  */
		$(document).on("click", '#qnADeleteBtn', function() {
			formObj.attr("action", "/board/qnARemove");
			formObj.submit();
		});

		/* 수정버튼 클릭시  */
		$(document).on("click", '#qnAModifyBtn', function() {
			formObj.attr("action", "/board/qnAMod");
			formObj.attr("method", "get");
			formObj.submit();
		});
	});
</script>
<%@include file="../include/footer.jsp"%>