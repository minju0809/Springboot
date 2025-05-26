<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br>
  <div class="record-info">
    <div>1. 전체 레코드 수 : ${totalCount}</div>
    <div>2. 총 페이지 수 : ${totalPage}</div>
  </div>
  <br>
  <div align=center>
    <h2>방명록 목록</h2>
    <br>
    <table class="basic-table">
      <tr>
        <th colspan="7">
          <div style="text-align: left; float: left;">
              <a class="button" href="/a/guestbookAdd.do"> 방명록 추가 </a>
          </div>
          <div style="text-align: right; float: right;">
              <a class="button" href="guestbookForm.do"> 글쓰기 </a>
          </div>
      </th>
      </tr>
      <tr>
        <th>번호</th>
        <th>이름</th>
        <th class="memo">메모</th>
        <th>날짜</th>
        <th>삭제</th>
      </tr>
      <c:forEach items="${li}" var="record">
        <tr>
          <td>${record.guestbook_idx}</td>
          <td><a class="button" href="getGuestbook.do?guestbook_idx=${record.guestbook_idx}&page=${page}&ch1=${ch1}&ch2=${ch2}">${record.guestbook_name}</a></td>
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
          <td><a href="#" onclick="confirmDelete('${record.guestbook_idx}'); return false;">삭제</a></td>
      </tr>
      </c:forEach>
    </table>

    <form action="getGuestbookList.do">
      <select name="ch1">
        <option value="guestbook_name">이름</option>
        <option value="guestbook_memo">메모</option>
        <option value="guestbook_today">날짜</option>
      </select>
      <input type="text" name="ch2">
      <input type="submit" value="검색">
    </form>

    <div class="pagination">
      <a class="button" href="getGuestbookList.do?page=1&ch1=${ch1}&ch2=${ch2}">처음으로</a>

      <a href="getGuestbookList.do?page=${currentPage > 1 ? currentPage - 1 : 1}&ch1=${ch1}&ch2=${ch2}">이전</a>

      <c:forEach var="page_num" begin="${startPage}" end="${endPage}">
          <a href="getGuestbookList.do?page=${page_num}&ch1=${ch1}&ch2=${ch2}">
            <c:if test="${currentPage == page_num}"></c:if>
            ${page_num}
          </a>
      </c:forEach>

      <c:if test="${currentPage < totalPage}">
        <a href="getGuestbookList.do?page=${currentPage + 1}&ch1=${ch1}&ch2=${ch2}">다음</a>
      </c:if>
      
      <a href="getGuestbookList.do?page=${totalPage}&ch1=${ch1}&ch2=${ch2}">마지막</a>
    </div>
  </div>
  <br>
</section>

<script>
  function confirmDelete(guestbook_idx) {
    var result = confirm("정말로 삭제하시겠습니까?");
    if (result) {
      location.href = 'guestbookDelete.do?guestbook_idx=' + guestbook_idx + '&page=${page}&ch1=${ch1}&ch2=${ch2}';
    }
    return result;
  }
</script>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />

