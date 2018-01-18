<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/headerSub.jsp"%>
<%
	response.addHeader("Cache-control", "no-store");
%>
<script type="text/javascript" src="/resources/dist/js/items.js"></script>
<div class="list_bg">
	<div class="container list inner">
		<div class="col-md-12 search-sub">
			<!-- <div class="search-typebtn">
				<button type="button" class="btn btn-default">스터디검색</button>
				<button type="button" class="btn btn-default">방검색</button>
			</div> -->
			<div class="form-inline">
				<form>
					<div class="form-group col-md-7 label-floating">
						<input type="hidden" name="searchType" value="t" /> <label class="control-label">검색어를 입력해주세요.</label> <input type="text"
							class="form-control" name="keyword" id="searchBox">
					</div>
					<div class="form-group col-md-3 label-floating">
						<button type="submit" class="btn btn-default" data-dismiss="modal">검색</button>
					</div>
				</form>
				<div class="form-group col-md-6 label-floating">
					<label class="control-label">지역 대분류</label> <select class="form-control filtering">
						<option value="studyList${pageMaker.makeUpRegion('n') }" <c:out value="${cri.upRegion eq 'n'?'selected':''}"/>>---</option>
						<option value="studyList${pageMaker.makeUpRegion('11') }" <c:out value="${cri.upRegion eq '11'?'selected':''}"/>>서울</option>
						<option value="studyList${pageMaker.makeUpRegion('21') }" <c:out value="${cri.upRegion eq '21'?'selected':''}"/>>부산</option>
						<option value="studyList${pageMaker.makeUpRegion('22') }" <c:out value="${cri.upRegion eq '22'?'selected':''}"/>>대구</option>
						<option value="studyList${pageMaker.makeUpRegion('23') }" <c:out value="${cri.upRegion eq '23'?'selected':''}"/>>인천</option>
						<option value="studyList${pageMaker.makeUpRegion('24') }" <c:out value="${cri.upRegion eq '24'?'selected':''}"/>>광주</option>
						<option value="studyList${pageMaker.makeUpRegion('25') }" <c:out value="${cri.upRegion eq '25'?'selected':''}"/>>대전</option>
						<option value="studyList${pageMaker.makeUpRegion('26') }" <c:out value="${cri.upRegion eq '26'?'selected':''}"/>>울산</option>
						<option value="studyList${pageMaker.makeUpRegion('29') }" <c:out value="${cri.upRegion eq '29'?'selected':''}"/>>세종</option>
						<option value="studyList${pageMaker.makeUpRegion('31') }" <c:out value="${cri.upRegion eq '31'?'selected':''}"/>>경기</option>
						<option value="studyList${pageMaker.makeUpRegion('32') }" <c:out value="${cri.upRegion eq '32'?'selected':''}"/>>강원</option>
						<option value="studyList${pageMaker.makeUpRegion('33') }" <c:out value="${cri.upRegion eq '33'?'selected':''}"/>>충북</option>
						<option value="studyList${pageMaker.makeUpRegion('34') }" <c:out value="${cri.upRegion eq '34'?'selected':''}"/>>충남</option>
						<option value="studyList${pageMaker.makeUpRegion('35') }" <c:out value="${cri.upRegion eq '35'?'selected':''}"/>>전북</option>
						<option value="studyList${pageMaker.makeUpRegion('36') }" <c:out value="${cri.upRegion eq '36'?'selected':''}"/>>전남</option>
						<option value="studyList${pageMaker.makeUpRegion('37') }" <c:out value="${cri.upRegion eq '37'?'selected':''}"/>>경북</option>
						<option value="studyList${pageMaker.makeUpRegion('38') }" <c:out value="${cri.upRegion eq '38'?'selected':''}"/>>경남</option>
						<option value="studyList${pageMaker.makeUpRegion('39') }" <c:out value="${cri.upRegion eq '39'?'selected':''}"/>>제주</option>
						<option value="studyList${pageMaker.makeUpRegion('40') }" <c:out value="${cri.upRegion eq '40'?'selected':''}"/>>전국</option>
					</select>
				</div>

				<div class="form-group col-md-6 label-floating">
					<label class="control-label">지역 소분류</label>
					<%@include file="downRegion.jsp"%>
					<!-- 지역 카테고리 데이터 -->
				</div>

				<div class="form-group col-md-6 label-floating">
					<label class="control-label">카테고리 대분류</label> <select class="form-control filtering">
						<option value="studyList${pageMaker.makeUpCategory('n') }" <c:out value="${cri.upCategory eq 'n'?'selected':''}"/>>---</option>
						<option value="studyList${pageMaker.makeUpCategory('0') }" <c:out value="${cri.upCategory eq '0'?'selected':''}"/>>영어</option>
						<option value="studyList${pageMaker.makeUpCategory('1') }" <c:out value="${cri.upCategory eq '1'?'selected':''}"/>>외국어</option>
						<option value="studyList${pageMaker.makeUpCategory('2') }" <c:out value="${cri.upCategory eq '2'?'selected':''}"/>>IT</option>
						<option value="studyList${pageMaker.makeUpCategory('3') }" <c:out value="${cri.upCategory eq '3'?'selected':''}"/>>교양</option>
						<option value="studyList${pageMaker.makeUpCategory('4') }" <c:out value="${cri.upCategory eq '4'?'selected':''}"/>>공무원</option>
					</select>
				</div>

				<div class="form-group col-md-6 label-floating">
					<label class="control-label">카테고리 소분류</label>
					<c:if test="${empty upCategory || upCategory == 'n' || upCategory == ''}">
						<select class="form-control filtering">
							<option value="studyList${pageMaker.makeCategory('n') }" <c:out value="${cri.category eq 'n'?'selected':''}"/>></option>
						</select>
					</c:if>
					<c:if test="${upCategory eq '0' }">
						<select class="form-control filtering">
							<option value="studyList${pageMaker.makeCategory('n') }" <c:out value="${cri.category eq 'n'?'selected':''}"/>>전체</option>
							<option value="studyList${pageMaker.makeCategory('00') }" <c:out value="${cri.category eq '00'?'selected':''}"/>>토익</option>
							<option value="studyList${pageMaker.makeCategory('01') }" <c:out value="${cri.category eq '01'?'selected':''}"/>>토플</option>
							<option value="studyList${pageMaker.makeCategory('02') }" <c:out value="${cri.category eq '02'?'selected':''}"/>>텝스</option>
							<option value="studyList${pageMaker.makeCategory('03') }" <c:out value="${cri.category eq '03'?'selected':''}"/>>토스/오픽</option>
							<option value="studyList${pageMaker.makeCategory('04') }" <c:out value="${cri.category eq '04'?'selected':''}"/>>영어회화</option>
							<option value="studyList${pageMaker.makeCategory('05') }" <c:out value="${cri.category eq '05'?'selected':''}"/>>작문/독해</option>
							<option value="studyList${pageMaker.makeCategory('06') }" <c:out value="${cri.category eq '06'?'selected':''}"/>>미드정복</option>
							<option value="studyList${pageMaker.makeCategory('07') }" <c:out value="${cri.category eq '07'?'selected':''}"/>>영어 기타</option>
						</select>
					</c:if>
					<c:if test="${upCategory eq '1' }">
						<select class="form-control filtering">
							<option value="studyList${pageMaker.makeCategory('n') }" <c:out value="${cri.category eq 'n'?'selected':''}"/>>전체</option>
							<option value="studyList${pageMaker.makeCategory('10') }" <c:out value="${cri.category eq '10'?'selected':''}"/>>중국어</option>
							<option value="studyList${pageMaker.makeCategory('11') }" <c:out value="${cri.category eq '11'?'selected':''}"/>>일본어</option>
							<option value="studyList${pageMaker.makeCategory('12') }" <c:out value="${cri.category eq '12'?'selected':''}"/>>독일어</option>
							<option value="studyList${pageMaker.makeCategory('13') }" <c:out value="${cri.category eq '13'?'selected':''}"/>>프랑스어</option>
							<option value="studyList${pageMaker.makeCategory('14') }" <c:out value="${cri.category eq '14'?'selected':''}"/>>스페인어</option>
							<option value="studyList${pageMaker.makeCategory('15') }" <c:out value="${cri.category eq '15'?'selected':''}"/>>러시아어</option>
							<option value="studyList${pageMaker.makeCategory('16') }" <c:out value="${cri.category eq '16'?'selected':''}"/>>베트남어</option>
							<option value="studyList${pageMaker.makeCategory('17') }" <c:out value="${cri.category eq '17'?'selected':''}"/>>태국어</option>
							<option value="studyList${pageMaker.makeCategory('18') }" <c:out value="${cri.category eq '18'?'selected':''}"/>>외국어 기타</option>
						</select>
					</c:if>
					<c:if test="${upCategory eq '2' }">
						<select class="form-control filtering">
							<option value="studyList${pageMaker.makeCategory('n') }" <c:out value="${cri.category eq 'n'?'selected':''}"/>>전체</option>
							<option value="studyList${pageMaker.makeCategory('20') }" <c:out value="${cri.category eq '20'?'selected':''}"/>>컴퓨터언어</option>
							<option value="studyList${pageMaker.makeCategory('21') }" <c:out value="${cri.category eq '21'?'selected':''}"/>>웹프로그래밍</option>
							<option value="studyList${pageMaker.makeCategory('22') }" <c:out value="${cri.category eq '22'?'selected':''}"/>>모바일프로그래밍</option>
							<option value="studyList${pageMaker.makeCategory('23') }" <c:out value="${cri.category eq '23'?'selected':''}"/>>데이터베이스/서버</option>
							<option value="studyList${pageMaker.makeCategory('24') }" <c:out value="${cri.category eq '24'?'selected':''}"/>>게임프로그래밍</option>
							<option value="studyList${pageMaker.makeCategory('25') }" <c:out value="${cri.category eq '25'?'selected':''}"/>>문서작성/편집</option>
							<option value="studyList${pageMaker.makeCategory('26') }" <c:out value="${cri.category eq '26'?'selected':''}"/>>컴퓨터자격증</option>
							<option value="studyList${pageMaker.makeCategory('27') }" <c:out value="${cri.category eq '27'?'selected':''}"/>>사물인터넷</option>
							<option value="studyList${pageMaker.makeCategory('28') }" <c:out value="${cri.category eq '28'?'selected':''}"/>>컴퓨터 기타</option>
						</select>
					</c:if>
					<c:if test="${upCategory eq '3' }">
						<select class="form-control filtering">
							<option value="studyList${pageMaker.makeCategory('n') }" <c:out value="${cri.category eq 'n'?'selected':''}"/>>전체</option>
							<option value="studyList${pageMaker.makeCategory('30') }" <c:out value="${cri.category eq '30'?'selected':''}"/>>디자인/미술</option>
							<option value="studyList${pageMaker.makeCategory('31') }" <c:out value="${cri.category eq '31'?'selected':''}"/>>취업</option>
							<option value="studyList${pageMaker.makeCategory('32') }" <c:out value="${cri.category eq '32'?'selected':''}"/>>음악/공연</option>
							<option value="studyList${pageMaker.makeCategory('33') }" <c:out value="${cri.category eq '33'?'selected':''}"/>>스포츠</option>
							<option value="studyList${pageMaker.makeCategory('34') }" <c:out value="${cri.category eq '34'?'selected':''}"/>>뷰티/미용</option>
							<option value="studyList${pageMaker.makeCategory('35') }" <c:out value="${cri.category eq '35'?'selected':''}"/>>라이프스타일</option>
							<option value="studyList${pageMaker.makeCategory('36') }" <c:out value="${cri.category eq '36'?'selected':''}"/>>게임</option>
							<option value="studyList${pageMaker.makeCategory('37') }" <c:out value="${cri.category eq '37'?'selected':''}"/>>교양 기타</option>
						</select>
					</c:if>
					<c:if test="${upCategory eq '4' }">
						<select class="form-control filtering">
							<option value="studyList${pageMaker.makeCategory('n') }" <c:out value="${cri.category eq 'n'?'selected':''}"/>>전체</option>
							<option value="studyList${pageMaker.makeCategory('40') }" <c:out value="${cri.category eq '40'?'selected':''}"/>>행정</option>
							<option value="studyList${pageMaker.makeCategory('41') }" <c:out value="${cri.category eq '41'?'selected':''}"/>>교육</option>
							<option value="studyList${pageMaker.makeCategory('42') }" <c:out value="${cri.category eq '42'?'selected':''}"/>>경찰</option>
							<option value="studyList${pageMaker.makeCategory('43') }" <c:out value="${cri.category eq '43'?'selected':''}"/>>소방</option>
							<option value="studyList${pageMaker.makeCategory('44') }" <c:out value="${cri.category eq '44'?'selected':''}"/>>의료/보건</option>
							<option value="studyList${pageMaker.makeCategory('45') }" <c:out value="${cri.category eq '45'?'selected':''}"/>>사법</option>
							<option value="studyList${pageMaker.makeCategory('46') }" <c:out value="${cri.category eq '46'?'selected':''}"/>>기술</option>
							<option value="studyList${pageMaker.makeCategory('47') }" <c:out value="${cri.category eq '47'?'selected':''}"/>>공무원 기타</option>
						</select>
					</c:if>
				</div>
			</div>
		</div>
		<!-- Single button -->
		<div class="btn-group">
			<select class="form-control filtering" id="line-up">
				<option value="studyList${pageMaker.makeLineUp('n') }" <c:out value="${cri.lineUp == null?'selected':''}"/>>최신순</option>
				<option value="studyList${pageMaker.makeLineUp('f') }" <c:out value="${cri.lineUp eq 'f'?'selected':''}"/>>북마크순</option>
				<option value="studyList${pageMaker.makeLineUp('v') }" <c:out value="${cri.lineUp eq 'v'?'selected':''}"/>>조회순</option>
				<option value="studyList${pageMaker.makeLineUp('r') }" <c:out value="${cri.lineUp eq 'r'?'selected':''}"/>>댓글순</option>

			</select>
		</div>

		<!-- 썸네일 출력할 장소 -->
		<div class="sub-thumbnail">
			<div class="row" id="sub-thumbnail">
				<c:if test="${empty list}">
				검색 결과가 존재하지않습니다.
				</c:if>
			</div>
			<!-- 페이지네이션 -->
			<div class="pagination-nav">
				<ul class="pagination">
					<c:if test="${pageMaker.prev }">
						<li><a href="studyList${pageMaker.makeSearch(pageMaker.startPage -1) }">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
						<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}" />><a href="studyList${pageMaker.makeSearch(idx) }">${idx }</a></li>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
						<li><a href="studyList${pageMaker.makeSearch(pageMaker.endPage + 1) }">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/resources/dist/js/upload.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<!-- 템플릿 -->
