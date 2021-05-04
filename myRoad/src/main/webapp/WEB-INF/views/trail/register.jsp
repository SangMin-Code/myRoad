<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 

<%@include file ="/WEB-INF/views/includes/header.jsp" %>

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
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Trail Register</h1>
                    <p class="mb-4"></p>
					
					<!-- map -->                   
                    <div class="row">
						<div class="col-xl-8 col-lg-7"> <!--left box-->
                    		<!-- 주변 코스 목록 -->
							<div class= "card shadow mb-4">
                        <div class="card-header py-3">
                            <h7 class= "m-0 font-weight-bold text-primary">Make Trail</h7>
                        </div>
                        <div>
	                        <button id="addLine"class="btn btn-success">
	                            경로 추가
	                        </button>
	                        <button id="addMarker"class="btn btn-success">
	                            마커 추가
	                        </button>
                        </div>
                        <div class="card-body">
                            <div id="map" style="width:80%;height:350px;"></div>  
                        </div>
                    </div>						
					</div> <!--div left box-->
						<div class="col-xl-4 col-lg-5"> <!--right box-->
                    		<!-- 마커 정보 -->
							<div class="card shadow mb-4">
								<div class="card-header py-3" >
									<h6 class="m-0 mt-2 font-weight-bold text-primary" style="width:50%; float:left">스팟 정보</h6>
								</div>
								<div class="card-body">
									<form role ="form" action="/" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <div class="form-group">
                                            <label>Title</label>
                                            <input class ="form-control" name="title">
                                        </div>
                                        <div class="form-group">
                                            <label>Text area</label>
                                            <textarea class ="form-control" rows="3" name='content'></textarea>
                                        </div>
                                    </form> 
								</div>
							</div>
							<!--스팟 정보 (text, img) 스팟정보 양식필요-->
							<div class="card shadow mb-4">
								<div class="card-header py-3" >
									<h6 class="m-0 mt-2 font-weight-bold text-primary" style="width:50%; float:left">갤러리</h6>
								</div>
								<div class="card-body">
									<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                                        <div class="carousel-indicators">
                                          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                                          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                                          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                                        </div>

                                        <div class="carousel-inner">
                                          <div class="carousel-item active">
                                            <img src="/resources/img/undraw_posting_photo.svg" class="d-block w-100" alt="...">
                                          </div>
                                          <div class="carousel-item">
                                            <img src="/resources/img/undraw_posting_photo.svg" class="d-block w-100" alt="...">
                                          </div>
                                          <div class="carousel-item">
                                            <img src="/resources/img/undraw_posting_photo.svg" class="d-block w-100" alt="...">
                                          </div>
                                        </div>

                                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                          <span class="visually-hidden">Previous</span>
                                        </button>
                                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                          <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                          <span class="visually-hidden">Next</span>
                                        </button>
                                      </div>
								</div>
							</div>
						</div> <!--div right box-->
					</div> <!--div row-->

                    <!-- trail 제목, 내용 -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Trail Register</h6>
                        </div>
                        <div class="card-body">
                            <form role ="trail_form" action="/trail/register" method="post">
                                <input type="hidden" name="userNo" value="1"/>
                                <input type="hidden" name="startLat" value="33.450450810177195"/>
                                <input type="hidden" name="startLng" value="126.57138305595264"/>
                                <input type="hidden" name="endLat" value="33.45170405221839"/>
                                <input type="hidden" name="endLng" value="126.57138764645934"/>
                                <input type="hidden" name="thumnail" value="0"/>
                                

                                <div class="form-group">
                            		<label>제목</label>
                            		<input class ="form-control" name="title">
                            	</div>
                            	<div class="form-group">
                            		<label>내용</label>
                            		<textarea class ="form-control" rows="3" name='contents'></textarea>
                            	</div>
                            	<button type="submit" class="btn btn-success">
                            		Submit button
                            	</button>
                            	<button type="reset" class="btn btn-success">
                            		Reset Button
                            	</button>
                            </form> 
                        </div>
                    </div>
                    <div class= "card shadow mb-4">
                        <div class="card-header py-3">
                            <h7 class= "m-0 font-weight-bold text-primary">File Attach</h7>
                        </div>
                        <div class="card-body">
                            <div class="input-group">
                                <input type="file" class = "form-control p-1" name='uploadFile' multiple>
                            </div>
                            <div class ="uploadResult">
                                <ul class="list-group">
                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->

<!-- map -->
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
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
        position: latlng 
        }); 
        // 지도에 마커를 표시합니다
        marker.setMap(map);
    
        var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
        message += '경도는 ' + latlng.getLng() + ' 입니다';

        console.log(message)  
    }

// 선 생성
var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
function makeLineClick(mouseEvent){
    // 마우스로 클릭한 위치입니다 
    var clickPosition = mouseEvent.latLng;

    // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
    if (!drawingFlag) {

        // 상태를 true로, 선이 그리고있는 상태로 변경합니다
        drawingFlag = true;
               
        // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
        deleteClickLine();
        
        // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
        deleteDistnce();

        // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
        deleteCircleDot();
    
        // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
        clickLine = new kakao.maps.Polyline({
            map: map, // 선을 표시할 지도입니다 
            path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });
        
        // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
        moveLine = new kakao.maps.Polyline({
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다    
        });
    
        // 클릭한 지점에 대한 정보를 지도에 표시합니다
        displayCircleDot(clickPosition, 0);

            
    } else { // 선이 그려지고 있는 상태이면

        // 그려지고 있는 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();

        // 좌표 배열에 클릭한 위치를 추가합니다
        path.push(clickPosition);
        
        // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
        clickLine.setPath(path);

        var distance = Math.round(clickLine.getLength());
        displayCircleDot(clickPosition, distance);
    }

    a = clickLine.getPath()

    for (var i =0; i<a.length; i++){
        console.log(a[i].La+","+a[i].Ma)
    }

    

}
// 지도에 마우스무브 이벤트를 등록합니다
// 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
function makeLineMouseMove(mouseEvent){
     // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
     if (drawingFlag){
        
        // 마우스 커서의 현재 위치를 얻어옵니다 
        var mousePosition = mouseEvent.latLng; 

        // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
        
        // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
        var movepath = [path[path.length-1], mousePosition];
        moveLine.setPath(movepath);    
        moveLine.setMap(map);
        
        var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
            content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
        
        // 거리정보를 지도에 표시합니다
        showDistance(content, mousePosition);   
    } 
}

