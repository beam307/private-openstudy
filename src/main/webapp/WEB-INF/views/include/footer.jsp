<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<c:if test="${not empty login && login.userAuth eq '0'}">
<div class="dropup chat">
  <button type="button" id="chatBtn" class="dropdown-toggle chat" data-toggle="dropdown" aria-expanded="false">
    <i class="fa fa-comments" aria-hidden="true"></i>
    <div id="new-message" class="new-message-style badge"></div>
  </button>
  <ul class="dropdown-menu" role="menu">
    <%@include file="../chat/chatView.jsp"%>
  </ul>
</div>
</c:if>

 <footer>
	Copyright © OpenStudy Corp. All Rights Reserved.
</footer>
    
</body>
</html>