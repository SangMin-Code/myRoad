package com.myproject.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myproject.domain.Criteria;
import com.myproject.domain.TrailVO;
import com.myproject.mapper.TrailMapper;
import com.myproject.mapper.SampleMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TrailMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private SampleMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private TrailMapper trailMapper;
	
	//@Test
	public void testGetTime() {
		log.info(mapper.getClass().getName());
		log.info(mapper.getTime());
	}
	
	@Test
	//Trail Main
	public void testGetList() { 
		Criteria cri = new Criteria();
		cri.setPageNum(2);
		cri.setAmount(5);
		trailMapper.getList(cri).forEach(trail -> log.info(trail));
	}
	
	//@Test
	//Train trailSelectInsertKey
	public void testTrailSelectInsertKey() {
		
		TrailVO trail = new TrailVO();
		trail.setUserNo(1L);
		trail.setTitle("select key test");
		trail.setThumnail("0");
		trail.setContent("select key test contests");
		trail.setStartLat(37.566826D);
		trail.setStartLng(126.978656D);
		trail.setEndLat(37.566828D);
		trail.setEndLng(126.978658D);
		
		trailMapper.trailInsertSelectKey(trail);
		
		log.info(trail);
	}
	
	//@Test
	//Train TrailGet
	public void testTralget() {
		
		Long trailNo = 71L;
		
		TrailVO trailvo = trailMapper.trailGet(trailNo);
		
		log.info(trailvo);
	
	}
	
	//@Test
	//Train TrailGet
	public void testTrailUpdate() {
		
		TrailVO trailvo = new TrailVO();
		trailvo.setTrailNo(123L);
		trailvo.setContent("업데이트 테스트");
		trailvo.setTitle("업데이트 테스트 타이틀");
			
		log.info("Update Count: "+trailMapper.trailUpdate(trailvo));
		
	}
	
	//@Test
	//Train TrailDelete
	public void testTrailDelete() {
		
		Long trailNo = 123L;
			
		log.info("Delete Count: "+ trailMapper.trailDelete(trailNo));
		
	}
	
	
}
