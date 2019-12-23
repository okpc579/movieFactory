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

<!-- 시큐리티 EL을 이용해 로그인한 경우에만 js를 읽어들여 연결을 생성하도록 함  -->

<title>고객센터</title>
</head>
<style>
#admin_board {
	text-align: center;
}

th {
	text-align: center;
}

.title_center {
	text-align: center;
}

.normal_user {
	font-size: 40px;
}

#paging {
	width: 600px;
	padding-right: 130px;
}

.pagination a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #ddd;
}

.pagination a.active {
	background-color: #4CAF50;
	color: white;
	border: 1px solid #4CAF50;
}

.pagination a:hover:not (.active ) {
	background-color: #ddd;
}

#listbtn {
	float: left;
	margin: 20px 0 0 60px;
}

#writebtn {
	float: right;
	margin: 20px 40px 0 0;
}
</style>
<script>
	var typeUsername;
	var title;
	var askNo;
	function adminaskList(page) {
		var $body = ("#list");
		$.each(page.adminAsks, function(adminAskNo, adminAsk) {
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(adminAsk.askStateContent).appendTo($tr);
			var $td = $("<td>").appendTo($tr);
			$("<a>").attr(
					"href",
					"/moviefactory/adminAsk/read?adminAskNo=" 
							+ adminAsk.adminAskNo).attr("class","title").text(adminAsk.title)
					.appendTo($td);
			$("<td>").text(adminAsk.username).attr("data-username",
					adminAsk.username).attr("data-toggle", "model").attr(
					"data-target", "#usernameModal").attr("class", "username")
					.appendTo($tr);
			$("<td>").text(adminAsk.writingDate).appendTo($tr)
		});
	}

	function adminaskPage(page, username) {
		var $ul = $("<ul>").attr("class", "pagination").appendTo($("#paging"));

		var cntOfPage = Math.floor(page.totalcount / page.pagesize);
		if (page.totalcount % page.pagesize != 0)
			cntOfPage++;

		var blockSize = 5;
		var blockNo = Math.floor(page.pageno / blockSize) + 1;
		// page.pageno가 blockSize의 배수인 경우 (위에서 pageno가 5, 10, 15) blockNo 감소
		if (page.pageno % blockSize == 0)
			blockNo--;
		// 시작과 종료 페이지 계산
		var startPage = (blockNo - 1) * blockSize + 1;
		var endPage = startPage + blockSize - 1;
		// 마지막 페이지가 페이지의 개수보다 큰 경우 처리
		if (endPage > cntOfPage)
			endPage = cntOfPage;

		// 2.2 페이징 출력
		var usernameParam = '';
		if (username != undefined)
			usernameParam = '&username=' + username;
		// 블록 번호가 1보다 큰 경우 앞으로 버튼 출력
		if (blockNo > 1) {
			if (typeof typeUsername == "undefined" && typeof title == "undefined") {
				var $li = $("<li>").attr("class", "previous").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/adminAsk/list?pageno=" + (startPage - 1)
								+ usernameParam).text("이전").appendTo($li);
			} else if (typeof typeUsername == "string") {
				var $li = $("<li>").attr("class", "previous").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/adminAsk/list?username=" + typeUsername
								+ "&pageno=" + (startPage - 1) + usernameParam)
						.text("이전").appendTo($li);
			} else if (typeof title == "string") {
				var $li = $("<li>").attr("class", "previous").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/adminAsk/list?title=" + title
								+ "&pageno=" + (startPage - 1) + usernameParam)
						.text("이전").appendTo($li);
			}
		}

		// 현재 페이지인 경우 li에 active 클래스를 지정하면서 페이지 번호 출력
		for (var i = startPage; i <= endPage; i++) {
			if (i == page.pageno) {
				if (typeof typeUsername == "undefined" && typeof title == "undefined") {
					var $li = $("<li>").attr("class", "active").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/adminAsk/list?pageno=" + i
									+ usernameParam).text(i).appendTo($li);
				}
				else if (typeof typeUsername == "string") {
					var $li = $("<li>").attr("class", "active").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/adminAsk/list?username="
									+ typeUsername + "&pageno=" + i
									+ usernameParam).text(i).appendTo($li);
				} 
				else if (typeof title == "string") {
					var $li = $("<li>").attr("class", "active").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/adminAsk/list?title=" + title
									+ "&pageno=" + i + usernameParam).text(i)
							.appendTo($li);
				}
			    } else {
				if (typeof typeUsername == "undefined" &&  typeof title == "undefined") {
					var $li = $("<li>").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/adminAsk/list?pageno=" + i
									+ usernameParam).text(i).appendTo($li);
				} else if (typeof typeUsername == "string") {
					var $li = $("<li>").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/adminAsk/list?username="
									+ typeUsername + "&pageno=" + i
									+ usernameParam).text(i).appendTo($li);
				} else if (typeof title == "string") {
					var $li = $("<li>").appendTo($ul);
					$("<a>").attr(
							"href",
							"/moviefactory/adminAsk/list?title=" + title
									+ "&pageno=" + i + usernameParam).text(i)
							.appendTo($li);
				}
			}
		}

		// 블록의 마지막 페이지가 페이지 개수보다 작은 경우 다음으로 버튼 출력
		if (endPage < cntOfPage) {
			if (typeof typeUsername == "undefined" && typeof title == "undefined") {
				var $li = $("<li>").attr("class", "next").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/adminAsk/list?pageno=" + (endPage + 1)
								+ usernameParam).text("다음").appendTo($li);
			}
			else if (typeof typeUsername == "string") {
				var $li = $("<li>").attr("class", "next").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/adminAsk/list?username=" + typeUsername
								+ "&pageno=" + (endPage + 1) + usernameParam)
						.text("다음").appendTo($li);
			} 
			else if (typeof title == "string") {
				var $li = $("<li>").attr("class", "next").appendTo($ul);
				$("<a>").attr(
						"href",
						"/moviefactory/adminAsk/list?title=" + title
								+ "&pageno=" + (endPage + 1) + usernameParam)
						.text("다음").appendTo($li);
			}
		}
		
		$("body").on("click", "#write", function() {
			location.href = "/moviefactory/adminAsk/write";
		})
	}

	$(function() {
		toastr.options = {
			"progressBar" : true
		}
		// 전체 글을 페이징하면 주소가 ?pageno=11
		// 특정 사용자가 작성한 글을 페이징하면 ?pageno=11&writer=spring11
		// &를 기준으로 문자열을 자른다
		var params = location.search.split('&');
		var url = "/moviefactory/api/adminAsk/list";
		console.log(params[1]);

		if (typeof params[1] == "undefined") {
			if (params[0] == "") {
				url = url + "?pageno=" + 1;
			} else {
				url = url + "?pageno=" + params[0].split('=')[1];
			}

			$.ajax({
				url : url ,
				method : "get",
				success : function(result) {
					/*
					if(result.totalcount/10+1<result.pageno){
						location.href="/moviefactory/adminAsk/list?pageno=1";
					}else if(result.totalcount%10==0 && result.totalcount/10<result.pageno){
						location.href="/moviefactory/adminAsk/list?pageno=1";
					}else if(result.pageno<=0){
						location.href="/moviefactory/adminAsk/list?pageno=1";
					}else if(result.pageno==){
						location.href="/moviefactory/adminAsk/list?pageno=1";
					}*/
					if(typeof result =="undefined"){
						//location.href="/moviefactory/adminAsk/list?pageno=" + (location.search.split("=")[1]) +  "&pageno="+1	
					}else if(result.adminAsks.length ==0 && result.pageno!=1){
						location.href="/moviefactory/adminAsk/list?pageno="+1
					}
					console.log(result);
					adminaskList(result);
					adminaskPage(result);
				}, error: function(xhr) {
					console.log(xhr);
					 location.href="/moviefactory/adminAsk/list?pageno="+1
		         }
			});
		} else if (params[0].split('=')[0] == "?username") {
			console.log("들어왔다.");
			typeUsername = params[0].split('=')[1];
			console.log(username);
			console.log(params[0].split('=')[1]);
			//url = url + "?pageno=" + params[1].split('=')[1];
			$.ajax({
				url : "/moviefactory/api/adminAsk/searchlist?pageno="
						+ params[1].split('=')[1] + "&username="
						+ params[0].split('=')[1],
				method : "get",
				success : function(result) {
					console.log(result);
					adminaskList(result);
					adminaskPage(result);
				}
			});
		} else if (params[0].split('=')[0] == "?title") {
			console.log("?title 들어옴");
			//url = url + "?pageno=" + params[1].split('=')[1];
			console.log(params[0].split('=')[1]);
			title = params[0].split('=')[1];
			console.log(typeof title);
			$.ajax({
				url : "/moviefactory/api/adminAsk/searchlisttitle?pageno="
						+ params[1].split('=')[1] + "&title="
						+ params[0].split('=')[1],
				method : "get",
				success : function(result) {
					console.log(result);
					adminaskList(result);
					adminaskPage(result);
				}
			});
		}
	});

	function check() {
		if (document.searchForm.search.value == "") {
			alert("검색어를 입력하세요.");
			document.searchForm.search.focus();
			return;
		}
		document.searchForm.submit();
	}

	$(function() {
		$("#search1").keydown(function(key) {
			if (key.keyCode == 13) { // 엔터 활성화
				key.preventDefault();
				if ($("#search1").val() == "") {
					alert("검색어를 입력하세요.");
				} else {
					if ($("#searchType").val() == "typeUsername") {
						location.href = "/moviefactory/adminAsk/list?username=" + $("#search1").val() + "&pageno=1";
					}else if($("#searchType").val()=="title"){
		                  location.href="/moviefactory/adminAsk/list?title=" + $("#search1").val() + "&pageno=1";
		            }
				}
			}
		});

		$("#searchBtn")
				.on(
						"click",
						function() {
							if ($("#search1").val() == "") {
								alert("검색어를 입력하세요.");
							} else {
								if ($("#searchType").val() == "typeUsername") {
									location.href = "/moviefactory/adminAsk/list?username=" + $("#search1").val() + "&pageno=1";
								}else if($("#searchType").val()=="title"){
						               location.href="/moviefactory/adminAsk/list?title=" + $("#search1").val() + "&pageno=1";
					            }
							}
						});
	});
