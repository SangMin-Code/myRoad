<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<style>
.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
</style>
<%@include file ="/WEB-INF/views/includes/header.jsp" %>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">코스 수정하기</h1>
                    <p class="mb-4"></p>
					
					<!-- map -->                   
                    <div class="row">
						<div class="col-xl-6 col-lg-7"> <!--left box-->
                    		<!-- 주변 코스 목록 -->
							<div class= "card shadow mb-4">
                        <div class="card-header py-3">
                            <h7 class= "m-0 font-weight-bold text-primary">코스 수정하기</h7>
							<button id="addMarker"class="btn btn-success float-right mr-1">
	                            마커 추가
	                        </button>
                        </div>
                        <div class="card-body">
                            <div id="map" style="width:100%;height:730px;"></div>  
                        </div>
                    </div>						
					</div> <!--div left box-->
						<div class="col-xl-5 col-lg-5"> <!--right box-->
                    		<!-- 스팟 정보 -->
							<div class="card shadow mb-4">
								<div class="card-header py-3" >
									<h6 class="m-0 mt-2 font-weight-bold text-primary" style="width:50%; float:left">마커 정보</h6>
								</div>
								<div class="card-body">
									<form role ="marker_form" method="post">
                                        <div class="form-group">
                                            <label>장소 이름</label>
                                            <input class ="form-control" id="markerTitle">
                                        </div>
                                        <div class="form-group">
                                            <label>내용</label>
                                            <textarea class ="form-control" rows="3" id='markerContent' ></textarea>
                                        </div>
                                        <button type="button" class="btn btn-success" id="markerSaveBtn">
                            				마커저장
		                            	</button>
		                            	<button type="button" class="btn btn-danger" id="markerDelBtn">
		                            		마커삭제
		                            	</button>
		                            	<input type="hidden" id="markerIdx" value="0"/>
                                    </form> 
								</div>
							</div>
							<!--마커 갤러리-->
							<div class="card shadow mb-4" >
								<div class="card-header py-3" >
									<h6 class="m-0 mt-2 font-weight-bold text-primary" style="width:50%; float:left">갤러리</h6>
								</div>
								<div class="card-body" style="overflow:auto; height:400px">
		                            <div class="input-group">
		                                <input type="file" class = "form-control p-1" name='uploadFile' multiple>
		                            </div>
		                            <div class ="uploadResult">
		                                <ul class="list-group">
		                                </ul>
		                            </div>
                        		</div>
							</div>
						</div> <!--div right box-->
					</div> <!--div row-->

                    <!-- trail 제목, 내용 -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">코스 수정하기</h6>
                        </div>
                        <div class="card-body">
                            <form role ="trail_form" method="post">
                                <input type="hidden" name="userNo" value='<c:out value="${trail.userNo}"/>'/>
                                <input type="hidden" name="thumnail" value='<c:out value="${trail.thumnail}"/>'/>
                                <input type ="hidden" name ="trailNo" value ='<c:out value="${trail.trailNo}"/>'/>
                                <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>                        
                        		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>  
                                
                                <div class="form-group">
                            		<label>제목</label>
                            		<input class ="form-control" name="title" value='<c:out value="${trail.title}"/>'>
                            	</div>
                            	<div class="form-group">
                            		<label>내용</label>
                            		<textarea class ="form-control" rows="3" name='content'><c:out value="${trail.content}"/></textarea>
                            	</div>
                            	
                            	<button type ="submit" data-oper='modify' class="btn btn-success">
										수정</button>
								<button type="submit" data-oper='delete' class="btn btn-danger">
										삭제</button>
								<button type="submit" data-oper='list' class="btn btn-info">
                           				목록</button>
                            	
                            </form> 
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->

<!-- map -->
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(<c:out value="${trail.startLat}"/>, <c:out value="${trail.startLng}"/>), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


