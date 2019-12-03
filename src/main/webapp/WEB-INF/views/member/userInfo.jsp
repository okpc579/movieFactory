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
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
	//서버에서 보내온 데이터를 화면에 출력
	function printMember(member) {
		$("#show_profile1").attr("src", member.photo);
		$("#username1").text(member.username);
		$("#regDate1").text(member.regDate);
		$("#name1").text(member.name);
		$("#nick1").text(member.nick);
		$("#birth1").text(member.birth);
		$("#email1").text(member.email);
		$("#zipCode1").text(member.zipCode);
		$("#baseAddr1").text(member.baseAddr);
		$("#tel1").text(member.tel);
		$("#intro1").text(member.intro);
	}

	$(function() {
		$("#updateUser").on("click", function() {
			var result = confirm("회원정보를 수정하시겠습니까?");
			if (result == true) {
				location.href = "/moviefactory/member/userupdate" }
			else {
				return false;
			}
		});

		$("#resign2").on("click", function() {
			console.log("resign button");
			var result = confirm("정말 탈퇴 하시겠습니까? 작성한 글은 삭제되지 않습니다.");
			if (result == true) {
				$.ajax({
					url : '/moviefactory/api/member/resign',
					method : 'post',
					success : function(result) {
						alert("즐거웠습니다! 다시만날때까지 안녕히 가세요.");
						location.href = "/moviefactory"
					}
				});
			} else {
				alert("다시 생각해주셔서 감사합니다!");
				return false;
			}
		});

		// 화면출력
		$.ajax({
			url : "/moviefactory/api/member/userinfo",
			method : "get",
			success : function(result) {
				console.log(result);
				printMember(result);
			},
			error : function(xhr) {
			}
		});
		
	});
</script>
<style>
#resign2, #updateUser {

	height: 50px;
	line-height: 50px;
	width: 100px;
}
#p1 {
	font-size: 25pt;
	
}
</style>
<title>일반회원 내 정보</title>
</head>
<body>
	<div id="section">
		<form id="infoForm" action="" method="post">
			<div class="form-group">
				<p class="text-center" id="p1"><strong>♥ 무비 팩토리 회원정보 ♥</strong></p>
				<div>
					<label for="username">아이디</label>
				</div>
				<div class="form-group">
					<span id="username1"></span>
				</div>
				<div>
					<label for="regDate">가입일</label>
				</div>
				<div class="form-group">
					<span id="regDate1"></span>
				</div>
				<div>
					<label for="name">이름</label>
				</div>
				<div class="form-group">
					<span id="name1"></span>
				</div>

				<div>
					<label for="nick">닉네임</label>
				</div>
				<div class="form-group">
					<span id="nick1"></span>
				</div>

				<div>
					<label for="email">이메일</label>
				</div>
				<div class="form-group">
					<span id="email1"></span>
				</div>

				<div>
					<label for="zipCode">우편번호</label>
				</div>
				<div class="form-group">
					<span id="zipCode1"></span>
				</div>

				<div>
					<label for="baseAddr">기본주소</label>
				</div>
				<div class="form-group">
					<span id="baseAddr1"></span>
				</div>

				<div>
					<label for="tel">전화번호</label>
				</div>
				<div class="form-group">
					<span id="tel1"></span>
				</div>

				<div>
					<label for="birth">생년월일</label>
				</div>
				<div class="form-group">
					<span id="birth1"></span>
				</div>

				<div>
					<label for="profile">프로필 사진</label> <br> <img
						id="show_profile1" height="240px">
				</div>
				<div class="form-group">
				</div>

				<div>
					<label class="center">한줄소개</label>
				</div>
				<div class="form-group">
					<span id="intro1"></span>
				</div>
				<div></div>
			</div>
		</form>
		<div class="row text-center" style="width: 100%">
			<div style="width: 30%; float: none; margin: 0 auto">
				<button id="resign2" type="button" class="btn btn-default">회원탈퇴</button>
				<button id="updateUser" class="btn btn-info" type="button">정보수정</button>
			</div>
		</div>
	</div>
</body>
</html>