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
	href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<title>Insert title here</title>
</head>
<style>
.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}
table {
	table-layout: fixed;
}

#mcmntcontent {
	overflow: hidden;
	width: 900px;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: none;
}

#admin_board {
	text-align: center;
}

tr th {
	text-align: center;
}

th td {
	vertical-align: middle;
}

.title_center {
	text-align: center;
}

.normal_user {
	font-size: 40px;
}

#paging {
	width: 300px;
}

.pagination a {
	color: black;
	float: left;
	padding: 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #FBCEB1;
}

#listbar {
	background-color: #4ABFD3;
	color: white;
}
</style>
<script>
var cmntcontent;
var typeUsername;
	function printList(page) {
		var $body = $("#list");
		$.each(page.movieReviewComments, function(idx, movieReviewComment) {
			console.log(movieReviewComment);
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(movieReviewComment.mrevCmntNo).appendTo($tr);
			var $td = $("<td>").appendTo($tr);
			$("<a>").attr(
					"href",
					"/moviefactory/admin/readrevcmntblind?mrevCmntNo="
							+ movieReviewComment.mrevCmntNo).attr("id","mcmntcontent").
							text(movieReviewComment.content).appendTo($td);
			$("<td>").text(movieReviewComment.username).appendTo($tr);
			$td = $("<button>").appendTo($tr);
			$("<button class='btn btn-default' id='unblock" + idx +  "'>")
					.text("블라인드해제").appendTo($td);
			$("<input type='hidden' id='unblocksub" + idx +  "'>").val(
					movieReviewComment.mrevCmntNo).appendTo($td);
		});

		$("#unblock0").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub0").val(),
			}
			unblindcomment(param);
		});
		$("#unblock1").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub1").val(),
			}
			unblindcomment(param);
		});
		$("#unblock2").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub2").val(),
			}
			unblindcomment(param);
		});
		$("#unblock3").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub3").val(),
			}
			unblindcomment(param);
		});
		$("#unblock4").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub4").val(),
			}
			unblindcomment(param);
		});
		$("#unblock5").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub5").val(),
			}
			unblindcomment(param);
		});
		$("#unblock6").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub6").val(),
			}
			unblindcomment(param);
		});
		$("#unblock7").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub7").val(),
			}
			unblindcomment(param);
		});
		$("#unblock8").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub8").val(),
			}
			unblindcomment(param);
		});
		$("#unblock9").on("click", function() {
			var param = {
				_method : "post",
				mRevCmntNo : $("#unblocksub9").val(),
			}
			unblindcomment(param);
		});
	}

	function unblindcomment(param) {
		console.log(param);
		$.ajax({
			url : "/moviefactory/api/blind/updatecomment",
			method : "post",
			data : param,
			success : function(result) {
				location.reload();
			}
		});
	}

	function revCmntBlindPage(page, username) {
		var $ul = $("<ul>").attr("class", "pagination").appendTo($("#paging"));
		var cntOfPage = Math.floor(page.totalcount / page.pagesize);
		if (page.totalcount % page.pagesize != 0)
			cntOfPage++;
		var blockSize = 5;
		var blockNo = Math.floor(page.pageno / blockSize) + 1;
		if (page.pageno % blockSize == 0)
			blockNo--;
		var startPage = (blockNo - 1) * blockSize + 1;
		var endPage = startPage + blockSize - 1;
		if (endPage > cntOfPage)
			endPage = cntOfPage;

		var usernameParam = '';
		if (username != undefined)
			usernameParam = '&username=' + username;
		
		console.log(typeof cmntcontent);
		console.log(typeof typeUsername);
		if (blockNo > 1) {
			if(typeof cmntcontent == "undefined" && typeof typeUsername == "undefined"){
				var $li = $("<li>").attr("class", "previous").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/admin/blindcmntlist?pageno="
								+ (startPage - 1) + usernameParam).text("앞으로")
						.appendTo($li);
			}
			else if(typeof cmntcontent == "string"){
				var $li = $("<li>").attr("class", "previous").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/admin/blindcmntlist?cmntcontent=" + cmntcontent + "&pageno="
								+ (startPage - 1) + usernameParam).text("앞으로")
						.appendTo($li);
			}else if(typeof typeUsername == "string"){
				var $li = $("<li>").attr("class", "previous").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/admin/blindcmntlist?username=" + typeUsername + "&pageno="
								+ (startPage - 1) + usernameParam).text("앞으로")
						.appendTo($li);
			}
		}
		// 현재 페이지인 경우 li에 active 클래스를 지정하면서 페이지 번호 출력
		for (var i = startPage; i <= endPage; i++) {
			if (i == page.pageno) {
				if(typeof cmntcontent == "undefined" && typeof typeUsername == "undefined"){
					console.log("tt");
					var $li = $("<li>").attr("class", "active").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/admin/blindcmntlist?pageno=" + i
									+ usernameParam).text(i).appendTo($li);
					}
				else if(typeof cmntcontent == "string"){
					console.log("ft");
					var $li = $("<li>").attr("class", "active").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/admin/blindcmntlist?cmntcontent=" + cmntcontent + "&pageno=" + i
									+ usernameParam).text(i).appendTo($li);
					}
				else if(typeof typeUsername == "string"){
					console.log("tf");
					var $li = $("<li>").attr("class", "active").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/admin/blindcmntlist?username=" + typeUsername + "&pageno=" + i
									+ usernameParam).text(i).appendTo($li);
				}
				} else {
				if(typeof cmntcontent == "undefined" && typeof typeUsername == "undefined"){
					var $li = $("<li>").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/admin/blindcmntlist?pageno=" + i
									+ usernameParam).text(i).appendTo($li);
				}
				else if(typeof cmntcontent == "string"){
					var $li = $("<li>").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/admin/blindcmntlist?cmntcontent=" + cmntcontent + "&pageno=" + i
									+ usernameParam).text(i).appendTo($li);
					}
				else if(typeof typeUsername == "string"){
					var $li = $("<li>").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/admin/blindcmntlist?username=" + typeUsername + "&pageno=" + i
									+ usernameParam).text(i).appendTo($li);
				}
			}
		}
		
		
		// 블록의 마지막 페이지가 페이지 개수보다 작은 경우 다음으로 버튼 출력
		if (endPage < cntOfPage) {
			if(typeof cmntcontent == "undefined" && typeof typeUsername == "undefined"){
				var $li = $("<li>").attr("class", "next").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/admin/blindcmntlist?pageno=" + (endPage + 1)
								+ usernameParam).text("다음으로").appendTo($li);
			}
			else if(typeof cmntcontent == "string"){
				var $li = $("<li>").attr("class", "next").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/admin/blindcmntlist?cmntcontent=" + cmntcontent + "&pageno=" + (endPage + 1)
								+ usernameParam).text("다음으로").appendTo($li);
			}
			else if(typeof typeUsername == "string"){
				var $li = $("<li>").attr("class", "next").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/admin/blindcmntlist?cmntcontent=" + cmntcontent + "&pageno=" + (endPage + 1)
								+ usernameParam).text("다음으로").appendTo($li);
			}
			
		}
	}  
	
	$(function() {
		toastr.options = {
			"progressBar" : true
		}
		// var params = location.search.split('=');
		// console.log(params);
		var params = location.search.split('&');
		var url = "/moviefactory/api/findcmntblind";
		console.log(params);
		
		if(typeof params[1] == "undefined"){	
			if (params[0] == "") {
				url = url + "?pageno=" + 1;
			} else {
				url = url + "?pageno=" + params[0].split('=')[1];
			}
			
			$.ajax({
				url : url,
				method : "get",
				success : function(result, xhr) {
					
					console.log(result);
					printList(result);
					revCmntBlindPage(result);
					   if(typeof result =="undefined"){
			                  location.href="/moviefactory/admin/blindcmntlist?pageno=" + (location.search.split("=")[1]) +  "&pageno="+1   
			           }else if(result.movieReviewComments.length==0){
			                  location.href="/moviefactory/admin/blindcmntlist?pageno="+1
			           } 
				}, error: function(xhr) {
		               console.log(xhr);
		                location.href="/moviefactory/admin/blindcmntlist?pageno="+1
				}
			});
			
			
		}else if(params[0].split('=')[0] == "?cmntcontent"){
			console.log("?cmntcontent 들어옴");
			//url = url + "?pageno=" + params[1].split('=')[1];
			cmntcontent = params[0].split('=')[1];
			console.log(typeof cmntcontent);			
			$.ajax({
				url : "/moviefactory/api/blind/search/commentbycontent?pageno="+params[1].split('=')[1] + "&search="+params[0].split('=')[1],
				method : "get",
				success : function(result) {
					console.log(result);
					printList(result);
					revCmntBlindPage(result);
				}
			});
			
		}else if(params[0].split('=')[0] == "?username"){
			console.log("?username 들어옴");
			typeUsername = params[0].split('=')[1];
			//url = url + "?pageno=" + params[1].split('=')[1];
			$.ajax({
				url : "/moviefactory/api/blind/search/commentbyusername?pageno="+params[1].split('=')[1] + "&search="+params[0].split('=')[1],
				method : "get",
				success : function(result) {
					console.log(result);
					printList(result);
					revCmntBlindPage(result);
				}
			});
		}
	});
	
	function check() {
		if (document.searchblind.search.value == "") {
			alert("검색어를 입력하세요.");
			document.searchblind.search.focus();
			return;
		}
		document.searchblind.submit();
	}
	
	$(function() {
		$("#search1").keydown(function(key) {
			if(key.keyCode==13) {
				key.preventDefault();
				if($("#search1").val()=="") {
					alert("검색어를 입력하세요.");
				}else{
					if($("#searchType").val()=="cmntcontent"){
						location.href="/moviefactory/admin/blindcmntlist?cmntcontent=" + $("#search1").val() + "&pageno=1";
					}else if($("#searchType").val()=="typeUsername"){
						location.href="/moviefactory/admin/blindcmntlist?username=" + $("#search1").val() + "&pageno=1";
					}
				}
			}
		});
		
		$("#searchbtn").on("click", function() {
			if($("#search1").val()=="") {
				alert("검색어를 입력하세요.");
			} else {
				if($("#searchType").val()=="cmntcontent"){
					location.href="/moviefactory/admin/blindcmntlist?cmntcontent=" + $("#search1").val() + "&pageno=1";
				}else if($("#searchType").val()=="typeUsername"){
					location.href="/moviefactory/admin/blindcmntlist?username=" + $("#search1").val() + "&pageno=1";
				}
			}
		});
	});
