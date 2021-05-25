package com.myproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myproject.domain.AttachFileDTO;
import com.myproject.domain.AttachVO;
import com.myproject.domain.MarkerVO;
import com.myproject.domain.TrailVO;
import com.myproject.mapper.AttachMapper;
import com.myproject.mapper.MarkerMapper;
import com.myproject.mapper.PathMapper;
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
	@Setter(onMethod_=@Autowired)
	private AttachMapper attachMapper;
	@Setter(onMethod_=@Autowired)
	private PathMapper pathMapper;
	

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
		
		/*경로 추가 부분*/
		if(trail.getPathList()==null||trail.getPathList().size()<=0) {
			return result;
		}
		trail.getPathList().forEach(path->{
			path.setTrailNo(trail.getTrailNo());
			pathMapper.insert(path);
		});
		
		/*마커 추가 부분*/
		if(trail.getMarkerList()==null || trail.getMarkerList().size()<=0) {
			return result;
		}
		
		trail.getMarkerList().forEach(marker->{
			marker.setTrailNo(trail.getTrailNo());
			markerMapper.markerInsertSelectKey(marker);
			/*마커별 파일 추가 부분*/
			if(marker.getAttachList()!=null && !marker.getAttachList().isEmpty()) {
				marker.getAttachList().forEach(attach->{
					attach.setMarkerNo(marker.getMarkerNo());
					attachMapper.insert(attach);
				});
			};
		});
		
		return result;
		
	}

	@Override
	@Transactional
	public TrailVO getTrail(Long trailNo) {
		
		log.info("getTrail...");
		
		TrailVO trailvo =trailMapper.trailGet(trailNo);
		
		trailvo.setMarkerList(markerMapper.markerGetList(trailNo));
		
		return trailvo;
	}
	
	@Transactional
	@Override
	public int updateTrail(TrailVO trail) {
		
		log.info("updateTrail..."+trail);
		
		int result =trailMapper.trailUpdate(trail);
			
		/*마커 추가 부분*/
		if(trail.getMarkerList()==null || trail.getMarkerList().size()<=0) {
			return result;
		}
		
		trail.getMarkerList().forEach(marker->{
			if (marker.getState() =="I") {
				marker.setTrailNo(trail.getTrailNo());
				markerMapper.markerInsertSelectKey(marker);
				/*마커별 파일 추가 부분*/
				if(marker.getAttachList()!=null && !marker.getAttachList().isEmpty()) {
					marker.getAttachList().forEach(attach->{
						attach.setMarkerNo(marker.getMarkerNo());
						attachMapper.insert(attach);
					});
				};
			}else if (marker.getState()=="U") {
				markerMapper.markerUpdate(marker);
				attachMapper.deleteByMarkerNo(marker.getMarkerNo());
				if(marker.getAttachList()!=null && !marker.getAttachList().isEmpty()) {
					marker.getAttachList().forEach(attach->{
						attach.setMarkerNo(marker.getMarkerNo());
						attachMapper.insert(attach);
					});
				};
			}else if (marker.getState()=="D") {
				attachMapper.deleteByMarkerNo(marker.getMarkerNo());
				markerMapper.markerDelete(marker.getMarkerNo());
			}
		});
		
		return result;
	}
	
	@Transactional
	@Override
	public int deleteTrail(Long trailNo) {
		
		pathMapper.pathDelete(trailNo);
		
		List<MarkerVO> markerList = markerMapper.markerGetList(trailNo);
		
		if(markerList!=null && markerList.size()>0) {
			markerList.forEach(marker->{
				attachMapper.deleteByMarkerNo(marker.getMarkerNo());
				markerMapper.markerDelete(marker.getMarkerNo());
			});
		}
		
		int result =trailMapper.trailDelete(trailNo);
		
		return result;
	}

}
