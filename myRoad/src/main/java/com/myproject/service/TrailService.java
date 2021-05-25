package com.myproject.service;

import java.util.List;

import com.myproject.domain.TrailVO;

public interface TrailService {
	
	//Main Trail List 목록 가져오기
	public List<TrailVO> getTrailList();
	
	public Long insertSelectKeyTrail(TrailVO trail);
	
	public TrailVO getTrail(Long trailNo);
	
	public int updateTrail(TrailVO trail);
	
	public int deleteTrail(Long trailNo);
	
}
