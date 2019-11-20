<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<title>Insert title here</title>

</head>
<body>
<div id="wrap">
	<div>
		<div id="title_div">
			<!-- 제목, 작성자 출력 영역 -->
			<div id="">
				<span id=""></span>
			</div>
			<!-- 글번호, 작성일, 아이피, 추천수, 조회수, 신고수 출력 영역 -->
			<div id="">
				<ul id="">
					<li>리뷰번호<span id=""></span></li>
					<li><span id=""></span></li>
				</ul>
				<ul id="lower_right">
					<li><button type="button" class="btn btn-primary" id="a">좋아요<span class="badge" id=""></span></button></li>
  					<li><button type="button" class="btn btn-danger" id="c">신고 <span class="badge" id=""></span></button></li>        
				</ul>
			</div>
		</div> 
		<!--  본문, 갱신 버튼, 삭제 버튼 출력 영역 -->
		<div id="content_div">
			<div class="form-group">
				<div class="form-control" id="">
					
				</div>
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