	google.charts.load('current', {'packages': ['line']});
	google.charts.setOnLoadCallback(drawChart1);

	var today = new Date(); // 오늘 날짜
	var before = new Array(); // 이전 날짜 배열

	for(var i = 1 ; i < 7 ; i ++) { // 1주일전까지 날짜 구하기
		before[i] = new Date(today.getTime() - (i * 24 * 60 * 60 * 1000)); // ex) before[1] = 1일전 , before[2] = 2일전
		before[i] = before[i].getDate() + '일';
	}
	today = today.getDate() + '일'; // 오늘 날짜에서 '일'만
	
	var userVisitCnt = new Array(7); // 방문자수 배열
	$.ajax({ // 배열에 방문자수 넣기
		type : 'post',
		url : '/admin/weekUserVisit',
		async: false,
		success : function(data) {
			for(var i in data) {
				userVisitCnt[i] = data[i];
			}
		}
	})
		
	var userRegCnt = new Array(7); // 회원가입수 배열
	$.ajax({ // 배열에 가입자수 넣기
		type : 'post',
		url : '/admin/weekUserReg',
		async: false,
		success : function(data) {
			for(var i in data) {
				userRegCnt[i] = data[i];
			}
		}
	})
	
	var max1 = 0;
	var max2 = 0;
	var weekUserVisit = 0; // 최신 1주일간 방문자 수
	for(var i = 0; i < 7; i++) { // 1주일간 방문자수 더하기
		weekUserVisit += userVisitCnt[i];
		if(max1 < userVisitCnt[i])
			max1 = userVisitCnt[i];
	}
	
	var weekUserReg = 0; // 최신 1주일간 방문자 수
	for(var i = 0; i < 7; i++) { // 1주일간 가입자수 더하기
		weekUserReg += userRegCnt[i];
		if(max2 < userRegCnt[i])
			max2 = userRegCnt[i];
	}
	
	$('#todayUserVisit').html(userVisitCnt[0]); // 오늘 방문자수
	$('#yesterdayUserVisit').html(userVisitCnt[1]); // 어제 방문자수
	$('#weekUserVisit').html(weekUserVisit); // 최근 일주일 방문자수
	$('#todayUserReg').html(userRegCnt[0]); // 오늘 가입자수
	$('#yesterdayUserReg').html(userRegCnt[1]); // 어제 가입자수
	$('#weekUserReg').html(weekUserReg); // 최근 일주일 가입자수
   
	function drawChart1() {

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Day');
		data.addColumn('number', '방문자 수');
		data.addColumn('number', '회원가입 수');

		data.addRows([
			[before[6], userVisitCnt[6], userRegCnt[6]],
			[before[5], userVisitCnt[5], userRegCnt[5]],
			[before[4], userVisitCnt[4], userRegCnt[4]],
			[before[3], userVisitCnt[3], userRegCnt[3]],
			[before[2], userVisitCnt[2], userRegCnt[2]],
			[before[1], userVisitCnt[1], userRegCnt[1]],
			[today, userVisitCnt[0], userRegCnt[0]]
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
	$.ajax({ // 배열에 등록수 넣기
		type : 'post',
		url : '/admin/weekStudyReg',
		async: false,
		success : function(data) {
			for(var i in data) {
				studyRegCnt[i] = data[i];
			}
		}
	})
	
	var studyApplyCnt = new Array(7); // 스터디 신청수 배열
	$.ajax({ // 배열에 신청수 넣기
		type : 'post',
		url : '/admin/weekStudyApply',
		async: false,
		success : function(data) {
			for(var i in data) {
				studyApplyCnt[i] = data[i];
			}
		}
	})	
		
	var studyEndCnt = new Array(7); // 스터디 완료수 배열
	$.ajax({ // 배열에 완료수 넣기
		type : 'post',
		url : '/admin/weekStudyEnd',
		async: false,
		success : function(data) {
			for(var i in data) {
				studyEndCnt[i] = data[i];
			}
		}
	})
	
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