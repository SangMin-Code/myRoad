<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 

<%@include file ="/WEB-INF/views/includes/header.jsp" %>

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">코스 목록</h1>
                    <p class="mb-4"></p>
					<div class="row">
						<div class="col-xl-8 col-lg-7"> <!--left box-->
                    		<!-- 주변 코스 목록 -->
							<div class="card shadow mb-4">
								<div class="card-header py-3" >
									<h6 class="m-0 mt-2 font-weight-bold text-primary" style="width:50%; float:left">코스 목록</h6>
									<button id='regBtn' type="button" class="btn btn-success btn-xs" style="float:right">코스 등록하기</button>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-bordered" id="WdataTable" width="100%" cellspacing="0">
											<thead>
												<tr>
													<th>번호</th>
													<th>제목</th>
													<th>작성자</th>
													<th>작성일</th>
													<!-- <th>상세보기</th> -->
												</tr>
											</thead>
											<c:forEach items="${list}" var="trail" varStatus="t">
											<tr>
											<td><c:out value = "${t.count + (pageMaker.cri.pageNum-1)*10}"/></td>
												<td>
													<a class = 'move' href='<c:out value="${trail.trailNo}"/>'> 
														<c:out value = "${trail.title}"/>
													</a>
												</td>
												<td>Test</td>
												<td><fmt:formatDate pattern="yyyy-MM-dd" value ="${trail.regdate}"/></td>
												<%-- <td><a class = 'move' href='<c:out value="${trail.trailNo}"/>'> 
														상세보기
													</a>
												</td> --%>
											</tr>
											</c:forEach>
										</table>
										<!-- 코스 검색용 -->
										 <%-- <div class='row' style="width:100%;">
											<div class='col-lg-7'>
												<form id='searchForm' action='/board/list' method='get'>
													<select class = 'custom-select-sm' name='type'>
														<option value="" <c:out value="${pageMaker.cri.type==null?'selected':''}"/>>--</option>
														<option value="T"<c:out value="${pageMaker.cri.type=='T' ?'selected':''}"/> >제목</option>
														<option value="C"<c:out value="${pageMaker.cri.type=='C'?'selected':''}"/>>내용</option>
														<option value="W"<c:out value="${pageMaker.cri.type=='W'?'selected':''}"/>>작성자</option>
														<option value="TC"<c:out value="${pageMaker.cri.type=='TC'?'selected':''}"/>>제목 or 내용</option>
														<option value="TW"<c:out value="${pageMaker.cri.type=='TW'?'selected':''}"/>>제목 or 작성자</option>												
														<option value="TWC"<c:out value="${pageMaker.cri.type=='TWC'?'selected':''}"/>>제목 or 내용 or 작성자</option>													
													</select>
													<input type='text' name='keyword' value ='<c:out value="${pageMaker.cri.keyword==null ? '': pageMaker.cri.keyword}"/>'>				
													<input type ='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
													<input type ='hidden' name='amount' value='${pageMaker.cri.amount}'>             
													<button class='btn btn-primary'>Search</button>
												</form>
											</div>
										</div>  --%>
										
										
										<!-- 페이징 -->
										<ul class="pagination justify-content-end">
											<c:if test="${pageMaker.prev}">
											<li class="page-item previous">
											<a class="page-link" href="${pageMaker.startPage-1}" tabindex="-1">Previous</a>
											</li>								    
											</c:if>
											<c:forEach var ="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
												<li class="page-item ${pageMaker.cri.pageNum==num ? "active" :""}"><a class="page-link" href="${num}">${num}</a></li>
											</c:forEach>
											<c:if test="${pageMaker.next}">
											<li class="page-item next">
											<a class="page-link" href="${pageMaker.endPage+1 }" tabindex="-1">Next</a>
											</li>								    
											</c:if>
										</ul>
										
										
										
										
										
										<!-- Modal (등록 후 메인으로 이동 시) -->
										<!-- <div class="modal fade" id="MyModal" tabindex="-1" role="dialog" aria-labelledby="MyModalLabel"
											aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="myModalLabel">Modal Title</h5>
														<button class="close" type="button" data-dismiss="modal" aria-label="Close">
															<span aria-hidden="true">×</span>
														</button>
													</div>
													<div class="modal-body">처리가 완료되었습니다.</div>
													<div class="modal-footer">
														<button class="btn btn-default" type="button" data-dismiss="modal">Close</button>
														<button class="btn btn-primary" type="button" >Save Changes</button>
													</div>
												</div>
											</div>
										</div> -->
									</div>
								</div>
							</div>
						</div> <!--div left box-->
					</div> <!--div row-->
                </div><!-- /.container-fluid -->
                <form id='actionForm' action = "/trail/list" method ='get'>
                	<input type ='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
                	<input type ='hidden' name='amount' value='${pageMaker.cri.amount}'>
                <%-- 	<input type ='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
                	<input type ='hidden' name='keyword'value='<c:out value="${pageMaker.cri.keyword}"/>'> --%>
                </form>
                
                
                
<script type="text/javascript">
	$(document).ready(function(){
		var result = '<c:out value="${result}"/>';
		
		//checkModal(result);
		//history.replaceState({},null,null); TODO : 모달문제처리
		
		$("#regBtn").on("click",function(){
			self.location="/trail/register";
		});
		
		var actionForm = $("#actionForm");
		$(".page-item a").on("click",function(e){
			e.preventDefault();
			console.log($(this).attr("href"));
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		$(".move").on("click",function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='trailNo' value='"+
							$(this).attr("href")+"'>");
			actionForm.attr("action","/trail/get");
			actionForm.submit();
		})
		
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click",function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			}
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDeFault();
			searchForm.submit();
		})
	});
	
function checkModal(result){
	
	if(result ===''
			//|| hisotry.state
			){
		return;
	}
	if(parseInt(result)>0){
		$(".modal-body").html("게시글 "+parseInt(result)+" 번이 등록되었습니다.");
	}
	$("#MyModal").modal("show");
}
	
</script>
                
<%@include file ="/WEB-INF/views/includes/footer.jsp"%>

