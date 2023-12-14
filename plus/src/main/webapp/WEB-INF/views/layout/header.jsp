<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	function view(arg){
	$(".time1, .time2, .time3, .time4, .ad1, .ad2, .ad3, .ad4").css("display","none");
	if(arg=="0") {
		$(".time2, .ad2").css("display","block");
		viewcount = 1;
	}
	else if(arg=="1") {
		$(".time3, .ad3").css("display","block");
		viewcount = 2;
	}
	else if(arg=="2") {
		$(".time4, .ad4").css("display","block");
		viewcount = 3;
	}
	else if(arg=="3") {
		$(".time1, .ad1").css("display","block");
		viewcount = 0;
	}
	}
	var viewcount = 0;
	var rtcarousel = setInterval(function(){ view(viewcount) },5000);
	
	$("#best_search").mouseenter(function() {
		clearInterval(rtcarousel);
	});
	
	$("#best_search").mouseleave(function() {
		rtcarousel = setInterval(function(){ view(viewcount) },5000);
	});
</script>

<style>
	#txt{
	   display:flex;
	   align-items:center;
	   float:left;
	   flex:1;
	   font-family:sans-serif;
	   letter-spacing:3.5px;
	   font-size:2.0rem;
	   font-weight:700;
	   position:relative;

	}
	#txt>b{
	   height:2.0rem;
	   box-shadow:0 .4rem .3rem -.3rem #aaa;
	   color:#979c9f;
	   background:linear-gradient(#aaf,#acf,#afc);
	   background-clip:text;
	   text-fill-color:transparent;
	   -webkit-background-clip:text;
	   -webkit-text-fill-color:transparent;
	   transform-origin:bottom;
	   transform:rotateX(-85deg);
	   -webkit-transform-origin:bottom;
	   -webkit-transform:rotateX(-85deg);
	   animation:getUp 5s infinite;
	}
	#txt>b:nth-child(2){
	   animation-delay:.25s;
	}
	#txt>b:nth-child(3){
	   animation-delay:.5s;
	}
	#txt>b:nth-child(4){
	   animation-delay:.75s;
	}
	#txt>b:nth-child(5){
	   animation-delay:1s;
	}
	#txt>b:nth-child(6){
	   animation-delay:1.25s;
	}
	#txt>b:nth-child(7){
	   animation-delay:1.5s;
	}
	#txt>b:nth-child(8){
	   animation-delay:1.75s;
	}
	@keyframes getUp{
	   10%,50%{
	      transform:rotateX(0);
	   }
	   0%,60%,100%{
	      transform:rotateX(-85deg);
	   }
	}
</style>


