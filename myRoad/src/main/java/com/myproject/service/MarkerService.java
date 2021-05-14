package com.myproject.service;

import java.util.List;

import com.myproject.domain.MarkerVO;
import com.myproject.domain.TrailVO;

public interface MarkerService {
	
	//MarkerInsert
	public void	insertMarker(MarkerVO marker);
	//MarkerInsertSelect
	public void insertSelectKeyMarker(MarkerVO marker);
	
}