<script id="templateList" type="text/x-handlebars-template">
<div class="col-md-4">
	<div class="card hovercard">
		<div class="cardheaderbox">
			<div class="cardheaderboxIn">
				<div class="cardheader" style="background: url({{backgroundImg}}); background-size: cover;"></div>
				<a href='/study/studyView?${pageMaker.makeSearch(pageMaker.cri.page)}&studyNo={{studyNo}}' class="card-name">{{studyName}}</a>
			</div>
		</div>
		<div class="avatar">
			<span class="mailbox-attachment-icon has-img"> 
			<img src="{{profileImg}}"></span>
			<span class="icon icon_1"><i class="fa fa-eye" aria-hidden="true"></i>{{viewCnt}}</span>
<span class="icon icon_2">
				<i class="fa fa-user" aria-hidden="true"></i>{{curMemCnt}}</span>
		</div>
		<div class="info">
			<div class="title">
				<a target="_blank" class="userNick_link" data-writer={{writer}} href='#'>{{userNick}}</a>
			</div>
			<div class="desc">{{studyRegion}}</div>
			<div class="desc info-bold">스터디 시작일 - {{startDate}}</div>
		</div>
		<a class="btn btn-primary btn-sm" href='/study/studyView?${pageMaker.makeSearch(pageMaker.cri.page)}&studyNo={{studyNo}}'>자세히보기</a>
	<div class="mailbox-attachment-info"></div>
