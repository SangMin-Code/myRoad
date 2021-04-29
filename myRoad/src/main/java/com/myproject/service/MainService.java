package com.myproject.service;

import java.util.List;

import com.myproject.domain.TrailVO;

public interface MainService {
	
	//Main Trail List 목록 가져오기
	public List<TrailVO> getTrailList();
}