<!-- header start-->
			<header class="clearfix">
				<span>원데이 클래스 추천 </span>
				<div class="txt" id="txt">
				        <b>원</b>
				        <b>데</b>
				        <b>이</b>
				        <b>플</b>
				        <b>러</b>
				        <b>스</b>
				        <b>+</b>
				</div>
								
				<div class="search">
					<i class="bi bi-search-heart" style="padding: 10px;"></i>
					<input type="text" placeholder="검색어를 입력하세요." class="searchbox">
					<input type="button" class="search-button" value="검색">
				</div>
				<nav>
				<c:choose>
					<c:when test="${empty sessionScope.member}">
						<a href="#" class="icon-arrow-left bi bi-cart4" data-info="위시리스트"></a>
						<a href="${pageContext.request.contextPath}/member/member" class="icon-drop bi bi-person" data-info="로그인/회원가입"></a>
						<a href="javascript:dialogLogin();" class="icon-arrow-left bi bi-person-fill-gear" data-info="로그인">로그인</a>
					</c:when>
				<c:otherwise>
					<a href="#" class="icon-arrow-left bi bi-cart4" data-info="위시리스트"></a>
					<a href="${pageContext.request.contextPath}/member/logout" class="icon-drop bi bi-person" data-info="로그아웃"></a>
					<c:if test="${sessionScope.member.membership > 90}">
						<a href="${pageContext.request.contextPath}/admin" class="icon-drop bi bi-gear-wide-connected" data-info="관리자 페이자"></a>
					</c:if>
				</c:otherwise>
				</c:choose>
				</nav>
			</header>
			
			
			
						
								
									
							
											
								
			
			
			
			
			
			
			
			

			<ul id="best_search" style="margin-left: 30px;">
				<li><p>인기검색어</p></li>
				<li>
					<dl class="time1">
						<dd><a class="t" href="#"><div class="num">1</div>공예</a></dd>
						<dd><a class="t" href="#"><div class="num">2</div>다이어트</a></dd>
						<dd><a class="t" href="#"><div class="num">3</div>향수</a></dd>
						<dd><a class="t" href="#"><div class="num">4</div>새로운 경험</a></dd>
						<dd><a class="t" href="#"><div class="num">5</div>데이트</a></dd>
					</dl>
					<dl class="time2" style="display:none;">
						<dd><a class="t" href="#"><div class="num">6</div>선물</a></dd>
						<dd><a class="t" href="#"><div class="num">7</div>뷰티</a></dd>
						<dd><a class="t" href="#"><div class="num">8</div>스트레스 해소</a></dd>
						<dd><a class="t" href="#"><div class="num">9</div>핸드메이드</a></dd>
						<dd><a class="t" href="#"><div class="num">10</div>드로잉</a></dd>
					</dl>
					<dl class="time3" style="display:none;">
						<dd><a class="t" href="#"><div class="num">11</div>음악</a></dd>
						<dd><a class="t" href="#"><div class="num">12</div>쿠킹</a></dd>
						<dd><a class="t" href="#"><div class="num">13</div>미용</a></dd>
						<dd><a class="t" href="#"><div class="num">14</div>학업</a></dd>
						<dd><a class="t" href="#"><div class="num">15</div>도예</a></dd>
					</dl>
					<dl class="time4" style="display:none;">
						<dd><a class="t" href="#"><div class="num">16</div>사진</a></dd>
						<dd><a class="t" href="#"><div class="num">17</div>미술</a></dd>
						<dd><a class="t" href="#"><div class="num">18</div>아크릴화</a></dd>
						<dd><a class="t" href="#"><div class="num">19</div>칵테일</a></dd>
						<dd><a class="t" href="#"><div class="num">20</div>금속공예</a></dd>
					</dl>
				</li>
				<li>
					<a class="best_add ad1" style="cursor:pointer" onClick="javascript:view('0')">&#62;</a>
					<a class="best_add ad2" onClick="javascript:view('1')" style="display:none;cursor:pointer" >&#62;</a>
					<a class="best_add ad3" onClick="javascript:view('2')" style="display:none;cursor:pointer" >&#62;</a>
					<a class="best_add ad4" onClick="javascript:view('3')" style="display:none;cursor:pointer" >&#60;</a>
				</li>
			</ul>	
			<div class="main">
				<nav id="cbp-hrmenu" class="cbp-hrmenu">
					<ul>
						<li>
							<a href="#">원데이 클래스</a>
							<div class="cbp-hrsub">
								<div class="cbp-hrsub-inner"> 
									<div>
										<h4>베스트 &amp; 클래스<hr class="my-hr1"></h4>
										<ul>
											<li><a href="#">향수 공방</a></li>
											<li><a href="#">쿠킹 클래스</a></li>
											<li><a href="#">드로잉 클래스</a></li>
											<li><a href="#">다이어트 클래스</a></li>
											<li><a href="#">보컬 클래스</a></li>
											<li><a href="#">댄스 클래스</a></li>
											<li><a href="#">도예 클래스</a></li>
										</ul>
									</div>
									
									<div>
										<h4>SALE<hr class="my-hr1"></h4>
										<ul>
											<li><a href="#">전통공예 클래스</a></li>
											<li><a href="#">플라워 공예 클래스</a></li>
											<li><a href="#">가죽 공예 클래스</a></li>
										</ul>
										<h4>이벤트 클래스<hr class="my-hr1"></h4>
										<ul>
											<li><a href="#">드럼 클래스</a></li>
											<li><a href="#">수채화 클래스</a></li>
										</ul>
									</div>

									<div>
										<h4>NEW 클래스<hr class="my-hr1"></h4>
										<ul>
											<li><a href="#">댄스 클래스</a></li>
											<li><a href="#">쿠킹 클래스</a></li>
											<li><a href="#">목공예 클래스</a></li>
											<li><a href="#">네일아트 클래스</a></li>
											<li><a href="#">프로듀싱 클래스</a></li>
											<li>&nbsp;</li>
											<li>&nbsp;</li>
											<li><a href="${pageContext.request.contextPath}/product/list" style="text-decoration: underline;">&gt;&gt;모든 원데이 클래스 보러가기</a></li>
										</ul>
									</div>
								</div>
							</div>
						</li>
						<li>
							<a href="#">원데이 플러스</a>
							<div class="cbp-hrsub" style="background: url('/finalApp/resources/images/beach1.jpg');">
								<div class="cbp-hrsub-inner">
									<div>
										<h4>인기 콘텐츠<hr class="my-hr1"></h4>
										<ul>
											<li><a href="#">핸드 메이드</a></li>
											<li><a href="#">필라테스</a></li>
											<li><a href="#">스포츠</a></li>
										</ul>
										<h4>추천 콘텐츠<hr class="my-hr1"></h4>
										<ul>
											<li><a href="#">플라워 가드닝</a></li>
											<li><a href="#">쿠킹</a></li>
										</ul>
									</div>
									<div>
										<h4>추천 키워드<hr class="my-hr1"></h4>
										<ul>
											<li><a href="#">#재미</a></li>
											<li><a href="#">#추억</a></li>
											<li><a href="#">#데이트</a></li>
											<li><a href="#">#이색데이트</a></li>
											<li><a href="#">#가족</a></li>
											<li><a href="#">#단체</a></li>
											<li><a href="#">#음악</a></li>
										</ul>
									</div>
									<div>
										<h4>원데이 추천 플러스<hr class="my-hr1"></h4>
										<ul>
											<img src="${pageContext.request.contextPath}/resources/images/center.jpg"  
												style="width: 400px; border-radius: 20px; 
												box-shadow: -5px -3px 3px  3px black inset, 3px 2px 3px 3px white;">
										</ul>
									</div>
								</div>
							</div>
						</li>
						<li>
							<a href="#">이벤트</a>
							<div class="cbp-hrsub">
								<div class="cbp-hrsub-inner"> 
									<div>
										<h4>첫 구매 이벤트<hr class="my-hr1"></h4>
										<ul>
											<li class="mt-3"><img src="${pageContext.request.contextPath}/resources/images/cupon.jpg" style="width: 300px; border-radius: 20px;"></li>
											<li><a href="#">- 첫 구매시 쿠폰 지급</a></li>
											<li><a href="#"style="text-decoration: underline;">&gt;&gt; 원데이 클래스 보러가기</a></li>
										</ul>
										
									</div>
									<div>
										<h4>리뷰 이벤트<hr class="my-hr1"></h4>
										<ul>
											<li class="mt-3"><img src="${pageContext.request.contextPath}/resources/images/cupon.jpg" style="width: 300px; border-radius: 20px;"></li>
											<li><a href="#">- 리뷰 작성 시 포인트 지급</a></li>
											<li><a href="#"style="text-decoration: underline;">&gt;&gt; 리뷰 게시판 바로가기</a></li>
										</ul>
										
									</div>
									<div>
										<h4>추가 쿠폰 이벤트<hr class="my-hr1"></h4>
										<ul>
											<li class="mt-3"><img src="${pageContext.request.contextPath}/resources/images/cupon.jpg" style="width: 300px; border-radius: 20px;"></li>
											<li><a href="#">- 오늘만 추가 쿠폰 지급</a></li>
											<li><a href="${pageContext.request.contextPath}/event/progress/list" style="text-decoration: underline;">&gt;&gt; 이벤트 페이지 바로가기</a></li>
										</ul>
										
									</div>
								</div>
							</div>
						</li>
						
						<li>
							<a href="#">고객센터</a>
							<div class="cbp-hrsub" style="background: url('/finalApp/resources/images/beach1.jpg');">
								<div class="cbp-hrsub-inner"> 
									<div>
										<h4>문의<hr class="my-hr1"></h4>
										<ul>
											<li><a href="#">자주 묻는 질문</a></li>
											<li><a href="#">신고 / 제안 / 문의</a></li>
											<li><a href="#">실시간 1:1 문의</a></li>
										</ul>
									</div>
									<div>
										<h4>공지사항<hr class="my-hr1"></h4>
										<ul>
											<li><a href="#">공지사항1</a></li>
											<li><a href="#">공지사항2</a></li>
											<li><a href="#">공지사항3</a></li>
											<li><a href="#">공지사항4</a></li>
											<li><a href="#">공지사항5</a></li>
											<li><a href="#">공지사항6</a></li>
										</ul>
									</div>
									<div>
										<ul>
											<li class="mt-5"><img src="${pageContext.request.contextPath}/resources/images/center.jpg" width="400px;" 
											style="border-radius: 20px; box-shadow: -5px -3px 3px  3px black inset, 3px 2px 3px 3px white;"></li>
											<li><a href="${pageContext.request.contextPath}/notice/list"style="text-decoration: underline;">&gt;&gt;고객센터 바로가기</a></li>
										</ul>

									</div>
								</div>
							</div>
						</li>
						
						<li>
						    <li onclick="urlOk('/bbs/list')" class="menubtn">커뮤니티</li>
						</li>
						
						<li>
							<li onclick="urlOk('/')" class="menubtn">사이트맵</li>
						</li>

					</ul>
				</nav>
			</div>

		
		<script src="${pageContext.request.contextPath}/resources/js/menu.js"></script>
		<script>
			function urlOk(url) {
			    window.location.href = "${pageContext.request.contextPath}" + url;
			  }
		
			$(function() {
				cbpHorizontalMenu.init();
			});
		</script>

	<!-- header end-->