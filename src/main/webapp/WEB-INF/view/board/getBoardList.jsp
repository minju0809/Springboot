<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br>
  <div align=center>
    <h2>게시판 목록</h2>
    <br>
    <div class="board-container">
      <c:forEach items="${li}" var="record">
        <div class="board" onclick="location.href='/getBoard.do?board_idx=${record.board_idx}&start=${start}&ch1=${ch1}&ch2=${ch2}'">
          <img class="img" src="/img/board/${record.board_imgStr}" alt="image" width="100">
          <div class="board-content">
            <p>제목: ${record.board_title}</p>
            <p>조회수: ${record.board_cnt}</p>
            <p>등록일: ${record.board_today.substring(0, 10)}</p>
          </div>
        </div>
      </c:forEach>
    </div>
    <table border="1">
      <tr>
        <th colspan="7">
          <div style="text-align: right; float: right;">
            <a class="button" href="/m/boardForm.do"> 글쓰기 </a>
          </div>
        </th>
      </tr>

      <tr>
        <th>번호</th>
        <th>이름</th>
        <th>제목</th>
        <th>내용</th>
        <th>사진</th>
        <th>날짜</th>
      </tr>
      <c:forEach items="${li}" var="record">
        <tr>
          <td>${record.board_idx}</td>
          <td><a class="button"
              href="getBoard.do?board_idx=${record.board_idx}&start=${start}&ch1=${ch1}&ch2=${ch2}">${record.member_name}</a>
          </td>
          <td>${record.board_title}</td>
          <td>
            <c:choose>
              <c:when test="${fn:length(record.board_content) > 10}">
                ${fn:substring(record.board_content, 0, 10)}...
              </c:when>
              <c:otherwise>
                ${record.board_content}
              </c:otherwise>
            </c:choose>
          </td>
          <td>
            <img src="/img/board/${record.board_imgStr}" alt="image" width="50">
          </td>
          <td>${record.board_today.substring(0, 10)}</td>
        </tr>
      </c:forEach>
    </table>
    <form action="getBoardList.do">
      <select name="ch1">
        <option value="board_title">제목</option>
        <option value="board_content">내용</option>
        <option value="board_today">날짜</option>
      </select>
      <input type="text" name="ch2">
      <input type="submit" value="검색">
    </form>
  </div>
  <br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />