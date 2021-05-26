package com.myproject.service;

import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Marker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myproject.domain.AttachVO;
import com.myproject.domain.Criteria;
import com.myproject.domain.MarkerVO;
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
	@Test
	public void testGetTrailList() {
		log.info("trail test");
		trailService.getTrailList(new Criteria(3,5)).forEach(trail -> log.info(trail.toString()));
	}
	
	//@Test
	public void testInsertSelectTrailTests() {
		log.info("insertSelect test");
		
		TrailVO trail = new TrailVO();
		trail.setUserNo(1L);
		trail.setTitle("test title");
		trail.setContent("test contents");
		trail.setThumnail("0");
		trail.setStartLat(33.450450810177195d);
		trail.setStartLng(126.57138305595264d);
		trail.setEndLat(33.45170405221839d);
		trail.setEndLng(126.57138764645934d);
		
		MarkerVO marker = new MarkerVO();
		marker.setTitle("test marekr");
		marker.setContent("test");
		marker.setLat(33.450450810177195d);
		marker.setLng(126.57138305595264d);
		List<MarkerVO> list = new ArrayList<MarkerVO>();
		list.add(marker);
		trail.setMarkerList(list);
	
		trailService.insertSelectKeyTrail(trail);
		
		log.info(trail.getTrailNo().toString());
		
	}
	
	//@Test
	public void testgetTrail() {
		
		log.info("testGetTrail");
		
		Long trailNo=81L;
		
		trailService.getTrail(trailNo);
		
	}
	
	//@Test
	public void testupdateTrail() {
		log.info("testUpdateTRail");
		
		TrailVO trail = new TrailVO();
		
		trail.setTrailNo(124L);
		trail.setContent("콘콘콘");
		trail.setTitle("타타타");
		
		List<MarkerVO> markerList = new ArrayList<MarkerVO>();
		
		MarkerVO insert = new MarkerVO();
		insert.setTrailNo(124L);
		insert.setState("I");
		insert.setTitle("test marekr");
		insert.setContent("test");
		insert.setLat(33.450450810177195d);
		insert.setLng(126.57138305595264d);
		
		List<AttachVO> insertAttach = new ArrayList<AttachVO>();
		AttachVO insertFile = new AttachVO();
		insertFile.setFileName("insert test");
		insertFile.setUuid("insert test");
		insertFile.setUploadPath("insert test");
		insertAttach.add(insertFile);
		insert.setAttachList(insertAttach);
		
		markerList.add(insert);
		
		MarkerVO update = new MarkerVO();
		update.setTrailNo(124L);
		update.setState("U");
		update.setMarkerNo(91L);
		update.setTitle("update test marekr");
		update.setContent("update test");
		
		List<AttachVO> updateAttach = new ArrayList<AttachVO>();
		AttachVO updateFile = new AttachVO();
		updateFile.setFileName("update test");
		updateFile.setUuid("update test");
		updateFile.setUploadPath("update test");
		updateAttach.add(updateFile);
		update.setAttachList(updateAttach);
		
		markerList.add(update);
		
		MarkerVO delete = new MarkerVO();
		delete.setTrailNo(124L);
		delete.setState("D");
		delete.setMarkerNo(90L);
		
		markerList.add(delete);
		
		trail.setMarkerList(markerList);
		
		trailService.updateTrail(trail);		

	}
	
	//@Test
	public void testdeleteTrail() {
		log.info("deleteTrail");
		Long trailNo = 123L;
		trailService.deleteTrail(trailNo);
	}
	
}
