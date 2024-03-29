<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

  <c:import url="${path}/WEB-INF/view/include/top.jsp" />

  <section>
    <br><br>
    <div align=center>
      <h2>방명록 상세보기</h2>
      <br>
      <form action="guestbookUpdate.do">
        <input type="hidden" name="start" value="${param.start}">
        <input type="hidden" name="ch1" value="${param.ch1}">
        <input type="hidden" name="ch2" value="${param.ch2}">
        <table class="another-table">
          <tr>
            <th>번호</th>
            <td><input type="text" name="guestbook_idx" value="${guestbook.guestbook_idx}" readonly></td>
          </tr>
          <tr>
            <th>이름</th>
            <td><input type="text" name="guestbook_name" value="${guestbook.guestbook_name}" readonly></td>
          </tr>
          <tr>
            <th>메모</th>
            <td><textarea cols="30" rows="5" type="text" name="guestbook_memo">${guestbook.guestbook_memo}</textarea>
            </td>
          </tr>
          <tr>
            <th>날짜</th>
            <td><input type="text" name="guestbook_today" value="${guestbook.guestbook_today}" readonly></td>
          </tr>
          <tr>
            <td align="center" colspan="2">
              <input type="submit" value="수정">
              <input type="button" onclick="confirmDelete()" value="삭제">
            </td>
          </tr>
        </table>
      </form>
    </div>
    <br>
  </section>

  <script>
    function confirmDelete() {
      var result = confirm("정말로 삭제하시겠습니까?");
      if (result) {
        location.href = 'guestbookDelete.do?guestbook_idx=${guestbook.guestbook_idx}&start=${param.start}&ch1=${param.ch1}&ch2=${param.ch2}';
      }
      return result;
    }
  </script>

  <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />