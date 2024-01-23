<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath }" scope="session" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스프링 게시판</title>
<link type="text/css" rel="stylesheet" href="${path}/css/style.css" />
</head>

<body>
	<header>
		Portfolio
	</header>
	<nav>
		&emsp;<a class="button" href="index.do">홈으로</a>
		&emsp;<a class="button" href="getGuestbookList.do"> 목록보기 </a>
		&emsp;<a class="button" href="getRestaurantList.do"> 맛집 </a>
	</nav>


	