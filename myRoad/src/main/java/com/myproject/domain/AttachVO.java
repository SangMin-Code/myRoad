package com.myproject.domain;

import lombok.Data;

@Data
public class AttachVO {
	
	private Long markerNo;  	//마커번호
	private String uuid;		//uuid
	private String uploadPath;	//업로드경로
	private String fileName;	//파일명
	
}
