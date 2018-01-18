<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/headerAdmin.jsp"%>
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
                                <li class="bg_lh"> <strong id="todayVisit"></strong> <small>오늘 방문자 수 </small></li>
                                <li class="bg_lh"> <strong id="yesterdayVisit"></strong> <small>어제 방문자 수</small></li>
                                <li class="bg_lh"> <strong id="weekVisit"></strong> <small>1주 방문자 수</small></li>
                                <li class="bg_lh"> <strong>${totalVisit}</strong> <small>총 방문자 수</small></li>
                                <li class="bg_lh"> <strong id="todayReg"></strong> <small>오늘 가입 수</small></li>
                                <li class="bg_lh"> <strong id="yesterdayReg"></strong> <small>어제 가입 수</small></li>
                                <li class="bg_lh"> <strong id="weekReg"></strong> <small>1주 가입 수</small></li>
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
<%@include file="../include/footerAdmin.jsp"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {'packages': ['line']});
	google.charts.setOnLoadCallback(drawChart1);

	var today = new Date(); // 오늘 날짜
	var before = new Array(); // 이전 날짜 배열

	for(var i = 1 ; i < 7 ; i ++) { // 1주일전까지 날짜 구하기
		before[i] = new Date(today.getTime() - (i * 24 * 60 * 60 * 1000)); // ex) before[1] = 1일전 , before[2] = 2일전
		before[i] = before[i].getDate() + '일';
	}
	today = today.getDate() + '일'; // 오늘 날짜에서 '일'만
	
	var visitCnt = new Array(7); // 방문자수 배열
	<c:forEach items="${weekVisit}" var="weekVisit" varStatus="status">
		visitCnt['${status.index}'] = ${weekVisit}; // 배열에 방문자수 넣기
	</c:forEach>
		
	var regCnt = new Array(7); // 회원가입수 배열
	<c:forEach items="${weekUserReg}" var="weekUserReg" varStatus="status">
		regCnt['${status.index}'] = ${weekUserReg}; // 배열에 방문자수 넣기
	</c:forEach>
	
	var max1 = 0;
	var max2 = 0;
	var weekVisit = 0; // 최신 1주일간 방문자 수
	for(var i = 0; i < 7; i++) { // 1주일간 방문자수 더하기
		weekVisit += visitCnt[i];
		if(max1 < visitCnt[i])
			max1 = visitCnt[i];
	}
	
	var weekReg = 0; // 최신 1주일간 방문자 수
	for(var i = 0; i < 7; i++) { // 1주일간 가입자수 더하기
		weekReg += regCnt[i];
		if(max2 < regCnt[i])
			max2 = regCnt[i];
	}
	
	$('#todayVisit').html(visitCnt[0]); // 오늘 방문자수
	$('#yesterdayVisit').html(visitCnt[1]); // 어제 방문자수
	$('#weekVisit').html(weekVisit); // 최근 일주일 방문자수
	$('#todayReg').html(regCnt[0]); // 오늘 가입자수
	$('#yesterdayReg').html(regCnt[1]); // 어제 가입자수
	$('#weekReg').html(weekReg); // 최근 일주일 가입자수
   
	function drawChart1() {

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Day');
		data.addColumn('number', '방문자 수');
		data.addColumn('number', '회원가입 수');

		data.addRows([
			[before[6], visitCnt[6], regCnt[6]],
			[before[5], visitCnt[5], regCnt[5]],
			[before[4], visitCnt[4], regCnt[4]],
			[before[3], visitCnt[3], regCnt[3]],
			[before[2], visitCnt[2], regCnt[2]],
			[before[1], visitCnt[1], regCnt[1]],
			[today, visitCnt[0], regCnt[0]]
		]);

		var options = {
	  		legend : {position: 'bottom'}, // 범례 위, 아래 지원 X
			chart: {
				title: '사용자 통계',
			subtitle: '일일 방문자 및 회원가입 수'
			},
			series: {
		        0: {targetAxisIndex: 0},
		        1: {targetAxisIndex: 1}
	      	},
	      	vAxes: {
				0: {viewWindow : {max : max1 + 4}},
				1: {viewWindow : {max : max2 + 4}}
			},
			vAxis:{
				gridlines: {count: 0},
	       
			},
			hAxis: {
				gridlines: {count: 2}
			},
			colors: ['#620017','#0066ff'],
		};

		var chart = new google.charts.Line(document.getElementById('chart1'));
		
		chart.draw(data, google.charts.Line.convertOptions(options));

	}

	google.charts.load('current', {'packages': ['line']});
	google.charts.setOnLoadCallback(drawChart2);

	var today = new Date(); // 오늘 날짜
	var before = new Array(); // 이전 날짜 배열
	
	for(var i = 1 ; i < 7 ; i ++) { // 1주일전까지 날짜 구하기
		before[i] = new Date(today.getTime() - (i * 24 * 60 * 60 * 1000)); // ex) before[1] = 1일전 , before[2] = 2일전
		before[i] = before[i].getDate() + '일';
	}
	today = today.getDate() + '일'; // 오늘 날짜에서 '일'만
	
	var studyRegCnt = new Array(7); // 스터디 등록수 배열
	<c:forEach items="${weekStudyReg}" var="weekStudyReg" varStatus="status">
		studyRegCnt['${status.index}'] = ${weekStudyReg}; // 배열에 등록수 넣기
	</c:forEach>
		
	var studyApplyCnt = new Array(7); // 스터디 신청수 배열
	<c:forEach items="${weekStudyApply}" var="weekStudyApply" varStatus="status">
		studyApplyCnt['${status.index}'] = ${weekStudyApply}; // 배열에 신청수 넣기
	</c:forEach>
		
	var studyEndCnt = new Array(7); // 스터디 완료수 배열
	<c:forEach items="${weekStudyEnd}" var="weekStudyEnd" varStatus="status">
		studyEndCnt['${status.index}'] = ${weekStudyEnd}; // 배열에 완료수 넣기
	</c:forEach>
	var max = 0;
	var weekStudyReg = 0; // 최신 1주일간 스터디 등록 수
	for(var i = 0; i < 7; i++) { // 1주일간 스터디 등록 더하기
		weekStudyReg += studyRegCnt[i];
		if(max < studyRegCnt[i])
			max = studyRegCnt[i];
	}
	var weekStudyApply = 0; // 최신 1주일간 스터디 신청 수
	for(var i = 0; i < 7; i++) { // 1주일간 스터디 신청 더하기
		weekStudyApply += studyApplyCnt[i];
		if(max < studyApplyCnt[i])
			max = studyApplyCnt[i];
	}
	var weekStudyEnd = 0; // 최신 1주일간 스터디 완료 수
	for(var i = 0; i < 7; i++) { // 1주일간 스터디 완료 더하기
		weekStudyEnd += studyEndCnt[i];
		if(max < studyEndCnt[i])
			max = studyEndCnt[i];
	}
	
	$('#todayStudyReg').html(studyRegCnt[0]); // 오늘 스터디 등록 수
	$('#yesterdayStudyReg').html(studyRegCnt[1]); // 어제 스터디 등록 수
	$('#weekStudyReg').html(weekStudyReg); // 최근 1주간 스터디 등록 수
	$('#todayStudyApply').html(studyApplyCnt[0]); // 오늘 스터디 신청 수
	$('#yesterdayStudyApply').html(studyApplyCnt[1]); // 어제 스터디 신청 수
	$('#weekStudyApply').html(weekStudyApply); // 최근 1주간 스터디 신청 수
	$('#todayStudyEnd').html(studyEndCnt[0]); // 오늘 스터디 완료 수
	$('#yesterdayStudyEnd').html(studyEndCnt[1]); // 어제 스터디 완료 수
	$('#weekStudyEnd').html(weekStudyEnd); // 최근 1주간 스터디 완료 수
   
	function drawChart2() {

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Day');
	    data.addColumn('number', '스터디 등록');
	    data.addColumn('number', '스터디 신청');
	    data.addColumn('number', '스터디 완료');

		data.addRows([
			[before[6], studyRegCnt[6], studyApplyCnt[6], studyEndCnt[6]],
			[before[5], studyRegCnt[5], studyApplyCnt[5], studyEndCnt[5]],
			[before[4], studyRegCnt[4], studyApplyCnt[4], studyEndCnt[4]],
			[before[3], studyRegCnt[3], studyApplyCnt[3], studyEndCnt[3]],
			[before[2], studyRegCnt[2], studyApplyCnt[2], studyEndCnt[2]],
			[before[1], studyRegCnt[1], studyApplyCnt[1], studyEndCnt[1]],
			[today, studyRegCnt[0], studyApplyCnt[0], studyEndCnt[0]]
		]);

    	var options = {
		  	legend : {position: 'bottom'}, // 범례 위, 아래 지원X 
			chart: {
				title: '스터디 통계',
				subtitle: '일일  스터디 등록 및 신청,  완료  수'
			},
			vAxis:{
			       gridlines: {count: -1},
			       viewWindow : {max : max + 4}
			},
			hAxis: {
				gridlines: {count: 2}
			},
			colors: ['#620017','#0066ff', '#009933'],
		};

		var chart = new google.charts.Line(document.getElementById('chart2'));
		
		chart.draw(data, google.charts.Line.convertOptions(options));
	}
   
   $(window).resize(function(){
       drawChart1();
       drawChart2();
   });
</script>