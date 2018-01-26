package org.sbang.naver;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.sbang.domain.UserVO;

public class JsonParser {
	JSONParser jsonParser = new JSONParser();

	public UserVO changeJson(String string) throws Exception { // JSON -> userVO에 담기 (string 변수는 불러들인 유저정보)

		JSONParser jsonParser = new JSONParser();
		UserVO userVO = new UserVO();

		JSONObject jsonObject = (JSONObject) jsonParser.parse(string);

		jsonObject = (JSONObject) jsonObject.get("response"); // 유저정보를 풀어서 JSONObject에 담기
		
		userVO.setUserName(jsonObject.get("name").toString()); // name -> vo.name 넣기
		userVO.setUserNick(jsonObject.get("nickname").toString()); // nickname -> vo.nick 넣기
		userVO.setUserEmail(jsonObject.get("id").toString()); // id -> vo.email 넣기
		userVO.setUserGender(jsonObject.get("gender").toString()); // gender -> vo.gender 넣기
		userVO.setUserNaver(jsonObject.get("id").toString());// id -> vo.naver 넣기

		return userVO;
	}
}
