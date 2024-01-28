<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
		<c:set var="path" value="${pageContext.request.contextPath }" scope="session" />

		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>스프링 게시판</title>
			<link type="text/css" rel="stylesheet" href="/css/style.css" />
		</head>

		<body>
			<nav id="nav">
				<div class="list-container">
					<h2>Portfolio</h2>
					<ul class="list">
						<li><a class="button" href="/">시작으로</a></li>
						<li><a class="button" href="/jsp.do">홈으로</a></li>
					</ul>
				</div>
				<div class="list-container">
					<h4>방명록</h4>
					<ul class="list">
						<li><a class="button" href="/getGuestbookList.do"> 목록보기 </a></li>
						<li><a class="button" href="/a/guestbookAdd.do"> 방명록 추가 </a></li>
						<li><a class="button" href="/guestbookForm.do"> 글쓰기 </a></li>
					</ul>
				</div>
				<div class="list-container">
					<h4>맛집</h4>
					<ul class="list">
						<li><a class="button" href="/getRestaurantList.do"> 맛집목록 </a></li>
						<li><a class="button" href="/getRestaurantMap.do"> 맛집지도 </a></li>
					</ul>
				</div>
				<div class="list-container">
					<h4>상품</h4>
					<ul class="list">
						<li><a class="button" href="/getProductList.do"> 상품목록 </a></li>
						<li><a class="button" href="/a/productForm.do"> 상품등록 </a></li>
					</ul>
				</div>
				<div class="list-container">
					<h4>맴버</h4>
					<ul class="list">
						<li><a class="button" href="/memberForm.do"> 회원가입 </a></li>
						<li><a class="button" href="/a/getMemberList.do"> 맴버목록 </a></li>
					</ul>
				</div>
				<div class="list-container">
					<c:choose>
							<c:when test="${empty session.username}">
									<h4>로그인</h4>
									<ul class="list">
											<li class="menu5">
													<a href="/login.do">
															<span>로그인</span>
													</a>
											</li>
											<li class="menu6">
												<a href="/logout">
														<span>로그아웃</span>
												</a>
										</li>
									</ul>
							</c:when>
							<c:otherwise>
									<h4>${session.username}(${session.name})</h4>
									<ul class="list">
											<li class="menu6">
													<a href="/logout">
															<span>로그아웃</span>
													</a>
											</li>
									</ul>
							</c:otherwise>
					</c:choose>
			</div>
			</nav>