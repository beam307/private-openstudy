	$(document).ready(function() {
		var formObj = $("form[role='form']");
		console.log(document.referrer);
		/* 목록으로버튼 클릭시  */
		$("#goListBtn").on("click", function() {
			if(document.referrer.indexOf('studyManage') != -1)
				location.href = "/user/studyManage?target=4";
			else
				location.href = "/studyList";
		});

		var studyNo = $('#studyNo').val();

		var template = Handlebars.compile($("#templateAttach").html());

		/* 제이슨으로 이미지 파일 불러오기  */
		$.getJSON("/study/getImgEnd/" + studyNo, function(list) {
			$(list).each(function(index) {
				var fileInfo = getFileInfo(this);
				if (index == 0) {
					$("#img-slide").append("<div class='item active'><img src="+fileInfo.imgsrc+" alt='스터디 이미지'></div>");
					$("#img-slide-target").append("<li data-target='#carousel-example-generic' data-slide-to="+index+" class='active'></li>");
				} else {
					$("#img-slide").append("<div class='item'><img src="+fileInfo.imgsrc+" alt='스터디 이미지'></div>");
					$("#img-slide-target").append("<li data-target='#carousel-example-generic' data-slide-to="+index+"></li>");
				}
				/* var html = template(fileInfo);
				$(".uploadedList").append(html); */
			});
		});

		/* upCategory 출력 */
		var upCategoryStr = $('#studyUpCategory').val();
		var upCategoryArr = upCategoryStr.split(',');
		var uniq = upCategoryArr.slice().sort(function(a, b) { //복사본 생성
			return a - b;
		}).reduce(function(a, b) {
			if (a.slice(-1)[0] !== b)
				a.push(b); // slice(-1)[0] 을 통해 마지막 아이템을 가져온다.
			return a;
		}, []); //a가 시작될 때를 위한 비어있는 배열

		for (let i = 0; i < uniq.length; i++) {
			$("#output-upCategory").append("<div class='view-category'>" + uniq[i] + "</div>");
		}
	});