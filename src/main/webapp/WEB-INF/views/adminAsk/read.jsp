<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 읽기</title>
</head>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
	// read.jsp의 모든 자바스크립트 기능에서 board가 필요 -> 변수로 따로 뺀다 
	var adminAsk;

	// 1. 글 출력
	function adminaskData() {
		// 작성자, 제목, 글번호, 작성날짜, 글내용 출력
		$("#username").text(adminAsk.username);
		$("#title").text(adminAsk.title);
		$("#adminAskNo").text(adminAsk.adminAskNo);
		$("#writingDate").text(adminAsk.writingDate);
		$("#content").text(adminAsk.content);
		// 로그인 을 해야 자신의 문의목록을 볼수있다
		// 답변전일때는 수정을 할수있다 답변완료가 되면 수정불가
		if (adminAskState =='답변전') {
			$("<button></button>").attr("id", "btnUpdate").attr("class",
					"btn btn-info").css("margin", "10px").text("변 경").appendTo(
					$("#btnArea"));
			}
		$("<button></button>").attr("id", "btnDelete").attr("class",
		"btn btn-info").text("삭 제").appendTo($("#btnArea"));
	// 답글출력
	printAskAnswer();
}

// 2. 답글 출력
function printAskAnswer(AskAnswer) {
	if(askAnswer==undefined)
		askAnswer = adminAsk.askAnswer;
	
	// 답글을 출력할 영역(#comments)를 읽어와 초기화(출력중인 모든 댓글을 삭제)
	var $askAnswer = $("#askAnswer");
	$askAnswer.empty();
		
	$.each(askAnswer, function(i, askAnswer){
		var $askAnswer = $("<div>").appendTo($askAnswer)
		var $upper_div = $("<div>").appendTo($askAnswer);
		var $center_div = $("<div>").appendTo($askAnswer);
		var $lower_div = $("<div>").appendTo($askAnswer);
		$("<span></span>").text(askAnswer.username).appendTo($upper_div);
		$("<span>").text(askAnswer.content).appendTo($center_div);
		$("<span>").text(askAnswer.writingDate).appendTo($lower_div);
			var btn = $("<button>").attr("class", "delete_askAnswer").attr("data-admin_ask_no", adminAsk.adminAskNo)
			.attr("data-username", askAnswer.username).text("삭제").appendTo($center_div);
			btn.css("float","right");
		$("<hr>").appendTo($askAnswer);
	});
}

// 답글을 포함한 게시글을 읽어온다
$(function() {
	var adminAskNo = location.search.substr(5);
	$.ajax({
		url: "/moviefactory/api/adminAsks/" + adminAskNo,
		method: "get",
		success: function(result, status, xhr) {
			console.log(result);
			adminaskData(result)
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	
	// 3. 글 수정
	$("#btnArea").on("click", "#btnUpdate", function() {
		var param = {
			_method:"put",
			adminAskNo: $("#admin_ask_no").text(),
			title:$("#title").val(),
			content:$("content").text()
		};
		$.ajax({
			url : "/moviefactory/api/adminAsks",
			method: "post",
			data:param,
			success:function() {
				location.reload();
			}, error : function(xhr) {
		        console.log(xhr.status);
		    }
		});
	});

	// 4. 글 삭제 
	$("#btnArea").on("click", "#btnDelete", function() {
		var param = {
			_method:"delete",
		};
		$.ajax({
			url : "/moviefactory/api/adminAsks/" + adminAsk.adminAskNo,
			method:"post",
			data: param,
			success:function(result, text, xhr) {
				location.href = "/moviefactory";
			}, error : function(xhr) {
				console.log("삭제에 실패했습니다");
			}
		});
	});

	// 7. 답글 작성
	$("#askAnswer_write").on("click", function() {
		// 비로그인이면 중단
		var param = {
			adminAskNo: adminAsk.adminAskNo,
			content: $("#askAnswer_textarea").val(),
		}
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/askAnswer",
			method: "post",
			data : param,
			success : function(result) {
				console.log(result);
				$("#askAnswer_textarea").val(""); 
				printAskAnswer(result);
			}
		});
	});

	// 8. 답글 삭제
	$("#askAnswer").on("click", ".delete_askAnswer", function() {
		var param = {
			_method:"delete",
			adminAskNo : adminAsk.adminAskNo,
		}
		$.ajax({
			url: "/moviefactory/api/askAnswer",
			method: "post",
			data: param,
			success : function(result) {
				console.log(result);
				$("#askAnswer_textarea").val(""); 
				printAskAnswer(result);
			}
		});
	});
});
</script>
<body>
	<div id="reading">
		<div>
			<div id="title_div">
				<!-- 제목, 작성자 출력 영역 -->
				<div id="upper">
					<span id="title"></span>
				    <span id="username"></span>
				</div>
				<!-- 글번호, 작성일 출력 영역 -->
				<div id="lower">
					<ul id="lower_left">
						<li>글번호<span id="adminAskNo"></span></li>
						<li><span id="writingDate"></span></li>
					</ul>
				</div>
			</div>
			<!--  본문, 갱신 버튼, 삭제 버튼 출력 영역 -->
			<div id="content_div">
				<div class="form-group">
					<div class="form-control" id="content">우리나라 좋은나라</div>
				</div>
				<div id="btnArea"></div>
			</div>
		</div>
		<div>
		<div class="form-group">
      		<label for="askAnswer_textarea">답글을 입력하세요</label>
      		<textarea class="form-control" rows="5" id="askAnswer_textarea" placeholder="답글"></textarea>
    	</div>
    	<button type="button" class="btn btn-info" id="askAnswer_write">
     		<span class="glyphicon glyphicon-ok"></span>답글 작성
    	</button>
	</div>
	<hr>
	<div id="askAnswer">
	</div>
	</div>
</body>
</html>