package com.myproject.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myproject.domain.TrailVO;
import com.myproject.mapper.MainMapper;
import com.myproject.mapper.SampleMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MainMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private SampleMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private MainMapper mainMapper;
	
	//@Test
	public void testGetTime() {
		log.info(mapper.getClass().getName());
		log.info(mapper.getTime());
	}
	
	//@Test
	//Trail Main
	public void testGetList() { 
		mainMapper.getList().forEach(trail -> log.info(trail));
	}
	
	@Test
	//Train trailSelectInsertKey
	public void testTrailSelectInsertKey() {
		
		TrailVO trail = new TrailVO();
		trail.setUserNo(1L);
		trail.setTitle("select key test");
		trail.setThumnail("0");
		trail.setContents("select key test contests");
		trail.setStartLat(37.566826D);
		trail.setStartLng(126.978656D);
		trail.setEndLat(37.566828D);
		trail.setEndLng(126.978658D);
		
		mainMapper.trailInsertSelectKey(trail);
		
		log.info(trail);
	}
	
}
