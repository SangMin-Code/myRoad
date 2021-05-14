package com.myproject.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myproject.domain.MarkerVO;
import com.myproject.domain.PathVO;
import com.myproject.domain.TrailVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class PathServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private PathService pathService;
	
	//@Test
	public void testExist() {
		log.info(pathService.toString());
		assertNotNull(pathService);
	}
	
	
	@Test
	public void testInsertSelectMarkerService() {
		log.info("insertSelectMarkertService test");
		
		PathVO path = new PathVO();
		path.setTrailNo(69L);
		path.setLng(126.57138305595264D);
		path.setLat(33.450450810177195D);
		
		pathService.insertPath(path);
		
				
	}
}
