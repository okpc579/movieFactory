<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style>
/*  #section {
    width :800px;
    margin: 0 auto;
    display: 
 } */
   #writeForm {
      width: 500px;
      margin : 0 auto;
   }
   coll_read {
   
   }
 }
</style>
<script>
var collection;
var coll_no;
var $movies;

<<<<<<< HEAD
function printData() {   
   $("<a>").attr("href","/moviefactory/usermovie/userpage?username=" + collection.username).text(collection.username).appendTo($("#writer"));
   $("#title").text(collection.collName);
   
   $movies = $("#movies");
   $movies.empty();
   
   $.each(collection.detail, function(i, detail){   // 컬렉션 디테일 가져오기
      var $movie = $("<div>").appendTo($movies);
      $("<span></span>").text(detail.mno).appendTo($movie);
      $("<input type='hidden' id='hiddenval" + i +"'>").val(detail.mno).appendTo($movie);
      $("<button type='button' id='delete" + i +"'>").val(detail.mno).text('x').appendTo($movie);
   });
   
   $("#delete0").on("click", function() {
      deletemovie($("#delete0").val());
   });
   $("#delete1").on("click", function() {
      deletemovie($("#delete1").val());
   });
   $("#delete2").on("click", function() {
      deletemovie($("#delete2").val());
   });
   $("#delete3").on("click", function() {
      deletemovie($("#delete3").val());
   });
   $("#delete4").on("click", function() {
      deletemovie($("#delete4").val());
   });
   $("#delete5").on("click", function() {
      deletemovie($("#delete5").val());
   });
   $("#delete6").on("click", function() {
      deletemovie($("#delete6").val());
   });
   $("#delete7").on("click", function() {
      deletemovie($("#delete7").val());
   });
   $("#delete8").on("click", function() {
      deletemovie($("#delete8").val());
   });
   $("#delete9").on("click", function() {
      deletemovie($("#delete9").val());
   });
   
=======

function printData() {
	//$("#writer").text(collection.username);
	$("<a>").attr("href","/moviefactory/usermovie/userpage?username=" + collection.username).text(collection.username).appendTo($("#writer"));
	$("#title").text(collection.collName);
	
	var $movies = $("#movies");
	$movies.empty();
	
	$.each(collection.detail, function(i, detail){
		var $movie = $("<div>").appendTo($movies);
		$("<span></span>").text(detail.mno).appendTo($movie);
		$("<input type='hidden' id='hiddenval" + i +"'>").val(detail.mno).appendTo($movie);
		$("<button type='button' id='delete" + i +"'>").val(detail.mno).text('x').appendTo($movie);
	});
	
	$("#delete0").on("click", function() {
		deletemovie($("#delete0").val());
	});
	$("#delete1").on("click", function() {
		deletemovie($("#delete1").val());
	});
	$("#delete2").on("click", function() {
		deletemovie($("#delete2").val());
	});
	$("#delete3").on("click", function() {
		deletemovie($("#delete3").val());
	});
	$("#delete4").on("click", function() {
		deletemovie($("#delete4").val());
	});
	$("#delete5").on("click", function() {
		deletemovie($("#delete5").val());
	});
	$("#delete6").on("click", function() {
		deletemovie($("#delete6").val());
	});
	$("#delete7").on("click", function() {
		deletemovie($("#delete7").val());
	});
	$("#delete8").on("click", function() {
		deletemovie($("#delete8").val());
	});
	$("#delete9").on("click", function() {
		deletemovie($("#delete9").val());
	});
	
>>>>>>> 20191204_이태호
}


function printPaging(result) {      // 페이징 
   //$("#pagination>*").remove();
   var pageno = result.pageno;
   var pagesize = result.pagesize;
   var totalcount = result.totalcount;
   var pagesPerBlock = 10;
   var cntOfPage = totalcount/pagesize + 1;
   if(totalcount%pagesize==0) cntOfPage--;
   var blockNo = Math.floor((pageno-1)/pagesPerBlock);
   var startPage = blockNo * pagesPerBlock + 1;
   var endPage = startPage + pagesPerBlock - 1;
   if(endPage>cntOfPage)
      endPage = cntOfPage;
   
   var $pagination = $("#pagination");   
   
   var serverUrl = "http://localhost:8081/moviefactory/collection/read?collNo="+coll_no+"&pageno=";
   
   console.log("페이징함수 들어옴");
   
   
   
   var pagearr = new Array();
   for(var i=startPage;i<=endPage; i++){
      pagearr[i]=i;
   }
   if(blockNo>0) {
      var $li = $("<li>").attr("class","previous").appendTo($pagination);
      $("<a>").attr("href", serverUrl + (startPage-1)).text("<").appendTo($li);      
   }
   for(var i=startPage; i<=endPage; i++) {
      if(pageno==i) {
         var $li = $("<li>").attr("class","active").appendTo($pagination);
         $("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
         } 
      else{
         var $li = $("<li>").appendTo($pagination);
         $("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
      }
   }
   if(endPage<cntOfPage) {
      var $li = $("<li>").attr("class","next").appendTo($pagination);
      $("<a>").attr("href", serverUrl + (endPage+1)).text(">").appendTo($li);
   }
}   // 페이징 




function deletemovie(mno){   // 영화번호로 영화 삭제
   console.log(mno);
   var param = {
         mNo:mno,
         collNo:coll_no,
   }
   $.ajax({
      url: "/moviefactory/api/collection/deletemovie",
      method: "post",
      data: param,
      success: function(result, status, xhr) {
         location.reload();
      }, error: function(xhr) {
         
      }
   });
}
$(function() {      // 
   coll_no = location.search.split("&")[0].split("=")[1];
   console.log(location.search.split("&")[0].split("=")[1]);
   console.log(location.search.split("&")[1].split("=")[1]);
      $.ajax({
         url: "/moviefactory/api/collection/read?collNo=" + location.search.split("&")[0].split("=")[1] + "&pageno="+location.search.split("&")[1].split("=")[1],
         method: "get",
         success: function(result, status, xhr) {
            console.log(result);
            console.log(result.collection);
            collection=result;
            printData();
            printPaging(result);
         }, error: function(xhr) {
            
         }
      });
   $("#update").on("click", function() {
      location.href="http://localhost:8081/moviefactory/collection/update?collno=" + coll_no;
   });
   
   $("#popup").on("click", function() {
      window.open('/moviefactory/collection/addmovie?coll_no='+coll_no,'window','width=400, height=400, status=no,toolbar=no,scrollbars=no, location=no');   
   });
   
});
</script>
<sec:authorize access="hasRole('ROLE_USER')">
   <script>
   var collection;
   var $movies;
   $(function() {
      $movies = $("#movies");
      $.ajax({
         url: "/moviefactory/api/collection/checklike?collNo=" + coll_no,
         method: "get",
         success: function(result, status, xhr) {
            console.log(result);
            if(result=="true"){
               $("<button type='button' id='cancellike'>").text('좋아요취소').appendTo($("#doyoulike"));
               $("#cancellike").on("click", function() {
                  var param = {
                        collNo:coll_no,
                  }
                  $.ajax({
                     url: "/moviefactory/api/collection/cancellike",
                     method: "post",
                     data: param,
                     success: function(result, status, xhr) {
                        location.reload();
                     }, error: function(xhr) {
                        
                     }
                  });
               });
               
            }else if(result=="false"){
               $("<button type='button' id='like'>").text('좋아요').appendTo($("#doyoulike"));
               $("#like").on("click", function() {
                  var param = {
                        collNo:coll_no,
                  }
                  $.ajax({
                     url: "/moviefactory/api/collection/like",
                     method: "post",
                     data: param,
                     success: function(result, status, xhr) {
                        location.reload();
                     }, error: function(xhr) {
                        
                     }
                  });
               });
            }
         }, error: function(xhr) {
            
         }
      });
/*       $.each(collection.detail, function(i, detail){   // 컬렉션 디테일 가져오기
         var $movie = $("<div>").appendTo($movies);
         $("<span></span>").text(detail.mno).appendTo($movie);
      }); */
       $("#update").on("click", function() {   // 영화 컬렉션 수정으로 페이지 이동
         location.href="http://localhost:8081/moviefactory/collection/update?collno=" + coll_no;
      });
       $("#popup").on("click", function() {   // 영화 컬렉션 추가 팝업창 띄우기
          window.open('/moviefactory/collection/addmovie?coll_no='+coll_no,'window','width=400, height=400, status=no,toolbar=no,scrollbars=no, location=no');   
       });
       $movie = $("<div>").appendTo($movies);
      //$("<span></span>").text(collection.username).appendTo($movie);
      $("<span></span>").text(collection.collName).appendTo($movie);
   });
   </script>
</sec:authorize>
</head>
<body>
<div id="section">
  <div style="width: 22.7%; float: none; margin: 0 auto">
   <button id="update">수정버튼</button>
   <div id="doyoulike"></div>
   <div>
      <span>작성자 : </span><span id="writer"></span>
   </div>
   <div>
      <span>제목 : </span><span id="title"></span>
   </div>
   <div id="movies">
   </div>
   <button type="button" id="popup">팝업추가</button>
   <div id="pagination"></div>
  </div>
</div>
</body>
</html>