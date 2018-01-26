<c:if test="${empty cri.upRegion || cri.upRegion == 'n' || cri.upRegion == ''}">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>---</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '11' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('1101') }" <c:out value="${cri.downRegion eq '1101'?'selected':''}"/>>강남구</option>
		<option value="studyList${pageMaker.makeDownRegion('1102') }" <c:out value="${cri.downRegion eq '1102'?'selected':''}"/>>강동구</option>
		<option value="studyList${pageMaker.makeDownRegion('1103') }" <c:out value="${cri.downRegion eq '1103'?'selected':''}"/>>강북구</option>
		<option value="studyList${pageMaker.makeDownRegion('1104') }" <c:out value="${cri.downRegion eq '1104'?'selected':''}"/>>강서구</option>
		<option value="studyList${pageMaker.makeDownRegion('1105') }" <c:out value="${cri.downRegion eq '1105'?'selected':''}"/>>관악구</option>
		<option value="studyList${pageMaker.makeDownRegion('1106') }" <c:out value="${cri.downRegion eq '1106'?'selected':''}"/>>광진구</option>
		<option value="studyList${pageMaker.makeDownRegion('1107') }" <c:out value="${cri.downRegion eq '1107'?'selected':''}"/>>구로구</option>
		<option value="studyList${pageMaker.makeDownRegion('1108') }" <c:out value="${cri.downRegion eq '1108'?'selected':''}"/>>금천구</option>
		<option value="studyList${pageMaker.makeDownRegion('1109') }" <c:out value="${cri.downRegion eq '1109'?'selected':''}"/>>노원구</option>
		<option value="studyList${pageMaker.makeDownRegion('1110') }" <c:out value="${cri.downRegion eq '1110'?'selected':''}"/>>도봉구</option>
		<option value="studyList${pageMaker.makeDownRegion('1111') }" <c:out value="${cri.downRegion eq '1111'?'selected':''}"/>>동대문구</option>
		<option value="studyList${pageMaker.makeDownRegion('1112') }" <c:out value="${cri.downRegion eq '1112'?'selected':''}"/>>동작구</option>
		<option value="studyList${pageMaker.makeDownRegion('1113') }" <c:out value="${cri.downRegion eq '1113'?'selected':''}"/>>마포구</option>
		<option value="studyList${pageMaker.makeDownRegion('1114') }" <c:out value="${cri.downRegion eq '1114'?'selected':''}"/>>서대문구</option>
		<option value="studyList${pageMaker.makeDownRegion('1115') }" <c:out value="${cri.downRegion eq '1115'?'selected':''}"/>>서초구</option>
		<option value="studyList${pageMaker.makeDownRegion('1116') }" <c:out value="${cri.downRegion eq '1116'?'selected':''}"/>>성동구</option>
		<option value="studyList${pageMaker.makeDownRegion('1117') }" <c:out value="${cri.downRegion eq '1117'?'selected':''}"/>>성북구</option>
		<option value="studyList${pageMaker.makeDownRegion('1118') }" <c:out value="${cri.downRegion eq '1118'?'selected':''}"/>>송파구</option>
		<option value="studyList${pageMaker.makeDownRegion('1119') }" <c:out value="${cri.downRegion eq '1119'?'selected':''}"/>>양천구</option>
		<option value="studyList${pageMaker.makeDownRegion('1120') }" <c:out value="${cri.downRegion eq '1120'?'selected':''}"/>>영등포구</option>
		<option value="studyList${pageMaker.makeDownRegion('1121') }" <c:out value="${cri.downRegion eq '1121'?'selected':''}"/>>용산구</option>
		<option value="studyList${pageMaker.makeDownRegion('1122') }" <c:out value="${cri.downRegion eq '1122'?'selected':''}"/>>은평구</option>
		<option value="studyList${pageMaker.makeDownRegion('1123') }" <c:out value="${cri.downRegion eq '1123'?'selected':''}"/>>종로구</option>
		<option value="studyList${pageMaker.makeDownRegion('1124') }" <c:out value="${cri.downRegion eq '1124'?'selected':''}"/>>중구</option>
		<option value="studyList${pageMaker.makeDownRegion('1125') }" <c:out value="${cri.downRegion eq '1125'?'selected':''}"/>>중랑구</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '21' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('2101') }" <c:out value="${cri.downRegion eq '2101'?'selected':''}"/>>강서구</option>
		<option value="studyList${pageMaker.makeDownRegion('2102') }" <c:out value="${cri.downRegion eq '2102'?'selected':''}"/>>금정구</option>
		<option value="studyList${pageMaker.makeDownRegion('2103') }" <c:out value="${cri.downRegion eq '2103'?'selected':''}"/>>기장군</option>
		<option value="studyList${pageMaker.makeDownRegion('2104') }" <c:out value="${cri.downRegion eq '2104'?'selected':''}"/>>남구</option>
		<option value="studyList${pageMaker.makeDownRegion('2105') }" <c:out value="${cri.downRegion eq '2105'?'selected':''}"/>>동구</option>
		<option value="studyList${pageMaker.makeDownRegion('2106') }" <c:out value="${cri.downRegion eq '2106'?'selected':''}"/>>동래구</option>
		<option value="studyList${pageMaker.makeDownRegion('2107') }" <c:out value="${cri.downRegion eq '2107'?'selected':''}"/>>부산진구</option>
		<option value="studyList${pageMaker.makeDownRegion('2108') }" <c:out value="${cri.downRegion eq '2108'?'selected':''}"/>>북구</option>
		<option value="studyList${pageMaker.makeDownRegion('2109') }" <c:out value="${cri.downRegion eq '2109'?'selected':''}"/>>사상구</option>
		<option value="studyList${pageMaker.makeDownRegion('2110') }" <c:out value="${cri.downRegion eq '2110'?'selected':''}"/>>사하구</option>
		<option value="studyList${pageMaker.makeDownRegion('2111') }" <c:out value="${cri.downRegion eq '2111'?'selected':''}"/>>서구</option>
		<option value="studyList${pageMaker.makeDownRegion('2112') }" <c:out value="${cri.downRegion eq '2112'?'selected':''}"/>>수영구</option>
		<option value="studyList${pageMaker.makeDownRegion('2113') }" <c:out value="${cri.downRegion eq '2113'?'selected':''}"/>>연제구</option>
		<option value="studyList${pageMaker.makeDownRegion('2114') }" <c:out value="${cri.downRegion eq '2114'?'selected':''}"/>>영도구</option>
		<option value="studyList${pageMaker.makeDownRegion('2115') }" <c:out value="${cri.downRegion eq '2115'?'selected':''}"/>>중구</option>
		<option value="studyList${pageMaker.makeDownRegion('2116') }" <c:out value="${cri.downRegion eq '2116'?'selected':''}"/>>해운대구</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '22' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('2201') }" <c:out value="${cri.downRegion eq '2201'?'selected':''}"/>>남구</option>
		<option value="studyList${pageMaker.makeDownRegion('2202') }" <c:out value="${cri.downRegion eq '2202'?'selected':''}"/>>달서구</option>
		<option value="studyList${pageMaker.makeDownRegion('2203') }" <c:out value="${cri.downRegion eq '2203'?'selected':''}"/>>달성군</option>
		<option value="studyList${pageMaker.makeDownRegion('2204') }" <c:out value="${cri.downRegion eq '2204'?'selected':''}"/>>동구</option>
		<option value="studyList${pageMaker.makeDownRegion('2205') }" <c:out value="${cri.downRegion eq '2205'?'selected':''}"/>>북구</option>
		<option value="studyList${pageMaker.makeDownRegion('2206') }" <c:out value="${cri.downRegion eq '2206'?'selected':''}"/>>서구</option>
		<option value="studyList${pageMaker.makeDownRegion('2207') }" <c:out value="${cri.downRegion eq '2207'?'selected':''}"/>>수성구</option>
		<option value="studyList${pageMaker.makeDownRegion('2208') }" <c:out value="${cri.downRegion eq '2208'?'selected':''}"/>>중구</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '23' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('2301') }" <c:out value="${cri.downRegion eq '2301'?'selected':''}"/>>강화군</option>
		<option value="studyList${pageMaker.makeDownRegion('2302') }" <c:out value="${cri.downRegion eq '2302'?'selected':''}"/>>계양구</option>
		<option value="studyList${pageMaker.makeDownRegion('2303') }" <c:out value="${cri.downRegion eq '2303'?'selected':''}"/>>남구</option>
		<option value="studyList${pageMaker.makeDownRegion('2304') }" <c:out value="${cri.downRegion eq '2304'?'selected':''}"/>>남동구</option>
		<option value="studyList${pageMaker.makeDownRegion('2305') }" <c:out value="${cri.downRegion eq '2305'?'selected':''}"/>>동구</option>
		<option value="studyList${pageMaker.makeDownRegion('2306') }" <c:out value="${cri.downRegion eq '2306'?'selected':''}"/>>부평구</option>
		<option value="studyList${pageMaker.makeDownRegion('2307') }" <c:out value="${cri.downRegion eq '2307'?'selected':''}"/>>서구</option>
		<option value="studyList${pageMaker.makeDownRegion('2308') }" <c:out value="${cri.downRegion eq '2308'?'selected':''}"/>>연수구</option>
		<option value="studyList${pageMaker.makeDownRegion('2309') }" <c:out value="${cri.downRegion eq '2309'?'selected':''}"/>>옹진군</option>
		<option value="studyList${pageMaker.makeDownRegion('2310') }" <c:out value="${cri.downRegion eq '2310'?'selected':''}"/>>중구</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '24' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('2401') }" <c:out value="${cri.downRegion eq '2401'?'selected':''}"/>>광산구</option>
		<option value="studyList${pageMaker.makeDownRegion('2402') }" <c:out value="${cri.downRegion eq '2402'?'selected':''}"/>>남구</option>
		<option value="studyList${pageMaker.makeDownRegion('2403') }" <c:out value="${cri.downRegion eq '2403'?'selected':''}"/>>동구</option>
		<option value="studyList${pageMaker.makeDownRegion('2404') }" <c:out value="${cri.downRegion eq '2404'?'selected':''}"/>>북구</option>
		<option value="studyList${pageMaker.makeDownRegion('2405') }" <c:out value="${cri.downRegion eq '2405'?'selected':''}"/>>서구</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '25' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('2501') }" <c:out value="${cri.downRegion eq '2501'?'selected':''}"/>>대덕구</option>
		<option value="studyList${pageMaker.makeDownRegion('2502') }" <c:out value="${cri.downRegion eq '2502'?'selected':''}"/>>동구</option>
		<option value="studyList${pageMaker.makeDownRegion('2503') }" <c:out value="${cri.downRegion eq '2503'?'selected':''}"/>>서구</option>
		<option value="studyList${pageMaker.makeDownRegion('2504') }" <c:out value="${cri.downRegion eq '2504'?'selected':''}"/>>유성구</option>
		<option value="studyList${pageMaker.makeDownRegion('2505') }" <c:out value="${cri.downRegion eq '2505'?'selected':''}"/>>중구</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '26' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('2601') }" <c:out value="${cri.downRegion eq '2601'?'selected':''}"/>>남구</option>
		<option value="studyList${pageMaker.makeDownRegion('2602') }" <c:out value="${cri.downRegion eq '2602'?'selected':''}"/>>동구</option>
		<option value="studyList${pageMaker.makeDownRegion('2603') }" <c:out value="${cri.downRegion eq '2603'?'selected':''}"/>>북구</option>
		<option value="studyList${pageMaker.makeDownRegion('2604') }" <c:out value="${cri.downRegion eq '2604'?'selected':''}"/>>울주군</option>
		<option value="studyList${pageMaker.makeDownRegion('2605') }" <c:out value="${cri.downRegion eq '2605'?'selected':''}"/>>중구</option>
	</select>                                                                                                                    
</c:if>
<c:if test="${cri.upRegion eq '29' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('2901') }" <c:out value="${cri.downRegion eq '2901'?'selected':''}"/>>세종시</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '31' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('3101') }" <c:out value="${cri.downRegion eq '3101'?'selected':''}"/>>가평군</option>
		<option value="studyList${pageMaker.makeDownRegion('3102') }" <c:out value="${cri.downRegion eq '3102'?'selected':''}"/>>고양시 덕양구</option>
		<option value="studyList${pageMaker.makeDownRegion('3103') }" <c:out value="${cri.downRegion eq '3103'?'selected':''}"/>>고양시 일산동구</option>
		<option value="studyList${pageMaker.makeDownRegion('3104') }" <c:out value="${cri.downRegion eq '3104'?'selected':''}"/>>고양시 일산서구</option>
		<option value="studyList${pageMaker.makeDownRegion('3105') }" <c:out value="${cri.downRegion eq '3105'?'selected':''}"/>>과천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3106') }" <c:out value="${cri.downRegion eq '3106'?'selected':''}"/>>광명시</option>
		<option value="studyList${pageMaker.makeDownRegion('3107') }" <c:out value="${cri.downRegion eq '3107'?'selected':''}"/>>광주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3108') }" <c:out value="${cri.downRegion eq '3108'?'selected':''}"/>>구리시</option>
		<option value="studyList${pageMaker.makeDownRegion('3109') }" <c:out value="${cri.downRegion eq '3109'?'selected':''}"/>>군포시</option>
		<option value="studyList${pageMaker.makeDownRegion('3110') }" <c:out value="${cri.downRegion eq '3110'?'selected':''}"/>>김포시</option>
		<option value="studyList${pageMaker.makeDownRegion('3111') }" <c:out value="${cri.downRegion eq '3111'?'selected':''}"/>>남양주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3112') }" <c:out value="${cri.downRegion eq '3112'?'selected':''}"/>>동두천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3113') }" <c:out value="${cri.downRegion eq '3113'?'selected':''}"/>>부천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3114') }" <c:out value="${cri.downRegion eq '3114'?'selected':''}"/>>성남시 분당구</option>
		<option value="studyList${pageMaker.makeDownRegion('3115') }" <c:out value="${cri.downRegion eq '3115'?'selected':''}"/>>성남시 수정구</option>
		<option value="studyList${pageMaker.makeDownRegion('3116') }" <c:out value="${cri.downRegion eq '3116'?'selected':''}"/>>성남시 중원구</option>
		<option value="studyList${pageMaker.makeDownRegion('3117') }" <c:out value="${cri.downRegion eq '3117'?'selected':''}"/>>수원시 권선구</option>
		<option value="studyList${pageMaker.makeDownRegion('3118') }" <c:out value="${cri.downRegion eq '3118'?'selected':''}"/>>수원시 영통구</option>
		<option value="studyList${pageMaker.makeDownRegion('3119') }" <c:out value="${cri.downRegion eq '3119'?'selected':''}"/>>수원시 장안구</option>
		<option value="studyList${pageMaker.makeDownRegion('3120') }" <c:out value="${cri.downRegion eq '3120'?'selected':''}"/>>수원시 팔달구</option>
		<option value="studyList${pageMaker.makeDownRegion('3121') }" <c:out value="${cri.downRegion eq '3121'?'selected':''}"/>>시흥시</option>
		<option value="studyList${pageMaker.makeDownRegion('3122') }" <c:out value="${cri.downRegion eq '3122'?'selected':''}"/>>안산시 단원구</option>
		<option value="studyList${pageMaker.makeDownRegion('3123') }" <c:out value="${cri.downRegion eq '3123'?'selected':''}"/>>안산시 상록구</option>
		<option value="studyList${pageMaker.makeDownRegion('3124') }" <c:out value="${cri.downRegion eq '3124'?'selected':''}"/>>안성시</option>
		<option value="studyList${pageMaker.makeDownRegion('3125') }" <c:out value="${cri.downRegion eq '3125'?'selected':''}"/>>안양시 동안구</option>
		<option value="studyList${pageMaker.makeDownRegion('3126') }" <c:out value="${cri.downRegion eq '3126'?'selected':''}"/>>안양시 만안구</option>
		<option value="studyList${pageMaker.makeDownRegion('3127') }" <c:out value="${cri.downRegion eq '3127'?'selected':''}"/>>양주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3128') }" <c:out value="${cri.downRegion eq '3128'?'selected':''}"/>>양평군</option>
		<option value="studyList${pageMaker.makeDownRegion('3129') }" <c:out value="${cri.downRegion eq '3129'?'selected':''}"/>>여주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3130') }" <c:out value="${cri.downRegion eq '3130'?'selected':''}"/>>연천군</option>
		<option value="studyList${pageMaker.makeDownRegion('3131') }" <c:out value="${cri.downRegion eq '3131'?'selected':''}"/>>오산시</option>
		<option value="studyList${pageMaker.makeDownRegion('3132') }" <c:out value="${cri.downRegion eq '3132'?'selected':''}"/>>용인시 기흥구</option>
		<option value="studyList${pageMaker.makeDownRegion('3133') }" <c:out value="${cri.downRegion eq '3133'?'selected':''}"/>>용인시 수지구</option>
		<option value="studyList${pageMaker.makeDownRegion('3134') }" <c:out value="${cri.downRegion eq '3134'?'selected':''}"/>>용인시 처인구</option>
		<option value="studyList${pageMaker.makeDownRegion('3135') }" <c:out value="${cri.downRegion eq '3135'?'selected':''}"/>>의왕시</option>
		<option value="studyList${pageMaker.makeDownRegion('3136') }" <c:out value="${cri.downRegion eq '3136'?'selected':''}"/>>의정부시</option>
		<option value="studyList${pageMaker.makeDownRegion('3137') }" <c:out value="${cri.downRegion eq '3137'?'selected':''}"/>>이천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3138') }" <c:out value="${cri.downRegion eq '3138'?'selected':''}"/>>파주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3139') }" <c:out value="${cri.downRegion eq '3139'?'selected':''}"/>>평택시</option>
		<option value="studyList${pageMaker.makeDownRegion('3140') }" <c:out value="${cri.downRegion eq '3140'?'selected':''}"/>>포천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3141') }" <c:out value="${cri.downRegion eq '3141'?'selected':''}"/>>하남시</option>
		<option value="studyList${pageMaker.makeDownRegion('3142') }" <c:out value="${cri.downRegion eq '3142'?'selected':''}"/>>화성시</option>
	</select>                                                                                                                    