// 마커 생성
function makeMarker(mouseEvent){
	// 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng; 
        
    // 지도를 클릭한 위치에 표출할 마커입니다
    var marker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: latlng,
    clickable:true,
    title:markerIdx
    }); 
       	
    var data = {
    			lat:latlng.getLat()
     			,lng:latlng.getLng()
      			,title:""
      			,content:"test"+markerIdx
      			,markerNo:-1 
      			,state:"I"
     			}
    
    var iwContent = '<div class="dotOverlay">'+data.title+'</div>'

	// 인포윈도우를 생성합니다
	var infoWindow = new kakao.maps.CustomOverlay({
		map: map,
		position : latlng, 
    	content : iwContent,
    	zIndex:1000,
    	yAnchor: 2 
	});
    
    markerIdx++;
        
    markers.push({"data":data,"marker":marker,"infoWindow":infoWindow})    
        
    //마커 왼쪽 클릭 시 스팟 정보 뿌리기
    kakao.maps.event.addListener(marker, 'click', function() {
    	   	
    	for (var i = 0; i < markers.length; i ++) {
        if (markers[i].marker.getTitle()==marker.getTitle()){
            $("#markerTitle").val(markers[i].data.title)
        	$("#markerContent").val(markers[i].data.content)
        	$("#markerIdx").val(marker.getTitle())
        	showUploadResult(markers[i].data.files)
        	markers[i].marker.setOpacity(1)
        }else{
        	markers[i].marker.setOpacity(0.5)
        }
	    if (markers[i].data.state !="D"){
		    markers[i].marker.setMap(map);
	      	
	        }
        }
      });
        
    //마커 오른족 클릭 시 마커 삭제
	kakao.maps.event.addListener(marker, 'rightclick', function() {
		
	    var d_idx = 0			
			
        for (var i = 0; i < markers.length; i ++) {
        	if (markers[i].marker.getTitle()==marker.getTitle()){
            	d_idx=i
      			break
        		}
        	}
		markers[d_idx].marker.setMap(null)
        markers[d_idx].data.state="D"
        markers[d_idx].infoWindow.setMap(null)
        	
        $("#markerTilte").val(null)
        $("#markerContent").val(null)
        $("#markerIdx").val(null)
        	
        	
      	});
    
		for (var i = 0; i < markers.length-1; i++) {
			markers[i].marker.setOpacity(0.5)
			if(markers[i].data.state !="D"){
				markers[i].marker.setMap(map);
			}
	    }
        
        // 지도에 마커를 표시합니다
        marker.setMap(map);
    
    }


// 선 생성
var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
var dots = []; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.


// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
function deleteClickLine() {
    if (clickLine) {
        clickLine.setMap(null);    
        clickLine = null;        
    }
}

// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
function showDistance(content, position) {
    
    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
        
        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
        distanceOverlay.setPosition(position);
        distanceOverlay.setContent(content);
        
    } else { // 커스텀 오버레이가 생성되지 않은 상태이면
        
        // 커스텀 오버레이를 생성하고 지도에 표시합니다
        distanceOverlay = new kakao.maps.CustomOverlay({
            map: map, // 커스텀오버레이를 표시할 지도입니다
            content: content,  // 커스텀오버레이에 표시할 내용입니다
            position: position, // 커스텀오버레이를 표시할 위치입니다.
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3  
        });      
    }
}

// 그려지고 있는 선의 총거리 정보와 
// 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
function deleteDistnce () {
    if (distanceOverlay) {
        distanceOverlay.setMap(null);
        distanceOverlay = null;
    }
}

// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
function displayCircleDot(position, distance) {

    
    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
    var circleOverlay = new kakao.maps.CustomOverlay({
        content: '<span class="dot"></span>',
        position: position,
        zIndex: 1
    });

    // 지도에 표시합니다
    circleOverlay.setMap(map);

    if (distance > 0) {

        //표시한 커스텀 오버레이 제거
        $(".dotOverlay").remove()

        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
        var distanceOverlay = new kakao.maps.CustomOverlay({
            content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
            position: position,
            yAnchor: 1,
            zIndex: 2
        });

        // 지도에 표시합니다
        distanceOverlay.setMap(map);
    }

    // 배열에 추가합니다
    dots.push({circle:circleOverlay, distance: distanceOverlay});
}

// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
function deleteCircleDot() {
    var i;

    for ( i = 0; i < dots.length; i++ ){
        if (dots[i].circle) { 
            dots[i].circle.setMap(null);
        }

        if (dots[i].distance) {
            dots[i].distance.setMap(null);
        }
    }

    dots = [];
}

// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
// HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {

    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
    var walkkTime = distance / 67 | 0;
    var walkHour = '', walkMin = '';

    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
    if (walkkTime > 60) {
        walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
    }
    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

    // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
    var bycicleTime = distance / 227 | 0;
    var bycicleHour = '', bycicleMin = '';

    // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
    if (bycicleTime > 60) {
        bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
    }
    bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
    var content = '<ul class="dotOverlay distanceInfo">';
    content += '    <li>';
    content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
    content += '    </li>';
    content += '    <li>';
    content += '        <span class="label">도보</span>' + walkHour + walkMin;
    content += '    </li>';
    content += '    <li>';
    content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
    content += '    </li>';
    content += '</ul>'

    return content;
}

</script>

<!-- others -->
<script>
var csrfHeadName ="${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
var markers = []
var markerIdx = 1
var paths = []

var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880;

function checkExtension(fileName, fileSize){
    if(fileSize>=maxSize){
        alert("파일 사이즈 초과");
        return false;
    }
    if(regex.test(fileName)){
        alert("해당 종류의 파일은 업로드할 수 없습니다.");
        return false;
    }
    return true;
}

function appendFileList(result){
	idx = $("#markerIdx").val()
	for (var i=0; i<markers.length; i++){
		if (markers[i].marker.getTitle()==idx){
			markers[i].data.files = result
			if (markers[i].data.state=="R"){
				markers[i].data.state="U"
			}
				
			break
		}
	}
}



function showUploadResult(uploadResultArr){
    var uploadUL = $(".uploadResult ul");
    var str = "";
    
	if(!uploadResultArr||uploadResultArr.length==0){
		uploadUL.html(str)
		return;
		}
    
    $(uploadResultArr).each(function(i,obj){
    		var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName)
            str+="<li class='list-group-item' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'"; 
            str+=" data-type='"+obj.image+"'><div>";
            str+= "<span>"+obj.fileName+"</span>";
            str+="<button type='button' class='btn btn-warning btn-circle' style='float:right;' data-file=\'"+fileCallPath+"\' data-type='image' data-uuid='"+obj.uuid+"'>" 
            str+="<i class='fa fa-times'></i></button>"
            str+="</div></li>"
    });
    uploadUL.html(str);
}

function makePath(pathArr){
	
	if(!pathArr||pathArr.length==0){
		return;
	}
	
	var clickPosition =[]
	
	$(pathArr).each(function(i,p){
		var lat =p.lat
		var lng =p.lng
		paths.push({lat,lng})
		clickPosition=new kakao.maps.LatLng(lat, lng);
		if(i==0){
			clickLine = new kakao.maps.Polyline({
	            map: map, // 선을 표시할 지도입니다 
	            path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
	            strokeWeight: 3, // 선의 두께입니다 
	            strokeColor: '#db4040', // 선의 색깔입니다
	            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	            strokeStyle: 'solid' // 선의 스타일입니다
			});
	        moveLine = new kakao.maps.Polyline({
	            strokeWeight: 3, // 선의 두께입니다 
	            strokeColor: '#db4040', // 선의 색깔입니다
	            strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	            strokeStyle: 'solid' // 선의 스타일입니다    
	        });
	        displayCircleDot(clickPosition, 0);
		}else{
	        var path = clickLine.getPath();

	        var movepath = [path[path.length-1], clickPosition];
	        
	        moveLine.setPath(movepath);    
	        
	        var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
	            content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
	        
	        showDistance(content, clickPosition);   
	        
	        path.push(clickPosition);
	        
	        clickLine.setPath(path);

	        var distance = Math.round(clickLine.getLength());

	        displayCircleDot(clickPosition, distance);	
		}
		if(i==pathArr.length-1){
	        
	        // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
	        var path = clickLine.getPath();
	    
	        // 선을 구성하는 좌표의 개수가 2개 이상이면
	        if (path.length > 1) {

	            // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
	            if (dots[dots.length-1].distance) {
	                dots[dots.length-1].distance.setMap(null);
	                dots[dots.length-1].distance = null;    
	            }

	            var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
	                content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
	                
	            // 그려진 선의 거리정보를 지도에 표시합니다
	            showDistance(content, path[path.length-1]);  
			
			}
		}
		
	})
	
}

