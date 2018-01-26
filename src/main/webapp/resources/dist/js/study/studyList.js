$(document).ready(function() {

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