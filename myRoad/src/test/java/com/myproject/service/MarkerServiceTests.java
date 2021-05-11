package com.myproject.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myproject.domain.MarkerVO;
import com.myproject.domain.TrailVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class MarkerServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private MarkerService markerService;
	
	//@Test
	public void testExist() {
		log.info(markerService.toString());
		assertNotNull(markerService);
	}
	
	@Test
	public void testInsertMarkerService() {
		log.info("insertMarkertService test");
		
		MarkerVO marker = new MarkerVO();
		marker.setTrailNo(42L);
		marker.setTitle("test");
		marker.setContent("test");
		marker.setLng(126.57138305595264D);
		marker.setLat(33.450450810177195D);
		
		markerService.insertMarker(marker);
				
	}
	
}