function makeReadMarker(markerArr){
	if(!markerArr||markerArr.length==0){
		return;
	}
	$(markerArr).each(function(i,m){	
		var lat = m.lat
		var lng = m.lng
		var title = m.title
		var content = m.content
		var markerNo = m.markerNo
		var files = m.attachList
	
    	var latlng = new kakao.maps.LatLng(lat, lng);
    	var marker = new kakao.maps.Marker({
    		position:latlng
    		,clickable:true
    		,title:markerIdx
			,zIndex:999
			,opacity:0.5
    	});
    	
    	var iwContent = '<div class="dotOverlay">'+title.substr(0,7)+'</div>'
    	
    	// 인포윈도우를 생성합니다
    	var infoWindow = new kakao.maps.CustomOverlay({
    		map: map,
    		position : latlng, 
        	content : iwContent,
        	zIndex:1000,
        	yAnchor: 2 
    	});
    	
    	var data = {
    			"lat" :lat
    			,"lng":lng
    			,"title":title
    			,"content":content
    			,"markerNo":markerNo
    			,"files":files
    			,"state":"R"
    	}
    	markerIdx++;
    	
    	markers.push({"data":data,"marker":marker,"infoWindow":infoWindow})
	
    	kakao.maps.event.addListener(marker, 'click', function() {
	    	for (var j = 0; j < markers.length; j ++) {
	    		if (markers[j].marker.getTitle()==marker.getTitle()){
	    			$("#markerTitle").val(markers[j].data.title)
	    			$("#markerContent").val(markers[j].data.content)
	    			$("#markerIdx").val(marker.getTitle())
	    			showUploadResult(markers[j].data.files)
	    			markers[j].marker.setOpacity(1)
	    		}else{
	    			markers[j].marker.setOpacity(0.5)
	    		}
	    	}
  		}); 
    	
	});//arr
	
	for (var i = 0; i < markers.length; i++) {
			markers[i].marker.setMap(map);
    }   
}

function deleteFileList(uuid,markerTitle){
	for (var i = 0; i < markers.length; i ++) {
		if (markers[i].marker.getTitle()==markerTitle){
			for(var j=0; j<markers[i].data.files.length; j++){
				d_idx = 0
				flag = false
				if(markers[i].data.files[j].uuid == uuid){
					d_idx = j
					flag = true
				}
				if(flag) {
					markers[i].data.files.splice(j,1)
					if(markers[i].data.state=="R"){
						markers[i].data.state="U"
					}
					break
				}	
			}
		}
	}
}