</script>

<body>

	<div id="section">
		<sec:authorize access="isAnonymous()">
			<script>
				location.href = "/moviefactory/system/e403";
			</script>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_USER')">
			<script>
				location.href = "/moviefactory/system/e403";
			</script>
		</sec:authorize>
		<div id="admin">
			<h2>
				<a href="/moviefactory/admin/blindcmntlist">관리자
					센터 - 블라인드 댓글</a>
			</h2>
			<br>
			<hr>
			<div id="admin_board">
				<table class="table">
					<colgroup>
						<col width="10%">
						<col width="55%">
						<col width="20%">
						<col width="15%">
					</colgroup>
					<thead class="board_top">
						<tr id="listbar">
							<th>댓글번호</th>
							<th>댓글내용</th>
							<th id="username">아이디</th>
							<th>블라인드해제</th>
						</tr>
					</thead>
					<tbody id="list">

					</tbody>
				</table>

				<div class="row text-center" style="width: 100%">
					<div style="width: 30%; float: none; margin: 0 auto">
						<div id="paging" class="pagination" style="text-align: center;">
						</div>
					</div>
				</div>

				<div>
					<form class="form-inline" onsubmit="return false;" action=""
						id="searchrev" name="searchblind" method="get">
						<select id="searchType" name="searchType" size="1">
							<option value="cmntcontent">내용</option>
							<option value="typeUsername">아이디</option>
						</select> <input type="text" id="search1" size="20">
						<button type="button" id="searchbtn">검색</button>
					</form>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>