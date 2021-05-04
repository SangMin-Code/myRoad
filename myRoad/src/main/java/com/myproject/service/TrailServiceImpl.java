package com.myproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myproject.domain.TrailVO;
import com.myproject.mapper.TrailMapper;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@AllArgsConstructor
public class TrailServiceImpl implements TrailService {
	
	private TrailMapper trailMapper;

	@Override
	public List<TrailVO> getTrailList() {
		
		log.info("trailMapper.getList");
		
		return trailMapper.getList();
	}
	
	@Override
	public Long insertSelectKeyTrail(TrailVO trail) {
		
		log.info("trailMapper.insertSelectKeyTrail");
		
		return trailMapper.trailInsertSelectKey(trail);
		
	}

}
