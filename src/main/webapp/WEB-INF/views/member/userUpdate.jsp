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
var isNickNameAvailable=false;
var isEmailAvailable=false;
var mmmmmmm;

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
		mmmmmmm = member;
		$("#pwdArea").hide();
		$("#show_profile1").attr("src", member.photo);
		$("#username1").text(member.username);
		$("#name1").text(member.name);
		$("#nick1").text(member.nick);
		$("#nick").val(member.nick);
		$("#birth1").text(member.birth);
		$("#regDate1").text(member.regDate);
		$("#email1").text(member.email);
		$("#email").val(member.email);
		$("#zipCode1").text(member.zipCode);
		$("#zipCode").val(member.zipCode);
		$("#baseAddr1").text(member.baseAddr);
		$("#baseAddr").val(member.baseAddr);
		$("#tel1").text(member.tel);
		$("#tel").val(member.tel);
		$("#intro1").text(member.intro);
		$("#intro").val(member.intro);
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
		if($("#email").val() == ""){
			$("#helper_email").text("");
			return false;
		}
		if (patt.test(email) == false ) {
			console.log("이메일 형식이 틀렸다")
			$("#helper_email").text("이메일형식에 어긋납니다").css("color", "red").css("font-size", "0.75em");
			 isEmailAvailable=false;
			return false;
		}
		if(email == mmmmmmm.email){
			console.log("이메일 형식이 맞다")
			$("#helper_email").text("");
		}
		 isEmailAvailable=true;
		return true;
	}

	// 닉네임 사용여부 확인
	function checkNick() {
		var patt = /^[가-힣]{2,10}$/;
		var nick = $("#nick").val(); 
		if($("#nick").val() == ""){
			$("#helper_nick").text("");
			return false;
		}
		if (patt.test(nick) == false) {
			console.log("닉네임 형식이 틀렸다")
			$("#helper_nick").text("닉네임은 한글 2~10글자 입니다").css("color", "red").css("font-size", "0.75em");
			isNickNameAvailable=false;
			return false;
		}
		if(nick == mmmmmmm.nick){
			console.log("닉네임 형식이 맞다")
			$("#helper_nick").text("");
		}
		isNickNameAvailable=true;
		return true;
	}

	// 전화번호 확인
	function checkTel() {
		var telPattern = /^[0-9]{10,11}$/;
		// 전화번호에 포함될 수 있는 -를 제거
		var tel = $("#tel").val().replace(/\-/g, '');
		if (!telPattern.test(tel)) {
			$("#helper_tel").text("정확한 전화번호를 입력해 주세요").css("color", "red").css("font-size", "0.75em");
			return false;
		}
		$("#helper_tel").text("");
		return true;
	}
	
	// 우편번호 입력
	function checkZipCode() {
	   var zipCodePattern = /^[0-9]{5,5}$/;
	   var zipCode = $("#zipCode").val();
	   if(!zipCodePattern.test(zipCode)) {
		      $("#helper_zipCode").text("형식이 맞지 않습니다.").css("color","red").css("font-size","0.75em");
		      return false;
		   }
	   $("#helper_zipCode").text("");
	   return true;
	}
	
	// 사용 가능 여부  
	$(function () {
		$("#nick").on("blur",function() {
					if (checkNick() == true) {
						if($("#nick").val() == mmmmmmm.nick){
							return false;
						}
						$.ajax({
							url : "/moviefactory/api/member/nick?nick="
									+ $("#nick").val(),
							method : "get",
							success : function(result) {
								$("#helper_nick").text("사용가능합니다").css("color",
										"green").css("font-size", "0.75em");
								isNickNameAvailable=true;
								
							},
							error : function(xhr) {
								console.log(xhr)
								$("#helper_nick").text("사용중인 닉네임입니다").css(
										"color", "red").css("font-size",
										"0.75em").attr("data-pass", "true");
								isNickNameAvailable=false;		// 여기는 왜 isEmailAvailable=false; 이게 없어여??
							}
						});
					}
				})
		
		$("#email").on("blur",function() {
					if (checkEmail() == true) {
						if($("#email").val() == mmmmmmm.email){
							return false;
						}
						$.ajax({
							url : "/moviefactory/api/member/email?email="
									+ $("#email").val(),
							method : "get",
							success : function(result) {
								$("#helper_email").text("사용가능합니다").css("color",
										"green").css("font-size", "0.75em");
								isEmailAvailable=true;
							},
							error : function(xhr) {
								console.log(xhr)
								$("#helper_email").text("사용중인 이메일입니다").css(
										"color", "red").css("font-size",
										"0.75em").attr("data-pass", "true");
								isEmailAvailable=false;
								isNickNameAvailable=false;	// 여기는 얘가 있는데
							}
						});
					}
				});
				
		$("#zipCode").on("blur", checkZipCode);		
		$("#tel").on("blur", checkTel);
		
	})
	
	
	// 비밀번호 관련 동작
	$(function() {
		// 비밀번호 변경 화면 보이기
		$("#activateChangePwd").on("click", function() {
			$("#pwdArea").toggle();
		});
		
		// 비밀번호 변경 버튼을 클릭한 경우 ajax 처리
		$("#changePwd").on("click", function() {
			var password = $("#password").val();
			var newPassword = $("#newPassword");
			var newPassword2 = $("#newPassword2");
			// 특수문자를 하나이상 포함하는 8~10자 (전방탐색 이용)
			var patt = /(?=.*[!@#$%^&*])^[A-Za-z0-9!@#$%^&*]{8,10}$/;
			
			if(patt.test(password)==false) {
    			  $("#helper_password").text("현재 비밀번호를 입력해주세요.").css("color","red").css("font-size","0.75em");;
    		  	return false;
   			}			
   			
			// 새 비밀번호 정규식 확인
			if(!patt.test(newPassword.val())) {
				$("#helper_newpassword").text("새 비밀번호를 입력해주세요.").css("color","red").css("font-size","0.75em");;
				toastr.error("새 비밀번호는 특수문자를 포함하는 영숫자 8~10자입니다"); 
				newPassword.val("");
				newPassword2.val(""); 
				return;
			}
			
			// 새 비밀번호 일치 확인
			if(newPassword.val()!=newPassword2.val()) {
				newPassword.val("");
				newPassword2.attr("placeholder", "새 비밀번호가 일치하지 않습니다");
				return;
			}
			var param = {
				_method:"patch",
				password: $("#password").val(),
				newPassword: newPassword.val(),
			};
			
			$.ajax({
				url: "/moviefactory/api/member/newpassword",
				method: "post",
				data:param,
				success: function() {
					$("#myFrm").submit();
					console.log("ffffff");
					location.reload();
					alert('비밀번호를 변경하였습니다.');
				}, error: function(xhr) {
					console.log(xhr.status);
					location.reload();
					alert('비밀번호변경에 실패했습니다.');

				}
			})
		});
	})
	
	
	// 업데이트 버튼 
	$(function() {	
		// 사진변경 
		$("#sajin").on("change", loadImage);
		
		// 변경 버튼을 클릭한 경우 ajax 처리
		$("#updateEnd").on("click", function() {
			var formData = new FormData();
			
			if($("#nick").val() == "" || $("#nick").val() == mmmmmmm.nick ){
				$("#nick").val(mmmmmmm.nick);
				isNickNameAvailable = true;
			}
			if($("#email").val() == "" || $("#email").val() == mmmmmmm.email){
				$("#email").val(mmmmmmm.email);
				isEmailAvailable = true;
			}
			if(isEmailAvailable == false || isNickNameAvailable == false || !checkZipCode()
					|| !checkTel() ){
				return false;
			}
			
			formData.append("nick", $("#nick").val());
			formData.append("email", $("#email").val());
			formData.append("zipCode", $("#zipCode").val());
			formData.append("baseAddr", $("#baseAddr").val());
			formData.append("tel", $("#tel").val());
			formData.append("intro", $("#intro").val());
			
			if(document.getElementById("sajin").files[0]!=undefined)
				formData.append("sajin", document.getElementById("sajin").files[0]);
			
			for (var key of formData.keys()) {
				console.log(key);
			}
			for(var value of formData.values()) {
				console.log(value);
			}
			var result = confirm("회원정보를 수정하시겠습니까?");
			if (result == true) {
				console.log("수정완료");
				$.ajax({
					url: "/moviefactory/api/member/userupdate",
					method: "post",
					data : formData,
					processData: false,
					contentType: false,
					success:function() {
						toastr.success("정보를 변경했습니다", "서버 메시지");
						location.href = "/moviefactory/member/userinfo"
					}, error: function() {
					
					}
				});
				
			 }
			else {
				console.log("수정안해줌 ㅎㅎㅎ");
				return false;
			}		
		});
	});
</script>
<style>
#updateEnd, #changePwd, #activateChangePwd {
	height: 50px;
	line-height: 50px;
	width: 100px;
	magin : 0 auto;
}
#activateChangePwd {
	padding : 0 0 2px 0;
}
#p1 {
	font-size: 25pt;
	
}
</style>
<title>일반회원 내 정보수정</title>
</head>
<body>
	<div id="wrap">
		<form id="updateForm" action="" method="post">
			<div class="form-group">
				<p class="text-center" id="p1"><strong>♥ 무비 팩토리 정보수정 ♥</strong></p>
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
				<button type="button" class="btn btn-info" id="activateChangePwd">비밀번호<br>수정</button>
				
				<form action="/moviefactory/member/newpassword" method="post" id="myFrm">
					<div id="pwdArea" class="form-group">
					<br>
						<span class="key">현재 비밀번호 : </span><span class="helper-text"
							id="helper_password"></span> <input type="password" id="password"
							class="form-control" name="password"> <span class="key">새
							비밀번호 : </span><span class="helper-text"
							id="helper_newpassword"></span> <input type="password" id="newPassword"
							name="newPassword" class="form-control"> <span
							class="key">새 비밀번호 확인 :</span><span class="helper-text"
							id="helper_newpassword2"></span> <input type="password"
							id="newPassword2" class="form-control"> <br>
						<button type="button" class="btn btn-info" id="changePwd">변경</button>
					</div>
				</form>

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
						value="" name="nick" class="form-control" maxlength="10">
				</div>

				<div>
					<label for="email">이메일</label><span class="helper-text"
						id="helper_email"></span>
				</div>
				<div class="form-group">
					<span id="email1"></span><br> <input type="text" id="email"
						value="" name="email" class="form-control" size="20"
						maxlength="30">
				</div>

				<div>
					<label for="zipCode">우편번호</label><span class="helper-text"
						id="helper_zipCode"></span>
				</div>
				<div class="form-group">
					<span id="zipCode1"></span><br> <input type="text" value=""
						id="zipCode" name="zipCode" class="form-control" size="5"
						maxlength="5">
				</div>

				<div>
					<label for="baseAddr">기본주소</label><span class="helper-text"
						id="helper_baseAddr"></span>
				</div>
				<div class="form-group">
					<span id="baseAddr1"></span><br> <input type="text" value=""
						id="baseAddr" name="baseAddr" class="form-control" size="30"
						maxlength="300">
				</div>

				<div>
					<label for="tel">전화번호</label><span class="helper-text"
						id="helper_tel"></span>
				</div>
				<div class="form-group">
					<span id="tel1"></span><br> <input type="text" id="tel"
						value="" name="tel" class="form-control" size="30" maxlength="11">
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
						placeholder="한 줄 소개를 입력해주세요^^" value=""></textarea>
				</div>
				<div></div>
			</div>
			<div class="row text-center" style="width: 100%">
				<div style="width: 30%; float: none; margin: 0 auto">
					<button id="updateEnd" class="btn btn-info" type="button">수정완료</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>