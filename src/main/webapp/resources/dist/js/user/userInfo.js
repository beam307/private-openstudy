$(document).ready(function() {
		$(".btn-pref .btn").click(function() {
		$(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
		// $(".tab").addClass("active"); // instead of this do the below 
		$(this).removeClass("btn-default").addClass("btn-primary");
	});

	/* 부모창에 신청스터디 띄우기  */
	$(".studyName_link").on("click", function(event) {
		event.preventDefault();
		var studyNo = $(this).attr('data-studyNo');
		window.opener.location.href = "/study/studyView?studyNo=" + studyNo;
		self.close();
	});

	/* 부모창에 완료스터디 띄우기  */
	$(".endStudyName_link").on("click", function(event) {
		event.preventDefault();
		var studyNo = $(this).attr('data-studyNo');
		window.opener.location.href = "/study/studyEndView?studyNo=" + studyNo;
		self.close();
	});
});