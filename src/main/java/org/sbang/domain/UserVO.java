package org.sbang.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	
	private Integer userNo;
	
	private String userEmail;
	private String userPwd;
	private String userNick;
	private String userName;
	private String userBirth;
	private String userGender;
	private String userPhoneNumber;
	private String userIntroduce;
	private String userProfileImgPath;
	private String userFavUpCategory;
	private String userFavCategory;
	private String userFavUpRegion;
	private String userFavDownRegion;
	
	private String userWishList;
	private String userKakao;
	private String userNaver;
	
	private Date userRegDate;
	private Date userUpdateDate;

	private Boolean userCertification;

	private String sessionKey;
	private Date sessionLimit;
	
	private Integer userApprove; // 유저 승인 여부
	private Integer userAuth; // 유저 인증 여부 (0 = 일반유저 , 1 = 관리자)
	private Integer userHaltDate; // 유저 ~까지 정지
	private Integer userLeave; // 유저 탈퇴 유무
	private Integer userPenalty; // 유저 패널티
	
}