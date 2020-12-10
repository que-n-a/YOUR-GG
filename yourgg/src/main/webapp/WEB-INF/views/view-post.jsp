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

					<form id="updateForm" action="/post/update" method="POST" style="text-align: center" >
						<div class="form-row">
						<div class="col-5"></div>
						<div class="col-2"><input type="text" name="boardNumber" id="board-number" class="form-control" style="width: 100%" value="${board.boardNumber}" readonly></div>
						<div class="col-3"><input type="text" class="form-control" style="width: 100%" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.boardRegdate}" />" readonly></div>
							<div class="form-inline col-2">
								<input type="text" class="form-control" style="width: 100%" value="${board.boardWriter}" readonly>
							</div>
						</div>
						<input type="text" name="boardTitle" id="board-title" class="form-control mt-4 mb-2" maxlength="50" value="${board.boardTitle}" readonly>
						<div class="form-group">
							<textarea class="form-control" id="board-content" name="boardContent" id="board-content" rows="10" maxlength="2000" onchange="adjustHeight();" readonly>${board.boardContent}</textarea>
						</div>
					</form>
					
					<input style="float: left" type="button" class="btn btn-danger" onclick="goList();" value="목록" />
					<input style="float: right" id="delete-button" type="button" class="btn btn-danger ml-1" data-toggle="modal" data-target="#modal-delete" value="삭제" />
					<input style="float: right" type="button" class="btn btn-dark ml-1" onclick="doWrite();" value="글쓰기" />
					<input style="float: right" type="button" class="btn btn-info ml-1" data-toggle="modal" data-target="#modal-update" value="수정" id="update-button"/>
					<input style="float: right" type="hidden" class="btn btn-info ml-1" onclick="doUpdatePost();" value="수정" id="true-update-button"/>
					
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
		
		<!-- 모달-수정 -->
		<div class="modal fade" id="modal-update">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
				
					<!-- 헤더 -->
					<div class="modal-header">
						<h4 class="modal-title">게시글을 수정하시겠습니까?</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- 바디 -->
					<div class="modal-body">
						<input type="password" id="update-password" class="form-control" placeholder="비밀번호를 입력하세요" style="width: 100%">
					</div>

					<!-- 푸터 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-info" onclick="doUpdate();" data-dismiss="modal">수정</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 모달-삭제 -->
		<div class="modal fade" id="modal-delete">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
				
					<!-- 헤더 -->
					<div class="modal-header">
						<h4 class="modal-title">게시글을 삭제하시겠습니까?</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- 바디 -->
					<div class="modal-body">
						<input type="password" id="delete-password" class="form-control" placeholder="비밀번호를 입력하세요" style="width: 100%">
					</div>

					<!-- 푸터 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" onclick="doDelete();" data-dismiss="modal">삭제</button>
					</div>
				</div>
			</div>
		</div>
  
	</body>
	
	<script type="text/javascript">
	
		function goList() {
			var nowPage = document.location.search.replace("?","").split("&")[0];
			window.location = "/boardList?" + nowPage;
		}
		
		function doWrite() {
			var nowPage = document.location.search.replace("?","").split("&")[0];
			window.location = "/post?" + nowPage;
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
		
		function doDelete() {
			var nowPage = document.location.search.replace("?","").split("&")[0];
			var boardNumber = $("#board-number").val();
			var password = $("#delete-password").val();
			var sendData = {"boardNumber": $("#board-number").val(), "boardPassword" : $("#delete-password").val()};
			
			$.ajax({
				url: "/delete",
				type: "POST",
				dataType: "json",
				data: sendData,
				success: function (data) {
					if (data) {						
						alert("삭제하였습니다");
						window.location = "/boardList?" + nowPage;
					} else {
						alert("비밀번호가 틀립니다");
					}
				},
				error: function () {
					alert("Error. 관리자에게 문의하십시오.");
				},
			});
			
		}
		
		function doUpdate() {
			var boardNumber = $("#board-number").val();
			var password = $("#update-password").val();
			var sendData = {"boardNumber": $("#board-number").val(), "boardPassword" : $("#update-password").val()};
			
			$.ajax({
				url: "/update-judge",
				type: "POST",
				dataType: "json",
				data: sendData,
				success: function (data) {
					if (data) {						
						$("#board-title").removeAttr("readonly");
						$("textarea").removeAttr("readonly");
						$("#update-button").attr("type", "hidden");
						$("#delete-button").attr("type", "hidden");
						$("#true-update-button").attr("type", "button");
					} else {
						alert("비밀번호가 틀립니다");
					}
				},
				error: function () {
					alert("Error. 관리자에게 문의하십시오.");
				},
			});
		}
		
		function doUpdatePost() {
			var titleCheck = $("#board-title").val();
			var contentCheck = $("#board-content").val();
			
			if(titleCheck.length < 1){
				alert("제목을 입력하십시오");
				return;
			}
			if(contentCheck.length < 1){
				alert("내용을 입력하십시오");
				return;
			}
			else{
				alert("게시글을 수정하였습니다");
				$("#updateForm").submit();
			}
			
			
		}
		
	</script>
	
</html>
