<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ page session = "true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<title>Insert title here</title>
<script>
	var isLogin = false;
	var loginId = undefined;
</script>
<sec:authorize access="isAuthenticated()">

	<sec:authentication property="principal.username" var="member" />
	<script>
		isLogin = true;
		loginId = '${member}';
	</script>
</sec:authorize>
<script>
//1. 글 출력
var moviereview;
function printData() {
	$("#writer").text(moviereview.username);
	$("#bno").text(moviereview.mRevNo);
	$("#writeDay").text(moviereview.writingDate);
	$("#recommend").text(moviereview.likeCnt);
		
	// 추천수, 신고수	
	$("#content").prop("readonly", true);
	$("#a").prop("disabled", true);
	$("#c").prop("disabled", true);
	
	// 글 추천, 신고, 변경, 삭제
	// 1. 로그인이 안된 유저
	//		추천, 신고, 변경, 삭제 모두 불가능. content 편집 불가. 댓글 작성 불가
	// 2. 글의 작성자인 경우
	//		변경, 삭제 가능. content 편집 가능
	// 3. 글의 작성자가 아닌 경우
	// 		추천, 신고 가능. content 편집 불가
	
	if(isLogin==false) {
		$("#content").prop("readonly", true);
		$("#comment_textarea").prop("disabled", true).attr("placeholder", "로그인이 필요합니다");
		$("#comment_write").prop("disabled", true);
	} else if(isLogin==true && moviereview.own!=true) {
		$("#a").prop("disabled", false).attr("title", "좋아요");
		$("#c").prop("disabled", false).attr("title", "신고하기");
	} else if(isLogin==true && moviereview.own==true) {
		$("<button></button>").attr("id","btnUpdate").attr("class", "btn btn-info").css("margin","10px").text("변 경").appendTo($("#btnArea"));
		$("<button></button>").attr("id","btnDelete").attr("class", "btn btn-info").text("삭 제").appendTo($("#btnArea"));
	} 
	// 댓글 출력
	printComment();
	
}
//2. 댓글 출력
function printComment(comments) {
	if(comments==undefined)
		comments = moviereview.comments;
	console.log(comments);
	// 댓글을 출력할 영역(#comments)를 읽어와 초기화(출력중인 모든 댓글을 삭제)
	var $comments = $("#comments");
	$comments.empty();
		
	$.each(comments, function(i, comment){
		var $comment = $("<div>").appendTo($comments)
		var $upper_div = $("<div>").appendTo($comment);
		var $center_div = $("<div>").appendTo($comment);
		var $lower_div = $("<div>").appendTo($comment);
		$("<span></span>").text(comment.writer).appendTo($upper_div);
		$("<img>").attr("src","/profile/" + comment.username + ".jpg").css("width","40px").appendTo($center_div);
		$("<span>").text(comment.content).appendTo($center_div);
		$("<span>").text(comment.writeday).appendTo($lower_div);
		if(comment.writer==loginId) {
			var btn = $("<button>").attr("class", "delete_comment").attr("data-cno", comment.cno)
				.attr("data-mRevNo", moviereview.mRevNo).attr("data-writer", comment.writer).text("삭제").appendTo($center_div);
			btn.css("float","right");
		}
		$("<hr>").appendTo($comment);
	});
}

