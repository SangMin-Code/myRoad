package com.myproject.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myproject.domain.AttachVO;
import com.myproject.domain.MarkerVO;
import com.myproject.domain.PathVO;
import com.myproject.domain.TrailVO;
import com.myproject.service.MarkerService;
import com.myproject.service.PathService;
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
	private PathService pathService;
	
	@GetMapping("/main")
	public void main(Model model) {
		log.info("main");
		
		model.addAttribute("trail",trailService.getTrailList());			
		
	}
	
	//get
	@GetMapping("/get")
	public void get(@RequestParam("trailNo") Long trailNo, Model model) {	
		log.info("/get");
		model.addAttribute("trail",trailService.getTrail(trailNo));
	}
	
	//getMarkerList
	@GetMapping(value ="/getMarkerList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<MarkerVO>>getMarkerList(Long trailNo){
		
		log.info("getMarkerList"+trailNo);
		
		return new ResponseEntity<List<MarkerVO>>(markerService.getListMarker(trailNo),HttpStatus.OK);
		
	}
	//getPathList
	@GetMapping(value ="/getPathList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<PathVO>>getPathList(Long trailNo){
		
		log.info("getPathList"+trailNo);
		
		return new ResponseEntity<List<PathVO>>(pathService.getListPath(trailNo),HttpStatus.OK);
		
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
	
	//modify 화면
	@GetMapping("/modify")
	public void modify(@RequestParam("trailNo") Long trailNo, Model model) {	
		log.info("modify");
		model.addAttribute("trail",trailService.getTrail(trailNo));
	}
	
	//modify 처리
	@PostMapping("/modify")
	public String trailModify(TrailVO trail, RedirectAttributes rttr) {
			
	log.info("modify: "+trail);
	
	int result =trailService.updateTrail(trail);
					
	rttr.addFlashAttribute("result", result);
			
	return "redirect:/trail/main";
			
	}
	
	//delete 처리
	@PostMapping("/delete")
	public String traildelete(@RequestParam("trailNo") Long trailNo, RedirectAttributes rttr) {
		
		log.info("delete: "+trailNo);
		
		List<MarkerVO> markerList = trailService.getTrail(trailNo).getMarkerList();
		
		int result =trailService.deleteTrail(trailNo);
		
		if(result==1) {
			if(markerList!=null && markerList.size()>0) {
				markerList.forEach(marker ->{
				deleteFiles(marker.getAttachList());
			});
			
			};
		}
		
		rttr.addFlashAttribute("result", "success");
		
		return "redirect:/trail/main";
		
	}
	
	private void deleteFiles(List<AttachVO> attachList) {
		
		if(attachList ==null||attachList.size()==0) {
			return;
		}
		
		log.info("delete attach files..............");
		log.info(attachList.toString());
		
		attachList.forEach(attach ->{
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumNail);
				}
			} catch (Exception e) {
				log.error("delete file error"+e.getMessage());
			}
		});
	}
	
	
	
}
