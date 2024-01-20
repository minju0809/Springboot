<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br>
  <div align=center>
    <h2>방명록 목록</h2>
    <table border="1">
      <tr>
        <th align="right" colspan="4"><button onclick="location.href='guestbookForm.do'">글쓰기</button>&emsp;
        </th>
      </tr>
      <tr>
        <th>번호</th>
        <th>이름</th>
        <th width="150">메모</th>
        <th>날짜</th>
      </tr>
      <c:forEach items="${li}" var="record">
        <tr>
          <td>${record.guestbook_idx}</td>
          <td><a href="getGuestbook.do?guestbook_idx=${record.guestbook_idx}">${record.guestbook_name}</a></td>
          <td>
            <c:choose>
              <c:when test="${fn:length(record.guestbook_memo) > 10}">
                ${fn:substring(record.guestbook_memo, 0, 10)}...
              </c:when>
              <c:otherwise>
                ${record.guestbook_memo}
              </c:otherwise>
            </c:choose>
          </td>
          <td>${record.guestbook_today.substring(0, 10)}</td>
      </tr>
      </c:forEach>
    </table>
  </div>
  <br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />

