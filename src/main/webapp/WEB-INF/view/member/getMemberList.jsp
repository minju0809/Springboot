<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br>
  <div align=center>
    <h2>맴버 목록</h2>
    <br>
    <table border="1">
      <tr>
        <th>번호</th>
        <th>아이디</th>
        <th>비밀번호</th>
        <th>등급</th>
        <th>이름</th>
        <th>번호</th>
        <th>메일</th>
        <th>우편번호</th>
        <th>주소</th>
        <th>상세주소</th>
        <th>나머지</th>
        <th>날짜</th>
        <th>기타</th>
      </tr>
      <c:forEach items="${li}" var="record">
        <tr>
          <td>${record.member_idx}</td>
          <td>${record.username}</td>
          <td>${record.password}</td>
          <td>${record.role}</td>
          <td>${record.name}</td>
          <td>${record.phone}</td>
          <td>${record.email}</td>
          <td>${record.postcode}</td>
          <td>${record.address}</td>
          <td>${record.detailAddress}</td>
          <td>${record.extraAddress}</td>
          <td>${record.regdate}</td>
          <td>${record.etc}</td>
        </tr>
      </c:forEach>
    </table>

    <form action="getMemberList.do">
      <select name="ch1">
        <option value="username">아이디</option>
        <option value="name">이름</option>
        <option value="address">지역</option>
        <option value="regdate">날짜</option>
      </select>
      <input type="text" name="ch2">
      <input type="submit" value="검색">
    </form>
  </div>
  <br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />