package com.myproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myproject.service.MainService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/trail/*")
@AllArgsConstructor
public class MainController {
	
	private MainService mainService;
	
	@GetMapping("/main")
	public void main(Model model) {
		log.info("main");
		
		model.addAttribute("trail",mainService.getTrailList());
		
	}
	
	
	
}
