package com.myproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myproject.domain.TrailVO;
import com.myproject.service.MarkerService;
import com.myproject.service.TrailService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/trail/*")
@AllArgsConstructor
public class TrailController {
	
	private TrailService trailService;
	private MarkerService markerService;
	
	@GetMapping("/main")
	public void main(Model model) {
		log.info("main");
		
		model.addAttribute("trail",trailService.getTrailList());
				
		
	}
	
	//register 화면
	@GetMapping("/register")
	public void trailRegister(Model mode) {
		log.info("register");
		
	}
	
	//register 처리
	@PostMapping("/register")
	public String trailRegister(TrailVO trail, RedirectAttributes rttr) {
		
		log.info("register: "+trail);
		
		Long trailSeq =trailService.insertSelectKeyTrail(trail);
				
		rttr.addFlashAttribute("result", trailSeq);
		
		return "redirect:/trail/main";
		
	}
	
	
	
	
	
}
