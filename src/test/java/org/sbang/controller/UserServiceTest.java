package org.sbang.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.sbang.domain.UserVO;
import org.sbang.service.UserService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml","file:src/main/webapp/WEB-INF/spring/**/spring-security.xml"})
public class UserServiceTest {

	@Inject
	private UserService service;
	
	@Test // 회원가입 추가 테스트
	public void testCreate() throws Exception {
		
		UserVO user = new UserVO();
		String email = "admin@naver.com"; // 아이디
		String name = "관리자임다"; // 이름
		String nick = "관리자임다"; // 이름
		String pwd = "1234"; // 패스워드
		String gender = "M"; // 성별
		String birth = "900101";
		String number = "010,0000,0000"; // 전화번호
		
		user.setUserEmail(email); 
		user.setUserName(name); 
		user.setUserPwd(pwd); 
		user.setUserGender(gender); 
		user.setUserNick(nick); 
		user.setUserBirth(birth); 
		user.setUserPhoneNumber(number);
		service.create(user); 
		
	}

}
