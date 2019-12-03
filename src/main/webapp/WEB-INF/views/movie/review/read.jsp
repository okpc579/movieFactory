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

function printData(moviereview) {
	$("#writer").text(moviereview.username);
	console.log(moviereview);
	$("#bno").text(moviereview.mrevNo);
	$("#writeDate").text(moviereview.writingDate);
	$("#recommend").text(moviereview.likeCnt);
	if(moviereview.isSpo==0){
		$("#content").text(moviereview.mrevContent);
	}else if(moviereview.own==true){
		$("#content").text(moviereview.mrevContent);
	}else{
		$("#content").text("스포일러");
	}
	// 추천수, 신고수	
	$("#content").prop("readonly", true);
	$("#a").prop("disabled", true);
	$("#c").prop("disabled", true);
	console.log($("#recommend").text());
	console.log(moviereview.likeCnt);
	console.log("=============");
	
	// 글 추천, 신고, 변경, 삭제
	// 1. 로그인이 안된 유저
	//		추천, 신고, 변경, 삭제 모두 불가능. content 편집 불가. 댓글 작성 불가
	// 2. 글의 작성자인 경우
	//		변경, 삭제 가능. content 편집 가능
	// 3. 글의 작성자가 아닌 경우
	// 		추천, 신고 가능. content 편집 불가
	
	if(isLogin==false) {
		$("#content").prop("readonly", true);
		$("#update_com").prop("readonly", true);
		$("#comment_textarea").prop("disabled", true).attr("placeholder", "로그인이 필요합니다");
		$("#comment_write").prop("disabled", true);
	} else if(isLogin==true && moviereview.own!=true) {
		$("#a").prop("disabled", false).attr("title", "좋아요");
		$("#c").prop("disabled", false).attr("title", "신고하기");
	} else if(isLogin==true && moviereview.own==true) {
		$("#content").prop("readonly", false);
		$("#update_com").prop("readonly", false);
		$("<button></button>").attr("id","btnUpdate").attr("class", "btn btn-info").css("margin","10px").text("변 경").appendTo($("#btnArea"));
		$("<button></button>").attr("id","btnDelete").attr("class", "btn btn-info").text("삭 제").appendTo($("#btnArea"));
	} 
	// 댓글 출력
	printComment();
	
}
//2. 댓글 출력

