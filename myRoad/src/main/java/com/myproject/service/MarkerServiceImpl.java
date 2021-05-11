package com.myproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myproject.domain.MarkerVO;
import com.myproject.domain.TrailVO;
import com.myproject.mapper.MarkerMapper;
import com.myproject.mapper.TrailMapper;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@AllArgsConstructor
public class MarkerServiceImpl implements MarkerService {
	
	private MarkerMapper markerMapper;

	@Override
	public void insertMarker(MarkerVO marker) {
		
		log.info("markerMapper.insertMarker");
		
		markerMapper.markerInsert(marker);
		
		
		
	}

}
