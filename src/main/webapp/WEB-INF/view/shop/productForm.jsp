<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br><br>
  <div align=center>
    <h2>${empty product ? '상품 등록' : '상품 수정'}</h2>
    <br>
    <form action="${empty product ? '/a/productInsert.do' : '/a/productUpdate.do'}" method="post" enctype="multipart/form-data">
      <c:if test="${not empty product}">
        <input type="hidden" name="product_idx" value="${product.product_idx}">
      </c:if>
      <input type="hidden" name="product_imgStr" value="${product.product_imgStr}">
      <table class="another-table">
        <tr>
          <th>상품명</th>
          <td><input type="text" name="product_name" value="${product.product_name}" required></td>
        </tr>
        <tr>
          <th>가격</th>
          <td><input type="number" name="product_price" value="${product.product_price}" required></td>
        </tr>
        <tr>
          <th>상세설명</th>
          <td><textarea name="product_desc" rows="5" cols="30" required>${product.product_desc}</textarea></td>
        </tr>
        <tr>
          <th>이미지</th>
          <td>
            <c:if test="${not empty product}">
              <img src="${product.product_imgStr}" alt="현재 이미지" width="100" height="100"><br>
            </c:if>
            <input type="file" name="product_img">
          </td>
        </tr>
        <tr>
          <td colspan="2" align="center">
            <input type="submit" value="${empty product ? '등록' : '수정'}">
            <input type="button" value="취소" onclick="location.href='getProductList.do'">
          </td>
        </tr>
      </table>
    </form>
  </div>
  <br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />