<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br><br>
  <div align=center>
    <h2>상품등록</h2>
    <br>
    <form action="/a/productInsert.do" method="post" enctype="multipart/form-data">
      <table class="another-table">
        <tr>
          <th>상품이름</th>
          <td><input type="text" name="product_name"></td>
        </tr>
        <tr>
          <th>가격</th>
          <td><input type="text" name="product_price"></td>
        </tr>
        <tr>
          <th>상세설명</th>
          <td><input type="text" name="product_desc"></td>
        </tr>
        <tr>
          <th>이미지</th>
          <td><input type="file" name="product_img"></td>
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