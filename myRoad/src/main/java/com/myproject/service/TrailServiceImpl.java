package com.myproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myproject.domain.TrailVO;
import com.myproject.mapper.MarkerMapper;
import com.myproject.mapper.TrailMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@AllArgsConstructor
public class TrailServiceImpl implements TrailService {
	
	@Setter(onMethod_=@Autowired)
	private TrailMapper trailMapper;
	@Setter(onMethod_=@Autowired)
	private MarkerMapper markerMapper;

	@Override
	public List<TrailVO> getTrailList() {
		
		log.info("trailMapper.getList");
		
		return trailMapper.getList();
	}
	
	@Override
	@Transactional
	public Long insertSelectKeyTrail(TrailVO trail) {
		
		log.info("trailMapper.insertSelectKeyTrail");
		
		log.info(trail.toString()+"~~~~~~");
		
		Long result = trailMapper.trailInsertSelectKey(trail);
		
		//TODO trail service안에 넣어야 하는지?? 안에 컨텐츠 list도 넣을건데
		if(trail.getMarkerList()==null || trail.getMarkerList().size()<=0) {
			return result;
		}
		
		trail.getMarkerList().forEach(marker->{
			marker.setTrailNo(trail.getTrailNo());
			markerMapper.markerInsert(marker);
		});
		
		return result;
		
	}

}
