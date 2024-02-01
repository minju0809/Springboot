<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <c:import url="${path}/WEB-INF/view/include/top.jsp" />

    <section>
      <br>
      <div align=center>
        <h2>게시 글 등록</h2>
        <form action="/m/boardInsert.do" method="post" enctype="multipart/form-data">
          <table border="1">
            <tr>
              <td>
                지도
              </td>
            </tr>
            <tr>
              <th>제목</th>
              <td><input type="text" name="board_title"></td>
            </tr>
            <tr>
              <th>내용</th>
              <td><textarea cols="30" rows="5" name="board_content"></textarea></td>
            </tr>
            <tr>
              <th>사진</th>
              <td>
                <input type="file" name="board_img">
              </td>
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


