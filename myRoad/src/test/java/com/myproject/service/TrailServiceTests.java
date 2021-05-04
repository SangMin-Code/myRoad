package com.myproject.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myproject.domain.TrailVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class TrailServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private TrailService trailService;
	
	//@Test
	public void testExist() {
		log.info(trailService.toString());
		assertNotNull(trailService);
	}
	//@Test
	public void testGetTrailList() {
		log.info("trail test");
		trailService.getTrailList().forEach(trail -> log.info(trail.toString()));
	}
	
	@Test
	public void testInsertSelectTrailTests() {
		log.info("insertSelect test");
		
		TrailVO trail = new TrailVO();
		trail.setUserNo(1L);
		trail.setTitle("test title");
		trail.setContents("test contents");
		trail.setThumnail("0");
		trail.setStartLat(33.450450810177195d);
		trail.setStartLng(126.57138305595264d);
		trail.setEndLat(33.45170405221839d);
		trail.setEndLng(126.57138764645934d);
		
		trailService.insertSelectKeyTrail(trail);
		
		log.info(trail.getTrailNo().toString());
		
	}
	
}
