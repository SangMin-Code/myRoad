package com.myproject.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myproject.domain.MarkerVO;
import com.myproject.domain.TrailVO;
import com.myproject.mapper.TrailMapper;
import com.myproject.mapper.MarkerMapper;
import com.myproject.mapper.SampleMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MarkerMapperTests {
	
		
	@Setter(onMethod_=@Autowired)
	private MarkerMapper mapper;
		

	//@Test
	//Marker MarkerInsert test
	public void testMarkerInsert() {
		
		MarkerVO marker = new MarkerVO();
		marker.setTrailNo(42L);
		marker.setTitle("test");
		marker.setContent("test");
		marker.setLng(126.57138305595264D);
		marker.setLat(33.450450810177195D);
		
		mapper.markerInsert(marker);
		
		
		log.info("test end");
	}
	@Test
	public void testMarkerGetList() {
		
		log.info("testMarkerGetList");
		
		Long trailNo = 71L;
		
		mapper.markerGetList(trailNo);
	
	}
}
