<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br>
  <div align=center>
    <h2>게시판 상세보기</h2>
    <br>
    <table border="1">
      <tr>
        <th>번호</th>
        <td>${board.board_idx}</td>
      </tr>
      <tr>
        <th>이름</th>
        <td>${board.member_name}</td>
      </tr>
      <tr>
        <th>제목</th>
        <td>${board.board_title}</td>
      </tr>
      <tr>
        <th>내용</th>
        <td>${board.board_content}</td>
      </tr>
      <tr>
        <th>총 이동거리</th>
        <td>${board.board_map}</td>
      </tr>
      <tr>
        <th>사진</th>
        <td>
          <img src="/img/board/${board.board_imgStr}" alt="image" width="50" height="40">
        </td>
      </tr>
      <tr>
        <th>날짜</th>
        <td>${board.board_today}</td>
      </tr>  
    </table>
  </div>
  <br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />