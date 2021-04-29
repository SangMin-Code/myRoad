package com.myproject.mapper;

import java.util.List;

import com.myproject.domain.TrailVO;

public interface MainMapper {
	//Main Trail 목록
	public List<TrailVO> getList();
	
	//Main Trail 등록
	public void trailInsertSelectKey(TrailVO trail);
}
