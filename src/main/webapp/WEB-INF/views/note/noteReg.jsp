<jsp:include page="../include/headerNote.jsp" flush="false"/>
</head>
<body>
	<div class="noteReg">
		<div role="tabpanel">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="/note/noteReg?noteTarget=">쪽지보내기</a></li>
				<li role="presentation"><a href="/note/noteList">받은 쪽지</a></li>
				<li role="presentation"><a href="/note/noteListSender">보낸 쪽지</a></li>
				<li role="presentation"><a href="/note/noteListToMe">내게 쓴 쪽지</a></li>
				<li role="presentation"><a href="/note/cutOffList">차단설정</a></li>
			</ul>
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="home">
					<label for="noteTarget">받는 이<input type="text" class="form-control" id="noteTarget" name="noteTargetNick" value="${noteTargetNick}" placeholder="받는 이의 닉네임을 입력해주세요." /></label>
					<div class="text-area">
						<textarea name="noteText" id="noteText" rows="10"></textarea>
					</div>
					<div class="checkbox">
						<label> <input type="checkbox" id="meSend"> 내게쓰기 </label>
					</div>
					<div>
						<input type="button" class="btn btn-default" id="sendNote" value="보내기" />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="/resources/dist/js/note.js"></script>
</html>