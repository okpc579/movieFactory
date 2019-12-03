<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 읽기</title>
<link rel="icon" type="image/png" href="http://example.com/myicon.png">
<style>

</style>
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
	var adminAsk;
	
	// 답변 완료 전 후로 나뉘는 기능
	function adminaskList(page){
		var adminAskStateContent = adminAsk.AskStateContent;
	}
	
	
	// 1. 글 출력
	function adminaskData(adminAsk) {
		// 작성자, 제목, 글번호, 작성날짜, 글내용 출력
		$("#title").text(adminAsk.title);
		$("#askStateContent").text(adminAsk.askStateContent);
		$("#username").text(adminAsk.username);
		$("#adminAskNo").text(adminAsk.adminAskNo);
		$("#writingDate").text(adminAsk.writingDate);
		$("#content").text(adminAsk.content);
		$("#askAnswer").text(adminAsk.askAnswer);
		// 로그인 을 해야 자신의 문의목록을 볼수있다
		// 답글출력
		printAskAnswer();
	}

	// 2. 답글 출력
	function printAskAnswer(AskAnswers) {
		if (AskAnswers == undefined)
			AskAnswers = adminAsk.askAnswer;

		// 답글을 출력할 영역(#askAnswer)를 읽어와 초기화(출력중인 모든 댓글을 삭제)
		var $askAnswer = $("#askAnswer");
		$askAnswer.empty();

		$.each(AskAnswers, function(i, askAnswer) {
			console.log(askAnswer);
			var $upper_div = $("<div>").appendTo($askAnswer);
			var $askAnswer_div = $("<div>").appendTo($askAnswer);
			var $lower_div = $("<div>").appendTo($askAnswer);
			var btn = $("<button>").attr("class", "delete_askAnswer").attr(
					"adminAskNo", adminAsk.adminAskNo)
					.attr("username", adminAsk.username).text("삭제").appendTo(
					$askAnswer_div);
			btn.css("float", "right");
			$("<hr>").appendTo($askAnswer);
		});
	}

	// 답글을 포함한 게시글을 읽어온다
		$(function() {
			var adminAskNo = location.search.substr(12);
			$.ajax({
				url : "/moviefactory/api/adminAsk/read?adminAskNo=" + adminAskNo,
				method : "get",
				success : function(result) {
					adminAsk = result;
					if(adminAsk.askAnswer==null){
						adminAsk = result;
						$("#title").text(adminAsk.title);
						$("#username").text(adminAsk.username);
						$("#adminAskNo").text(adminAsk.adminAskNo);
						$("#askStateContent").text(adminAsk.askStateContent);
						$("#writingDate").text(adminAsk.writingDate);
						$("#content").text(adminAsk.content);
						$("#askAnswer").text(adminAsk.askAnswer);
						adminaskData(adminAsk);	
					}else{
						console.log(result);
						$("#title").text(adminAsk.title);
						$("#username").text(adminAsk.username);
						$("#adminAskNo").text(adminAsk.adminAskNo);
						$("#askStateContent").text(adminAsk.askStateContent);
						$("#writingDate").text(adminAsk.writingDate);
						$("#content").text(adminAsk.content);
						$("#askAnswer").text(adminAsk.askAnswer);
					}
				}
			});

		// 3. 글 수정
		$("#adminAsk_updateStart").on("click", function() {
			$("#content").text("");
			$("<textarea></textarea>").val(adminAsk.content).appendTo("#content").attr("class","form-control").attr("id","content_update");
				console.log(adminAsk.content);
		});
		
		$("#adminAsk_updateEnd").on("click", function(){
				var param =
					{
						adminAskNo : adminAsk.adminAskNo,
						content : $("#content_update").val()
					};
				//console.log(param);
				$.ajax({
					url : "/moviefactory/api/adminAsk/update",
					method : "post",
					data : param,
					success : function(result){
						location.href = "/moviefactory/adminAsk/read?adminAskNo=" + adminAskNo;
					},error : function(xhr) {
						console.log(xhr.status);
					}
				})
		});
		// 4. 글 삭제 
		$("#adminAsk_delete").on("click", function() {
			var param = {
				_method : "delete",
			};
			$.ajax({
				url : "/moviefactory/api/adminAsk/delete?adminAskNo=" + adminAskNo,
				method : "post",
				data : param,
				success : function(result, xhr) {
					location.href = "/moviefactory/adminAsk/listuser";
				},
				error : function(xhr) {
					console.log("삭제에 실패했습니다");
				}
			});
		});

		// 7. 답글 작성
		$("#askAnswer_write").on("click", function() {
			var param = {
					adminAskNo : $("#adminAskNo").text(),
					title : $("#title").text(),
					content : $("#content").text(),
					askAnswer : $("#askAnswer_textarea").val()
			}
			console.log(param);
			$.ajax({
				url : "/moviefactory/api/adminAsk/askAnswer?adminAskNo=" + adminAskNo,
				method : "post",
				data : param,
				success : function(result) {
					location.href = "/moviefactory/adminAsk/read?adminAskNo=" + adminAskNo;
				},error : function(xhr) {
					console.log("작성을 실패했습니다");
				}
			});
		});
	});
</script>
<body>
<div id="section">
	<div id="reading">
		<div>
			<div id="title_div">
				<!-- 제목, 작성자 출력 영역 -->
				<div id="upper_div">
					제목:<span id="title"></span><br>
					아이디:<span id="username"></span><br>
					문의상태:<span id="askStateContent"></span>
				</div>
				<!-- 글번호, 작성일 출력 영역 -->
				<div id="lower_div">
					<ul id="lower_left">
						<li>글번호:<span id="adminAskNo"></span></li>
						<li>날짜:<span id="writingDate"></span></li>
					</ul>
				</div>
			</div>
			<!--  본문, 갱신 버튼, 삭제 버튼 출력 영역 -->
			<div id="content_div">
				<div class="form-group">
					<div id="content" class="form-control" rows="10" cols="100" name="content" >
					</div>
				</div>
			</div>
		</div>
		<hr>
		<div class="form-control" id="askAnswer" cols="100" rows="10"></div>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
		<div id="askAnswer_input">
			<div class="form-group">
				<label for="askAnswer">답글을 입력하세요</label>
				<textarea class="form-control" rows="5" id="askAnswer_textarea"
					placeholder="답글" name="askAnswer"></textarea>
			</div>
			<button type="button" class="btn btn-info" id="askAnswer_write">
				<span class="glyphicon glyphicon-ok"></span>답글완료
			</button>
		</div>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_USER')">
		<div id="btnArea">
		<br>
			<div id="update">
				<c:set var="askStateContent" value='답변전'/>
				<c:choose> 
    				<c:when test="${askStateContent eq '답변전'}">
						<button type="button" class="btn btn-info" id="adminAsk_updateStart">수정하기</button>
						<button type="button" class="btn btn-info" id="adminAsk_updateEnd">수정완료</button>
						<button type="button" class="btn btn-info" id="adminAsk_delete">삭제하기</button>					
					</c:when>
					<c:when test="${askStateContent eq '답변완료'}">
						<button type="button" class="btn btn-info" id="adminAsk_delete">삭제하기</button>
					</c:when>
				</c:choose>
			</div>
		</div>
		</sec:authorize>
	</div>
	</div>
</body>
</html>