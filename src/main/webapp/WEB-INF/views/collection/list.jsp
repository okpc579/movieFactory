<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"
	charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- 3x3 부트스트랩 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>

#list {
	table-layout: fixed;
	/* table-cell의 동일한 넓이를 위한 레이아웃 설정 */
}

#pageName {
	margin-left: 40px;
}

#add {
	float:right;
	margin-right: 40px;
}

table {
	border: 5px solid #00D8FF;
	width: 298px;
	table-layout: fixed;
}

table:hover {
	font-weight: bold;
}

a:hover {
	text-decoration: none;
	color:black;
}

</style>
<script>
	var strArray;
	var collections;
	var page;
	var username = "";
	var mno = "";
	var collNo = "";
	var poster;

	function printPaging(result) {
		//$("#pagination>*").remove(); 
		var pageno = page;
		var pagesize = 10;
		var totalcount = result.totalcount;
		var pagesPerBlock = 10;
		var cntOfPage = totalcount / pagesize + 1;
		if (totalcount % pagesize == 0)
			cntOfPage--;
		var blockNo = Math.floor((pageno - 1) / pagesPerBlock);
		var startPage = blockNo * pagesPerBlock + 1;
		var endPage = startPage + pagesPerBlock - 1;
		if (endPage > cntOfPage)
			endPage = cntOfPage;

		var $pagination = $("#pagination");
		if (username != "")
			var serverUrl = "/moviefactory/collection/list?username="
					+ username + "&pageno=";
		else if (mno != "")
			var serverUrl = "/moviefactory/collection/list?mno="
					+ mno + "&pageno=";
		console.log("페이징함수 들어옴");

		var pagearr = new Array();
		for (var i = startPage; i <= endPage; i++) {
			pagearr[i] = i;
		}
		if (blockNo > 0) {
			var $li = $("<li>").attr("class", "previous").appendTo($pagination);
			$("<a>").attr("href", serverUrl + (startPage - 1)).text("<")
					.appendTo($li);
		}
		for (var i = startPage; i <= endPage; i++) {
			if (pageno == i) {
				var $li = $("<li>").attr("class", "active").appendTo(
						$pagination);
				$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
			} else {
				var $li = $("<li>").appendTo($pagination);
				$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
			}
		}
		if (endPage < cntOfPage) {
			var $li = $("<li>").attr("class", "next").appendTo($pagination);
			$("<a>").attr("href", serverUrl + (endPage + 1)).text(">")
					.appendTo($li);
		}
	}

	function printData() {
		var $body = $("#list");
		$.each(collections, function(i, collection) {
			
			var $movies = $("#movies");
			var $movie = $("<span>").css("display", "inline-block").css("margin", "2px").appendTo($movies);   
			var $title = $("<div>").css("display", "inline-block").appendTo($movie);
			
			var $div = $("<div>").attr("class", "w3-third").css("padding", "33px").appendTo($body); // .attr("class", "w3-third") 3x3 부트스트랩 클래스 지정
			var $table = $("<table>").appendTo($div);
			var $tr = $("<tr>").appendTo($table);
			$("<td colspan=2>").text(collection.writingDate).css("padding", "10px").appendTo($tr); // 작성일
			
			var $tr = $("<tr>").appendTo($table);
			var $td = $("<td colspan=2>").css("padding-left", "30px").css("padding-right", "30px").css("padding-top", "10px").css("padding-bottom", "10px").css("text-align", "center")
			.css("border-top", "solid 3px #00D8FF").css("border-bottom", "solid 3px #00D8FF").css("height","240px").appendTo($tr);
			$.ajax({
		          url: "/moviefactory/api/collection/collposter?collNo=" + collection.collNo,
		          method: "get",
		          success: function(result, status, xhr) { // 요청이 성공했을 때 수행되는 함수 뜻함(포스터,영화이름 가져옴)
		          	// console.log(result.detail[0]);
		          if(typeof result.detail[0] =="undefined"){
		        	  $td.text("영화를 추가해주세요.");
		          }
		             $.each(result.detail, function(i, detail){
		         	 	$.ajax({
				 	    	url: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=147d96f90a50a05230287f0f02412bfd&movieCd=" + detail.mno,
				 	    	method: "get",
							success: function(result, status, xhr) { // 요청이 성공했을 때 수행되는 함수 뜻함(포스터,영화이름 가져옴)
				 	        	console.log(result);   // result 값을 출력
				 	        	getPoster($(result).find('movieNm').text(), $(result).find('prdtYear').text(), $td);
				 	        }, error: function(xhr) {   // 에러발생시 
				 	             console.log(xhr.status);   // 오류번호 발생번호 출력
				 	        }
				 	    });
		             });
		          }, error: function(xhr) {   // 에러발생시 
		              console.log(xhr.status);   // 오류번호 발생번호 출력
		              console.log("오류");
		          }
		    });
			// .css("overflow","hidden").css("text-overflow","ellipsis").css("white-space","nowrap").css("width","50px")
			// text-overflow:ellipsis
			var $tr = $("<tr>").appendTo($table);
			$("<td colspan=2>").text(collection.collName).css("white-space","nowrap").css("overflow","hidden").css("text-overflow","ellipsis").css("padding", "10px").css("height","50px").appendTo($tr); // 콜렉션 이름
			var $tr = $("<tr>").appendTo($table);
			$("<td colspan=2>").text(collection.collIntro).css("white-space","nowrap").css("overflow","hidden").css("text-overflow","ellipsis").css("padding", "10px").css("height","50px").appendTo($tr); // 콜렉션 내용
			var $tr = $("<tr>").css("text-align", "center").appendTo($table);
			var $td2 = $("<td colspan=2>").css("padding", "10px").css("border-top", "solid 3px #00D8FF").appendTo($tr);
			$("<a>").attr("href", "/moviefactory/collection/read?collNo=" + collection.collNo + "&pageno=1").text("보기").appendTo($td2);	// 콜렉션 상세 링크
			// 상세, 열기, 읽기, 보기, 열람,  
	});
}
		
	function getPoster(movieNm, prdtYear, $tr) {   // (영화제목,제작년도)로 포스터 불러오는 기능
	   console.log(movieNm);
	   console.log(prdtYear);
	   $.ajax({
	      url:"/moviefactory/api/image?subtitle=" + movieNm + "&pubData=" + prdtYear,
	      method: "get",
	      success:function(result) {
	         console.log(result.image);
	         //posterString = result.image;
	         if(typeof result.image == "undefined"){   // 이미지가 정해지지 않을 경우
	        	 console.log("디폴트이미지");
	         		
	            //var $td = $("<td>").appendTo($tr)   // td에 tr를 넣어라
	            $("<img>").attr("src","/sajin/default_movie.png").attr("height","100px").attr("width", "80px").appendTo($tr); 
	         }else {
	         	//var $td = $("<td>").appendTo($tr)   // 이미지가 들어있는 td를 tr에 넣어라
	         	$("<img>").attr("src",result.image).attr("height","100px").attr("width", "80px").appendTo($tr);   // result.image를 td안에 넣어라
	         	console.log("이미지들가냐");
	         //$("<td>").text(result.image).appendTo($tr);
	         }
	         
	      }, error:function(xhr) {
	         console.log(xhr);
	      }
	   });
	}
	
	$(function() {
		console.log(location.search.split('&'));
		strArray = location.search.split('&');
		   if(typeof location.search.split("&")[1]== "undefined"){
			   page = 1;
			}else{
				page = strArray[1].split('=')[1];
			}
		
		if (strArray[0].split('=')[0] == '?mno') {
			mno = strArray[0].split('=')[1];
			$.ajax({
				url : "/moviefactory/api/collection/list?mNo="
						+ strArray[0].split('=')[1] + "&pageno="
						+ page,
				method : "get",
				success : function(result,xhr) {
					console.log(result);
					collections = result.collections;
					printData();
					printPaging(result);
					if(result.collections.length==0){
			               $("#emptytext").text("등록한 컬렉션이 없습니다.").css("text-align","center")
			               .css("margin","100px").css("color","gray").css("font-size","20px").css("font-style" ,"italic");
			        }
					
				}, error: function(){
					location.href="/moviefactory";
				}
			});
		} else if (strArray[0].split('=')[0] == '?username') {
			username = strArray[0].split('=')[1];
			$.ajax({
				url : "/moviefactory/api/collection/userlist?username="
						+ strArray[0].split('=')[1] + "&pageno="
						+ page,
				method : "get",
				success : function(result,xhr) {
					$.ajax({
						url:"/moviefactory/api/collection/username",
						method:"get",
						success:function(str){
							console.log(str);
							if(username!=str) {
								$("#add").hide();
							}
						}, error: function(xhr){
							$("#add").hide();
						}
					
					})
					console.log(result);
					console.log(username);	// 유저네임
					collections = result.collections;
					printData();
					printPaging(result);
					if(result.collections.length==0){
			               $("#emptytext").text("등록한 컬렉션이 없습니다.").css("text-align","center")
			               .css("margin","100px").css("color","gray").css("font-size","20px").css("font-style" ,"italic");
			        }
				}, error: function(){
					location.href="/moviefactory";
				}
			});
		}
		
		$("#add").on("click", function() {
		      window.open('/moviefactory/collection/add?username='+username+'&pageno=1','window','width=700, height=700, status=no,toolbar=no,scrollbars=no, location=no')
		      
		   });

	});
    
</script>
<title>Insert title here</title>
</head>
<body>
	<div id="section">
		<h1 id="pageName">컬렉션 목록</h1>
		<button class="btn btn-primary" id="add">컬렉션 추가</button>
		<br>		<!-- 불편한거 정리함 : 폰트 굵기, 체크박스와 글자 위치 정렬 완료 -->
		<div class="w3-row-padding" id="list">
			
		</div>
		<div id="emptytext"></div>
	</div>
</body>
</html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>