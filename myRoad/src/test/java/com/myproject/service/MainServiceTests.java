package com.myproject.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class MainServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private MainService mainService;
	
	//@Test
	public void testExist() {
		log.info(mainService.toString());
		assertNotNull(mainService);
	}
	@Test
	public void testGetTrailList() {
		log.info("trail test");
		mainService.getTrailList().forEach(trail -> log.info(trail.toString()));
	}
	
}
