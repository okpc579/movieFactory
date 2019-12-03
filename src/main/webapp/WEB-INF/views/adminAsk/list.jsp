<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
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
/* #section {
	width: 1000px; display: inline-block;
} */

#admin_board {
	width: 758px; text-align: center;
}

.board_top {
	text-align: center;
}

#title_center {
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
</style>
<script>
	function adminaskList(page){
		var $body = ("#list");
		$.each(page.adminAsks, function(adminAskNo, adminAsk){
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(adminAsk.adminAskNo).appendTo($tr)
			var $td = $("<td>").appendTo($tr)
			$("<td>").text(adminAsk.askStateContent).appendTo($td);
			$("<a>").attr("href","/moviefactory/adminAsk/read?adminAskNo=" + adminAsk.adminAskNo)
			.text(adminAsk.title).appendTo($tr);
			$("<td>").text(adminAsk.username).attr("data-username", adminAsk.username)
			.attr("data-toggle", "model").attr("data-target","#usernameModal")
			.attr("class","username").appendTo($tr);
			$("<td>").text(adminAsk.writingDate).appendTo($tr)
		});
	}
	function adminaskPage(page, username){
		var $ul = $("<ul>").attr("class", "Page").appendTo($("#paging"));
		
		var cntOfPage = Math.floor(page.totalcount/page.pagesize);
		if(page.totalcount%page.pagesize!=0)
			cntOfPage++;
		
		var blockSize = 5;
		var blockNo = Math.floor(page.pageno/blockSize) + 1;
		// page.pageno가 blockSize의 배수인 경우 (위에서 pageno가 5, 10, 15) blockNo 감소
		if(page.pageno % blockSize==0)
			blockNo--;
		// 시작과 종료 페이지 계산
		var startPage = (blockNo-1) * blockSize + 1;
		var endPage = startPage + blockSize -1;
		// 마지막 페이지가 페이지의 개수보다 큰 경우 처리
		if(endPage>cntOfPage)
			endPage = cntOfPage;
		
		// 2.2 페이징 출력
		var usernameParam = '';
		if(username!=undefined)
			usernameParam = '&username=' + username;
		// 블록 번호가 1보다 큰 경우 앞으로 버튼 출력
		if(blockNo>1) {
			var $li = $("<li>").attr("class", "previous").appendTo($ul);
			$("<a>").attr("href","/moviefactory/adminAsk/list?pageno=" + (startPage-1) + usernameParam).text("이전").appendTo($li);
		}
		// 현재 페이지인 경우 li에 active 클래스를 지정하면서 페이지 번호 출력
		for(var i=startPage; i<=endPage; i++) {
			if(i==page.pageno) {
				var $li = $("<li>").attr("class","active").appendTo($ul);
				$("<a>").attr("href","/moviefactory/adminAsk/list?pageno=" + i + usernameParam).text(i).appendTo($li);
			}
			else {
				var $li = $("<li>").appendTo($ul);
				$("<a>").attr("href","/moviefactory/adminAsk/list?pageno=" + i + usernameParam).text(i).appendTo($li);
			}
		}
		
		// 블록의 마지막 페이지가 페이지 개수보다 작은 경우 다음으로 버튼 출력
		if(endPage<cntOfPage) {
			var $li = $("<li>").attr("class", "next").appendTo($ul);
			$("<a>").attr("href", "/moviefactory/adminAsk/list?pageno=" + (endPage+1) +  usernameParam).text("다음").appendTo($li);
		}	
	}
	
	$("body").on("click", "#write", function() {
		location.href = "/moviefactory/adminAsk/write";
	})
	
	// 3. .username 클릭 처리
	$("body").on("click", ".username", function() {
		// 글쓴사람 아이디를 클릭하면 모달 메뉴를 출력
		// 아이디는 td에 data-username으로 저장. 모달 메뉴를 띄우는 순간에 메뉴쪽에 복사	
		$(".modal-body li").attr("data-username", $(this).attr("data-username"));
	});
	$(function() {
		toastr.options = {
			"progressBar" : true
		}
		
		// 전체 글을 페이징하면 주소가 ?pageno=11
		// 특정 사용자가 작성한 글을 페이징하면 ?pageno=11&writer=spring11
		// &를 기준으로 문자열을 자른다
		var params = location.search.split('&');
		
		// pageno=11
		//console.log(params[0]);
		// 전체 글 페이징 : undefined, 사용자가 작성한 글 페이징: writer=spring11
		console.log(params[1]);
		$.ajax({
			url: "/moviefactory/api/adminAsk/list",	//여기 주소 니가 이상하게 적어놨어
			method: "get",
			data : location.search.substr(1),
			success: function(result) {
				console.log(result);
				adminaskList(result); // 이거 이름 안바꿈 adminaskList
				if(params[1]!=undefined)
					adminaskPage(result, params[1].substr(7));	//여기 이름 안바꿈 adminaskPage
				else
					adminaskPage(result);	// 여기 이름 안바꿈 adminaskPage
			}
		});
	});
</script>
<body>
<div id="section">
	<div id="adminask">
		<h2>고객 센터 - 관리자 문의</h2>
		<hr>
		<div id="menu_list">
			<div id="admin_board">
				<!-- 검색 폼 영역 -->
				<form name="searchForm" action="" method="get">
					<p>
					<p class="user">-일반 회원</p>
					<select name="searchType">
						<option value="all">전체검색</option>
						<option value="title">제목</option>
						<option value="username">작성자</option>
						<option value="content">내용</option>
					</select> <input type="text" name="searchText" value="" /> 
					<input type="submit" value="검색" />
					</p>
				</form>
				<table class="table">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="54%">
						<col width="14%">
						<col width="12%">
					</colgroup>
					<thead class="board_top">
						<tr>
							<th>글번호</th>
							<th>문의상태</th>
							<th id="title_center">제목</th>
							<th>아이디</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody id="list">
						
					</tbody>
				</table>
				<div class="row text-center" style="width: 100%">
            <div style="width: 30%; float: none; margin: 0 auto">
				<div id="paging" class="pagination" style="text-align: center;">
				</div>
				<div>
					<input type=button value="목록" Onclick="window.location='list'" />
				</div>
			</div>
			</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>