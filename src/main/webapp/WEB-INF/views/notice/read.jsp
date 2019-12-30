<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 읽기</title>
<link rel="icon" type="image/png" href="http://example.com/myicon.png">
</head>
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
	// read.jsp의 모든 자바스크립트 기능에서 adminAsk가 필요 -> 변수로 따로 뺀다 
	var notice;

	// 1. 글 출력
	function noticeData(notice) {
		console.log(notice)
		// 작성자, 제목, 글번호, 작성날짜, 글내용 출력
		$("#title").text(notice.title);
		$("#noticeNo").text(notice.noticeNo);
		$("#writingDate").text(notice.writingDate);
		$("#content").text(notice.content);
	}
	// "/moviefactory/api/notice/read?noticeNo=" + noticeNo,
	// 답글을 포함한 게시글을 읽어온다
	$(function() {
		var noticeNo = location.search.substr(10);
		$.ajax({
			url : "/moviefactory/api/notice/read?noticeNo=" + noticeNo,
			method : "get",
			success : function(result) {
				$("#notice_updateEnd").hide();
				notice = result;
				console.log(notice);
				$("#title").text(notice.title);
				$("#noticeNo").text(notice.noticeNo);
				$("#writingDate").text(notice.writingDate);
				$("#content").text(notice.content);
				noticeData(result);
			}
		});

		// 3. 글 수정
		$("#notice_updateStart").on(
				"click",
				function() {
					$("#notice_updateEnd").show(); // 수정하기 버튼을 눌럿을때 수정완료 버튼 뜨기
					$("#notice_updateStart").hide(); // 수정하기 버튼 눌렀을때 수정하기버튼 사라지게 하기
					$("#content").hide();
					$("<textarea></textarea>").val(notice.content)
					.appendTo("#content_div").attr("id","content_update");
				});

		$("#notice_updateEnd")
				.on(
						"click",
						function() {
							var param = {
								noticeNo : notice.noticeNo,
								content : $("#content_update").val()
							};
							//console.log(param);
							$
									.ajax({
										url : "/moviefactory/api/notice/update",
										method : "post",
										data : param,
										success : function(result) {
											location.href = "/moviefactory/notice/read?noticeNo="
													+ noticeNo;
										},
										error : function(xhr) {
											console.log(xhr.status);
										}
									})
						});
		// 4. 글 삭제 
		$("#notice_delete").on("click", function() {
			var result = confirm("삭제하시겠습니까?");
			var param = {
				_method : "delete",
			};
			if (result == true) {	
			$.ajax({
				url : "/moviefactory/api/notice/delete?noticeNo=" + noticeNo,
				method : "post",
				data : param,
				success : function(result, xhr) {
					location.href = "/moviefactory/notice/list";
				},
				error : function(xhr) {
					console.log("삭제에 실패했습니다");
				}
			});
			}else{
				return false;
			}
		});
	});
</script>
<style>
#h3{
	background-color: #4ABFD3;
	height: 60px;
	color: #FFFFFF;
	padding-left: 30px;
}
#h3 h3{
	line-height: 60px;
}
#content{
	width: 100%;
  height: 150px;
  padding: 12px 20px;
  box-sizing: border-box;
  border: 2px solid #ccc;
  border-radius: 4px;
  background-color: #f8f8f8;
  font-size: 16px;
  resize: none;
}
textarea {
  width: 100%;
  height: 150px;
  padding: 12px 20px;
  box-sizing: border-box;
  border: 2px solid #ccc;
  border-radius: 4px;
  background-color: #f8f8f8;
  font-size: 16px;
  resize: none;
}
</style>
<body>
	<div id="section">
		<div>
			<h2>
				<a href="http://localhost:8080/moviefactory/notice/list">공지사항 게시판</a>
			</h2>
		</div>
		<div id="h3">
			<h3 style="margin-bottom: 0px;">공지사항 확인</h3>
		</div>
		<div id="reading">
			<div>
				<!-- 글번호, 작성일 출력 영역 -->
				<div id="title_wrap">
					<br>
					<div>
						<p><strong>제목 : </strong><span id="title"></span></p>
					</div>
					<div>
						<strong>날짜 : </strong><span id="writingDate"></span>
					</div>
				</div>
				<br>
				<div></div>
				<!--  본문, 갱신 버튼, 삭제 버튼 출력 영역 -->
				<div id="content_div">
					<div>
						<p>
							<strong>내용</strong>
						</p>
						<textarea readonly="readonly" id="content" rows="10" cols="100" name="content">
						</textarea>
					</div>
				</div>
			</div>
			<hr>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div id="btnArea">
					<br>
					<button type="button" class="btn btn-primary"
						id="notice_updateStart">수정</button>
					<button type="button" class="btn btn-primary" id="notice_updateEnd">수정완료</button>
					<button type="button" class="btn btn-primary" id="notice_delete">삭제하기</button>
				</div>
			</sec:authorize>
		</div>
	</div>
</body>
</html>