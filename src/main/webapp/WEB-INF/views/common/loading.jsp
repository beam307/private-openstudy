<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<link rel="icon" type="image/png" href="/resources/images/favicon.png" />
<style>
nav {
	display:none;
}
#loading {
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
	position: fixed;
	display: block;
	background-color: #fff;
	z-index: 999;
	text-align: center;
}

#loading-image {
    position: absolute;
    top: 44%;
    left: 47.5%;
    z-index: 100;
    width: 80px;
}
</style>
<script type="text/javascript">
	$(window).load(function() {
		$('#loading').hide();
		$('nav').show();
	});
</script>
</head>
<body>
<div id="loading"><img id="loading-image" src="/resources/images/loading.gif" alt="Loading..." /></div>
</body>
</html>