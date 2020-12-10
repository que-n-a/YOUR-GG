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
					<table class="table table-dark table-hover text-center" style="color: white; background-color: rgb(46, 47, 50)">
						<tr style="font-weight: bold">
							<th class="text-warning" style="width: 10%">번호</th>
							<th style="width: 50%">제목</th>
							<th style="width: 20%">글쓴이</th>
							<th style="width: 20%">등록일</th>
						</tr>
						<c:forEach items="${board}" var="board">
						<tr>
							<td class="text-warning">
								<c:out value="${board.boardNumber}" />
							</td>
							<td><a href="#" id="boardNumber-${board.boardNumber}" onclick="getPost(this.id);" style="text-decoration: none; color: white"><c:out value="${board.boardTitle}" /></a></td>
							<td><c:out value="${board.boardWriter}" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.boardRegdate}" /></td>	
						</tr>	
						</c:forEach>		
					</table>
					
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
			var nowPage = document.location.search.replace("?","");
			if(nowPage[1] === undefined){
				window.location = "/";
			} 
			else {
				window.location = "boardList?" + nowPage;
				
			}
		}
		
		function doWrite() {
			var nowPage = document.location.search.replace("?","").split("&")[0];
			if(nowPage === "") {
				nowPage = "page=1";
			}
			window.location = "/post?" + nowPage;
		}
		
		function getPost(data) {
			var boardNumber = data.replace("-", "=");
			var nowPage = document.location.search.replace("?","").split("&")[0];
			console.log(boardNumber);
			console.log(nowPage);
			if(nowPage === ""){
				nowPage = "page=1"
			}	
			window.location = "/get/view-post?" + nowPage + "&" + boardNumber;
		}
		
	</script>
	
</html>