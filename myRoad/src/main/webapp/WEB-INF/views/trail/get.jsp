<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 

<%@include file ="/WEB-INF/views/includes/header.jsp" %>
<style>
.bigPictureWrapper{
	position:absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}
.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img{
	width: 600px;
}

</style>

                <!-- Begin Page Content -->
                <div class="container-fluid">
					<div class='bigPictureWrapper'>
						<div class="bigPicture">

						</div>
					</div>
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Board Read</h1>
                    <p class="mb-4"></p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Board Read Page</h6>
                        </div>
                        <div class="card-body">
                           	<div class="form-group">
                           		<label>Bno</label>
                           		<input class ="form-control" name="bno"
                           		 value='<c:out value="${board.bno }"/>' readonly ="readonly">
                           	</div>
                           	<div class="form-group">
                           		<label>Title</label>
                           		<input class ="form-control" name="title"
                           		 value='<c:out value="${board.title }"/>' readonly ="readonly">
                           	</div>
                           	<div class="form-group">
                           		<label>Text area</label>
                           		<textarea class ="form-control" name='content' rows="3"
                           		  readonly ="readonly"><c:out value="${board.content}"/>
                           		 </textarea>
                           	</div>
                           	<div class="form-group">
                           		<label>Writer</label>
                           		<input class ="form-control" name="writer"
                           		 value='<c:out value="${board.writer}"/>' readonly ="readonly">
                           	</div>
                           	<sec:authentication property="principal" var="pinfo"/>
							   <sec:authorize access="isAuthenticated()">
								    <c:if test="${pinfo.username eq board.writer}">
							   			<button data-oper='modify' class="btn btn-success">
                           	   			<a style="color:white;" href="#"/>Modify</a></button>
									</c:if>
								</sec:authorize>
                           	<button data-oper='list' class="btn btn-info">
                           		<a style="color:white;" href="#">List</a></button>
                           	
                           	<form id='operForm' action="/board/modify" method="get">
                           		<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
                           		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                           		<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
                           		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
                           		<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
                           	</form>
						</div>  
                    </div>
					<!-- Files -->
					<div class= "card shadow mb-4">
                        <div class="card-header py-3">
                            <h7 class= "m-0 font-weight-bold text-primary">File Attach</h7>
                        </div>
                        <div class="card-body">
                            <div class ="uploadResult">
                                <ul class="list-group">
                                    
                                </ul>
                            </div>
                        </div>
                    </div>
					<!-- Reply -->
                    <div class="card shadow mb-4">
                    	 <div class="card-header py-2">
                            <h6 class="m-2 font-weight-bold text-primary float-left">
                            	<i class="fa fa-comments fa-fw"></i>
                            Reply</h6>
							<sec:authorize access="isAuthenticated()">
                            <button id='addReplyBtn' class="m-1 btn-sm btn-primary float-right" style="border:None;">
                            	New Reply
                            </button>
							</sec:authorize>
						</div>
                        <div class="card-body">
                        	<ul class="chat">
                        		<li class="left clearfix" data-rno='12'>
                        			<div class="header">
                        				<Strong class="primary-font">user00</Strong>
                        				<small class="float-right text-muted">2021-03-27 17:00</small>
                        			</div>
                        			<p>Good job!</p>
                        		</li>
                        	</ul>
                        </div>
                        <div class="card-footer">
                        	
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
                
				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" role="dialog" aria-hidden="False">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="myModalLabel">Reply Modal</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				      	<div class="form-group">
				      		<label>Reply</label>
				      		<input class="form-control" name='reply' value='New Reply!!!!'>
				      	</div>
				      	<div class="form-group">
				      		<label>Replyer</label>
				      		<input class="form-control" name='replyer' value='replyer'>
				      	</div>
				      	<div class="form-group">
				      		<label>Reply Date</label>
				      		<input class="form-control" name='replyDate' value=''>
				      	</div>
				      </div>
				      
				      <div class="modal-footer">
				        <button type="button" id='modalModBtn' class="btn btn-warning">Modify</button>
				        <button type="button" id='modalRemoveBtn' class="btn btn-danger">Remove</button>
				        <button type="button" id='modalRegisterBtn' class="btn btn-primary">Register</button>
				        <button type="button" id='modalCloseBtn' class="btn btn-info">Close</button>
				      </div>
				    </div>
				  </div>
				</div>
                
<script type="text/javascript" src="/resources/js/reply.js">
</script>                
<script type="text/javascript">

