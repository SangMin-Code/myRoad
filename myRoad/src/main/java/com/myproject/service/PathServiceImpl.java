package com.myproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myproject.domain.PathVO;
import com.myproject.mapper.PathMapper;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@AllArgsConstructor
public class PathServiceImpl implements PathService {
	
	private PathMapper pathMapper;

	@Override
	public void insertPath(PathVO path) {
		log.info("pathMapper.insertPath");
		
		pathMapper.insert(path);
		
	}

	@Override
	public List<PathVO> getListPath(Long trailNo) {
		log.info("pathMapper.getListPath");
		
		return pathMapper.pathGetList(trailNo);		
	}
	
	

}
