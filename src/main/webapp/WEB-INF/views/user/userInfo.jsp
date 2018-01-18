<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!-- 썸네일 js -->
<script type="text/javascript" src="/resources/dist/js/thumbInfo.js"></script>
<!-- 템플릿 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
    <html>

    <head>
        <!-- 부트스트랩 -->
        <link href="/resources/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- 폰트어썸 -->
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <!-- jQUery-Ui -->
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.0/jquery-ui.min.js"></script>
        <!-- 부트스트랩 -->
        <script src="/resources/dist/js/bootstrap.min.js"></script>

        <style>
            .userInfo .card {
                padding: 30px;
                background-color: rgba(214, 224, 226, 0.2);
                -webkit-border-top-left-radius: 5px;
                -moz-border-top-left-radius: 5px;
                border-top-left-radius: 5px;
                -webkit-border-top-right-radius: 5px;
                -moz-border-top-right-radius: 5px;
                border-top-right-radius: 5px;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
            }
            
            .userInfo .card.hovercard {
                position: relative;
                padding-top: 0;
                overflow: hidden;
                text-align: center;
                background-color: #fff;
                background-color: rgba(255, 255, 255, 1);
            }
            
            .userInfo .card.hovercard .card-background {
                height: 200px;
            }
            
            .userInfo .card-background img {
                -webkit-filter: blur(25px);
                -moz-filter: blur(25px);
                -o-filter: blur(25px);
                -ms-filter: blur(25px);
                filter: blur(25px);
                margin-left: -100px;
                margin-top: -200px;
                min-width: 130%;
            }
            
            .userInfo .card.hovercard .useravatar {
                position: absolute;
                top: 20px;
                left: 0;
                right: 0;
            }
            
            .userInfo .card.hovercard .useravatar img {
                width: 150px;
                height: 150px;
                max-width: 150px;
                max-height: 150px;
                -webkit-border-radius: 50%;
                -moz-border-radius: 50%;
                border-radius: 50%;
                border: 5px solid rgba(255, 255, 255, 0.5);
            }
            
            .card.hovercard .card-info {
                position: absolute;
                bottom: 20px;
                left: 0;
                right: 0;
            }
            
            .userInfo .card.hovercard .card-info .card-title {
                display: inline-block;
                padding: 4px 5px;
                font-size: 16px;
                line-height: 1;
                color: #33000c;
                font-weight: 600;
                background-color: rgba(255, 255, 255, 0.1);
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
            }
            
            .userInfo .card.hovercard .card-info {
                overflow: hidden;
                font-size: 12px;
                line-height: 20px;
                color: #737373;
                text-overflow: ellipsis;
            }
            
            .userInfo .card.hovercard .bottom {
                padding: 0 20px;
                margin-bottom: 17px;
            }
            
            .userInfo .btn-pref .btn {
                -webkit-border-radius: 0 !important;
                margin-top: -1px;
                margin-bottom: 0;
                border: 1px solid #620017;
            }
            
            .userInfo .btn-pref .btn-primary {
                background: #620017;
            }
            
            .userInfo .btn-pref .btn i {
                font-size: 20px;
            }
            
            .userInfo .btn-pref .btn-default i {
                color: #620017;
            }
            
            .userInfo .well {
                padding: 30px;
                margin-bottom: 0;
                background-color: #fff;
    			border: 1px solid #fff;
            }
            
            .userInfo .user-info-tit {
                font-size: 12px;
                color: #777;
                margin-bottom: 25px;
            }
            
            .userInfo .user-info-con {
                font-size: 12px;
                color: #33000c;
                font-weight: bold;
                margin-bottom: 25px;
            }
            
            .userInfo .user-info-con small {
                padding-right: 5px;
                font-size:100%;
            }
            
            .userInfo .last {
                margin-bottom: 0;
            }
            
            .userInfo .prelast .studyList a{
            	color: #33000c;
            }
            
            .userInfo .last .studyList a{
            	color: #33000c;
            	cusor: default;
            }
            
            .userInfo .prelast .sm{
            	float: left
            }
            
            .userInfo .last .sm{
            	float: left
            }
            
            .userInfo .last .studyList{
            	float: left;
            }            
        </style>
    </head>

    <body onLoad="parent.resizeTo(600,600)" >

        <div class="userInfo">
            <div class="">
                <div class="card hovercard">
                    <div class="card-background">
                        <img class="card-bkimg" alt="" src="/displayFile?fileName=${userVO.userProfileImgPath }">
                    </div>
                    <div class="useravatar">
                        <img alt="" src="/displayFile?fileName=${userVO.userProfileImgPath }">
                    </div>
                    <div class="card-info"> <span class="card-title">${userVO.userNick }</span>

                    </div>
                </div>
                <div class="btn-pref btn-group btn-group-justified btn-group-lg" role="group" aria-label="...">
                    <div class="btn-group" role="group">
                        <button type="button" id="stars" class="btn btn-primary" href="#tab1" data-toggle="tab">
                            <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                            <div class="hidden-xs">Stars</div>
                        </button>
                    </div>
                    <div class="btn-group" role="group">
                        <button type="button" id="favorites" class="btn btn-default" href="#tab2" data-toggle="tab">
                            <i class="fa fa-book" aria-hidden="true"></i>
                            <div class="hidden-xs">Favorites</div>
                        </button>
                    </div>
                </div>

                <div class="well">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="tab1">
                            <div class="row">
                                <div class="col-xs-3 user-info-tit">
                                    가입일
                                </div>
                                <div class="col-xs-9 user-info-con">
                                	<fmt:formatDate value="${userVO.userRegDate}" pattern="yyyy-MM-dd" var="userRegDate" />
                                    <small><i class="fa fa-angle-right" aria-hidden="true"></i> </small> ${userRegDate }
                                </div>

                                <div class="col-xs-3 user-info-tit">
                                    성별
                                </div>
                                <div class="col-xs-9 user-info-con">
                                    <small><i class="fa fa-angle-right" aria-hidden="true"></i> </small> 
                                    	<c:if test="${not empty userVO.userGender }">
                                    		${userVO.userGender }
	                                    </c:if>
                                    	<c:if test="${empty userVO.userGender }">
                                    		성별 정보가 없습니다.
	                                    </c:if>	                             
                                </div>

                                <div class="col-xs-3 user-info-tit">
                                    나이
                                </div>
                                <div class="col-xs-9 user-info-con">
                                    <small><i class="fa fa-angle-right" aria-hidden="true"></i> </small> 
									<!-- 생년월일을 나이로  -->
									<c:set var="now" value="<%=new java.util.Date()%>" />
									
									<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
									<fmt:formatNumber var="sysYearNum" value="${fn:substring(sysYear,1,4)}" />
									
									<c:set var="userBirth"><fmt:formatNumber value="${userVO.userBirth}" /></c:set>
									<fmt:formatNumber var="userBirthYy" value="${fn:substring(userBirth,0,2)}" />
									
									<c:out value="${sysYearNum+100-userBirthYy+1}세" />                                   
                                </div>

                                <div class="col-xs-3 user-info-tit last">
                                    자기소개
                                </div>
                                <div class="col-xs-9 user-info-con last">
                                    <small><i class="fa fa-angle-right" aria-hidden="true"></i> </small> 
                                     	<c:if test="${not empty userVO.userIntroduce }">
                                    		${userVO.userIntroduce }
	                                    </c:if>
                                    	<c:if test="${empty userVO.userIntroduce }">
                                    		자기소개 정보가 없습니다.
	                                    </c:if>	                                    
                                </div>

                            </div>
                        </div>
                        <div class="tab-pane fade in" id="tab2">
                            <div class="row">
                                <div class="col-xs-3 user-info-tit">
                                    참여횟수
                                </div>
                                <div class="col-xs-9 user-info-con">
                                    <small><i class="fa fa-angle-right" aria-hidden="true"></i> </small> ${applyStudyCnt }
                                </div>

                                <div class="col-xs-3 user-info-tit">
                                    관심 카테고리
                                </div>
                                <c:set var="userFavUpCategory" value="${fn:split(userVO.userFavUpCategory,',')}" />
                                <c:set var="userFavCategory" value="${fn:split(userVO.userFavCategory,',')}" />
                                <div class="col-xs-9 user-info-con">
                                    <small><i class="fa fa-angle-right" aria-hidden="true"></i> </small>
                                     	<c:if test="${not empty userVO.userFavUpCategory }">
		                                    <c:forEach var="temp" items="${userFavUpCategory}" varStatus="status">
		                                    	${userFavUpCategory[status.index]} - ${userFavCategory[status.index]}
		                                    	<c:if test="${!status.last}">,</c:if>
		                                    </c:forEach>
	                                    </c:if>
                                    	<c:if test="${empty userVO.userFavUpCategory }">
                                    		관심 카테고리 정보가 없습니다.
	                                    </c:if>                                    
                                </div>
                                
                                <div class="col-xs-3 user-info-tit">
                                    관심 지역
                                </div>
                                <div class="col-xs-9 user-info-con">
                                    <small><i class="fa fa-angle-right" aria-hidden="true"></i> </small> 
                                      	<c:if test="${not empty userVO.userFavUpRegion && userVO.userFavUpRegion ne 'n'}">
                                    		${userVO.userFavUpRegion } - ${userVO.userFavDownRegion }
	                                    </c:if>
                                    	<c:if test="${empty userVO.userFavDownRegion || userVO.userFavUpRegion eq 'n'}">
                                    		관심지역 정보가 없습니다.
	                                    </c:if>	                                     
                                </div>

                                <div class="col-xs-3 user-info-tit">
                                    참여중
                                </div>
                                <div class="col-xs-9 user-info-con prelast">
                                	<div class="sm">
                                   		<small><i class="fa fa-angle-right" aria-hidden="true"></i> </small>
                                   	</div>
                                   	<div class="studyList">
                                    	<c:if test="${fn:length(applyStudyList) >= 1 }">	 
	                                    	<c:forEach items="${applyStudyList}" varStatus="listIdx" var="studyVO">
                                    			<a class="studyName_link" data-studyNo="${studyVO.studyNo}" style="cursor:pointer">${listIdx.index+1 } | ${studyVO.studyName }</a><br>
	                                    	</c:forEach>
	                                    </c:if>
	                                    <c:if test="${fn:length(applyStudyList) == 0 }">	 
                                    		참여중인 스터디가 없습니다.
	                                    </c:if>
                                    </div>
                                </div>

                                <div class="col-xs-3 user-info-tit last">
                                    히스토리
                                </div>
                                <div class="col-xs-9 user-info-con last">
                               		<div class="sm">
                                    	<small><i class="fa fa-angle-right" aria-hidden="true"></i> </small>
                                   	</div>
                                   	<div class="studyList">
                                    	<c:if test="${fn:length(endStudyList) >= 1 }">	 
	                                    	<c:forEach items="${endStudyList}" varStatus="listIdx" var="studyVO">
	                                    		<a class="endStudyName_link" data-studyNo="${studyVO.studyNo}" style="cursor:pointer">${listIdx.index+1 } | ${studyVO.studyName }</a><br>
	                                    	</c:forEach>
	                                    </c:if>
	                                    <c:if test="${fn:length(endStudyList) == 0 }">	 
                                    		과거 스터디가 없습니다.
	                                    </c:if>                                
                               	 	</div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<!-- userinfo class controll -->
<script>
    $(document).ready(function () {
        $(".btn-pref .btn").click(function () {
            $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
            // $(".tab").addClass("active"); // instead of this do the below 
            $(this).removeClass("btn-default").addClass("btn-primary");
        });
        
		/* 부모창에 신청스터디 띄우기  */
		$(".studyName_link").on("click", function(event) {
			event.preventDefault();
			var studyNo = $(this).attr('data-studyNo');
			window.opener.location.href="/study/studyView?${pageMaker.makeQuery(pageMaker.cri.page)}&studyNo=" + studyNo;
			self.close();
		});
		
		/* 부모창에 완료스터디 띄우기  */
		$(".endStudyName_link").on("click", function(event) {
			event.preventDefault();
			var studyNo = $(this).attr('data-studyNo');
			window.opener.location.href="/study/studyEndView?${pageMaker.makeQuery(pageMaker.cri.page)}&studyNo=" + studyNo;
			self.close();
		});
    });
</script>
    </body>

    </html>