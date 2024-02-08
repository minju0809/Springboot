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
						<li><a class="button" href="https://firstnumberbaseballgame.netlify.app/" target="_blank">야구게임</a></li>
						<c:if test="${session.username eq 'admin'}">
							<li><a class="button" href="/a/dashboard.do">대시보드</a></li>
						</c:if>
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

						<c:set var="cartListUrl" value="" />
						<c:choose>
							<c:when test="${session.username eq 'admin'}">
								<c:set var="cartListUrl" value="/adminGetCartList.do" />
							</c:when>
							<c:otherwise>
								<c:set var="cartListUrl" value="/getCartList.do" />
							</c:otherwise>
						</c:choose>
						<c:set var="orderListUrl" value="" />
						<c:choose>
							<c:when test="${session.username eq 'admin'}">
								<c:set var="orderListUrl" value="/adminGetOrderList.do" />
							</c:when>
							<c:otherwise>
								<c:set var="orderListUrl" value="/getOrderList.do" />
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<div class="list-container">
					<h4>게시판</h4>
					<ul class="list">
						<li><a class="button" href="/getBoardList.do"> 목록보기 </a></li>
						<li><a class="button" href="/m/boardForm.do"> 글쓰기 </a></li>
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
				<c:if test="${session.username eq 'admin'}">
					<div class="list-container">
						<h4>맴버</h4>
						<ul class="list">
							<li><a class="button" href="/a/getMemberList.do"> 맴버목록 </a></li>
						</ul>
					</div>
				</c:if>
				<div class="list-container">
					<c:choose>
						<c:when test="${empty session.username}">
							<h4>로그인</h4>
							<ul class="list">
								<li><a class="button" href="/memberForm.do"> 회원가입 </a></li>
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
								<li>
									<a href="/getMember.do?member_idx=${session.member_idx}">
										<span>마이페이지</span>
									</a>
								</li>
								<c:if test="${not empty session.username}">
									<li><a class="button" href="<c:out value='${cartListUrl}'/>">장바구니</a></li>
								</c:if>
								<c:if test="${not empty session.username}">
									<li><a class="button" href="<c:out value='${orderListUrl}'/>">주문확인</a></li>
								</c:if>
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