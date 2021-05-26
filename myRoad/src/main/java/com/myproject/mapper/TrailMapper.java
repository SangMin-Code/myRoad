package com.myproject.mapper;

import java.util.List;

import com.myproject.domain.Criteria;
import com.myproject.domain.TrailVO;

public interface TrailMapper {
	// Trail 목록
	public List<TrailVO> getList(Criteria cri);
	
	//total count
	public int getTotalCount(Criteria cri);
	
	// Trail 등록
	public Long trailInsertSelectKey(TrailVO trail);
	
	//Trail 상세
	public TrailVO trailGet(Long trailNo);
	
	//Trail update
	public int trailUpdate(TrailVO trail);
	
	//Trail delete
	public int trailDelete(Long traulNo);
}
