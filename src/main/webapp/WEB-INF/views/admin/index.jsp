<jsp:include page="../include/headerAdmin.jsp" />
<!--sidebar-menu-->
<div id="sidebar">
    <ul>
        <li class="active"><a href="/admin/index"><i class="icon icon-signal"></i> <span>통계</span></a></li>
        <li><a href="/admin/user"><i class="fa fa-users" aria-hidden="true"></i> <span>회원</span></a></li>
        <li><a href="/admin/study"><i class="icon icon-pencil"></i> <span>스터디</span></a></li>
        <li><a href="/board/noticeList"><i class="icon icon-info-sign"></i> <span>공지사항</span></a></li>
        <li><a href="/board/qnAList"><i class="fa fa-quora" aria-hidden="true"></i> <span>FAQ</span></a></li>
    </ul>
</div>
<!--sidebar-menu-->
<!--main-container-part-->
<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb">
        	<a href="/admin/index" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
        	<a href="/admin/index" class="current">통계</a>
        </div>
        <h1>통계</h1>
    </div>
    <!--End-breadcrumbs-->

    <!--Action boxes-->
    <div class="container-fluid">
        <!--Chart-box-->
        <div class="row-fluid content-box">
            <div class="widget-box">
                <div class="widget-title bg_lg"><span class="icon"><i class="icon-signal"></i></span>
                    <h5>사용자 통계</h5>
                </div>
                <div class="widget-content">
                    <div class="row-fluid">
                        <div class="span12">
                            <div id="chart1" class="chart"></div>
                        </div>
                        <div class="span12 ">
                            <ul class="site-stats site-stats1">
                                <li class="bg_lh"> <strong id="todayUserVisit"></strong> <small>오늘 방문자 수 </small></li>
                                <li class="bg_lh"> <strong id="yesterdayUserVisit"></strong> <small>어제 방문자 수</small></li>
                                <li class="bg_lh"> <strong id="weekUserVisit"></strong> <small>1주 방문자 수</small></li>
                                <li class="bg_lh"> <strong>${totalUserVisit}</strong> <small>총 방문자 수</small></li>
                                <li class="bg_lh"> <strong id="todayUserReg"></strong> <small>오늘 가입 수</small></li>
                                <li class="bg_lh"> <strong id="yesterdayUserReg"></strong> <small>어제 가입 수</small></li>
                                <li class="bg_lh"> <strong id="weekUserReg"></strong> <small>1주 가입 수</small></li>
                                <li class="bg_lh"> <strong>${totalUserReg}</strong> <small>총 가입 수</small></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Chart-box-->
        <div class="row-fluid content-box">
            <div class="widget-box">
                <div class="widget-title bg_lg"><span class="icon"><i class="icon-signal"></i></span>
                    <h5>스터디 통계</h5>
                </div>
                <div class="widget-content">
                    <div class="row-fluid">
                        <div class="span12">
                            <div id="chart2" class="chart"></div>
                        </div>
                        <div class="span12">
                            <ul class="site-stats">
                                <li class="bg_lh"> <strong id="todayStudyReg"></strong> <small>오늘 등록 수 </small></li>
                                <li class="bg_lh"> <strong id="yesterdayStudyReg"></strong> <small>어제 등록 수</small></li>
                                <li class="bg_lh"> <strong id="weekStudyReg"></strong> <small>1주 등록 수</small></li>
                                <li class="bg_lh"> <strong>${totalStudyReg}</strong> <small>총 등록 수</small></li>
                                <li class="bg_lh"> <strong id="todayStudyApply"></strong> <small>오늘 신청 수</small></li>
                                <li class="bg_lh"> <strong id="yesterdayStudyApply"></strong> <small>어제 신청 수</small></li>
                                <li class="bg_lh"> <strong id="weekStudyApply"></strong> <small>1주 신청 수</small></li>
                                <li class="bg_lh"> <strong>${totalStudyApply}</strong> <small>총 신청 수</small></li>
                                <li class="bg_lh"> <strong id="todayStudyEnd"></strong> <small>오늘 완료 수</small></li>
                                <li class="bg_lh"> <strong id="yesterdayStudyEnd"></strong> <small>어제 완료 수</small></li>
                                <li class="bg_lh"> <strong id="weekStudyEnd"></strong> <small>1주 완료 수</small></li>
                                <li class="bg_lh"> <strong>${totalStudyEnd}</strong> <small>총 완료 수</small></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<!--end-main-container-part-->
<jsp:include page="../include/footerAdmin.jsp" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="/resources/dist/js/admin/adminindex.js"></script>