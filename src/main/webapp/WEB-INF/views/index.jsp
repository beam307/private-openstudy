<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>


<div id="visual">
	<div id="video-bg">
		<iframe class="mobile-none" id="ytplayer"
         src="https://youtube.com/embed/ps_K23M7Sfs?loop=1&disablekb=0&mute=1&rel=0&controls=0&autoplay=1&amp;controls=0&showinfo=0&wmode=opaque">
      	</iframe>
	</div>
	<div id="visual-content">
		<h1>
			<a onclick="return false;" class="typewrite" data-period="2000" data-type='[ "오픈스터디는 쉽고 빠른 스터디 매칭 서비스입니다", "지금 나에게 딱 맞는 스터디를 찾아보세요" ]'> <span
				class="wrap"></span>
			</a>
		</h1>
		<!-- 메인 검색 -->
		<form class="form-inline" action="/study/studyList">
			<div class="form-group label-floating">
				<input type="hidden" name="searchType" value="t" /> <label class="control-label">검색어를 입력해주세요.</label> <input type="text"
					class="form-control" name="keyword" id="searchBox">
			</div>
			<button type="submit" class="btn btn-default">검색</button>
		</form>
	</div>
</div>
<!-- 최신 스터디 -->
<div class="container main-thumbnail">
	<h1>
		NEW STUDY <a href="/studyList" class="more">더보기</a>
	</h1>
	<h2 class="line"></h2>
	<div class="study-thumbnail">
		<div class="row" id="studyList-thumbnail"></div>
	</div>
</div>
<!-- 베스트 스터디 -->
<div class="container main-thumbnail">
	<h1>
		BEST STUDY <a href="/study/studyList?page=1&perPageNum=9&searchType&keyword=&lineUp=f&upRegion&downRegion&upCategory&category" class="more">더보기</a>
	</h1>
	<h2 class="line"></h2>
	<div class="study-thumbnail">
		<div class="row" id="studyList-thumbnail-Line"></div>
	</div>
</div>
<!-- 추천 스터디 -->
<div class="container main-thumbnail recommend">
	<h1>
		RECOMMENDING STUDY <a href="/study/studyList?page=1&perPageNum=9&searchType&keyword=&lineUp=f&upRegion&downRegion&upCategory&category"
			class="more">더보기</a>
	</h1>
	<h2 class="line"></h2>
	<div class="study-thumbnail">
		<div class="row" id="userRecommend"></div>
	</div>
</div>

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
			<span class="icon"><i class="fa fa-eye" aria-hidden="true"></i>{{viewCnt}}</span><span class="icon">
				<i class="fa fa-user" aria-hidden="true"></i>{{curMemCnt}}</span>
		</div>
		<div class="info">
			<div class="title">
				<a target="_blank" class="userNick_link" data-writer={{writer}} href="#">{{userNick}}</a>
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

		var msg = "${msg}";
		if (msg == 'delete')
			alert('회원탈퇴 하였습니다.');

		/* 스터디리스트 썸네일과같이 출력  */
		var template = Handlebars.compile($("#templateList").html());
		var templateLine = Handlebars.compile($("#templateList").html());
		var templateUserFav = Handlebars.compile($("#templateList").html());

		var userRecommendCnt = 0;

		/* 최신 */
		<c:forEach items="${list}" varStatus="listIdx" var="studyVO">
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
		}
		var thumbInfo = thumbnailInfo(thumbnail);
		var html = template(thumbInfo);

		$("#studyList-thumbnail").append(html);
		</c:forEach>

		/* 베스트 */
		<c:forEach items="${listLine}" varStatus="listIdx" var="studyVO">
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
		}
		var thumbInfo = thumbnailInfo(thumbnail);
		var html = templateLine(thumbInfo);

		$("#studyList-thumbnail-Line").append(html);
		</c:forEach>

		/* 관심 지역 */
		<c:forEach items="${userFavRegion}" varStatus="listIdx" var="studyVO">
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
		}
		var thumbInfo = thumbnailInfo(thumbnail);
		var html = templateUserFav(thumbInfo);

		$("#userRecommend").append(html);
		userRecommendCnt++;
		</c:forEach>

		/* 관심 카테고리 */
		<c:forEach items="${userFavCategory}" varStatus="listIdx" var="studyVO">
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
		}
		var thumbInfo = thumbnailInfo(thumbnail);
		var html = templateUserFav(thumbInfo);

		$("#userRecommend").append(html);
		userRecommendCnt++;
		</c:forEach>

		/* 랜덤 */
		<c:forEach items="${listRand}" varStatus="listIdx" var="studyVO">
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
		}
		var thumbInfo = thumbnailInfo(thumbnail);
		var html = templateUserFav(thumbInfo);

		$("#userRecommend").append(html);
		</c:forEach>

		/* 로그인 되어있고, 추천이 없으면 지우기 
		<c:if test="${not empty login}">
		if (userRecommendCnt == 0)
			$(".recommend").html("부가정보를 입력하시면 ${login.userNick}님에게 더 알맞는 스터디를 추천해드립니다<i class='fa fa-angle-double-down' aria-hidden='true'></i>");
		</c:if> */

		/* userInfo 새창 띄우기  */
		$(".userNick_link").on("click", function(event) {
			event.preventDefault();
			var writerNo = $(this).attr('data-writer');
			window.open("/user/userInfo?userNo=" + writerNo, "userInfo", "location=no, left=400px, top=100px, width=600px, height=700px");
		});
	});
</script>
<%@include file="include/footer.jsp"%>