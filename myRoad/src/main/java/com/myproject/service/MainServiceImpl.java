package com.myproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myproject.domain.TrailVO;
import com.myproject.mapper.MainMapper;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@AllArgsConstructor
public class MainServiceImpl implements MainService {
	
	private MainMapper mainMapper;

	@Override
	public List<TrailVO> getTrailList() {
		
		log.info("mainMapper.getList");
		
		return mainMapper.getList();
	}
	

}