//onload
$(document).ready(function(e){

	//PathList 읽어오기
	$.ajax({
		url:"/trail/getPathList"
		,data:{trailNo:"<c:out value="${trail.trailNo}"/>"}
		,type:"GET"
		,dataType:'json'
		,success:function(result){
			makePath(result)
		}
		,error:function(error){
			console.log(error)
		}
	});
	
	
	//MarkerList 읽어오기
	$.ajax({
		url:"/trail/getMarkerList"
		,data:{trailNo:"<c:out value="${trail.trailNo}"/>"}
		,type:'GET'
		,dataType:'json'
		,success:function(result){
			makeReadMarker(result)
			if(markers.length>0){
				kakao.maps.event.trigger(markers[0].marker, 'click',function(){
				});				
			}
		}
		,error:function(error){
			console.log(error)
		}
	})
	
    /*for_test*/
    if($("input[name='userNo']").val()=="" || $("input[name='userNo']").val()==null){
        	$("input[name='userNo']").val(1);
    }
	
	//스팟 추가
	$("#addMarker").on("click",function(e){
        e.preventDefault();
        kakao.maps.event.addListener(map, 'click', makeMarker);
    })
	
	//스팟 저장
    $("#markerSaveBtn").on("click",function(e){
    	
    	if($("#markerIdx").val()==0 || $("#markerIdx").val()==null || $("#markerIdx").val()==""){
    		alert("마커를 선택해주세요.")
    		return
    	}
    	
    	idx = $("#markerIdx").val()   	
    	for(var i=0; i<markers.length; i++){
    		if(markers[i].marker.getTitle()==idx){
    			markers[i].data.title = $("#markerTitle").val()
    			markers[i].data.content = $("#markerContent").val()
    			if (markers[i].data.state=="R"){
    				markers[i].data.state="U"
    			}
    			markers[i].infoWindow.setContent('<div class="dotOverlay">'+$("#markerTitle").val().substr(0,10)+'</div>')
				markers[i].infoWindow.setMap(map);
    			break
    		}    			
    	}
    	
    	
    });
    
    //스팟 삭제
     $("#markerDelBtn").on("click",function(e){
    	 
    	if($("#markerIdx").val()==0 || $("#markerIdx").val()==null || $("#markerIdx").val()==""){
    		alert("마커를 선택해주세요.")
    		return
    	}
    	 
    	var d_idx = $("#markerIdx").val()			
			
       	for (var i = 0; i < markers.length; i ++) {
       		if (markers[i].marker.getTitle()==d_idx){
       			d_idx=i
     				break
       		}
       	}
		markers[d_idx].marker.setMap(null)
		markers[d_idx].data.state="D"
		markers[d_idx].infoWindow.setMap(null)
       	
       	$("#markerTilte").val(null)
       	$("#markerContent").val(null)
       	$("#markerIdx").val(null)
    	    	
    });
	
	
	//저장, 삭제 목록 버튼
	var formObj = $("form[role='trail_form']");   
	
	$('button[type="submit"]').on("click",function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		if(operation ==='delete'){
			formObj.attr("action","/trail/delete");
		}
		else if(operation==='list'){
			formObj.attr("action","/trail/list").attr("method","get");
			var pageNumTag=$("input[name='pageNum']").clone();
			var amountTag=$("input[name='amount']").clone();
			//var keywordTag=$("input[name='keyword']").clone();
			//var typeTag=$("input[name='type']").clone();
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			//formObj.append(keywordTag);
			//formObj.append(typeTag);
			
		}else if(operation ==='modify'){
			var str ="";
	         
	        for (var i =0; i<markers.length; i++){
	        	data = markers[i].data
	            str += "<input type = 'hidden' name = 'markerList["+i+"].markerNo' value = '"+data.markerNo+"'>"; 
	            str += "<input type = 'hidden' name = 'markerList["+i+"].title' value = '"+data.title+"'>"; 
	            str += "<input type = 'hidden' name = 'markerList["+i+"].content' value = '"+data.content+"'>";
	            str += "<input type = 'hidden' name = 'markerList["+i+"].lat' value = '"+data.lat+"'>";
	            str += "<input type = 'hidden' name = 'markerList["+i+"].lng' value = '"+data.lng+"'>";
	            str += "<input type = 'hidden' name = 'markerList["+i+"].state' value = '"+data.state+"'>";
	            	if(data.files!=null){
		            	for (var j=0; j<data.files.length; j++){
		            		str += "<input type = 'hidden' name = 'markerList["+i+"].attachList["+j+"].markerNo' value ='"+data.markerNo+"'>";
		            		str += "<input type = 'hidden' name = 'markerList["+i+"].attachList["+j+"].uuid' value ='"+data.files[j].uuid+"'>";
		             		str += "<input type = 'hidden' name = 'markerList["+i+"].attachList["+j+"].uploadPath'value ='"+data.files[j].uploadPath+"'>";
		             		str += "<input type = 'hidden' name = 'markerList["+i+"].attachList["+j+"].fileName' value ='"+data.files[j].fileName+"'>";
		             	}
	             	}
	         }
	        
			formObj.append(str)
		}
		formObj.submit();
	});
	
	/*파일 저장 */
    $("input[type='file']").change(function(e){
    	
    	if($("#markerIdx").val()==0 || $("#markerIdx").val()==null || $("#markerIdx").val()==""){
    		alert("마커를 선택해주세요.")
    		$("input[type='file']").val()
    		return
    	}
    	
        var formData = new FormData();
        var inputFile = $("input[name='uploadFile']");
        var files = inputFile[0].files;
        for (var i=0; i<files.length; i++){
            if(!checkExtension(files[i].name,files[i].size)){
                return false;
            }
            formData.append("uploadFile",files[i]);
        }
		
	    $.ajax({
	        url:'/uploadAjaxAction',
	        processData:false,
	        contentType:false,
	        data:formData,
	        type:'POST',
	        dataType:'json',
	        success:function(result){
	        	console.log(result)
	            showUploadResult(result);
	            appendFileList(result);
	        },
	        error:function(error){
	        	console.log(error)
	        }
	    })
	    
    })
    $(".uploadResult").on("click","button",function(e){
    	
    	var targetFile = $(this).data("file");
        var type = $(this).data("type");
        var fileName = $(this).data("uuid");
        var targetLi =$(this).closest("li");
        $.ajax({
            url:'/deleteFile',
            data:{fileName:targetFile, type:type},
            dataType:'text',
            type:'POST',
            success:function(result){
                alert("result");
                deleteFileList(fileName,$("#markerIdx").val());
                targetLi.remove();
            }
        })
    })

});
//onload end
</script>

<%@include file ="/WEB-INF/views/includes/footer.jsp"%>
