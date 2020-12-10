<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>YOUR.GG</title>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="/resources/bootstrap/4.5.3/css/bootstrap.min.css">
	    <link rel="stylesheet" href="/resources/css/index.css">
	    <script src="/resources/jquery/3.5.1/jquery.min.js"></script>
	    <script src="/resources/bootstrap/4.5.3/js/bootstrap.min.js"></script>
	</head>
	<body>
		<div class="content">
			<header style="height: 145px; position: relative;">
				<!-- logo -->
				<div class="row content-logo">
					<div class="col-2"></div>
					<div class="col-8">
						<a href="/"><img src="/resources/img/yourgg_logo.JPG" /></a>
					</div>
					<div class="col-2"></div>
				</div>

				<!-- top menu -->
				<div class="row content-menu">
					<div class="col-2"></div>
					<div class="col-8">
						<ul class="nav-menu">
							<li>
								<a href="#"><img src="/resources/img/DB.JPG" />아이템 DB</a>
							</li>
							<li>
								<a href="#"><img src="/resources/img/duo.JPG" />듀오 신청</a>
							</li>
							<li>
								<a href="#"><img src="/resources/img/more.JPG" />더 보기</a>
							</li>
						</ul>
					</div>
					<div class="col-2"></div>
				</div>
			</header>

			<!-- center -->
			<section class="row content-center">
				<br>
				<div class="col-2"></div>
				<div class="col-8">
					<br />
					<h1 style="text-align:center"><a href="/" style="text-decoration: none; color: white">Y O U R . G G</a></h1>
					<br />
					
					<form action="/post/regist" method="POST" id="posting" style="text-align: center" >
					<div class="form-row">
					<div class="col-6"></div>
						<div class="form-inline col-3">
							<input type="text" name="boardWriter" class="form-control" id="id-check" maxlength="10" placeholder="닉네임" required style="width: 100%">
						</div>
						<div class="form-inline col-3">
							<input type="password" name="boardPassword" class="form-control" id="pw-check" maxlength="10" placeholder="비밀번호" required style="width: 100%">
						</div>
					</div>
					<input type="text" name="boardTitle" class="form-control mt-4 mb-2" id="title-check" maxlength="50" placeholder="제목을 입력해주세요" required>
					<div class="form-group">
						<textarea class="form-control" rows="10" onchange="adjustHeight();" id="content-check" maxlength="2000" name="boardContent" placeholder="내용을 입력해주세요" required></textarea>
					</div>
						<input class="btn btn-secondary mb-3" type="button" onclick="doPost();" value="등록" />
					</form>
					
					<input style="float: left" type="button" class="btn btn-danger" onclick="goList();" value="목록" />
					<input style="float: right" type="button" class="btn btn-dark" onclick="doWrite();" value="글쓰기" />
					
					<br>
					
					<ul class="pagination justify-content-center my" st>
						<c:if test="${pageInfo.prev}">
						<li class="page-item"><a class="page-link text-white" style="background-color: rgb(46, 47, 50)" href="/boardList?page=${pageInfo.startPage-1}"><</a></li>
						</c:if>
						
					  	<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<li class="page-item ${pageInfo.nowPage == num ? "active" : ""}"><a class="page-link text-white" style="background-color: rgb(46, 47, 50)" href="/boardList?page=${num}">${num}</a></li>
						</c:forEach>
						
						<c:if test="${pageInfo.next}">
						<li class="page-item"><a class="page-link text-white" style="background-color: rgb(46, 47, 50)" href="/boardList?page=${pageInfo.endPage+1}">></a></li>
						</c:if>
					</ul>
				</div>
				<div class="col-2"></div>
			</section>

			<!-- bottom -->
			<footer class="row content-bottom">
			<div class="col-2"></div>
			<div class="col-8">
			<hr style="background-color: rgb(67, 68, 71)" />
				<span style="color: rgb(189, 190, 165)">GGtics</span>
				<span style="color: rgb(68, 149, 61)">Contact</span>
				<br /><br />
				<span style="color: rgb(105, 95, 75)">GGticsisn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are</span>
			</div>
			<div class="col-2"></div>
			</footer>
		</div>
	</body>
	
	<script type="text/javascript">
	
		function goList() {
			var nowPage = document.location.href.split("?");
			if(nowPage[1] === undefined){
				window.location = "/";
			} 
			else {
				window.location = "boardList?" + nowPage[1];
			}
		}
		
		function doWrite() {
			var nowPage = document.location.href.split("?");
			if(nowPage[1] === undefined){
				window.location = "/post?page=1";
			} 
			else{
				window.location = "/post?" + nowPage[1];
			}
		}
		
		function doPost() {
			var idCheck = $("#id-check").val();
			var pwCheck = $("#pw-check").val();
			var titleCheck = $("#title-check").val();
			var contentCheck = $("#content-check").val();
			
			if(idCheck.length < 2){
				alert("닉네임을 두글자 이상 입력하십시오");
				return;
			}
			if(pwCheck.length < 5){
				alert("비밀번호를 다섯글자 이상 입력하십시오");
				return;
			}
			if(titleCheck.length < 1){
				alert("제목을 입력하십시오");
				return;
			}
			if(contentCheck.length < 1){
				alert("내용을 입력하십시오");
				return;
			}
			else{
				alert("게시글을 등록하였습니다");
				$("#posting").submit();
			}
		}
		
		function adjustHeight() {
			var textEle = $('textarea');
			textEle[0].style.height = 'auto';
			var textEleHeight = textEle.prop('scrollHeight');
			textEle.css('height', textEleHeight);
		};
		
		var textEle = $('textarea');
		textEle.on('keyup', function() {
		  adjustHeight();
		});
		
	</script>
	
</html>
