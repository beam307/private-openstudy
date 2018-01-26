<jsp:include page="include/header.jsp" flush="false"/>
<div id="visual">
	<div id="video-bg">
		<iframe class="mobile-none" id="ytplayer" src="https://youtube.com/embed/C10KO5TnNOc?&version=3&loop=1&mute=1&start=90&controls=0&rel=0&autoplay=1&amp;loop=1&amp;controls=0&showinfo=0">
      	</iframe>
	</div>
	<div id="visual-content">
		<h1>
			<a onclick="return false;" class="typewrite" data-period="2000" data-type='[ "오픈스터디는 쉽고 빠른 스터디 매칭 서비스입니다", "지금 나에게 딱 맞는 스터디를 찾아보세요" ]'>
			<span class="wrap"></span>
			</a>
		</h1>
		<!-- 메인 검색 -->
		<form class="form-inline" action="/study/studyList">
			<div class="form-group label-floating">
				<input type="hidden" name="searchType" value="t" /> <label class="control-label">검색어를 입력해주세요.</label>
				<input type="text" class="form-control" name="keyword" id="searchBox">
			</div>
			<button type="submit" class="btn btn-default">검색</button>
		</form>
		<div class="scroll-downs">
		  <div class="mousey">
		    <div class="scroller"></div>
		  </div>
		</div>
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
		RECOMMENDING STUDY <a href="/study/studyList?page=1&perPageNum=9&searchType&keyword=&lineUp=f&upRegion&downRegion&upCategory&category" class="more">더보기</a>
	</h1>
	<h2 class="line"></h2>
	<div id="subInfoAdd" style="display:none">
		<p class="subTit">부가정보를 입력하시면 더 알맞는 스터디 정보를 보실 수 있습니다.</p>
		<div class="subTitBtnBox">
			<a href="/user/myPage?target=2" class="btn btn-primary subTitBtn">부가정보 입력하기</a>
		</div>
	</div>
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
				<a href='/study/studyView?studyNo={{studyNo}}' class="card-name">{{studyName}}</a>
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
		<a class="btn btn-primary btn-sm" href='/study/studyView?studyNo={{studyNo}}'>자세히보기</a>
	<div class="mailbox-attachment-info"></div>
</div>
</script>
<%@include file="/WEB-INF/views/common/variable.jspf"%>
<script src="/resources/dist/js/index.js"></script>
<jsp:include page="include/footer.jsp" flush="false"/>