</script>
<body>
	<div id="section">
		<div id="adminask">
			<h2>
				<strong>고객 센터 - 문의</strong>
			</h2>
			<hr>
			<div id="menu_list">
				<div id="admin_board">
					<!-- 검색 폼 영역 -->
					<form name="searchForm" onsubmit="return false;" action=""
						method="get">
						<p class="user">관리자</p>
						<select id="searchType" name="searchType">
							<option value="title">제목</option>
							<option value="typeUsername">작성자</option>
						</select> <input type="text" name="search1" value="" size="40" id="search1" />
						<button type="button" class="btn" id="searchBtn">검색</button>
					</form>
					<table class="table">
						<thead>
							<tr>
								<th style="width: 111px;">문의상태</th>
								<th style="width: 682px;" id="title">제목</th>
								<th style="width: 153px;" id="username">아이디</th>
								<th style="width: 153px;">작성일</th>
							</tr>
						</thead>
						<tbody id="list">
						</tbody>
					</table>
					<div class="row text-center" style="width: 100%">
						<span style="width: 30%; float: none; margin: 0 auto"><span
							id="paging" class="pagination" style="text-align: center;"></span>

							<span><input type=button class="btn btn-primary"
								value="목록" id="listbtn" Onclick="window.location='list'" /></span> <sec:authorize
								access="hasRole('ROLE_USER')">
								<span><input type=button class="btn btn-primary"
									value="글쓰기" id="writebtn" OnClick="window.location='write'" /></span>
							</sec:authorize> </span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>