</div>
</script>
<script>
	$(document).ready(function() {

		var applyResult = '${applyResult}'; // 스터디 신청여부
		/* 스터디리스트 썸네일과같이 출력  */
		if (applyResult == 'applyMsg') // 신청했을 경우 메시지
			alert('스터디를 신청 하셨습니다.');
		else if (applyResult == 'dupliApplyMsg') // 중복 신청 메시지
			alert('이미 신청한 스터디 입니다.');
		else if (applyResult == 'cancelMsg') // 취소 메시지
			alert('스터디신청을 취소 하였습니다.');
		else if (applyResult == 'noMsg') // 신청안할때 취소 메시지
			alert('신청하지 않은 스터디 입니다.');

		var template = Handlebars.compile($("#templateList").html());

		/* 리스트 페이지 썸네일과 같이 출력  --> 콜백순서대로 출력되니 정렬이 안되네 */
		<c:forEach items="${list}" var="studyVO">
		<fmt:formatDate value="${studyVO.studyStartDate}" pattern="yyyy-MM-dd" var="date" />
		var studyRegion = "${studyVO.studyUpRegion} " + "${studyVO.studyDownRegion}";
		var thumbnail = {
			imagePath : "${studyVO.imagePath}",
			studyName : "${studyVO.studyName}",
			userNick : "${studyVO.userNick}",
			studyRegion : studyRegion,
			studyNo : "${studyVO.studyNo}",
			profileImgPath : "${studyVO.userProfileImgPath}",
			date : "${date}",
			viewCnt : "${studyVO.studyViewCnt}",
			curMemCnt : "${studyVO.studyCurMemCnt}",
			writer : "${studyVO.studyWriter}"
		};

		var thumbInfo = thumbnailInfo(thumbnail);
		var html = template(thumbInfo);
		$("#sub-thumbnail").append(html);
		</c:forEach>

		$(".filtering").on("change", function() { // (데이터 유지한채 새로고침)
			window.location.href = $(this).val()
		});

		/*userInfo 새창 띄우기  */
		$(".userNick_link").on("click", function(event) {
			event.preventDefault();
			var writerNo = $(this).attr('data-writer');
			window.open("/user/userInfo?userNo=" + writerNo, "userInfo", "location=no, left=400px, top=100px, width=600px, height=700px");
		});

	});
</script>
<%@include file="../include/footerSub.jsp"%>