package org.sbang.DTO;

import lombok.Data;

@Data
public class LoginDTO { // 로그인 DTO

	private String userEmail;
	private String userPwd;
	private String userName;
	private boolean rememberEmail;
	private boolean useCookie;

}