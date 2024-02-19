<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <c:import url="${path}/WEB-INF/view/include/top.jsp" />

    <section>
      <br><br>
      <div align=center>
        <h2>방명록 입력</h2>
        <br>
        <form action="guestbookInsert.do">
          <table class="another-table">
            <tr>
              <th>이름</th>
              <td><input type="text" name="guestbook_name"></td>
            </tr>
            <tr>
              <th>메모</th>
              <td><textarea cols="30" rows="5" name="guestbook_memo"></textarea></td>
            </tr>
            <tr>
              <td align="center" colspan="2"><input type="submit" value="저장하기"></td>
            </tr>
          </table>
        </form>
      </div>
      <br>
    </section>

    <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />


