<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>무비팩토리 회원 회원가입</title>
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
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<script>
		location.href = "/moviefactory/system/e403";
	</script>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_USER')">
   <script>
      location.href="/moviefactory/system/e403";
   </script>
</sec:authorize>

<script>
var isUsernameAvailable=false;
var isNickNameAvailable=false;
var isEmailAvailable=false;
//프사 출력하기 : 1MB가 넘으면 업로드 거부
function loadImage() {
   var file = document.getElementById("profile").files[0];
   var maxSize = 1024*1024; // 1MB
   if(file.size>maxSize) {
      toastr.warning("사진은 1MB이하여야 합니다", "경고");
      document.getElementById("profile").value="";
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

// 1.아이디 사용여부 확인
function checkUsername() {
   /*var patt = /^[A-Za-z]+[A-Za-z0-9]{7,11}$/;*/
   var patt = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{7,11}$/;

   var username = $("#username").val();
   if(username.length==0) { 
      $("#helper_username").text("필수입력입니다").css("color","red").css("font-size","0.75em");
      isUsernameAvailable = false;
      return false;
   }
   if(!patt.test(username)) {
      $("#helper_username").text("아이디는 영숫자 8~12자입니다").css("color","red").css("font-size","0.75em");
      isUsernameAvailable = false;
      return false;
   }
   isUsernameAvailable = true;
   return true;
}

// 2. 이름을 정규식으로 확인
function checkName() {
   var patt = /^[가-힣]{2,10}$/
   var name = $("#name").val();
   if(name.length==0) {
      $("#helper_name").text("필수입력입니다").css("color","red").css("font-size","0.75em");
      return false;
   } 
   if(patt.test(name)==false) {
      $("#helper_name").text("이름은 한글 2~10자입니다").css("color","red").css("font-size","0.75em")
      return false;
   }
   $("#helper_name").text("");
   return true;
}

// 3. 비밀번호를 정규식으로 확인
function checkpassword() {
   // 특수문자를 하나이상 포함하는 8~10자 (전방탐색 이용)
   var patt = /(?=.*[!@#$%^&*])^[A-Za-z0-9!@#$%^&*]{8,10}$/;
   var password = $("#password").val();
   if(password.length==0) {
      $("#helper_password").text("필수입력입니다").css("color","red").css("font-size","0.75em");
      return false;
   }
   if(patt.test(password)==false) {
      $("#helper_password").text("비밀번호는 특수문자를 포함한 8~10자입니다").css("color","red").css("font-size","0.75em");
      return false;
   }
   $("#helper_password").text("");
   return true;
}

// 4. 비밀번호 재확인
function checkpassword2() {
   var password = $("#password").val();
   var password2 = $("#password2").val();
   if(password2.length==0) {
      $("#helper_password2").text("필수입력입니다").css("color","red").css("font-size","0.75em");
      return false;
   }
   if(password!=password2) {
      $("#helper_password2").text("비밀번호가 일치하지 않습니다").css("color","red").css("font-size","0.75em");
      return false;
   }
   $("#helper_password2").text("");
   return true;
}

// 5. 전화번호 확인
function checkTel() {
   var telPattern = /^[0-9]{10,11}$/;
   // 전화번호에 포함될 수 있는 -를 제거
   var tel = $("#tel").val().replace(/\-/g,'');
   if(tel.length==0) {
      $("#helper_tel").text("필수입력입니다").css("color","red").css("font-size","0.75em");
      return false;
   }
   if(!telPattern.test(tel)) {
      $("#helper_tel").text("정확한 전화번호를 입력해 주세요").css("color","red").css("font-size","0.75em");
      return false;
   }
   $("#helper_tel").text("");
   return true;
}

// 6. 이메일 사용여부 확인
function checkEmail() {
   var patt = /^[A-Za-z][A-Za-z0-9\.]+@[A-Za-z\.]+$/;
   var email = $("#email").val();
   if(email.length==0) {
      $("#helper_email").text("필수입력입니다").css("color","red").css("font-size", "0.75em");
      isEmailAvailable=false;
      return false;
   } 
   if(patt.test(email)==false) {
      $("#helper_email").text("이메일형식에 어긋납니다").css("color","red").css("font-size", "0.75em");
      isEmailAvailable=false;
      return false;
   }
   isEmailAvailable=true;
   return true;
}

// 7. 닉네임 사용여부 확인
function checkNick() {
	var patt = /^[가-힣]{2,10}$/;
	var nick = $("#nick").val();
	if(nick.length==0) {
		$("#helper_nick").text("필수입력입니다").css("color","red").css("font-size", "0.75em");
		isNickNameAvailable=false;
		return false;
	} 
	if(patt.test(nick)==false) {
		$("#helper_nick").text("닉네임은 한글 2~10글자 입니다").css("color","red").css("font-size", "0.75em");
		isNickNameAvailable=false;
		return false;
	}
	isNickNameAvailable=true;
	return true;
}

// 8. 우편번호 입력
function checkZipCode() {
   var zipCodePattern = /^[0-9]{5,5}$/;
   var zipCode = $("#zipCode").val();
   if(zipCode.length==0) {
      $("#helper_zipCode").text("").css("color","red").css("font-size","0.75em");
      return false;
   }
   if(!zipCodePattern.test(zipCode)) {
	      $("#helper_zipCode").text("형식이 맞지 않습니다.").css("color","red").css("font-size","0.75em");
	      return false;
	   }
   
   $("#helper_zipCode").text("");
   return true;
}

// 9. 생년월일 필수입력
function checkBirth() {
   var birthPattern = /^[0-9]{6,6}$/;
   var birth = $("#birth").val();
   if(birth.length==0) {
      $("#helper_birth").text("필수 입력입니다     ").css("color","red").css("font-size","0.75em");
      return false;
   }
   if(!birthPattern.test(birth)) {
      $("#helper_birth").text("정확한 생년월일을 입력해 주세요    ").css("color","red").css("font-size","0.75em");
      return false;
   }
   
   $("#helper_birth").text("");
   return true;
}


// 10. 성별 필수입력
function checkGender() {
   var genderPattern = /^[1-4]{1,1}$/;
   var gender = $("#gender").val();
   if(gender.length==0) {
      $("#helper_gender").text("주민번호 첫째자리까지 입력해주세요").css("color","red").css("font-size","0.75em");
      return false;
   }
   if(!genderPattern.test(gender)) {
	      $("#helper_gender").text("정확히 입력해주세요").css("color","red").css("font-size","0.75em");
	      return false;
	   }
   
   $("#helper_gender").text("");
   return true;
}


// 11. 회원 가입
function join() {
	// 사진을 포함할 수 있으므로 FormData 형식
	var formData = new FormData(document.getElementById("joinForm"));
	var result = confirm("회원가입 하시겠습니까?");
	if (result==true) {
		$.ajax({
					url:"/moviefactory/api/member/join",
					method: "post",
					processData:false,
					// multipart 지정
					contentType:false,
					data:formData,
					success:function(result, textStatus, response) {
						location.href = response.getResponseHeader('location');
					}, error:function(xhr) {
						console.log("에러 코드 :" + xhr.status);
						console.log("에러 메시지 :" + xhr.responseText);
						
					}
				})
		} else {
		return false;
	}
}

$(function() { 
	// 회원가입 페이지에 들어왔을때, 서비스 동의에 yes한 정보를 지운다
	$.ajax({
		url: "/moviefactory/api/member/clearyes",
		method: "post",
		success:function(result) {
			console.log(result)
		}, error: function(xhr) {
			console.log(xhr)
		}
	});
	// 비동기 병렬 수행(thread) -> 프로그래머가 순서 제어
	// 둘 이상의 ajax를 내가 원하는 순서대로 실행하려면 내가 순서를 통제해야 한다 

	// 1. ajax와 무관한 조건 체크. 작성한 순서대로 실행된다
	$("#profile").on("change", loadImage);
	$("#username").on("blur", function() {
		if(checkUsername()==true) {
			$.ajax({
				url: "/moviefactory/api/member/" + $("#username").val(),
				method: "get",
				success:function(result) {
					$("#helper_username").text("사용가능합니다").css("color","green").css("font-size","0.75em");
				}, error: function(xhr) {
					$("#helper_username").text("사용중인 아이디입니다").css("color","red").css("font-size","0.75em");
				}
			});
		}
	});
	$("#nick").on("blur", function() {
		if(checkNick()==true) {
			$.ajax({
				url: "/moviefactory/api/member/nick?nick=" + $("#nick").val(),
				method: "get",
				success:function(result) {
					console.log(result)
					$("#helper_nick").text("사용가능합니다").css("color","green").css("font-size","0.75em");
				}, error: function(xhr) {
					console.log(xhr)
					$("#helper_nick").text("사용중인 닉네임입니다").css("color","red").css("font-size","0.75em");
				}
			});
		}
	})
	$("#email").on("blur", function() {
		if(checkEmail()==true) {
			$.ajax({
				url: "/moviefactory/api/member/email?email=" + $("#email").val(),
				method: "get",
				success:function(result) {
					$("#helper_email").text("사용가능합니다").css("color","green").css("font-size","0.75em");
				}, error: function(xhr) {
					$("#helper_email").text("사용중인 이메일입니다").css("color","red").css("font-size","0.75em");
				}
			});
		}
	});
	$("#name").on("blur", checkName);
	$("#password").on("blur", checkpassword);
	$("#password2").on("blur", checkpassword2);
	$("#tel").on("blur", checkTel);
	$("#birth").on("blur", checkBirth);
	$("#gender").on("blur", checkGender);
	$("#zipCode").on("blur", checkZipCode);
	
	// 2. ajax 조건 체크. 작성한 순서와 무관하게 동시에 실행되므로 순서를 제어해야 한다
	$("#join").on("click", function() {
		// 다시 한번 동기 조건 체크
		if(!checkUsername() || !checkpassword() || !checkpassword2()|| !checkName() ||!checkNick()  ||  !checkEmail() || !checkZipCode()
				|| !checkTel() || !checkBirth() || !checkGender() || !isUsernameAvailable || !isNickNameAvailable || !isEmailAvailable ){
			console.log(!checkUsername());
			console.log(!checkpassword());
			console.log(!checkpassword2());
			console.log(!checkName());
			console.log(!checkNick());
			console.log(!checkEmail());
			console.log(!checkZipCode());
			console.log(!checkTel());
			console.log(!checkBirth());
			console.log(!checkGender());
			console.log(isUsernameAvailable);
			console.log(isNickNameAvailable);
			console.log(isEmailAvailable);
			return ;
		}
		join();
	});
	
});
</script>
<style>
table {
   text-align: center;
   width: 100px;
   height: 200px;
   margin: 0 auto;
   border-collapse: collapse;
}
#join, #reset {

	height: 50px;
	width: 100px;
}

p {
   font-size: 1.25em;
   font-weight: bold;
}
#p1 {
	font-size: 25pt;
	
}
#joinForm {
	margin: 0 auto;
	width : 500px;
}
</style>

</head>
<body>
	<div id="section">
		<form id="joinForm" method="post">
			<div class="form-group" >
				<legend class="text-center" id="p1"><strong>무비 팩토리 회원가입</strong></legend>
				<div>
					<label for="username">아이디</label> <span class="helper-text"
						id="helper_username"></span>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" id="username"
						maxlength="12" name="username">
				</div>

				<div>
					<label for="password">비밀번호</label> <span class="helper-text"
						id="helper_password"></span>
				</div>
				<div class="form-group">
					<input type="password" name="password" id="password" maxlength="10"
						class="form-control">
				</div>

				<div>
					<label for="password2">비밀번호 확인</label> <span class="helper-text"
						id="helper_password2"></span>
				</div>
				<div class="form-group">
					<input type="password" id="password2" maxlength="10"
						class="form-control">
				</div>

				<div>
					<label for="name">이름</label> <span class="helper-text"
						id="helper_name"></span>
				</div>
				<div class="form-group">
					<input type="text" id="name" name="name" class="form-control"
						maxlength="10">
				</div>

				<div>
					<label for="nick">닉네임</label> <span class="helper-text"
						id="helper_nick"></span>
				</div>
				<div class="form-group">
					<input type="text" id="nick" name="nick" class="form-control"
						maxlength="10">
				</div>

				<div>
					<label for="email">이메일</label> <span class="helper-text"
						id="helper_email"></span>
				</div>
				<div class="form-group">
					<input type="text" id="email" name="email" class="form-control"
						size="20" maxlength="30">
				</div>

				<div>
					<label for="zipCode">우편번호</label><span class="helper-text"
						id="helper_zipCode"></span>
				</div>
				<div class="form-group">
					<input type="text" id="zipCode" name="zipCode" class="form-control"
						size="5" maxlength="5">
				</div>

				<div>
					<label for="baseAddr">기본주소</label><span class="helper-text"
						id="helper_baseAddr"></span>
				</div>
				<div class="form-group">
					<input type="text" id="baseAddr" name="baseAddr"
						class="form-control" size="30" maxlength="300" placeholder="상세한 주소를 입력해주세요^^">
				</div>

				<div>
					<label for="tel">전화번호</label> <span class="helper-text"
						id="helper_tel"></span>
				</div>
				<div class="form-group">
					<input type="text" id="tel" name="tel" class="form-control"
						size="30" maxlength="11">
				</div>

				<div>
					<label for="birth">생년월일</label> <span class="helper-text"
						id="helper_birth"></span><span class="helper-text"
						id="helper_gender"></span>
				</div>
				<div class="form-group">
					<input type="text" id="birth" name="birth" size="6" maxlength="6">
					- <input type="text" id="gender" name="gender" size="1"
						maxlength="1">******
				</div>

				<div>
					<label for="profile">프로필 사진</label> <br> <img
						id="show_profile" height="240px">
				</div>
				<div class="form-group">
					<input id="profile" type="file" name="sajin" class="form-control"
						accept=".jpg,.jpeg,.png,.gif,.bmp" class="form-control">
				</div>

				<div>
					<label class="center">한줄소개</label>
				</div>
				<div class="form-group">
					<textarea rows="5" name="intro" id="intro" cols="70"
						placeholder="한 줄 소개를 입력해주세요^^" style = "resize : none;"></textarea>
				</div>

				<div>
					<div class="row text-center" style="width: 100%">
						<div style=" float: none; margin: 0 auto">
							<button type="reset" id="reset" class="btn btn-default" >초기화</button>
							<button id="join" class="btn btn-info"  type="button">회원가입</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>