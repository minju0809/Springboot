<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br>
  <div align=center>
    <br>
    <h2>북마크 목록</h2>
    <br>
    <div class="board-container">
      <c:forEach items="${li}" var="record">
        <div class="board" onclick="location.href='/getBoard.do?board_idx=${record.board_idx}&start=${start}&ch1=${ch1}&ch2=${ch2}'">
          <img class="img" src="${record.board_imgStr}" alt="image" width="100" height="80">
          <div class="board-content">
            <p>제목: ${record.board_title}</p>
            <p>작성자: ${record.member_name}</p>
            <p>조회수: ${record.board_cnt}</p>
            <p>등록일: ${record.board_today.substring(0, 10)}</p>
          </div>
        </div>
      </c:forEach>
    </div>
    <br>
  </div>
  <br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />