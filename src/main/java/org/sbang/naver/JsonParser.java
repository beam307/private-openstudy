package org.sbang.naver;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.sbang.domain.UserVO;

public class JsonParser {
	JSONParser jsonParser = new JSONParser();

	public UserVO changeJson(String string) throws Exception {

		HashMap<String, Object> map = new HashMap<>();
		JSONParser jsonParser = new JSONParser();
		UserVO vo = new UserVO();

		JSONObject jsonObject = (JSONObject) jsonParser.parse(string);

		jsonObject = (JSONObject) jsonObject.get("response");

		map.put("userGender", jsonObject.get("gender"));
		map.put("userId", jsonObject.get("id"));
		map.put("userName", jsonObject.get("name"));
		map.put("userNick", jsonObject.get("nickname"));
		
		vo.setUserName(map.get("userName").toString()); // name -> vo.name 넣기
		vo.setUserNick(map.get("userNick").toString()); // nickname -> vo.nick 넣기
		vo.setUserEmail(map.get("userId").toString()); // id -> vo.email 넣기
		vo.setUserGender(map.get("userGender").toString()); // gender -> vo.gender 넣기
		vo.setUserNaver(map.get("userId").toString());// id -> vo.naver 넣기

		return vo;
	}
}
