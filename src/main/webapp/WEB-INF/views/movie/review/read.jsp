<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
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
var isLike;
</script>
<sec:authorize access="isAuthenticated()">
	<script>
	var mRevNo = location.search.substr(8);
	console.log("동작하니?");
	$(function() {
		if(location.search.split('=')[0] == ""){
			location.href="/moviefactory";
		}
		$.ajax({
			
			url : "/moviefactory/api/movie/review/checkreviewlike?mRevNo=" + mRevNo,
			method : "get",
			success : function(result, status, xhr) {
				console.log("동작값은 뭐니?");
				console.log(result);
				isLike=result;
				console.log(isLike);
				if(isLike=="like"){
					$('#doyoulike').text('취소');					
				}
				if(isLike=="dontlike"){
					$('#doyoulike').text('좋아요');	
					$('#a').css("color","gray");
					
				}
			},
			error : function(xhr) {
				console.log(xhr.status);
			}
		});

	});

	</script>
</sec:authorize>





<sec:authorize access="hasRole('ROLE_ADMIN')">
	<script>
		//1. 글 출력
		var moviereview;
		function printData(moviereview) {
			$("<a>").attr(
					"href",
					"/moviefactory/usermovie/userpage?username="
							+ moviereview.username).text(moviereview.username)
					.appendTo($("#writer"));
			console.log(moviereview);
			$("#bno").text(moviereview.mrevNo);
			$("#writeDate").text(moviereview.writingDate);
			//$("#recommend").text(moviereview.likeCnt);
			$("#likecnt").text(moviereview.likeCnt);
			$("#content").text(moviereview.mrevContent);

			// 추천수, 신고수	
			//$("#content").prop("readonly", true);
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
			$("#c").hide();
			$("<button></button>").attr("id", "btnDelete").attr("class",
					"btn btn-default").css("margin", "2px").text("삭제")
					.appendTo($("#btnArea"));
			if (isLogin == false) {
				$("#content").prop("readonly", true);
				$("#update_com").css("class","form-control").prop("readonly", true);
				$("#comment_textarea").prop("disabled", true).attr(
						"placeholder", "로그인이 필요합니다");
				$("#comment_write").prop("disabled", true);
			} else if (isLogin == true && moviereview.own != true) {
				$("#a").prop("disabled", false).attr("title", "좋아요");
			} else if (isLogin == true && moviereview.own == true) {
				$("<button></button>").attr("id", "btnUpdate").attr("class",
						"btn btn-primary").css("margin", "2px").text("변경")
						.appendTo($("#btnArea"));
			}
			printComment();

		}
		//2. 댓글 출력
		function printComment(moviereviewcomment) {

			if (moviereviewcomment == undefined)
				moviereviewcomment = moviereview.comments;
			console.log(moviereviewcomment);
			// 댓글을 출력할 영역(#comments)를 읽어와 초기화(출력중인 모든 댓글을 삭제)
			var $moviereviewcomment = $("#comments");
			$moviereviewcomment.empty();

			$.each(moviereviewcomment, function(i, comment) {
				var $comment = $("<div>").appendTo($moviereviewcomment)
				var $upper_div = $("<div>").appendTo($comment);
				var $center_div = $("<div>").appendTo($comment);
				var $lower_div = $("<div>").appendTo($comment);
				console.log("===============================gggg")
				console.log(comment);
				//$("<span></span>").text(comment.username).appendTo($upper_div);
				$("<img>").css("display","inline-block").css("height","30px").attr("src", "/profile/" + comment.username + ".jpg")
				.css("width", "30px").css("margin-top","10px").appendTo($upper_div);
				$("<a>").attr(
						"href",
						"/moviefactory/usermovie/userpage?username="
								+ comment.username).text(comment.username).css("margin-top","10px")
						.appendTo($upper_div);
				
				var btn = $("<button type='button'>").attr("id", "delete_commenttt").attr(
						"class", "btn btn-default").attr("data-mrevcmntno",
						comment.mrevCmntNo).attr("data-mRevNo",
						moviereview.mRevNo).attr("data-username",
						comment.username).css("margin", "2px").text("삭제")
						.appendTo($lower_div);
						btn.css("float", "right");
						if (comment.username == loginId) {
							$("<div>").attr("id","update_com").css("display","inline-block").css("class","form-control").css("width", "600px").text(
									comment.content).prop("readonly", false).appendTo(
									$center_div);
						} else if (comment.username != loginId) {
							$("<div>").attr("id","update_coms").css("width", "600px").css("display","inline-block").text(comment.content).css("class","form-control").prop(
									"readonly", true).appendTo($center_div);
						}
				$("<span>").text(comment.writingDate).appendTo($lower_div);
				if (comment.username == loginId) {
					var btns = $("<button>").attr("id", "updates_commentt").attr(
							"class", "btn btn-default").attr("data-mrevcmntno",
							comment.mrevCmntNo).attr("data-mRevNo",
							moviereview.mRevNo).attr("data-username",
							comment.username).css("margin", "2px").text("수정").css("float", "right").on("click",function(){
								$(this).hide();
								$("#update_com").html("<textarea  style='resize: none;' style='width:600px' id='com_content'></textarea>").appendTo($center_div);
								$("#com_content").text(comment.content);
								content : $("#updates_com").val();
								var btn2 = $("<button type='button'>").attr("id", "update_commentt")
								.attr("class", "btn btn-primary").attr(
										"data-mrevcmntno", comment.mrevCmntNo)
								.attr("data-mRevNo", moviereview.mRevNo).attr(
										"data-username", comment.username).css(
										"margin", "2px").text("변경").appendTo(
										$lower_div);
								btn2.css("float", "right");
							})
							.appendTo($lower_div);
						
				}
				//$("<span>").text(comment.cmntLikeCnt).appendTo(".like_commentt");
				
				

			});
		}
		// 댓글을 포함한 게시글을 읽어온다
		$(function() {
			var mRevNo = location.search.substr(8);
			console.log(mRevNo);
			$.ajax({
				url : "/moviefactory/api/movie/review/read/" + mRevNo,
				method : "get",
				success : function(result, status, xhr) {
					console.log(result);
					moviereview = result;
					printData(result);
				},
				error : function(xhr) {
					console.log(xhr.status);
				}
			});

			// 3. 글 갱신
			$("#btnArea").on("click", "#btnUpdate", function() {
				var param = {
					mRevNo : moviereview.mrevNo,
					mRevContent : $("#content").val()
				};
				console.log(param);
				$.ajax({
					url : "/moviefactory/api/movie/review/readupdate",
					method : "post",
					data : param,
					success : function() {
						location.reload();
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				});
			});
			// 4. 글 삭제 
			$("#btnArea").on(
					"click",
					"#btnDelete",
					function() {
						var param = {
							_method : "delete",
							mRevNo : moviereview.mrevNo
						};
						var result = confirm("리뷰를 삭제 하시겠습니까?");
						if (result == true) {
							$.ajax({
								url : "/moviefactory/api/movie/review/delete/"
										+ moviereview.mrevNo,
								method : "post",
								data : param,
								success : function(result, text, xhr) {
									location.href = "/moviefactory/movie/read?mno="+ moviereview.mno ;
								},
								error : function(xhr) {
									console.log("삭제에 실패했습니다");
								}
							});
							 }
						else {
							return false;
						}	
					
					});
			// 5. 글 추천
			$("#a").on("click", function() {
				console.log("====================")
				// 비로그인이거나 글쓴 사람 본인이면 추천 금지
				if (isLogin == false || moviereview.own == true)
					return;
				var param = {
					_method : "patch",
					mRevNo : moviereview.mrevNo
				};
				var likeurl; 
				if(isLike=="dontlike")
					likeurl= "/moviefactory/api/movie/review/like";
				if(isLike=="like")
					likeurl= "/moviefactory/api/movie/review/dontlike";
				console.log(param);
				$.ajax({
					url : likeurl,
					method : "post",
					data : param,
					success : function(result) {
						// 추천에 성공한 경우 서버에서 새로운 추천수를 보내주므로 출력
						console.log(result);
						$("#recommend").text(result);
						location.reload();
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				});
			});
			// 7. 댓글 작성
			$("#comment_write").on("click", function() {
				// 비로그인이면 중단

				if (isLogin == false)
					return;

				var param = {
					mRevNo : moviereview.mrevNo,
					content : $("#comment_textarea").val()
				}
				console.log(param);
				$.ajax({
					url : "/moviefactory/api/movie/comment/write",
					method : "post",
					data : param,
					success : function(result) {
						console.log(result);
						$("#comment_textarea").val("");
						printComment(result);
						location.reload();
					},
					error : function() {
						console.log(222);
					}
				});
			});

			// 8. 댓글 삭제
			$("#comments").on("click", "#delete_commenttt", function() {
				if (isLogin == false)
					return;
				var param = {
					_method : "delete",
					mRevCmntNo : $(this).data("mrevcmntno"),
					mRevNo : moviereview.mrevNo
				}
				console.log(param);
				$.ajax({
					url : "/moviefactory/api/movie/comment/deletebycmntno",
					method : "post",
					data : param,
					success : function(result) {
						console.log(result);
						$("#comment_textarea").val("");
						location.reload();
					}
				});
			});
			// 9. 댓글 변경
			$("#comments").on("click", ".update_comment", function() {
				if (isLogin == false || loginId != $(this).data("username"))
					return;
				var param = {
					mRevNo : moviereview.mrevNo,
					mRevCmntNo : $(this).data("mrevcmntno"),
					content : $("#update_com").val()
				}
				console.log(param);
				$.ajax({
					url : "/moviefactory/api/movie/comment/update",
					method : "post",
					data : param,
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
				if (isLogin == false || loginId == $(this).data("username"))
					return;
				var param = {
					_method : "patch",
					mRevCmntNo : $(this).data("mrevcmntno"),
				};
				console.log(param);
				$.ajax({
					url : "/moviefactory/api/movie/comment/like",
					method : "post",
					data : param,
					success : function(result) {
						// 추천에 성공한 경우 서버에서 새로운 추천수를 보내주므로 출력
						console.log(result);
						$("#recommend").text(result);
						location.reload();
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				});
			});
		})
	</script>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_USER')">
	<script>
		//1. 글 출력
		var moviereview;
		function printData(moviereview) {
			$("<a>").attr(
					"href",
					"/moviefactory/usermovie/userpage?username="
							+ moviereview.username).text(moviereview.username)
					.appendTo($("#writer"));
			console.log(moviereview);
			$("#bno").text(moviereview.rating);
			$("#writeDate").text(moviereview.writingDate);
			//$("#recommend").text(moviereview.likeCnt);
			$("#likecnt").text(moviereview.likeCnt);
			$("#content").text(moviereview.mrevContent);

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

			if (isLogin == false) {
				$("#content").prop("readonly", true);
				$("#update_com").prop("readonly", true).css("class","form-control");
				$("#comment_textarea").prop("disabled", true).attr(
						"placeholder", "로그인이 필요합니다");
				$("#comment_write").prop("disabled", true);
			} else if (isLogin == true && moviereview.own != true) {
				$("#a").prop("disabled", false).attr("title", "좋아요");
				$("#c").prop("disabled", false).attr("title", "신고하기");
			} else if (isLogin == true && moviereview.own == true) {
				$("#content").prop("readonly", false);
				$("#update_com").css("class","form-control").prop("readonly", false);
				$("<button></button>").attr("id", "btnDelete").attr("class",
						"btn btn-default").css("margin", "2px").text("삭제")
						.appendTo($("#btnArea"));
				$("<button></button>").attr("id", "btnUpdate").attr("class",
						"btn btn-primary").css("margin", "2px").text("변경") 
						.appendTo($("#btnArea"));
			} 
			
			
			

			// 댓글 출력
			printComment();

		}
		//2. 댓글 출력
		function printComment(moviereviewcomment) {

			if (moviereviewcomment == undefined)
				moviereviewcomment = moviereview.comments;
			console.log(moviereviewcomment);
			// 댓글을 출력할 영역(#comments)를 읽어와 초기화(출력중인 모든 댓글을 삭제)
			var $moviereviewcomment = $("#comments");
			$moviereviewcomment.empty();

			$.each(moviereviewcomment, function(i, comment) {
				var $comment = $("<div>").appendTo($moviereviewcomment)
				var $upper_div = $("<div>").appendTo($comment);
				var $center_div = $("<div>").appendTo($comment);
				var $center_span= $("<span>").appendTo($center_div);
				var $lower_div = $("<div>").appendTo($comment);
				
				
				console.log("===============================gggg")
				console.log(comment);
				$("<img>").css("display","inline-block").css("height","30px").attr("src", "/profile/" + comment.username + ".jpg")
				.css("width", "30px").css("margin-top","10px").appendTo($upper_div);
				$("<a>").attr(
						"href",
						"/moviefactory/usermovie/userpage?username="
								+ comment.username).text(comment.username).css("margin-top","10px")
						.appendTo($upper_div);
				if (comment.username == loginId) {
					$("<div>").attr("id","update_com").css("display","inline-block").css("class","form-control").css("width", "600px").text(
							comment.content).prop("readonly", false).appendTo(
							$center_div);
				} else if (comment.username != loginId) {
					$("<div>").attr("id","update_coms").css("width", "600px").css("display","inline-block").text(comment.content).css("class","form-control").prop(
							"readonly", true).appendTo($center_div);
				}
				//$("<span>").text(comment.cmntLikeCnt).appendTo(".like_commentt");
				$("<span>").text(comment.writingDate + " ").attr("id","date").appendTo($lower_div);
				var $i = $("<i>").attr("class","fab fa-gratipay").css("color","red").appendTo($lower_div);	//별모양
				$("<span></span>").text(comment.cmntLikeCnt).css("color","black").appendTo($lower_div);   // 평점
				
				
				if (comment.username == loginId) {
					var btn = $("<button>").attr("id", "delete_commentt").attr(
							"class", "btn btn-default").attr("data-mrevcmntno",
							comment.mrevCmntNo).attr("data-mRevNo",
							moviereview.mRevNo).attr("data-username",
							comment.username).css("margin", "2px").text("삭제")
							.appendTo($center_span);
							btn.css("float", "right");
				
					var btns = $("<button>").attr("id", "updates_commentt").attr(
							"class", "btn btn-default").attr("data-mrevcmntno",
							comment.mrevCmntNo).attr("data-mRevNo",
							moviereview.mRevNo).attr("data-username",
							comment.username).css("margin", "2px").text("수정").css("float", "right").on("click",function(){
								$(this).hide();
								$("<textarea style='resize: none;'  style='width:600px' id='com_content'></textarea>").appendTo($center_div);
								$("#com_content").text(comment.content);
								content : $("#updates_com").val();
								var btn2 = $("<button type='button'>").attr("id", "update_commentt")
								.attr("class", "btn btn-primary").attr(
										"data-mrevcmntno", comment.mrevCmntNo)
								.attr("data-mRevNo", moviereview.mRevNo).attr(
										"data-username", comment.username).css(
										"margin", "2px").text("변경").appendTo($center_span
										);
								btn2.css("float", "right");
							})
							.appendTo($center_span);
						
				}
				if (comment.username != loginId) {
						$.ajax({
							url : "/moviefactory/api/movie/review/checkcmntlike?mrevCmntNo=" + comment.mrevCmntNo,
							method : "get",
							success : function(result, status, xhr) {
							
								if(result=="like"){
									var btn3 = $("<button>").attr("id", "like_commentt").attr(
											"class", "btn btn-primary").attr("data-mrevcmntno",
											comment.mrevCmntNo).attr("data-mRevNo",
											moviereview.mRevNo).attr("data-username",
											comment.username).attr("data-isLike",
													"like").css("margin", "2px").text(
											"취소").appendTo($center_div);
									btn3.css("float", "right");
									var btn4 = $("<button>").attr("id", "rep_commentt").attr(
											"class", "btn btn-danger").attr("data-mrevcmntno",
											comment.mrevCmntNo).attr("data-mRevNo",
											moviereview.mRevNo).attr("data-username",
											comment.username).css("margin", "2px").text("신고")
											.appendTo($center_div);
									btn4.css("float", "right");				
								}
								if(result=="dontlike"){
									var btn3 = $("<button>").attr("id", "like_commentt").attr(
											"class", "btn btn-primary").attr("data-mrevcmntno",
											comment.mrevCmntNo).attr("data-mRevNo",
											moviereview.mRevNo).attr("data-username",
											comment.username).attr("data-isLike",
											"dontlike").css("margin", "2px").text(
											"좋아요").appendTo($center_div);
									btn3.css("float", "right");
									var btn4 = $("<button>").attr("id", "rep_commentt").attr(
											"class", "btn btn-danger").attr("data-mrevcmntno",
											comment.mrevCmntNo).attr("data-mRevNo",
											moviereview.mRevNo).attr("data-username",
											comment.username).css("margin", "2px").text("신고")
											.appendTo($center_div);
									btn4.css("float", "right");				
								}
							},
							error : function(xhr) {
								console.log(xhr.status);
							}
						});
					
				}
				
			});
		}
		// 댓글을 포함한 게시글을 읽어온다
		$(function() {
			var mRevNo = location.search.substr(8);
			console.log(mRevNo);
			$.ajax({
				url : "/moviefactory/api/movie/review/read/" + mRevNo,
				method : "get",
				success : function(result, status, xhr) {
					console.log(result);
					moviereview = result;
					printData(result);
				},
				error : function(xhr) {
					console.log(xhr.status);
				}
			});

			// 3. 글 갱신
			$("#btnArea").on("click", "#btnUpdate", function() {
				var param = {
					mRevNo : moviereview.mrevNo,
					mRevContent : $("#content").val()
				};
				console.log(param);
				$.ajax({
					url : "/moviefactory/api/movie/review/readupdate",
					method : "post",
					data : param,
					success : function() {
						location.reload();
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				});
			});
			// 4. 글 삭제 
			$("#btnArea").on(
					"click",
					"#btnDelete",
					function() {
						var param = {
							_method : "delete",
							mRevNo : moviereview.mrevNo
						};
						var result = confirm("리뷰를 삭제 하시겠습니까?");
						if (result == true) {
							$.ajax({
								url : "/moviefactory/api/movie/review/delete/"
										+ moviereview.mrevNo,
								method : "post",
								data : param,
								success : function(result, text, xhr) {
									location.href = "/moviefactory/movie/read?mno="+ moviereview.mno ;
								},
								error : function(xhr) {
									console.log("삭제에 실패했습니다");
								}
							});
							 }
						else {
							return false;
						}	
					
					});
			// 5. 글 추천
			$("#a").on("click", function() {
				console.log("====================")
				// 비로그인이거나 글쓴 사람 본인이면 추천 금지
				if (isLogin == false || moviereview.own == true)
					return;
				var param = {
					_method : "patch",
					mRevNo : moviereview.mrevNo
				};
				console.log(param);
				var likeurl; 
				if(isLike=="dontlike")
					likeurl= "/moviefactory/api/movie/review/like";
				if(isLike=="like")
					likeurl= "/moviefactory/api/movie/review/dontlike";

				$.ajax({
					url : likeurl,
					method : "post",
					data : param,
					success : function(result) {
						// 추천에 성공한 경우 서버에서 새로운 추천수를 보내주므로 출력
						console.log(result);
						$("#recommend").text(result);
						location.reload();
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				});
			});
			//window.open('/moviefactory/movie/review/report?mrevno='+mRevNo,'window','width=400, height=400, status=no,toolbar=no,scrollbars=no, location=no');
			// 6. 글 신고
			$("#lower_right").on("click","#c",function() {
				if (isLogin == false || moviereview.own == true)
							return;
				window.open('/moviefactory/movie/review/report?mrevno='+mRevNo,'window','width=800, height=600, status=no,toolbar=no,scrollbars=no, location=no');
			});
			// 7. 댓글 작성
			$("#comment_write").on("click", function() {
				// 비로그인이면 중단

				if (isLogin == false)
					return;

				var param = {
					mRevNo : moviereview.mrevNo,
					content : $("#comment_textarea").val()
				}
				console.log(param);
				$.ajax({
					url : "/moviefactory/api/movie/comment/write",
					method : "post",
					data : param,
					success : function(result) {
						console.log(result);
						$("#comment_textarea").val("");
						printComment(result);
						location.reload();
					},
					error : function() {
						console.log(222);
					}
				});
			});

			// 8. 댓글 삭제
			$("#comments").on("click", "#delete_commentt", function() {
				if (isLogin == false || loginId != $(this).data("username"))
					return;
				var param = {
					_method : "delete",
					mRevCmntNo : $(this).data("mrevcmntno"),
					mRevNo : moviereview.mrevNo
				}
				console.log(param);
				$.ajax({
					url : "/moviefactory/api/movie/comment/deletebycmntno",
					method : "post",
					data : param,
					success : function(result) {
						console.log(result);
						$("#comment_textarea").val("");
						location.reload();
					}
				});
			});
			// 9. 댓글 변경
			$("#comments").on("click", "#update_commentt", function() {
				if (isLogin == false || loginId != $(this).data("username"))
					return;
				var param = {
					mRevNo : moviereview.mrevNo,
					mRevCmntNo : $(this).data("mrevcmntno"),
					content : $("#com_content").val()
				}
				console.log(param);
				$.ajax({
					url : "/moviefactory/api/movie/comment/update",
					method : "post",
					data : param,
					success : function(result) {
						console.log(result);
						$("#comment_textarea").val("");
						printComment(result);
						location.reload();
					}
				});
			});
			// 10. 댓글 좋아요
			$("#comments").on("click", "#like_commentt", function() {
				console.log("====================")
				// 비로그인이거나 글쓴 사람 본인이면 추천 금지
				if (isLogin == false || loginId == $(this).data("username"))
					return;
				var param = {
					_method : "patch",
					mRevCmntNo : $(this).data("mrevcmntno"),
				};
				var isCommentLike = $(this).data("islike");
				console.log(isCommentLike + "-----------");
				console.log("------------------------------")
				
				var likeurl2; 
				if(isCommentLike=="dontlike")
					likeurl2= "/moviefactory/api/movie/comment/like";
				if(isCommentLike=="like")
					likeurl2= "/moviefactory/api/movie/comment/dontlike";
				
				
				console.log(param);
				$.ajax({
					url : likeurl2,
					method : "post",
					data : param,
					success : function(result) {
						// 추천에 성공한 경우 서버에서 새로운 추천수를 보내주므로 출력
						console.log(result);
						$("#recommend").text(result);
						location.reload();
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				});
			});
		6. // 댓글 신고
			$("#comments").on("click","#rep_commentt",function() {
				var mRevCmntNo = $(this).data("mrevcmntno");
				console.log(mRevCmntNo);
				if (isLogin == false || moviereview.own == true)
						return;
				console.log("===들어옴===")
				window.open('/moviefactory/movie/review/cmntreport?mrevcmntno='+mRevCmntNo,'window','width=800, height=600, status=no,toolbar=no,scrollbars=no, location=no');
			});
		});
	</script>
</sec:authorize>
<sec:authorize access="isAnonymous()">
	<script>
		//1. 글 출력
		var moviereview;
		function printData(moviereview) {
			$("<a>").attr(
					"href",
					"/moviefactory/usermovie/userpage?username="
							+ moviereview.username).text(moviereview.username)
					.appendTo($("#writer"));
			console.log(moviereview);
			$("#bno").text(moviereview.rating);
			$("#writeDate").text(moviereview.writingDate);
			//$("#recommend").text(moviereview.likeCnt);
			$("#likecnt").text(moviereview.likeCnt);
			$("#content").text(moviereview.mrevContent);
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

			
			// 댓글 출력
			printComment();

		}
		//2. 댓글 출력
		function printComment(moviereviewcomment) {

			if (moviereviewcomment == undefined)
				moviereviewcomment = moviereview.comments;
			console.log(moviereviewcomment);
			// 댓글을 출력할 영역(#comments)를 읽어와 초기화(출력중인 모든 댓글을 삭제)
			var $moviereviewcomment = $("#comments");
			$moviereviewcomment.empty();

			$.each(moviereviewcomment, function(i, comment) {
				var $comment = $("<div>").appendTo($moviereviewcomment)
				var $upper_div = $("<div>").appendTo($comment);
				var $center_div = $("<div>").appendTo($comment);
				var $lower_div = $("<div>").appendTo($comment);
				console.log("===============================gggg")
				console.log(comment);
				//$("<span></span>").text(comment.username).appendTo($upper_div);
				$("<img>").css("display","inline-block").css("height","30px").attr("src", "/profile/" + comment.username + ".jpg")
				.css("width", "30px").css("margin-top","10px").appendTo($upper_div);
				$("<a>").attr(
						"href",
						"/moviefactory/usermovie/userpage?username="
								+ comment.username).text(comment.username).css("margin-top","10px")
						.appendTo($upper_div);
				
				$("<span id=update_com>").text(comment.content).prop(
							"readonly", true).appendTo($center_div);				
				//$("<span>").text(comment.cmntLikeCnt).appendTo(".like_commentt");
				$("<span>").text(comment.writingDate +" ").appendTo($lower_div);
				var $i = $("<i>").attr("class","fab fa-gratipay").css("color","red").appendTo($lower_div);	//별모양
				$("<span></span>").text(comment.cmntLikeCnt).css("color","black").appendTo($lower_div);   // 평점
				
				$("<hr>").appendTo($lower_div);
			});
		}
		// 댓글을 포함한 게시글을 읽어온다
		$(function() {
			var mRevNo = location.search.substr(8);
			console.log(mRevNo);
			if(location.search.split('=')[0] == ""){
				location.href="/moviefactory";
			}
			$.ajax({
				url : "/moviefactory/api/movie/review/read/" + mRevNo,
				method : "get",
				success : function(result, status, xhr) {
					console.log(result);
					moviereview = result;
					printData(result);
				},
				error : function(xhr) {
					console.log(xhr.status);
				}
			});

		
		})
	</script>
</sec:authorize>
<style>
#comment_write {
	height: 50px;
	width: 100px;
	
}
#a{
		cursor :pointer
}

#lower_right, #btnDelete, #btnUpdate {
	float: right;
}
#update_com,#update_coms{
	word-wrap: break-word;
}

#zzzz {
	border: 1px solid #EAEAEA;
	width: 800px;
	margin: 0 auto;
	padding : 20px;
	height: 100% 
}

table {
	width: 100%;
	text-align: center;
	margin: 0 auto;
	/* border-radius: 2px #BDBDBD solid;
 */ }

th {
	text-align: center;
	background-color: #5CD1E5;
	color: white;
}
#comment_textarea {
	margin-bottom:10px;
}
#comments{
}

#date {
	border-bottom: 1px solid #EAEAEA;
}
</style>
</head>
<body>
	<div id="section">
		<div id="zzzz">
			<div>
				<div id="title_div">
					<input type="hidden" name="mRevNo" id="mRevNo" val="">
					<table>
						<colgroup>
							<col width="22%">
							<col width="22%">
							<col width="22%">
							<col width="22%">
							<col width="12%">
						</colgroup>
						<tr>
							<th>평점</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>좋아요</th>
							<th rowspan="2"><i class="fas fa-heart fa-2x" style="color:red;" id="a"></i></th>
						</tr>
						<tr>
							<th>
							<i class="fas fa-star" style="color: red;"><span id="bno"></span></i>
							</th>
							<th id="writer"></th>
							<th id="writeDate">
							</th>
							<th><span id="likecnt"></span></th>
							
						</tr>
						
					</table>
					<br>
					<ul id="lower_right">
						<li>
						
						</li>
						<li>
							<!-- 
							<button type="button" class="btn btn-primary" id="a">
								<span id="doyoulike"></span><span class="badge" id="recommend"></span>
							</button>
							 -->
							<button type="button" class="btn btn-danger" id="c">
								신고 <span class="badge" id="report"></span>
							</button>
						</li>
					</ul>
				</div>
				<!--  본문, 갱신 버튼, 삭제 버튼 출력 영역 -->
				<div id="content_div">
					<div class="form-group">
						<textarea style="resize: none;" class="form-control" id="content"></textarea>
					</div>
					<div id="btnArea" style="overflow: hidden"></div>
				</div>
			</div>
			<div>
				<div class="form-group">
					<label for="comment_textarea">댓글을 입력하세요</label>
					<textarea style="resize: none;" class="form-control" rows="5" id="comment_textarea"
						placeholder="욕설이나 모욕적인 댓글은 삭제될 수 있습니다"></textarea>
				</div>
				<button type="button" class="btn btn-info" id="comment_write">
					<span class="glyphicon glyphicon-ok"></span>댓글 작성 
				</button>
			</div>
			<div >
				<div id="comments" ></div>
				</div>
		</div>
	</div>
</body>
</html>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>