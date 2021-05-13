package com.myproject.mapper;

import java.util.List;

import com.myproject.domain.AttachVO;
import com.myproject.domain.TrailVO;

public interface AttachMapper {
	
	public void insert(AttachVO vo);
	public void delete(String uuid);
	public List<AttachVO> findByMarkerNo(Long markerNo);
	
}