function printComment(moviereviewcomment) {
	
	if(moviereviewcomment==undefined)
		moviereviewcomment = moviereview.comments;
	console.log(moviereviewcomment);
	// 댓글을 출력할 영역(#comments)를 읽어와 초기화(출력중인 모든 댓글을 삭제)
	var $moviereviewcomment = $("#comments");
	$moviereviewcomment.empty();
		
	$.each(moviereviewcomment, function(i, comment){
		var $comment = $("<div>").appendTo($moviereviewcomment)
		var $upper_div = $("<div>").appendTo($comment);
		var $center_div = $("<div>").appendTo($comment);
		var $lower_div = $("<div>").appendTo($comment);
		console.log("===============================gggg")
		console.log(comment);
		$("<span></span>").text(comment.username).appendTo($upper_div);
		$("<img>").attr("src","/profile/" + comment.username + ".jpg").css("width","40px").appendTo($center_div);
		$("<textarea id=update_com>").text(comment.content).appendTo($center_div);
		//$("<span>").text(comment.cmntLikeCnt).appendTo(".like_commentt");
		$("<span>").text(comment.writingDate).appendTo($lower_div);
		if(comment.username==loginId) {
			var btn = $("<button>").attr("class", "delete_comment").attr("data-mrevcmntno", comment.mrevCmntNo)
				.attr("data-mRevNo", moviereview.mRevNo).attr("data-username", comment.username).text("삭제").appendTo($center_div);
			btn.css("float","right");
			var btn2 = $("<button>").attr("class", "update_comment").attr("data-mrevcmntno", comment.mrevCmntNo)
				.attr("data-mRevNo", moviereview.mRevNo).attr("data-username", comment.username).text("변경").appendTo($center_div);
			btn2.css("float","right");
		}else{
			var btn3 = $("<button>").attr("class", "like_commentt").attr("data-mrevcmntno", comment.mrevCmntNo)
				.attr("data-mRevNo", moviereview.mRevNo).attr("data-username", comment.username).text("좋아요"+comment.cmntLikeCnt).appendTo($center_div);
			btn3.css("float","right");
			var btn4 = $("<button>").attr("class", "rep_commentt").attr("data-mrevcmntno", comment.mrevCmntNo)
				.attr("data-mRevNo", moviereview.mRevNo).attr("data-username", comment.username).text("신고").appendTo($center_div);
			btn4.css("float","right");
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
			moviereview = result;
			printData(result);
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	
	// 3. 글 갱신
	$("#btnArea").on("click", "#btnUpdate", function() {
		var param = {
			mRevNo: moviereview.mrevNo,
			mRevContent: $("#content").val()
		};
		console.log(param);
		$.ajax({
			url : "/moviefactory/api/movie/review/update",
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
			mRevNo: moviereview.mrevNo
		};
		$.ajax({
			url : "/moviefactory/api/movie/review/delete/" + moviereview.mrevNo,
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
			mRevNo: moviereview.mrevNo
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
				location.reload();
			}, error: function(xhr) {
				console.log(xhr.status);
			}
		});
	});

	// 6. 글 신고
	$("#lower_right").on("click", "#c", function() {
		if(isLogin==false || moviereview.own==true)
			return;
		location.href="/moviefactory/movie/review/report?mrevno=" + mRevNo
		
	});
	// 7. 댓글 작성
	$("#comment_write").on("click", function() {
		// 비로그인이면 중단
		
		if(isLogin==false)
			return;
		
		var param = {
			mRevNo: moviereview.mrevNo,
			content: $("#comment_textarea").val()
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
				location.reload();
			}, error : function(){
				console.log(222);
			}
		});
	});
	
	// 8. 댓글 삭제
	$("#comments").on("click", ".delete_comment", function() {
		if(isLogin==false || loginId!=$(this).data("username"))
			return;
		var param = {
			_method:"delete",
			mRevCmntNo : $(this).data("mrevcmntno"),
			mRevNo : moviereview.mrevNo
		}
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/movie/comment/deletebycmntno",
			method: "post",
			data: param,
			success : function(result) {
				console.log(result);
				$("#comment_textarea").val(""); 
				printComment(result);
			}
		});
	});
	// 9. 댓글 변경
	$("#comments").on("click", ".update_comment", function() {
		if(isLogin==false || loginId!=$(this).data("username"))
			return;
		var param = {
			mRevNo : moviereview.mrevNo,	
			mRevCmntNo : $(this).data("mrevcmntno"),
			content : $("#update_com").val()
		}
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/movie/comment/update",
			method: "post",
			data: param,
			success : function(result) {
				console.log(result);
				$("#comment_textarea").val(""); 
				printComment(result);
				location.reload();
			}
		});
	});
	// 10. 댓글 좋아요
	$("#comments").on("click", ".like_commentt", function() {
		console.log("====================")
		// 비로그인이거나 글쓴 사람 본인이면 추천 금지
		if(isLogin==false || loginId==$(this).data("username"))
			return;
		var param = {
			_method: "patch",
			mRevCmntNo : $(this).data("mrevcmntno"),
		};
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/movie/comment/like",
			method: "post",
			data: param,
			success : function(result) {
				// 추천에 성공한 경우 서버에서 새로운 추천수를 보내주므로 출력
				console.log(result);
				$("#recommend").text(result);
				location.reload();
			}, error: function(xhr) {
				console.log(xhr.status);
			}
		});
	});
	6. // 댓글 신고
	$("#comments").on("click", ".rep_commentt", function() {
		var mRevCmntNo = $(this).data("mrevcmntno");
		console.log(mRevCmntNo);
		if(isLogin==false || moviereview.own==true)
			return;
		console.log("===들어옴===")
		location.href="/moviefactory/movie/review/cmntreport?mRevCmntNo=" + mRevCmntNo 
		
	});
})
</script>
</head>
<body>
<div id="section">
	<div>
		<div id="title_div">
			<input type="hidden" name="mRevNo" id="mRevNo" val="">
			<div id="upper">
				<span id="writer"></span>
			</div>
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
				<textarea class="form-control" id="content"></textarea>
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