var csrfHeadName ="${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ready(function(){
	
	console.log(replyService);
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	

	
	showList(1);
	
		
	//for Modal 	
	function showList(page){
		console.log("show list: "+page);
		replyService.getList(
		{bno:bnoValue, page:page||1}
		,
		function(replyCnt,list){
			
			console.log("replyCnt :"+replyCnt);
			console.log("list :"+list);
			console.log(list);
			
			if(page==-1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return
			}
			
			var str ="";
			if(list == null||list.length==0){
				replyUL.html("");
				return;
			}
			for(var i =0, len=list.length||0; i<len; i++){
				str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str+="<div><div class='header'><string class='primary-font'>"+list[i].replyer+"</string>";
				str+="<small class='float-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small><div>";
				str+="<p>"+list[i].reply+"</p></div></li>";
			}
			replyUL.html(str);
			
			showReplyPage(replyCnt);
			
	}); 
	}
	
	var modal = $("#myModal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	var modalCloseBtn = $('#modalCloseBtn');
	var replyer = null;
	<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	$('#addReplyBtn').on("click",function(e){
		modal.find("input").val("")
		modal.find("input[name='replyer']").val(replyer);
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id!='modalCloseBtn']").hide();
		modalRegisterBtn.show();
		$("#myModal").modal("show");
	})
	
	$(document).ajaxSend(function(e,xhr,oprtions){
		xhr.setRequestHeader(csrfHeadName,csrfTokenValue);
	})

	modalCloseBtn.on("click",function(e){
		modal.modal("hide");	
	})
	
	//댓글 등록 
	modalRegisterBtn.on("click",function(e){
		
		var reply ={
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno :bnoValue
		};
		replyService.add(reply,function(result){
			alert(result)
			modal.find("input").val("");
			modal.modal("hide")
			showList(-1);
		})
	})
	//각 댓글 클릭
	$(".chat").on("click","li",function(e){
		var rno = $(this).data("rno");
		replyService.get(rno,function(reply){
			
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
			modal.data("rno",reply.rno);
			
			modal.find("button[id!='modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$("#myModal").modal("show");
		})
	
	})
	//댓글 수정
	modalModBtn.on("click",function(e){
		
		var originalReplyer = modalInputReplyer.val();

		var reply = {rno:modal.data("rno"),
					reply:modalInputReply.val(),
					replyer:originalReplyer};

		if(!replyer){
			alert("로그인 후 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		console.log("Original Replyer :"+originalReplyer);

		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		replyService.update(reply,function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		})
	})
	
	// 댓글 삭제
	modalRemoveBtn.on("click",function(e){
		
		var rno =modal.data("rno");
		console.log("RNO :"+rno + " REPLYER :"+replyer);
		
		if(!replyer){
			alert("로그인 후 삭제가 가능합니다.")
			modla.modal("hide");
			return;
		}

		var originalReplyer = modalInputReplyer.val();

		console.log("OriginalReplyer :"+originalReplyer);

		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		replyService.remove(rno,originalReplyer,function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		})		
	})
	
	//댓글 페이징
	var pageNum =1;
	var replyPageFooter = $(".card-footer");
	
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum/10.0)*10;
		var startNum = endNum-9;
		
		var prev = startNum !=1;
		var next = false;
		
		if(endNum *10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		if(endNum*10 <replyCnt){
			next = true;
		}
		var str = "<ul class='pagination justify-content-end'>";
		if(prev){
			str +="<li class ='page-item previous'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>"
		}
		for(var i =startNum; i<=endNum; i++){
			var active = pageNum ==i ? "active":"";
			str+= "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>"
		}
		if(next){
			str +="<li class ='page-item next'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>"
		}
		str+="</ul></div>";
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click","li a",function(e){
		e.preventDefault()
		console.log("page click");
		var targetPageNum = $(this).attr("href");
		console.log("targetPageNum : ",targetPageNum);
		pageNum = targetPageNum;
		showList(pageNum);
		
	})
	
	var operForm = $("#operForm");
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit();
	})
	
	$("button[data-oper='list']").on("click",function(e){
		operForm.find('#bno').remove();
		operForm.attr("action","/board/list");
		operForm.submit();
	});

	(function(){
		var bno = '<c:out value ="${board.bno}"/>';
		$.getJSON("/board/getAttachList",{bno:bno},function(arr){
			console.log(arr);

			var str = "";

			$(arr).each(function(i,attach){
				if(attach.fileType){
					var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName)
					str+="<li class='list-group-item' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-fileName='"+attach.fileName+"'"
					str+=" data-type='"+attach.fileType+"'><div>";
					str+= "<span>"+attach.fileName+"</span>";
					str+="<img class='ml-2' src='/display?fileName="+fileCallPath+"'>";
					str+="</div></li>"
				}else{
					str+="<li class='list-group-item' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-fileName='"+attach.fileName+"'"
					str+=" data-type='"+attach.fileType+"'><div>";
					str+= "<span>"+attach.fileName+"</span>";
					str+="<img class='ml-2' src='/resources/img/attach.png' style='width:30px; height:30px' >";
					str+="</div></li>"
				}
			})//each
			$(".uploadResult ul").html(str);
		})
	})();

	$(".uploadResult").on("click","li",function(e){
		console.log("view image");
		var liObj = $(this);
		var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename")); //TODO data-fileName 안되는데?
		if(liObj.data("type")){
			showImage(path.replace(new RegExp(/\\/g),"/"));
		}else{
			self.location="/download?fileName="+path
		}
	})
	
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%',height:'0%'},1000);
		setTimeout(function(){
			$(".bigPictureWrapper").hide();
		},1000);
	})
	
});

function showImage(fileCallPath){
	alert(fileCallPath);
	$(".bigPictureWrapper").css("display","flex").show();
	$(".bigPicture")
	.html("<img src='/display?fileName="+fileCallPath+"'>")
	.animate({width:'100%',height:'100%'},1000);
}
</script>
<%@include file ="/WEB-INF/views/includes/footer.jsp"%>
