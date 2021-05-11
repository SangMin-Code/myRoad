package com.myproject.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.myproject.service.TrailServiceTests;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Slf4j
public class TrailControllerTests {
	
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	//@Test
	public void testMain() throws Exception{
		mockMvc.perform(MockMvcRequestBuilders.get("/trail/main"))
		.andReturn()
		.getModelAndView()
		.getModelMap();
	}
	
	@Test
	public void testRegister() throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/trail/register")
				.param("userNo", "1")
				.param("title","test Title")
				.param("content", "test Contents")
				.param("thumnail", "0")
				.param("startLat", "33.450450810177195d")
				.param("startLng","126.57138305595264d")
				.param("endLat", "33.45170405221839d")
				.param("endLng", "126.57138764645934d"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
		
	}
	

}
