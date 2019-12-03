<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
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
<script>
	function printList(page) {
		var $body = $("#list");
		$.each(page.members, function(idx, member) {
			console.log(member);
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(member.nick).appendTo($tr);
			var $td = $("<td>").appendTo($tr);
			$("<a>").attr("href","/moviefactory/admin/readblock?username=" + member.username).text(member.username).appendTo($td);
			$td = $("<td>").text(member.blockDate).appendTo($tr);
			$td = $("<td>").appendTo($tr);
			$("<button id='unblock" + idx +  "'>").text("정지해제").appendTo($td);
			$("<input type='hidden' id='unblocksub" + idx +  "'>").val(member.username).appendTo($td);
		});
		$("#unblock0").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub0").val(),		
			}
			unblock(param);
		});
		$("#unblock1").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub1").val(),		
			}
			unblock(param);
		});
		$("#unblock2").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub2").val(),		
			}
			unblock(param);
		});
		$("#unblock3").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub3").val(),		
			}
			unblock(param);
		});
		$("#unblock4").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub4").val(),		
			}
			unblock(param);
		});
		$("#unblock5").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub5").val(),		
			}
			unblock(param);
		});
		$("#unblock6").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub6").val(),		
			}
			unblock(param);
		});
		$("#unblock7").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub7").val(),		
			}
			unblock(param);
		});
		$("#unblock8").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub8").val(),		
			}
			unblock(param);
		});
		$("#unblock9").on("click", function() {
			var param ={
					_method:"post",
					username:$("#unblocksub9").val(),		
			}
			unblock(param);
		});
	}
	
	function unblock(param){
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/update/block",
			method: "post",
			data: param,
			success: function(result) {
				 location.reload();
			}
		});	
	}
	
	// 2. page.totalcount, page.pageno, page.pagesize를 이용해 페이징 처리를 하는 메소드
	function blockListPage(page, username) {
		var $ul = $("<ul>").attr("class", "pagination").appendTo($("#paging"));
		
		// 2.1 페이징을 위한 계산
		// 전체 페이지의 개수를 계산
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
		
		var usernameParam = '';
		if(username!=undefined)
			usernameParam = '&username=' + username;
		// 블록 번호가 1보다 큰 경우 앞으로 버튼 출력
		if(blockNo>1) {
			var $li = $("<li>").attr("class", "previous").appendTo($ul);
			$("<a>").attr("href","/moviefactory/admin/blockrevlist?pageno=" + (startPage-1) + usernameParam).text("앞으로").appendTo($li);
		}
		// 현재 페이지인 경우 li에 active 클래스를 지정하면서 페이지 번호 출력
		for(var i=startPage; i<=endPage; i++) {
			if(i==page.pageno) {
				var $li = $("<li>").attr("class","active").appendTo($ul);
				$("<a>").attr("href","/moviefactory/admin/blocklist?pageno=" + i + usernameParam).text(i).appendTo($li);
			}
			else {
				var $li = $("<li>").appendTo($ul);
				$("<a>").attr("href","/moviefactory/admin/blockrevlist?pageno=" + i + usernameParam).text(i).appendTo($li);
			}
		}
		
		// 블록의 마지막 페이지가 페이지 개수보다 작은 경우 다음으로 버튼 출력
		if(endPage<cntOfPage) {
			var $li = $("<li>").attr("class", "next").appendTo($ul);
			$("<a>").attr("href", "/moviefactory/admin/blockrevlist?pageno=" + (endPage+1) +  usernameParam).text("다음으로").appendTo($li);
		}	
	}
	$(function() {
		toastr.options = {
				"progressBar" : true
		}
		var params = location.search.split('=');
		console.log(params);
		var url = "/moviefactory/api/enabledlist";
		if(params[0]==""){
			url=url+"?pageno="+1;
		}else{
			url=url+"?pageno="+params[1];
		}
		
		$.ajax({
			url: url,
			method: "get",
			success: function(result) {
				console.log(result);
				printList(result);
				blockListPage(result);
			}
		});
	});
</script>
<style>
</style>
<body>
<sec:authorize access="isAnonymous()">
	<script>
		location.href="http://localhost:8081/moviefactory/system/e403";
	</script>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_USER')">
	<script>
		location.href="http://localhost:8081/moviefactory/system/e403";
	</script>
</sec:authorize>
	<div id="admin">
		<h2>고객 센터 - 정지목록</h2>
		<hr>
		<div id="admin_board">
			<table class="table">
				<colgroup>
					<col width="25%">
					<col width="45%">
					<col width="15%">
					<col width="15%">
				</colgroup>
				<thead class="board_top">
					<tr>
						<th>닉네임</th>
						<th id="username">아이디</th>
						<th>정지일</th>
						<th>정지해제</th>
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
		</div>
	</div>
</body>
</html>