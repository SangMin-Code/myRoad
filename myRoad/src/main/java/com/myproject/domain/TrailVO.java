package com.myproject.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class TrailVO {
	private Long userNo; 		//유저번호
	private Long trailNo;		//코스번호
	private String title;		//제목
	private String thumnail;	//섬네일유무 0 없음 1 있음
	private String content;	//내용
	private double startLat;		//출발위도
	private double  startLng;		//출발경도
	private double  endLat;		//도착위도
	private double  endLng;		//도착경도
	private Date regdate;		//등록일자
	private Date updateDate;	//수정일자
	
	private List<MarkerVO> markerList;
}
