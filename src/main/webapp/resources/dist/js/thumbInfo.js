function thumbnailInfo(thumbnail, check) {
	var backgroundImg = "/displayFile?fileName=" + thumbnail.imagePath;

	var studyName = thumbnail.studyName;
	var userNick = thumbnail.userNick;
	var studyNo = thumbnail.studyNo;
	var studyRegion = thumbnail.studyRegion;
	var profileImg;
	profileImg = "/displayFile?fileName=" + thumbnail.profileImgPath;

	var startDate = thumbnail.date;
	var viewCnt = thumbnail.viewCnt;
	var curMemCnt = thumbnail.curMemCnt;
	var writer = thumbnail.writer;
	var reg;
	var app;
	var fin;
	var target;
	var test;
	if(check == 'reg'){
		reg=1;
		target=2;
	}
	if(check == 'app'){
		app=1;
		target=3;
	}
	if(check == 'finL'){ // 완료 스터디장일 경우; 
		fin = {studyNo : thumbnail.studyNo, studyName : thumbnail.studyName, studyLeader : 1};
	}
	if(check == 'finM'){ // 완료 스터디원일 경우
		fin = {studyNo : thumbnail.studyNo, studyName : thumbnail.studyName};
	}
		
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
