package com.myproject.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myproject.domain.MarkerVO;
import com.myproject.domain.PathVO;
import com.myproject.domain.TrailVO;
import com.myproject.mapper.TrailMapper;
import com.myproject.mapper.PathMapper;
import com.myproject.mapper.MarkerMapper;
import com.myproject.mapper.SampleMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PathMapperTests {
	
		
	@Setter(onMethod_=@Autowired)
	private PathMapper mapper;
		

	@Test
	//Marker MarkerInsert test
	public void testpathInsert() {
		
		PathVO path = new PathVO();
		
		path.setTrailNo(69L);
		path.setLng(126.57138305595264D);
		path.setLat(33.450450810177195D);
		
		mapper.insert(path);
		
		
		log.info("test end");
	}
	
}
