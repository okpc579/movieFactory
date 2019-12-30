<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	
<title>Insert title</title>

<style>


.top{
	border : 1px solid gray;
	width : 620px;
}

#movies {
	height: 1350px;
}
#btn{
	overflow : hidden;
}
#doyoulike, #button, #update, #popup {
	float : right;
}

#paging {
   margin-top: 30px;      /* br로 사이를 벌리면 몇몇의 영화 이미지가 안나온다sss */
   text-align: center;      /* 페이징 ul,ol 요소를 div로 감싸 스타일을 주면 가운데 정렬이 된다 */
   position: fixed; bottom: 0; width: 120%;
	}
#titlediv {
	display: inline-block; 
	width: 400px; white-space: nowrap; 
	overflow: hidden; 
	text-overflow: ellipsis;
	font-size: 20px;
}
	

   

	/* 내가 추가한것 */

.top {
	font-size: 20px;
	margin : 1px;
	display : inline-block;
}
#doyoulike, #popup, #update {
	
	margin : 1px;
}

</style>
<script>
var collection;
var coll_no;
var $movies;
var mno;

function printData() {	

   //$("#writer").text(collection.username);
   /* $("<a>").attr("href","/moviefactory/usermovie/userpage?username=" + collection.username).text(collection.username).appendTo($("#writer")); */
   $("<a>").attr("href","/moviefactory/usermovie/userpage?username=" + collection.username).text(collection.username).appendTo($("#writer"));
   $("#title").text(collection.collName);
//   var $totalmovies = $("#totalMovies");
//  var $movies = $("#movies").appendTo($totalmovies);  
   var $movies = $("#movies"); 
   $movies.empty();	//.empty()는 선택한 요소의 내용을 지움, 내용만 지울 뿐 태그는 남아있다는 것에 주의
   
   $.each(collection.detail, function(i, detail){
	   console.log(detail);
      var $movie = $("<span>").css("display", "inline-block").css("margin", "2px").appendTo($movies);	
      var $title = $("<div>").css("display", "inline-block").appendTo($movie);
      mno = detail.mno;
      $.ajax({
    		url: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=147d96f90a50a05230287f0f02412bfd&movieCd=" + detail.mno,
    		method: "get",
    		success: function(result, status, xhr) { // 요청이 성공했을 때 수행되는 함수 뜻함(포스터,영화이름 가져옴)
    			console.log(result);	// result 값을 출력
    			console.log();			
    			
    			/* ("<button type='button' id='delete" + i +"'>") */
    			// 영화이름불러오기(영화이름을 부른뒤 텍스트화 해라)
    			  $("<a>").attr("href","/moviefactory/movie/read?mno=" + detail.mno).text($(result).find('movieNm').text()).css("width", "170px").css("font-size", "0.8em").attr("id", "titlediv").appendTo($title);
    				// 삭제 버튼 만들기
    				$("<button type='button' id='delete'>").attr("class","btn btn-danger delete_movie").val(detail.mno).text('x').appendTo($title);
						
    			  getPoster2($(result).find('movieNm').text(), $(result).find('prdtYear').text(), $movie);
    				// 영화포스터 불러오기(영화이름,제작년도로 영화 포스터를 가져옴)
    		}, error: function(xhr) {	// 에러발생시 
    			 console.log(xhr.status);	// 오류번호 발생번호 출력
    		}
    	});
      //("<span></span>").text(detail.mno).appendTo($movie);	
      /* $("<input type='hidden' id='hiddenval" + i +"'>").val(detail.mno).appendTo($movie);	 */
     
   });
   /*
   $("#delete0").on("click", function() {
	   console.log("클릭 완료");
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
	   console.log("delete9클릭");
      deletemovie($("#delete9").val());
   });
   */
   
}

function getPoster2(movieNm, prdtYear, $tr) {	// (영화제목,제작년도)로 포스터 불러오는 기능
	//console.log(movie);
	console.log(movieNm);
	console.log(prdtYear);
	$.ajax({
		url:"/moviefactory/api/image?subtitle=" + movieNm + "&pubData=" + prdtYear,
		method: "get",
		success:function(result) {
			console.log(result.image);
			//posterString = result.image;
			if(typeof result.image == "undefined"){	// 이미지가 정해지지 않을 경우
				var $td = $("<td>").appendTo($tr)	// td에 tr를 넣어라
				$("<img>").attr("src","/sajin/default_movie.png").attr("height","300px").attr("width", "200px").appendTo($td); 
			}else {
			var $td = $("<td>").appendTo($tr)	// 이미지가 들어있는 td를 tr에 넣어라
			$("<img>").attr("src",result.image).attr("height","300px").attr("width", "200px").appendTo($td);	// result.image를 td안에 넣어라
			//$("<td>").text(result.image).appendTo($tr);
			}
			
		}, error:function(xhr) {
			console.log(xhr);
		}
	});
}

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
	      success: function(result, status, xhr) {	// 성공했을때,
	         location.reload();		// 페이지를 새로고침해준다.
	      }, error: function(xhr) {
	         
	      }
	   });
	}

  function printPaging(result) {      // 여기는 페이징 하는곳 
   $("#pagination>*").remove();	// 주석처리?
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
   
   var serverUrl = "/moviefactory/collection/read?collNo="+coll_no+"&pageno=";
	///moviefactory/collection/read?collNo=60&pageno=1
	// (컬렉션.리스트) /moviefactory/collection/list?username=dlwndud8120&pageno=1
   console.log("페이징함수 들어옴");
   console.log(result);
   
   
   
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
}   // 여기는 페이징 하는곳 


