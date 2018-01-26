<div class="col-sm-11">
	<div class="col-sm-4 form-group">
		<select id="upRegion" name="studyUpRegion" class="form-control filtering">
			<option value="n">---</option>
			<option name="upRegion" id="r02" value="서울">서울</option>
			<option name="upRegion" id="r031" value="경기">경기</option>
			<option name="upRegion" id="r033" value="강원">강원</option>
			<option name="upRegion" id="r032" value="인천">인천</option>
			<option name="upRegion" id="r041" value="충남">충남</option>
			<option name="upRegion" id="r043" value="충북">충북</option>
			<option name="upRegion" id="r042" value="대전">대전</option>
			<option name="upRegion" id="r044" value="세종">세종</option>
			<option name="upRegion" id="r051" value="부산">부산</option>
			<option name="upRegion" id="r053" value="대구">대구</option>
			<option name="upRegion" id="r052" value="울산">울산</option>
			<option name="upRegion" id="r055" value="경남">경남</option>
			<option name="upRegion" id="r054" value="경북">경북</option>
			<option name="upRegion" id="r062" value="광주">광주</option>
			<option name="upRegion" id="r061" value="전남">전남</option>
			<option name="upRegion" id="r063" value="전북">전북</option>
			<option name="upRegion" id="r064" value="제주">제주</option>
			<option name="upRegion" id="r099" value="전국">전국</option>
		</select>
	</div>
	<div class="col-sm-7 form-group">
		<select id="downRegion" name="studyDownRegion" class="form-control filtering">
		</select>
	</div>
</div>
<script>
	$('#upRegion').change(function(){
		var upRegion = $('#upRegion option:selected').val();
		$('#downRegion').children().remove();
		if(upRegion=='서울')
			r02();
		if(upRegion=='인천')
			r032();
		if(upRegion=='경기')
			r031();
		if(upRegion=='강원')
			r033();
		if(upRegion=='부산')
			r051();
		if(upRegion=='대구')
			r053();
		if(upRegion=='울산')
			r052();
		if(upRegion=='대전')
			r042();
		if(upRegion=='광주')
			r062();
		if(upRegion=='충남')
			r041();
		if(upRegion=='충북')
			r043();
		if(upRegion=='전북')
			r063();
	    if(upRegion=='제주')
	    	r064();
	    if(upRegion=='전남')
	    	r061();
		if(upRegion=='경북')
			r054();
		if(upRegion=='경남')
			r055();
		if(upRegion=='세종')
		    r044();
		if(upRegion=='전국')
			r099();
	});
	
</script>