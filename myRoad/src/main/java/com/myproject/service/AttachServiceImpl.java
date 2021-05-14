package com.myproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myproject.domain.AttachVO;
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
public class AttachServiceImpl implements AttachService {
	
	private AttachMapper attachMapper;


	@Override
	public void insertAttach(AttachVO attach) {
		log.info("attachMapper.insertAttach");
		
		attachMapper.insert(attach);
	}


}
