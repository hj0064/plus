<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">

<style type="text/css">
.accordion {
	box-sizing: border-box;
	width: 100%;
	min-height: 50px;
	margin: 15px auto 5px;
}

.accordion div.question {
	box-sizing: border-box;
    color:#333;
    border:1px solid #ccc;
    background-color:#fff;
    padding: 0 15px;
    border-radius:4px;	
    margin: 3px 0 0;
}
.accordion div.question:hover {
	 background-color: #F8FFFF;
}

.accordion div.question .subject:hover {
	color: #0d58ba;
}

.accordion div.answer {
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-top: none;
	min-height: 50px;
	padding: 3px 10px 10px;
	display: none;
}

.accordion div.answer > .category {
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #eee;
}

.accordion div.answer > .content {
	padding: 7px 15px 5px;
}
.accordion div.answer > .content div:first-child {
	font-weight: 700;
	display: inline-block;
	vertical-align: top;
	padding-left: 5px;
}
.accordion div.answer > .content div:last-child {
	display: inline-block;
}

.accordion div.answer > .update {
	text-align: right;
}

.accordion div.active {
	font-weight: 600;
	background-color: #f8f9fa;
}
.rere {
	color: white;
	background: #46AA46;
	padding: 6px 12px 6px 12px;
	border: none;
}
</style>

<script type="text/javascript">
$(function(){
	$("#tab-content").on("click", ".accordion div.question", function(){
		 const $answer = $(this).next(".accordion div.answer");
		 let isVisible = $answer.is(':visible');
		 if(isVisible) {
			 $(this).next(".accordion div.answer").hide();
			 $(this).removeClass("active");
		 } else {
			 $(".accordion div.answer").hide();
			 $(".accordion div.question").removeClass("active");
			 
			 $(this).next(".accordion div.answer").show();
			 $(this).addClass("active");
		 }
	});
});

$(function(){
	let cateNum = "${cateNum}";
	let pageNo = "${pageNo}";
	if(pageNo === "") {
		pageNo = 1;
	}
	$("#tab-"+cateNum).addClass("active");
	listPage(pageNo);

	$("ul.tabs li").click(function() {
		cateNum = $(this).attr("data-cateNum");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+cateNum).addClass("active");
		
		listPage(1);
	});
});

function login() {
	location.href = '${pageContext.request.contextPath}/member/login';
}

function ajaxFun(url, method, formData, dataType, fn, file = false) {
	const settings = {
			type: method, 
			data: formData,
			success:function(data) {
				fn(data);
			},
			beforeSend: function(jqXHR) {
				jqXHR.setRequestHeader('AJAX', true);
			},
			complete: function () {
			},
			error: function(jqXHR) {
				if(jqXHR.status === 403) {
					login();
					return false;
				} else if(jqXHR.status === 400) {
					alert('요청 처리가 실패 했습니다.');
					return false;
		    	}
		    	
				console.log(jqXHR.responseText);
			}
	};
	
	if(file) {
		settings.processData = false;  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		settings.contentType = false;  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
	}
	
	$.ajax(url, settings);
}

// 글리스트 및 페이징 처리
function listPage(page) {
	const $tab = $(".tabs .active");
	let cateNum = $tab.attr("data-cateNum");
	
	let url = "${pageContext.request.contextPath}/admin/faqManage/list";
	let query = "pageNo="+page+"&cateNum="+cateNum;
	let search = $('form[name=faqSearchForm]').serialize();
	query = query+"&"+search;
	
	let selector = "#tab-content";
	
	const fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 검색
function searchList() {
	const f = document.faqSearchForm;
	f.schType.value = $("#schType").val();
	f.kwd.value = $("#kwd").val().trim();

	listPage(1);
}

// 새로고침
function reloadFaq() {
	const f = document.faqSearchForm;
	f.schType.value = "all";
	f.kwd.value = "";
	
	$("#schType").val("all");
	$("#kwd").val("");
	
	listPage(1);
}

// 글 삭제
function deleteFaq(num, page) {
	var url = "${pageContext.request.contextPath}/admin/faqManage/delete";
	var query = "num="+num;
	
	if(! confirm("위 게시물을 삭제 하시 겠습니까 ? ")) {
		  return;
	}
	
	const fn = function(data){
		listPage(page);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}
</script>

<main class="wrapper" style="margin:0 auto; width:100%;" >
	<div id="layoutSidenav_content" style="background: #F8F8FF;">
		<div class="container-fluid px-5">
			<div class="body-container" style="width:80%; margin:5% auto; ">
				<div class="body-main">
					<h3 class="mb-3 p-2" style="border-bottom:3px solid black;">
						<i class="fa-solid fa-clipboard-question"></i> 자주하는 질문
						<button type="button" class="btn btn-success rere" onclick="reloadFaq();" title="새로고침" style="float: right;">
							<i class="fa-solid fa-arrow-rotate-left"></i>
						</button>
						<button type="button" class="btn btn-success rere me-3" onclick="location.href='${pageContext.request.contextPath}/admin/faqManage/write';" style="float: right;">글올리기</button>
					</h3>

					<div>
						<ul class="tabs">
							<li id="tab-0" data-cateNum="0">모두</li>
							<c:forEach var="dto" items="${listCategory}">
								<li id="tab-${dto.cateNum}" data-cateNum="${dto.cateNum}">${dto.faqName}(${dto.showUser == 0 ? "공통" : (dto.showUser == 1 ? "이용자" : "플러스")})</li>
							</c:forEach>
						</ul>
					</div>
					
					<div id="tab-content" style="padding: 15px 10px 5px;"></div>
					
					<table class="table">
						<tr>
							<td align="center">
								<form name="searchForm" action="${pageContext.request.contextPath}/admin/faqManage/main" method="post" style="width: 300px; margin-left: 100px">
									<div class="input-group mb-3">
										<select id="schType" name="schType" class="form-select">
											<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
											<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
											<option value="content" ${schType=="content"?"selected":""}>내용</option>
										</select>
										<input type="text" id="kwd" name="kwd" class="form-control" value="${kwd}">
										<button type="button" class="btn btn-success rere" onclick="searchList();">검색</button>
									</div>
								</form>
							</td>
								<td align="right" width="120"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</main>

<form name="faqSearchForm" method="post">
	<input type="hidden" name="schType" value="all">
    <input type="hidden" name="kwd" value="">
</form>

