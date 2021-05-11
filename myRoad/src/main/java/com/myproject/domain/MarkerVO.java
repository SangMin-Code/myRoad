package com.myproject.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MarkerVO {
	
	private Long trailNo;  		//경로번호   
	private String title;		//제목
	private String content;		//내용
	private double lat; 		//경도
	private double lng;  		//위도
	private Date regdate;		//등록일자
	private Date updateDate;	//수정일자
	
}
