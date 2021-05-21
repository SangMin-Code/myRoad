package com.myproject.mapper;

import java.util.List;

import com.myproject.domain.AttachVO;
import com.myproject.domain.PathVO;
import com.myproject.domain.TrailVO;

public interface PathMapper {
	
	public void insert(PathVO vo);
	
	public List<PathVO> pathGetList(Long trailNo);
}
