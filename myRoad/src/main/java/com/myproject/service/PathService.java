package com.myproject.service;


import java.util.List;

import com.myproject.domain.AttachVO;
import com.myproject.domain.PathVO;

public interface PathService {
	
	//AttachInsert
	public void	insertPath(PathVO path);

	//getPathList
	public List<PathVO> getListPath(Long trailNo);
	
	
	
}
