package com.myproject.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.myproject.domain.AttachVO;
import com.myproject.mapper.AttachMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = {@Autowired})
	private AttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
	
	
	@Scheduled(cron="0 * * * * *")
	public void checkFiles()throws Exception{
		log.warn("File Check Task Run...........");
		log.warn((new Date()).toString());
		
		List<AttachVO>fileList = attachMapper.getOldFiles();
		
		List<Path>fileListPaths = fileList.stream()
						.map(vo->Paths.get("C:\\upload",vo.getUploadPath(),vo.getUuid()+"_"+vo.getFileName()))
						.collect(Collectors.toList());

		fileList.stream().map(vo->Paths.get("C:\\upload",vo.getUploadPath(),"s_"+vo.getUuid()+"_"+vo.getFileName()))
						.forEach(p->fileListPaths.add(p));
		
		fileListPaths.forEach(p->log.warn(p.toString()));
		
		File targetDir = Paths.get("C:\\upload",getFolderYesterDay()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file->fileListPaths.contains(file.toPath())==false);
		
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		
	}
	
}