</c:if>
<c:if test="${cri.upRegion eq '32' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('3201') }" <c:out value="${cri.downRegion eq '3201'?'selected':''}"/>>강릉시</option>
		<option value="studyList${pageMaker.makeDownRegion('3202') }" <c:out value="${cri.downRegion eq '3202'?'selected':''}"/>>고성군</option>
		<option value="studyList${pageMaker.makeDownRegion('3203') }" <c:out value="${cri.downRegion eq '3203'?'selected':''}"/>>동해시</option>
		<option value="studyList${pageMaker.makeDownRegion('3204') }" <c:out value="${cri.downRegion eq '3204'?'selected':''}"/>>삼척시</option>
		<option value="studyList${pageMaker.makeDownRegion('3205') }" <c:out value="${cri.downRegion eq '3205'?'selected':''}"/>>속초시</option>
		<option value="studyList${pageMaker.makeDownRegion('3206') }" <c:out value="${cri.downRegion eq '3206'?'selected':''}"/>>양구군</option>
		<option value="studyList${pageMaker.makeDownRegion('3207') }" <c:out value="${cri.downRegion eq '3207'?'selected':''}"/>>양양군</option>
		<option value="studyList${pageMaker.makeDownRegion('3208') }" <c:out value="${cri.downRegion eq '3208'?'selected':''}"/>>영월군</option>
		<option value="studyList${pageMaker.makeDownRegion('3209') }" <c:out value="${cri.downRegion eq '3209'?'selected':''}"/>>원주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3210') }" <c:out value="${cri.downRegion eq '3210'?'selected':''}"/>>인제군</option>
		<option value="studyList${pageMaker.makeDownRegion('3211') }" <c:out value="${cri.downRegion eq '3211'?'selected':''}"/>>정선군</option>
		<option value="studyList${pageMaker.makeDownRegion('3212') }" <c:out value="${cri.downRegion eq '3212'?'selected':''}"/>>철원군</option>
		<option value="studyList${pageMaker.makeDownRegion('3213') }" <c:out value="${cri.downRegion eq '3213'?'selected':''}"/>>춘천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3214') }" <c:out value="${cri.downRegion eq '3214'?'selected':''}"/>>태백시</option>
		<option value="studyList${pageMaker.makeDownRegion('3215') }" <c:out value="${cri.downRegion eq '3215'?'selected':''}"/>>평창군</option>
		<option value="studyList${pageMaker.makeDownRegion('3216') }" <c:out value="${cri.downRegion eq '3216'?'selected':''}"/>>홍천군</option>
		<option value="studyList${pageMaker.makeDownRegion('3217') }" <c:out value="${cri.downRegion eq '3217'?'selected':''}"/>>화천군</option>
		<option value="studyList${pageMaker.makeDownRegion('3218') }" <c:out value="${cri.downRegion eq '3218'?'selected':''}"/>>횡성군</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '33' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('3301') }" <c:out value="${cri.downRegion eq '3301'?'selected':''}"/>>괴산군</option>
		<option value="studyList${pageMaker.makeDownRegion('3302') }" <c:out value="${cri.downRegion eq '3302'?'selected':''}"/>>단양군</option>
		<option value="studyList${pageMaker.makeDownRegion('3303') }" <c:out value="${cri.downRegion eq '3303'?'selected':''}"/>>보은군</option>
		<option value="studyList${pageMaker.makeDownRegion('3304') }" <c:out value="${cri.downRegion eq '3304'?'selected':''}"/>>영동군</option>
		<option value="studyList${pageMaker.makeDownRegion('3305') }" <c:out value="${cri.downRegion eq '3305'?'selected':''}"/>>옥천군</option>
		<option value="studyList${pageMaker.makeDownRegion('3306') }" <c:out value="${cri.downRegion eq '3306'?'selected':''}"/>>음성군</option>
		<option value="studyList${pageMaker.makeDownRegion('3307') }" <c:out value="${cri.downRegion eq '3307'?'selected':''}"/>>제천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3308') }" <c:out value="${cri.downRegion eq '3308'?'selected':''}"/>>증평군</option>
		<option value="studyList${pageMaker.makeDownRegion('3309') }" <c:out value="${cri.downRegion eq '3309'?'selected':''}"/>>진천군</option>
		<option value="studyList${pageMaker.makeDownRegion('3310') }" <c:out value="${cri.downRegion eq '3310'?'selected':''}"/>>청주시 상당구</option>
		<option value="studyList${pageMaker.makeDownRegion('3311') }" <c:out value="${cri.downRegion eq '3311'?'selected':''}"/>>청주시 흥덕구</option>
		<option value="studyList${pageMaker.makeDownRegion('3312') }" <c:out value="${cri.downRegion eq '3312'?'selected':''}"/>>청주시 서원구</option>
		<option value="studyList${pageMaker.makeDownRegion('3313') }" <c:out value="${cri.downRegion eq '3313'?'selected':''}"/>>청주시 청원구</option>
		<option value="studyList${pageMaker.makeDownRegion('3314') }" <c:out value="${cri.downRegion eq '3314'?'selected':''}"/>>충주시</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '34' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('3401') }" <c:out value="${cri.downRegion eq '3401'?'selected':''}"/>>계룡시</option>
		<option value="studyList${pageMaker.makeDownRegion('3402') }" <c:out value="${cri.downRegion eq '3402'?'selected':''}"/>>공주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3403') }" <c:out value="${cri.downRegion eq '3403'?'selected':''}"/>>금산군</option>
		<option value="studyList${pageMaker.makeDownRegion('3404') }" <c:out value="${cri.downRegion eq '3404'?'selected':''}"/>>논산시</option>
		<option value="studyList${pageMaker.makeDownRegion('3405') }" <c:out value="${cri.downRegion eq '3405'?'selected':''}"/>>당진시</option>
		<option value="studyList${pageMaker.makeDownRegion('3406') }" <c:out value="${cri.downRegion eq '3406'?'selected':''}"/>>보령시</option>
		<option value="studyList${pageMaker.makeDownRegion('3407') }" <c:out value="${cri.downRegion eq '3407'?'selected':''}"/>>부여군</option>
		<option value="studyList${pageMaker.makeDownRegion('3408') }" <c:out value="${cri.downRegion eq '3408'?'selected':''}"/>>서산시</option>
		<option value="studyList${pageMaker.makeDownRegion('3409') }" <c:out value="${cri.downRegion eq '3409'?'selected':''}"/>>서천군</option>
		<option value="studyList${pageMaker.makeDownRegion('3410') }" <c:out value="${cri.downRegion eq '3410'?'selected':''}"/>>아산시</option>
		<option value="studyList${pageMaker.makeDownRegion('3411') }" <c:out value="${cri.downRegion eq '3411'?'selected':''}"/>>연기군</option>
		<option value="studyList${pageMaker.makeDownRegion('3412') }" <c:out value="${cri.downRegion eq '3412'?'selected':''}"/>>예산군</option>
		<option value="studyList${pageMaker.makeDownRegion('3413') }" <c:out value="${cri.downRegion eq '3413'?'selected':''}"/>>천안시 동남구</option>
		<option value="studyList${pageMaker.makeDownRegion('3414') }" <c:out value="${cri.downRegion eq '3414'?'selected':''}"/>>천안시 서북구</option>
		<option value="studyList${pageMaker.makeDownRegion('3415') }" <c:out value="${cri.downRegion eq '3415'?'selected':''}"/>>청양군</option>
		<option value="studyList${pageMaker.makeDownRegion('3416') }" <c:out value="${cri.downRegion eq '3416'?'selected':''}"/>>태안군</option>
		<option value="studyList${pageMaker.makeDownRegion('3417') }" <c:out value="${cri.downRegion eq '3417'?'selected':''}"/>>홍성군</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '35' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('3501') }" <c:out value="${cri.downRegion eq '3501'?'selected':''}"/>>강진군</option>
		<option value="studyList${pageMaker.makeDownRegion('3502') }" <c:out value="${cri.downRegion eq '3502'?'selected':''}"/>>고흥군</option>
		<option value="studyList${pageMaker.makeDownRegion('3503') }" <c:out value="${cri.downRegion eq '3503'?'selected':''}"/>>곡성군</option>
		<option value="studyList${pageMaker.makeDownRegion('3504') }" <c:out value="${cri.downRegion eq '3504'?'selected':''}"/>>광양시</option>
		<option value="studyList${pageMaker.makeDownRegion('3505') }" <c:out value="${cri.downRegion eq '3505'?'selected':''}"/>>구례군</option>
		<option value="studyList${pageMaker.makeDownRegion('3506') }" <c:out value="${cri.downRegion eq '3506'?'selected':''}"/>>나주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3507') }" <c:out value="${cri.downRegion eq '3507'?'selected':''}"/>>담양군</option>
		<option value="studyList${pageMaker.makeDownRegion('3508') }" <c:out value="${cri.downRegion eq '3508'?'selected':''}"/>>목포시</option>
		<option value="studyList${pageMaker.makeDownRegion('3509') }" <c:out value="${cri.downRegion eq '3509'?'selected':''}"/>>무안군</option>
		<option value="studyList${pageMaker.makeDownRegion('3510') }" <c:out value="${cri.downRegion eq '3510'?'selected':''}"/>>보성군</option>
		<option value="studyList${pageMaker.makeDownRegion('3511') }" <c:out value="${cri.downRegion eq '3511'?'selected':''}"/>>순천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3512') }" <c:out value="${cri.downRegion eq '3512'?'selected':''}"/>>신안군</option>
		<option value="studyList${pageMaker.makeDownRegion('3513') }" <c:out value="${cri.downRegion eq '3513'?'selected':''}"/>>여수시</option>
		<option value="studyList${pageMaker.makeDownRegion('3514') }" <c:out value="${cri.downRegion eq '3514'?'selected':''}"/>>영광군</option>
		<option value="studyList${pageMaker.makeDownRegion('3515') }" <c:out value="${cri.downRegion eq '3515'?'selected':''}"/>>영암군</option>
		<option value="studyList${pageMaker.makeDownRegion('3516') }" <c:out value="${cri.downRegion eq '3516'?'selected':''}"/>>완도군</option>
		<option value="studyList${pageMaker.makeDownRegion('3517') }" <c:out value="${cri.downRegion eq '3517'?'selected':''}"/>>장성군</option>
		<option value="studyList${pageMaker.makeDownRegion('3518') }" <c:out value="${cri.downRegion eq '3518'?'selected':''}"/>>장흥군</option>
		<option value="studyList${pageMaker.makeDownRegion('3519') }" <c:out value="${cri.downRegion eq '3519'?'selected':''}"/>>진도군</option>
		<option value="studyList${pageMaker.makeDownRegion('3520') }" <c:out value="${cri.downRegion eq '3520'?'selected':''}"/>>함평군</option>
		<option value="studyList${pageMaker.makeDownRegion('3521') }" <c:out value="${cri.downRegion eq '3521'?'selected':''}"/>>해남군</option>
		<option value="studyList${pageMaker.makeDownRegion('3522') }" <c:out value="${cri.downRegion eq '3522'?'selected':''}"/>>화순군</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '36' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('3601') }" <c:out value="${cri.downRegion eq '3601'?'selected':''}"/>>고창군</option>
		<option value="studyList${pageMaker.makeDownRegion('3602') }" <c:out value="${cri.downRegion eq '3602'?'selected':''}"/>>군산시</option>
		<option value="studyList${pageMaker.makeDownRegion('3603') }" <c:out value="${cri.downRegion eq '3603'?'selected':''}"/>>김제시</option>
		<option value="studyList${pageMaker.makeDownRegion('3604') }" <c:out value="${cri.downRegion eq '3604'?'selected':''}"/>>남원시</option>
		<option value="studyList${pageMaker.makeDownRegion('3605') }" <c:out value="${cri.downRegion eq '3605'?'selected':''}"/>>무주군</option>
		<option value="studyList${pageMaker.makeDownRegion('3606') }" <c:out value="${cri.downRegion eq '3606'?'selected':''}"/>>부안군</option>
		<option value="studyList${pageMaker.makeDownRegion('3607') }" <c:out value="${cri.downRegion eq '3607'?'selected':''}"/>>순창군</option>
		<option value="studyList${pageMaker.makeDownRegion('3608') }" <c:out value="${cri.downRegion eq '3608'?'selected':''}"/>>완주군</option>
		<option value="studyList${pageMaker.makeDownRegion('3609') }" <c:out value="${cri.downRegion eq '3609'?'selected':''}"/>>익산시</option>
		<option value="studyList${pageMaker.makeDownRegion('3610') }" <c:out value="${cri.downRegion eq '3610'?'selected':''}"/>>임실군</option>
		<option value="studyList${pageMaker.makeDownRegion('3611') }" <c:out value="${cri.downRegion eq '3611'?'selected':''}"/>>장수군</option>
		<option value="studyList${pageMaker.makeDownRegion('3612') }" <c:out value="${cri.downRegion eq '3612'?'selected':''}"/>>전주시 덕진구</option>
		<option value="studyList${pageMaker.makeDownRegion('3613') }" <c:out value="${cri.downRegion eq '3613'?'selected':''}"/>>전주시 완산구</option>
		<option value="studyList${pageMaker.makeDownRegion('3614') }" <c:out value="${cri.downRegion eq '3614'?'selected':''}"/>>정읍시</option>
		<option value="studyList${pageMaker.makeDownRegion('3615') }" <c:out value="${cri.downRegion eq '3615'?'selected':''}"/>>진안군</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '37' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('3701') }" <c:out value="${cri.downRegion eq '3701'?'selected':''}"/>>경산시</option>
		<option value="studyList${pageMaker.makeDownRegion('3702') }" <c:out value="${cri.downRegion eq '3702'?'selected':''}"/>>경주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3703') }" <c:out value="${cri.downRegion eq '3703'?'selected':''}"/>>고령군</option>
		<option value="studyList${pageMaker.makeDownRegion('3704') }" <c:out value="${cri.downRegion eq '3704'?'selected':''}"/>>구미시</option>
		<option value="studyList${pageMaker.makeDownRegion('3705') }" <c:out value="${cri.downRegion eq '3705'?'selected':''}"/>>군위군</option>
		<option value="studyList${pageMaker.makeDownRegion('3706') }" <c:out value="${cri.downRegion eq '3706'?'selected':''}"/>>김천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3707') }" <c:out value="${cri.downRegion eq '3707'?'selected':''}"/>>문경시</option>
		<option value="studyList${pageMaker.makeDownRegion('3708') }" <c:out value="${cri.downRegion eq '3708'?'selected':''}"/>>봉화군</option>
		<option value="studyList${pageMaker.makeDownRegion('3709') }" <c:out value="${cri.downRegion eq '3709'?'selected':''}"/>>상주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3710') }" <c:out value="${cri.downRegion eq '3710'?'selected':''}"/>>성주군</option>
		<option value="studyList${pageMaker.makeDownRegion('3711') }" <c:out value="${cri.downRegion eq '3711'?'selected':''}"/>>안동시</option>
		<option value="studyList${pageMaker.makeDownRegion('3712') }" <c:out value="${cri.downRegion eq '3712'?'selected':''}"/>>영덕군</option>
		<option value="studyList${pageMaker.makeDownRegion('3713') }" <c:out value="${cri.downRegion eq '3713'?'selected':''}"/>>영양군</option>
		<option value="studyList${pageMaker.makeDownRegion('3714') }" <c:out value="${cri.downRegion eq '3714'?'selected':''}"/>>영주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3715') }" <c:out value="${cri.downRegion eq '3715'?'selected':''}"/>>영천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3716') }" <c:out value="${cri.downRegion eq '3716'?'selected':''}"/>>예천군</option>
		<option value="studyList${pageMaker.makeDownRegion('3717') }" <c:out value="${cri.downRegion eq '3717'?'selected':''}"/>>울릉군</option>
		<option value="studyList${pageMaker.makeDownRegion('3718') }" <c:out value="${cri.downRegion eq '3718'?'selected':''}"/>>울진군</option>
		<option value="studyList${pageMaker.makeDownRegion('3719') }" <c:out value="${cri.downRegion eq '3719'?'selected':''}"/>>의성군</option>
		<option value="studyList${pageMaker.makeDownRegion('3720') }" <c:out value="${cri.downRegion eq '3720'?'selected':''}"/>>청도군</option>
		<option value="studyList${pageMaker.makeDownRegion('3721') }" <c:out value="${cri.downRegion eq '3721'?'selected':''}"/>>청송군</option>
		<option value="studyList${pageMaker.makeDownRegion('3722') }" <c:out value="${cri.downRegion eq '3722'?'selected':''}"/>>칠곡군</option>
		<option value="studyList${pageMaker.makeDownRegion('3723') }" <c:out value="${cri.downRegion eq '3723'?'selected':''}"/>>포항시 남구</option>
		<option value="studyList${pageMaker.makeDownRegion('3724') }" <c:out value="${cri.downRegion eq '3724'?'selected':''}"/>>포항시 북구</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '38' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('3801') }" <c:out value="${cri.downRegion eq '3801'?'selected':''}"/>>거제시</option>
		<option value="studyList${pageMaker.makeDownRegion('3802') }" <c:out value="${cri.downRegion eq '3802'?'selected':''}"/>>거창군</option>
		<option value="studyList${pageMaker.makeDownRegion('3803') }" <c:out value="${cri.downRegion eq '3803'?'selected':''}"/>>고성군</option>
		<option value="studyList${pageMaker.makeDownRegion('3804') }" <c:out value="${cri.downRegion eq '3804'?'selected':''}"/>>김해시</option>
		<option value="studyList${pageMaker.makeDownRegion('3805') }" <c:out value="${cri.downRegion eq '3805'?'selected':''}"/>>남해군</option>
		<option value="studyList${pageMaker.makeDownRegion('3806') }" <c:out value="${cri.downRegion eq '3806'?'selected':''}"/>>밀양시</option>
		<option value="studyList${pageMaker.makeDownRegion('3807') }" <c:out value="${cri.downRegion eq '3807'?'selected':''}"/>>사천시</option>
		<option value="studyList${pageMaker.makeDownRegion('3808') }" <c:out value="${cri.downRegion eq '3808'?'selected':''}"/>>산청군</option>
		<option value="studyList${pageMaker.makeDownRegion('3809') }" <c:out value="${cri.downRegion eq '3809'?'selected':''}"/>>양산시</option>
		<option value="studyList${pageMaker.makeDownRegion('3810') }" <c:out value="${cri.downRegion eq '3810'?'selected':''}"/>>의령군</option>
		<option value="studyList${pageMaker.makeDownRegion('3811') }" <c:out value="${cri.downRegion eq '3811'?'selected':''}"/>>진주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3812') }" <c:out value="${cri.downRegion eq '3812'?'selected':''}"/>>창녕군</option>
		<option value="studyList${pageMaker.makeDownRegion('3813') }" <c:out value="${cri.downRegion eq '3813'?'selected':''}"/>>창원시 마산합포구</option>
		<option value="studyList${pageMaker.makeDownRegion('3814') }" <c:out value="${cri.downRegion eq '3814'?'selected':''}"/>>창원시 마산회원구</option>
		<option value="studyList${pageMaker.makeDownRegion('3815') }" <c:out value="${cri.downRegion eq '3815'?'selected':''}"/>>창원시 성산구</option>
		<option value="studyList${pageMaker.makeDownRegion('3816') }" <c:out value="${cri.downRegion eq '3816'?'selected':''}"/>>창원시 의창구</option>
		<option value="studyList${pageMaker.makeDownRegion('3817') }" <c:out value="${cri.downRegion eq '3817'?'selected':''}"/>>창원시 진해구</option>
		<option value="studyList${pageMaker.makeDownRegion('3818') }" <c:out value="${cri.downRegion eq '3818'?'selected':''}"/>>통영시</option>
		<option value="studyList${pageMaker.makeDownRegion('3819') }" <c:out value="${cri.downRegion eq '3819'?'selected':''}"/>>하동군</option>
		<option value="studyList${pageMaker.makeDownRegion('3820') }" <c:out value="${cri.downRegion eq '3820'?'selected':''}"/>>함안군</option>
		<option value="studyList${pageMaker.makeDownRegion('3821') }" <c:out value="${cri.downRegion eq '3821'?'selected':''}"/>>함양군</option>
		<option value="studyList${pageMaker.makeDownRegion('3822') }" <c:out value="${cri.downRegion eq '3822'?'selected':''}"/>>합천군</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '39' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
		<option value="studyList${pageMaker.makeDownRegion('3901') }" <c:out value="${cri.downRegion eq '3901'?'selected':''}"/>>제주시</option>
		<option value="studyList${pageMaker.makeDownRegion('3902') }" <c:out value="${cri.downRegion eq '3902'?'selected':''}"/>>서귀포시</option>
	</select>
</c:if>
<c:if test="${cri.upRegion eq '40' }">
	<select class="form-control filtering">
		<option value="studyList${pageMaker.makeDownRegion('n') }" <c:out value="${cri.downRegion eq 'n'?'selected':''}"/>>전체</option>
	</select>
</c:if>