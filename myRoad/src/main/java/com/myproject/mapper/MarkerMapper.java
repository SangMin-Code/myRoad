package com.myproject.mapper;

import java.util.List;

import com.myproject.domain.MarkerVO;

public interface MarkerMapper {
	
	//marker등록
	public void markerInsert(MarkerVO marker);
	
	//markerInsertSelectKey
	public void markerInsertSelectKey(MarkerVO marker);

	//getmarker
	public List<MarkerVO> markerGetList(Long trailNo);
}
