package org.sbang.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class StudyVO {

	private Integer studyNo;
	private String studyName;
	private String studyUpCategory;
	private String studyCategory;
	private String studyUpRegion;
	private String studyDownRegion;
	private String studyIntroduce;
	private String studyTargetAge;
	
	private Integer studyWriter; // 유저 번호 저장
	private Integer studyMaxMemCnt;
	private Integer studyCurMemCnt;
	private Integer studyViewCnt;
	private Integer studyReplyCnt;
	private Integer studyFavCnt;
	
	private Date studyRegDate;
	private Date studyUpdateDate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date studyStartDate;
	private Date studyEndDate;

	private String imagePath; //리스트 썸네일 이미지
	private WeekVO[] weekVO; // 주 단위 일정
	private String[] files; // 파일 목록
	private String userProfileImgPath; // 유저 프로필 이미지
	private String userNick; // 유저 닉네임 저장
	private Integer studyDelete; // 스터디 삭제 유무
	private String studyLeader; //유저 승인정보(스터디원,장 비교)

}
