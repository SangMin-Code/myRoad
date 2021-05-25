package com.myproject.mapper;

import java.util.List;

import com.myproject.domain.TrailVO;

public interface TrailMapper {
	//Main Trail 목록
	public List<TrailVO> getList();
	
	//Main Trail 등록
	public Long trailInsertSelectKey(TrailVO trail);
	
	//Trail 상세
	public TrailVO trailGet(Long trailNo);
	
	//Trail update
	public int trailUpdate(TrailVO trail);
	
	//Trail delete
	public int trailDelete(Long traulNo);
}
