package com.myproject.service;

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
		log.info("attachMapper.insertAttach");
		
		pathMapper.insert(path);
		
	}


}