function makeLineRightClick(mouseEvent){
    // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
    if (drawingFlag) {
        
        // 마우스무브로 그려진 선은 지도에서 제거합니다
        moveLine.setMap(null);
        moveLine = null;  
        
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
             
        } else {

            // 선을 구성하는 좌표의 개수가 1개 이하이면 
            // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
            deleteClickLine();
            deleteCircleDot(); 
            deleteDistnce();

        }
        
        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
        drawingFlag = false;          
    }  
}

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
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880;
var csrfHeadName ="${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

function checkExtension(fileName, fileSize){
    if(fileSize>=maxSize){
        alert("파일 사이즈 초과");
        return false;
    }
    if(regex.test(fileName)){
        alert("해당 종류의 파일은 업로드할 수 없습니`다.");
        return false;
    }
    return true;
}

function showUploadResult(uploadResultArr){
	if(!uploadResultArr||uploadResultArr.length==0){return;}

    var uploadUL = $(".uploadResult ul");
    var str = "";
    $(uploadResultArr).each(function(i,obj){
        //image type
        if(obj.image){
            var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName)
            str+="<li class='list-group-item' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'";  /* TODO fileName filename -> data filename why?  */
            str+=" data-type='"+obj.image+"'><div>";
            str+= "<span>"+obj.fileName+"</span>";
            str+="<img class='ml-2' src='/display?fileName="+fileCallPath+"'>";
            str+="<button type='button' class='btn btn-warning btn-circle' style='float:right;' data-file=\'"+fileCallPath+"\' data-type='image'>" 
            str+="<i class='fa fa-times'></i></button>"
            str+="</div></li>"
        }else{
            var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
            var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
            str+="<li class='list-group-item' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'" ;
            str+=" data-type='"+obj.image+"'><div>";
            str += "<span>"+obj.fileName+"</span>";
            str += "<img src ='/resources/img/attach.png' class='ml-2' style='width:30px; height:30px'></a>";
            str += "<button type='button' class='btn btn-warning btn-circle' style='float:right;' data-file=\'"+fileCallPath+"\' data-image='file'>"
            str += "<i class='fa fa-times'></i></button>"
            str+="</div></li>"
        }
    });
    uploadUL.append(str);
}

//onload
$(document).ready(function(e){
    var formObj = $("form[role='trail_form']");

    $("#addLine").on("click",function(e){
        e.preventDefault();
        kakao.maps.event.removeListener(map, 'click', makeMarker);
        kakao.maps.event.addListener(map, 'click', makeLineClick)
        kakao.maps.event.addListener(map, 'mousemove', makeLineMouseMove)
        kakao.maps.event.addListener(map, 'rightclick', makeLineRightClick)           
    })

    $("#addMarker").on("click",function(e){
        e.preventDefault();
        kakao.maps.event.removeListener(map, 'click', makeLineClick)
        kakao.maps.event.removeListener(map, 'mousemove', makeLineMouseMove)
        kakao.maps.event.removeListener(map, 'rightclick', makeLineRightClick) 
        kakao.maps.event.addListener(map, 'click', makeMarker);
    })


    $("button[type='submit']").on("click",function(e){
        e.preventDefault();
        formObj.submit();
        // console.log("submit clicked");

        // var str ="";

        // $(".uploadResult ul li").each(function(i,obj){
        //     var jobj = $(obj);
        //     console.dir(jobj);
        //     str += "<input type = 'hidden' name = 'attachList["+i+"].fileName' value = '"+jobj.data("filename")+"'>"; 
        //     str += "<input type = 'hidden' name = 'attachList["+i+"].uuid' value = '"+jobj.data("uuid")+"'>";
        //     str += "<input type = 'hidden' name = 'attachList["+i+"].uploadPath' value = '"+jobj.data("path")+"'>";
        //     str += "<input type = 'hidden' name = 'attachList["+i+"].fileType' value = '"+jobj.data("type")+"'>";
        // })
        
        //console.log(str)
        //formObj.append(str).submit();
    })

    $("input[type='file']").change(function(e){
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
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeadName,csrfTokenValue);
            },
	        data:formData,
	        type:'POST',
	        dataType:'json',
	        success:function(result){
	            console.log(result);
	            showUploadResult(result);
	        }
	    })
    })

    $(".uploadResult").on("click","button",function(e){
        console.log("delete file");

        var targetFile = $(this).data("file");
        var type = $(this).data("type");
        var targetLi =$(this).closest("li");

        $.ajax({
            url:'/deleteFile',
            data:{fileName:targetFile, type:type},
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeadName,csrfTokenValue);
            },
            dataType:'text',
            type:'POST',
            success:function(result){
                alert("result");
                targetLi.remove();
            }
        })
    })

})
//onload end
</script>

<%@include file ="/WEB-INF/views/includes/footer.jsp"%>
