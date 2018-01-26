function thumbnailInfo(thumbnail, check) {
	var backgroundImg = "/displayFile?fileName=" + thumbnail.backgroundImg;
	var studyName = thumbnail.studyName;
	var userNick = thumbnail.userNick;
	var studyRegion = thumbnail.studyRegion;
	var studyNo = thumbnail.studyNo;
	var profileImg = "/displayFile?fileName=" + thumbnail.profileImg;
	var startDate = thumbnail.startDate;
	var viewCnt = thumbnail.viewCnt;
	var curMemCnt = thumbnail.curMemCnt;
	var writer = thumbnail.writer;
	
	var reg;
	var app;
	var fin;
	var target;
	var test;
	
	if (check == 'reg') {
		reg=1;
		target=2;
	}
	if (check == 'app') {
		app=1;
		target=3;
	}
	if (check == 'fin') // 완료 스터디장일 경우; 
		fin = {studyNo : thumbnail.studyNo, studyName : thumbnail.studyName, studyLeader : thumbnail.studyLeader}; // 리더 체크 (값이 있으면 스터디장, 없으면 스터디원)
		
	return {
		backgroundImg : backgroundImg,
		studyName : studyName,
		userNick : userNick,
		studyRegion : studyRegion,
		studyNo : studyNo,
		profileImg : profileImg,
		startDate : startDate,
		viewCnt : viewCnt,
		curMemCnt : curMemCnt,
		writer : writer,
		target : target,
		reg : reg, // 등록
		app : app, // 신청
		fin : fin // 완료
	}
	
}
