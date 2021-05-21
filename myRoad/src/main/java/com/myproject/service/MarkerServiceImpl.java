package com.myproject.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myproject.domain.MarkerVO;
import com.myproject.domain.TrailVO;
import com.myproject.mapper.AttachMapper;
import com.myproject.mapper.MarkerMapper;
import com.myproject.mapper.TrailMapper;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@AllArgsConstructor
public class MarkerServiceImpl implements MarkerService {
	
	private MarkerMapper markerMapper;
	private AttachMapper attachMapper;
	
	@Override
	public void insertMarker(MarkerVO marker) {
		
		log.info("markerMapper.insertMarker");
		
		markerMapper.markerInsert(marker);
		
	}

	@Override
	public void insertSelectKeyMarker(MarkerVO marker) {
		
		log.info("markerMapper.insertSelectKeyMarker");
		
		markerMapper.markerInsertSelectKey(marker);

	}

	@Override
	@Transactional
	public List<MarkerVO> getListMarker(Long markerNo) {
		log.info("markerMapper.getListMarker");
		
		List<MarkerVO> markerList = markerMapper.markerGetList(markerNo);
	
		markerList.forEach(marker ->{
			marker.setAttachList(attachMapper.findByMarkerNo(marker.getMarkerNo()));
		});
		
		return markerList;
	}
	

}
