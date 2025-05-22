<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@taglib uri="http://java.sun.com/jstl/core_rt"
prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath }" scope="session" />

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Shop</title>
    <link type="text/css" rel="stylesheet" href="/css/style.css" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp"
    />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
  </head>

  <body>
    <header class="header">
      <div class="logo"><a class="button" href="/jsp.do">드림페이퍼</a></div>
      <c:if test="${session.username eq 'admin'}">
        <a class="button" href="/a/productForm.do"> 상품등록 </a>
      </c:if>
      <div class="auth-buttons">
        <c:choose>
          <c:when test="${empty session.username}">
            <a href="/memberForm.do">회원가입</a>
            <a href="/login.do">로그인</a>
          </c:when>
          <c:otherwise>
            <a href="/getMember.do?member_idx=${session.member_idx}"
              >마이페이지</a
            >
            <a href="/getCartList.do">장바구니</a>
            <a href="/getOrderList.do">주문확인</a>
            <a
              class="button"
              href="/getBoardBookmark.do?member_idx=${session.member_idx}"
            >
              북마크
            </a>
            <a href="/logout">로그아웃</a>
          </c:otherwise>
        </c:choose>
      </div>
    </header>

    <nav id="nav">
      <!-- <div class="list-container">
					<h4>맛집</h4>
					<ul class="list">
						<li><a class="button" href="/getRestaurantList.do"> 맛집목록 </a></li>
						<li><a class="button" href="/getRestaurantMap.do"> 맛집지도 </a></li>
					</ul>
				</div> -->
      <div class="menu-item">
        <h4><a class="button" href="/getBoardList.do"> 게시판 </a></h4>
      </div>
      <div class="list-container">
        <h4><a class="button" href="/getGuestbookList.do"> 방명록 </a></h4>
        <ul class="list">
          <c:if test="${session.username eq 'admin'}">
            <li>
              <a class="button" href="/a/guestbookAdd.do"> 방명록 추가 </a>
            </li>
          </c:if>
        </ul>
      </div>
      <c:if test="${session.username eq 'admin'}">
        <div class="menu-item">
          <h4><a class="button" href="/a/admin.do"> 관리페이지 </a></h4>
        </div>
      </c:if>
      <div class="list-container">
        <h4>SideWorks</h4>
        <ul class="list">
					<li>
						<a
						class="button"
						href="https://firstnumberbaseballgame.netlify.app/"
						target="_blank"
						>야구게임</a
            >
          </li>
					<li><a class="button" href="/calendarToDoList.do">달력</a></li>
          <li>
            <a class="button" href="/dashboard.do" target="_blank">대시보드</a>
          </li>
        </ul>
      </div>
    </nav>
  </body>
</html>
