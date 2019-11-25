<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(function() {
		// 로그아웃 처리 - 주소는 스프링 시큐리티로 설정. post로 요청해야함
		$("#logout").on("click", function(e) {
			e.preventDefault();
			$.ajax({
				url:"/moviefactory/member/logout",
				method:"post",
				success:function() {
					location.href = "/moviefactory"
				}
			})
		});
		
		// 회원 탈퇴 - 사용자 의사를 다시 확인하고 비밀번호 입력 페이지로 이동
		$("#menu_parent").on("click", "#resign", function(e) {
			//var choice = prompt('회원을 탈퇴하시겠습니까? 같은 아이디로 재가입할 수 없으며 모든 글은 삭제됩니다');
			e.preventDefault();
			$("#resignDialog").modal('show');
		});
		$("#pwdCheck").on("click", function() {
			var params = {
				password : $("#passwordCheck").val(),
				_method : "delete"
			}
			$.ajax({
				url: '/moviefactory/api/member',
				method:'post',
				data: params,
				success: function(result) {
					location.href = "/moviefactory"
				}
			})
		})
	});
</script>
</head>
<body>
<div id="nav" class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="/moviefactory">ICIA</a>
		</div>
		<ul class="nav navbar-nav" id="menu_parent">
	       	<!-- 로그인하지 않았을 때 보여줄 메뉴 -->
          	<sec:authorize access="isAnonymous()">
				<li><a href="/moviefactory/api/member/findId">아이디 찾기</a></li>
				<li><a href="/moviefactory/api/member/findPassword">비번 찾기</a></li>
				<li><a href="/moviefactory/api/member/join">회원가입</a></li>
			</sec:authorize>
			
			<!-- ROLE_USER 권한으로 로그인했을 때 보여줄 메뉴 -->
			<sec:authorize access="hasRole('ROLE_USER')">
	        	<li><a href='/moviefactory/member/user'>내 정보</a></li>
				<li><a href='/moviefactory/memo/receive'>받은 메모</a></li>
				<li><a href='/moviefactory/memo/send'>보낸 메모</a></li> /
				<sec:authorize access="!hasRole('ROLE_ADMIN')">
          			<li><a id='resign' href='#'>탈퇴</a></li>
          		</sec:authorize>
          	</sec:authorize>
          	
			<!-- ROLE_ADMIN 권한으로 로그인했을 때 보여줄 메뉴 -->
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="/moviefactory/admin/stat">통계</a></li>
	        	<li><a href="/moviefactory/admin/user/report">회원 관리</a></li>
				<li><a href="/moviefactory/admin/user/block">게시물 관리</a></li>
          	</sec:authorize>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="/moviefactory/board/list">게시판</a></li>
			<sec:authorize access="isAnonymous()">
				<li><a href="/moviefactory/member/login">로그인</a></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li><a href="#" id="logout">로그아웃</a></li>
			</sec:authorize>
    	</ul>
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="resignDialog" role="dialog">
	<div class="modal-dialog">
    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	          	<h4 class="modal-title">Modal Header</h4>
	        </div>
	        <div class="modal-body">
	        	<input type="password" name="password" id="passwordCheck" style="background-color: yellow;">
	        </div>
	        <div class="modal-footer">
	          	<button type="button" class="btn btn-default" data-dismiss="modal" id="pwdCheck" >탈퇴</button>
	        </div>
		</div>
	</div>
</div>
</body>
</html>