$(function() {      // 문자열을 나누어는(split) 기능
   coll_no = location.search.split("&")[0].split("=")[1];
   console.log(location.search.split("&")[0].split("=")[1]);
   console.log(location.search.split("&")[1]);
   var pageno;
   if(typeof location.search.split("&")[1]== "undefined"){
	   pageno=1;
	}else{
	   pageno = location.search.split("&")[1].split("=")[1];
	}
   
   console.log(pageno);
   
      $.ajax({
         url: "/moviefactory/api/collection/read?collNo=" + location.search.split("&")[0].split("=")[1] + "&pageno="+pageno,
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
   $("#update").on("click", function() {	// 영화 컬렉션 수정으로 페이지 이동
      location.href="/moviefactory/collection/update?collno=" + coll_no;
   });
   
   $("#popup").on("click", function() {		// 영화 컬렉션 추가 팝업창 띄우기
      window.open('/moviefactory/collection/addmovie?coll_no='+coll_no,'window','width=1000, height=1000, status=no,toolbar=no,scrollbars=no, location=no');   
   });
   $("#movies").on("click", ".delete_movie", function() {
	  console.log("클릭 완료");
      deletemovie($(this).val());
   });
   var param = {
			collNo : coll_no
	}
   $("#delete").on("click", function() {
	   $.ajax({
	         url: "/moviefactory/api/collection/delete",
	         method: "post",
	         data:param,
	         success: function(result, status, xhr) {
	        	 $.ajax({
	    	         url: "/moviefactory/api/collection/username",
	    	         method: "get",
	    	         success: function(result, status, xhr) {
	    					location.href="/moviefactory/collection/list?username="+result; 	 
	    	         }, error: function(xhr) {
	    	            
	    	         }
	    	      });	        	 
	         }, error: function(xhr) {
	            
	         }
	      });
	});
});
</script>
<sec:authorize access="hasRole('ROLE_USER')">	<!-- 특정 권한을 가지는 사용자(role_user)만 접근할 수 있다 -->
	<script>
   var collection;
   var $movies;
   $(function() {
      $movies = $("#movies");
      var param = {
				collNo : coll_no
		}
      $.ajax({
			url: "/moviefactory/api/collection/checkmycollection",
			method:"get",
			data: param,
			success:function(result) {
				console.log(result);
				console.log("성공진입");
				if(result=="true"){
					

					$("#popup").show();
					$("#update").show();
					$("#delete").show();
				}				
				
				if(result=="false"){
					
				      $.ajax({	// 좋아요 버튼 기능(좋아요/좋아요취소)♥♡
				          url: "/moviefactory/api/collection/checklike?collNo=" + coll_no,
				          method: "get",
				          success: function(result, status, xhr) {
				             console.log(result);
				             if(result=="true"){
				                $("<button type='button' id='cancellike' class='btn btn-default'>").text('좋아요취소').appendTo($("#doyoulike"));
				                $("#cancellike").on("click", function() {
				                   var param = {
				                         collNo:coll_no,
				                   }
				                   $.ajax({
				                      url: "/moviefactory/api/collection/cancellike?collNo=" + coll_no,
				                      method: "post",
				                      data: param,
				                      success: function(result, status, xhr) {
				                     	console.log(result);
				                         location.reload();
				                      }, error: function(xhr) {
				                         console.log(xhr);
				                      }
				                   });
				                });
				                
				             }else if(result=="false"){
				                $("<button type='button' id='like' class='btn btn-primary'>").text('좋아요').appendTo($("#doyoulike"));
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
				      });	// 좋아요 버튼 기능(좋아요/좋아요취소)♥♡
				}
				//location.href="/moviefactory/collection/read?collNo="+result+"&pageno=1";
			}, error : function(xhr) {
				//location.href="/moviefactory/collection/read?collNo="+coll_no+"&pageno=1";
			
			}
		});
      
      
      
      
      
      
      
      

   });
   </script>
</sec:authorize>
</head>
<body>
	<div id="section">
<!-- 상단 div -->
				<div>
				<div class="top">
					<span>작성자 : </span><span id="writer"></span> <span id="doyoulike"></span>
				</div>
				<div id="btn" class="top">
					<span>제목: </span><span id="title"></span>
					<button type="button" class="btn btn-info" id="popup" style="display: none">추가</button>
					<button class="btn btn-info" id="update" style="display: none">수정</button>
					<button class="btn btn-info" id="delete" style="display: none">삭제</button>
				</div>
<!-- 상단 div --></div><br><br>
<!-- 영화보여주는 div -->
				<div id="movies">
				</div>
<!-- 영화보여주는 div -->
<!-- 하단페이징 -->	<div id="paging">
            			<ul class="pagination" id="pagination">
            		   <!-- 
         				<li class="previous"><a href="#"><</a></li>
        				<li class="active"><a href="#">1</a></li>
         				<li><a href="#">2</a></li>
         				<li><a href="#">3</a></li>
         				<li><a href="#">4</a></li>
        				<li><a href="#">5</a></li>
        				<li class="next"><a href="#">></a></li>
          				1 2 3 4 이런식으로 버튼 -->  
						</ul>
<!-- 하단페이징 --> </div>    
			</div>
			<!-- <div id="pagination"></div> -->
			
	<div id="delete">
	</div>
</body>
</html>