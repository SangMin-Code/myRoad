<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 

<%@include file ="/WEB-INF/views/includes/header.jsp" %>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Board Register</h1>
                    <p class="mb-4"></p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Board Register</h6>
                        </div>
                        <div class="card-body">
                            <form role ="form" action="/board/register" method="post">
                            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <div class="form-group">
                            		<label>Title</label>
                            		<input class ="form-control" name="title">
                            	</div>
                            	<div class="form-group">
                            		<label>Text area</label>
                            		<textarea class ="form-control" rows="3" name='content'></textarea>
                            	</div>
                            	<div class="form-group">
                            		<label>Writer</label>
                            		<input class ="form-control" name="writer"
                                    value="<sec:authentication property='principal.username'/>" readonly="readonly">
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
        alert("해당 종류의 파일은 업로드할 수 없습니다.");
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
    var formObj = $("form[role='form']");
    $("button[type='submit']").on("click",function(e){
        e.preventDefault();
        console.log("submit clicked");

        var str ="";

        $(".uploadResult ul li").each(function(i,obj){
            var jobj = $(obj);
            console.dir(jobj);
            str += "<input type = 'hidden' name = 'attachList["+i+"].fileName' value = '"+jobj.data("filename")+"'>"; 
            str += "<input type = 'hidden' name = 'attachList["+i+"].uuid' value = '"+jobj.data("uuid")+"'>";
            str += "<input type = 'hidden' name = 'attachList["+i+"].uploadPath' value = '"+jobj.data("path")+"'>";
            str += "<input type = 'hidden' name = 'attachList["+i+"].fileType' value = '"+jobj.data("type")+"'>";
        })
        
        //console.log(str)
        formObj.append(str).submit();
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
