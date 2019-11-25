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
<sec:authorize access="hasRole('ROLE_USER')">
</sec:authorize>
<script>
	//프사 출력하기 : 1MB가 넘으면 업로드 거부
	function loadImage() {
		var file = document.getElementById("profile").files[0];
		var maxSize = 1024 * 1024; // 1MB
		if (file.size > maxSize) {
			toastr.warning("사진은 1MB이하여야 합니다", "경고");
			document.getElementById("profile").value = "";
			return false;
		}

		// 이하 하드디스크에 있는 이미지 파일을 로딩해 화면에 출력하는 코드
		var url = window.URL || window.webkitURL;
		var img = new Image();

		img.src = url.createObjectURL(file);

		var reader = new FileReader();
		reader.onload = function(e) {
			$("#show_profile").attr("src", e.target.result);
		}
		reader.readAsDataURL(file);
		return true;
	}

	//서버에서 보내온 데이터를 화면에 출력
	function printMember(member) {
		$("#pwdArea").hide();
		$("#show_profile1").attr("src", member.photo);
		$("#username1").text(member.username);
		$("#name1").text(member.name);
		$("#nick1").text(member.nick);
		$("#birth1").text(member.birth);
		$("#regDate1").text(member.regDate);
		$("#email1").text(member.email);
		$("#zipCode1").text(member.zipCode);
		$("#baseAddr1").text(member.baseAddr);
		$("#tel1").text(member.tel);
		$("#intro1").text(member.intro);
	}
	// 정보출력
	$(function() {
		$.ajax({
			url : "/moviefactory/api/member/userinfo",
			method : "get",
			success : function(result) {
				printMember(result);
			},
			error : function(xhr) {
			}
		});
	});

	// 이메일 사용여부 확인
	function checkEmail() {
		var patt = /^[A-Za-z][A-Za-z0-9\.]+@[A-Za-z\.]+$/;
		var email = $("#email").val();
		if (patt.test(email) == false) {
			$("#helper_email").text("이메일형식에 어긋납니다").css("color", "red").css(
					"font-size", "0.75em");
			return false;
		}
		return true;
	}

	// 닉네임 사용여부 확인
	function checkNick() {
		var patt = /^[가-힣]{2,10}$/;
		var nick = $("#nick").val();
		if (patt.test(nick) == false) {
			$("#helper_nick").text("닉네임은 한글 2~10글자 입니다").css("color", "red")
					.css("font-size", "0.75em");
			return false;
		}
		return true;
	}

	// 전화번호 확인
	function checkTel() {
		var telPattern = /^[0-9]{10,11}$/;
		// 전화번호에 포함될 수 있는 -를 제거
		var tel = $("#tel").val().replace(/\-/g, '');
		if (!telPattern.test(tel)) {
			$("#helper_tel").text("정확한 전화번호를 입력해 주세요").css("color", "red").css(
					"font-size", "0.75em");
			return false;
		}
		$("#helper_tel").text("");
		return true;
	}

	// 사용가능여부
	$(function() {		
		$("#email").on(
				"blur",
				function() {
					if (checkEmail() == true) {
						$.ajax({
							url : "/moviefactory/api/member/email?email="
									+ $("#email").val(),
							method : "get",
							success : function(result) {
								$("#helper_email").text("사용가능합니다").css("color",
										"green").css("font-size", "0.75em");
							},
							error : function(xhr) {
								$("#helper_email").text("사용중인 이메일입니다").css(
										"color", "red").css("font-size",
										"0.75em").attr("data-pass", "true");
							}
						});
					}
				});

		$("#nick").on(
				"blur",
				function() {
					if (checkNick() == true) {

						$.ajax({
							url : "/moviefactory/api/member/nick?nick="
									+ $("#nick").val(),
							method : "get",
							success : function(result) {
								$("#helper_nick").text("사용가능합니다").css("color",
										"green").css("font-size", "0.75em");
							},
							error : function(xhr) {
								console.log(xhr)
								$("#helper_nick").text("사용중인 닉네임입니다").css(
										"color", "red").css("font-size",
										"0.75em").attr("data-pass", "true");
							}
						});
					}
				})
				
				
		$("#tel").on("blur", checkTel);

		$("#sajin").on("change", loadImage);
		
		// 비밀번호 변경 화면 보이기
		$("#activateChangePwd").on("click", function() {
			$("#pwdArea").toggle();
		});
		
		// 비밀번호 변경 버튼을 클릭한 경우 ajax 처리
		$("#changePwd").on("click", function() {
			var newPwd = $("#newPwd");
			var newPwd2 = $("#newPwd2");
			var regexp = /^(?=.*[!@#$%^&*])[0-9A-Za-z!@#$%^&*]{8,10}/;
			// 정규식 확인
			if(!regexp.test(newPwd.val())) {
				toastr.error("비밀번호는 특수문자를 포함하는 영숫자 8~10자입니다")
				newPwd.val("");
				newPwd2.val("");
				return;
			}	
			// 비밀번호 일치 확인
			else if(newPwd.val()!=newPwd2.val()) {
				newPwd2.val("");
				newPwd2.attr("placeholder", "비밀번호가 일치하지 않습니다");
				return;
			}
			var param = {
				_method:"patch",
				pwd: $("#pwd").val(),
				newPwd: newPwd.val(),
			};
			$.ajax({
				url: "/moviefactory/api/member/newpassword",
				method: "post",
				data:param,
				success: function() {
					console.log("ffffff");
					alert('비밀번호를 변경하였습니다.');
					toastr.success("비밀번호를 변경했습니다.", '서버 메시지');
				}, error: function(xhr) {
					console.log(xhr.status);
					alert('비밀번호를 다시 확인해 주세요.');
					toastr.error("비밀번호 변경에 실패했습니다.", '서버 메시지');
				}
			})
		});
		
		// 변경 버튼을 클릭한 경우 ajax 처리
		$("#updateEnd").on("click", function() {
			
			// 파일 업로드를 해야하므로 FormData로 변경
			var formData = new FormData();
			
			// join.jsp에서는 <form>을 바로 FormData로 변경했다
			// 하지만 이부분에서는 비밀번호나 프사가 있을 수도 없을 수도 있으므로 바로 변경할 수 없다
			// <input>의 값을 하나씩 append할 경우 한글이 깨진다
			// 이 문제를 해결하려면 자바스크립트에서 UTF-8로 인코딩해서 보내고 스프링에서 디코딩해야 한다
			//formData.append("username", $("#username").text())
			formData.append("nick", $("#nick").val());
			formData.append("email", $("#email").val());
			formData.append("zipCode", $("#zipCode").val());
			formData.append("baseAddr", $("#baseAddr").val());
			formData.append("tel", $("#tel").val());
			formData.append("intro", $("#intro").val());
			
			// 프사는 <img id='show_profile'>로 출력
			// 프사 변경은 <input id='profile'>로 선택
			if(document.getElementById("sajin").files[0]!=undefined)
				formData.append("sajin", document.getElementById("sajin").files[0]);
			
			for (var key of formData.keys()) {
				console.log(key);
			}
			for(var value of formData.values()) {
				console.log(value);
			}
			$.ajax({
				url: "/moviefactory/api/member/userupdate",
				method: "post",
				data : formData,
				processData: false,
				contentType: false,
				success:function(result) {
					var result = confirm("회원정보를 수정하시겠습니까?");
					if (result == true) {
						toastr.success("정보를 변경했습니다", "서버 메시지");
						location.href = "/moviefactory/member/userinfo" }
					else {
						return false;
					}
				}, error: function() {
				
				}
			});
		});
	})
	
	
	
	
</script>
<title>일반회원 내 정보</title>
</head>
<body>
	<div id="wrap">
		<form id="updateForm" action="" method="post">
			<div class="form-group">
				<p class="text-center">♥무비 팩토리 정보수정♥</p>
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
					<label for="password">※비밀번호 수정은 수정버튼과 변경버튼을 눌러야 가능합니다.</label>
				</div>
				<button type="button" class="btn btn-info" id="activateChangePwd">비밀번호
					수정</button>
				<div id="pwdArea" class="form-group">
					<span class="key">현재 비밀번호 : </span><input type="password" id="pwd" class="form-control">
					<span class="key">새 비밀번호 : </span><input type="password"
						id="newPwd" class="form-control"> <span class="key">새 비밀번호 확인 :
					</span><input type="password" id="newPwd2" class="form-control">
					<br>
					<button type="button" class="btn btn-info" id="changePwd">변경</button>
				</div>

				<div>
					<label for="name">이름</label>
				</div>
				<div class="form-group">
					<span id="name1"></span>
				</div>

				<div>
					<label for="nick">닉네임</label><span class="helper-text"
						id="helper_nick"></span>
				</div>
				<div class="form-group">
					<span id="nick1"></span><br> <input type="text" id="nick"
						name="nick" class="form-control" maxlength="10">
				</div>

				<div>
					<label for="email">이메일</label><span class="helper-text"
						id="helper_email"></span>
				</div>
				<div class="form-group">
					<span id="email1"></span><br> <input type="text" id="email"
						name="email" class="form-control" size="20" maxlength="30">
				</div>

				<div>
					<label for="zipCode">우편번호</label><span class="helper-text"
						id="helper_zipCode"></span>
				</div>
				<div class="form-group">
					<span id="zipCode1"></span><br> <input type="text"
						id="zipCode" name="zipCode" class="form-control" size="5"
						maxlength="5">
				</div>

				<div>
					<label for="baseAddr">기본주소</label><span class="helper-text"
						id="helper_baseAddr"></span>
				</div>
				<div class="form-group">
					<span id="baseAddr1"></span><br> <input type="text"
						id="baseAddr" name="baseAddr" class="form-control" size="30"
						maxlength="300">
				</div>

				<div>
					<label for="tel">전화번호</label><span class="helper-text"
						id="helper_tel"></span>
				</div>
				<div class="form-group">
					<span id="tel1"></span><br> <input type="text" id="tel"
						name="tel" class="form-control" size="30" maxlength="11">
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
					<br> <input type="file" name="sajin" id="sajin">
				</div>

				<div>
					<label class="center">한줄소개</label>
				</div>
				<div class="form-group">
					<span id="intro1"></span><br>
					<textarea rows="5" name="intro" id="intro" cols="100"
						placeholder="한 줄 소개를 입력해주세요^^"></textarea>
				</div>
				<div></div>
			</div>
			<div class="row text-center" style="width: 100%">
				<div style="width: 30%; float: none; margin: 0 auto">
					<button type="reset" id="updateReset" class="center">초기화</button>
					<button id="updateEnd" class="center" type="button">수정완료</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>