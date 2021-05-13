package com.myproject.domain;

import lombok.Data;

@Data
public class AttachVO {
	
	private Long MarkerNo;  	//마커번호
	private String uuid;		//uuid
	private String filePath;	//업로드경로
	private String fileName;	//파일명
	
}