// 댓글을 포함한 게시글을 읽어온다
$(function() {
	var mRevNo = location.search.substr(8);
	console.log(mRevNo);
	$.ajax({
		url: "/moviefactory/api/movie/review/read/" + mRevNo,
		method: "get",
		success: function(result, status, xhr) {
			console.log(result);
			moviereview = result
			printData();
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	
	// 3. 글 갱신
	$("#btnArea").on("click", "#btnUpdate", function() {
		var param = {
			_method:"put",
			mRevNo: $("#mRevNo").text(),
			title:$("#title").val(),
			content: $("#content").val(),
		};
		$.ajax({
			url : "/moviefactory/api/movie/review",
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
			url : "/moviefactory/api/movie/review/delete" + moviereview.mRevNo,
			method:"post",
			data: param,
			success:function(result, text, xhr) {
				location.href = "/moviefactory";
			}, error : function(xhr) {
				console.log("삭제에 실패했습니다");
			}
		});
	});

	// 5. 글 추천
	$("#lower_right").on("click", "#a", function() {
		console.log("====================")
		// 비로그인이거나 글쓴 사람 본인이면 추천 금지
		if(isLogin==false || moviereview.own==true)
			return;
		var param = {
			_method: "patch",
			mRevNo: moviereview.mRevNo,
		};
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/movie/review/like",
			method: "post",
			data: param,
			success : function(result) {
				// 추천에 성공한 경우 서버에서 새로운 추천수를 보내주므로 출력
				console.log(result);
				$("#recommend").text(result);
			}, error: function(xhr) {
				console.log(xhr.status);
			}
		});
	});

	// 6. 글 신고
	$("#lower_right").on("click", "#c", function() {
		// 비로그인이거나 글쓴 사람 본인이면 신고 금지
		if(isLogin==false || moviereview.own==true)
			return;
		var param = {
			_method: "patch",
			mRevNo: moviereview.mRevNo,
		};
		$.ajax({
			url: "/moviefactory/api/movie/report",
			method: "post",
			data: param,
			success : function(result) {
				// 신고에 성공한 경우 서버에서 새로운 신고수를 보내주므로 출력
				$("#report").text(result);
			}, error: function(xhr) {
				console.log(xhr.status);
			}
		});
	});
	// 7. 댓글 작성
	$("#comment_write").on("click", function() {
		// 비로그인이면 중단
		if(isLogin==false)
			return;
		var param = {
			mRevNo: moviereview.mRevNo,
			content: $("#comment_textarea").val(),
		}
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/movie/comment/write",
			method: "post",
			data : param,
			success : function(result) {
				console.log(result);
				$("#comment_textarea").val(""); 
				printComment(result);
			}
		});
	});

	// 8. 댓글 삭제
	$("#comments").on("click", ".delete_comment", function() {
		if(isLogin==false || loginId!=$(this).data("writer"))
			return;
		var param = {
			_method:"delete",
			cno : $(this).data("cno"),
			mRevNo : moviereview.mRevNo,
		}
		$.ajax({
			url: "/moviefactory/api/movie/deletebyrevno",
			method: "post",
			data: param,
			success : function(result) {
				console.log(result);
				$("#comment_textarea").val(""); 
				printComment(result);
			}
		});
	});
})
</script>
</head>
<body>
<div id="wrap">
	<div>
		<div id="title_div">
			<!-- 제목, 작성자 출력 영역 -->
			<div id="upper">
				<span id="writer"></span>
			</div>
			<!-- 글번호, 작성일, 아이피, 추천수, 조회수, 신고수 출력 영역 -->
			<div id="lower">
				<ul id="lower_left">
					<li>글번호<span id="bno"></span></li>
					<li><span id="writeDate"></span></li>
				</ul>
				<ul id="lower_right">
					<li><button type="button" class="btn btn-primary" id="a">좋아요 <span class="badge" id="recommend"></span></button></li>
  					<li><button type="button" class="btn btn-danger" id="c">신고 <span class="badge" id="report"></span></button></li>        
				</ul>
			</div>
		</div> 
		<!--  본문, 갱신 버튼, 삭제 버튼 출력 영역 -->
		<div id="content_div">
			<div class="form-group">
				<div class="form-control" id="content">우리나라 좋은나라</div>
			</div>
			<div id="btnArea">
			</div>
		</div>
	</div>
	<div>
		<div class="form-group">
      		<label for="comment_textarea">댓글을 입력하세요</label>
      		<textarea class="form-control" rows="5" id="comment_textarea" placeholder="욕설이나 모욕적인 댓글은 삭제될 수 있습니다"></textarea>
    	</div>
    	<button type="button" class="btn btn-info" id="comment_write">
     		<span class="glyphicon glyphicon-ok"></span>댓글 작성
    	</button>
	</div>
	<hr>
	<div id="comments">
	</div>
</div>
</body>
</html>