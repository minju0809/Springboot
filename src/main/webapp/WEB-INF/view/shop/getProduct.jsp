<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

  <c:import url="${path}/WEB-INF/view/include/top.jsp" />

  <section>
    <br>
    <div align=center>
      <h2>상품 상세보기</h2>
      <form action="cartAdd.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="product_idx" value="${product.product_idx}">
        <table border="1">
          <tr>
            <td colspan="2"><img src="/img/shop/${product.product_imgStr}" alt="image" name="product_imgStr" width="300"></td>
          </tr>
          <tr>
            <th>번호</th>
            <td><input type="text" name="product_idx" value="${product.product_idx}" readonly></td>
          </tr>
          <tr>
            <th>이름</th>
            <td><input type="text" name="product_name" value="${product.product_name}" readonly></td>
          </tr>
          <tr>
            <th>가격</th>
            <td><input type="text" name="product_price" value="${product.product_price}" readonly></td>
          </tr>
          <tr>
            <th>수량</th>
            <td>
              <select name="product_amount">
                <option value=1>1일</option>
                <option value=2>2일</option>
                <option value=3>3일</option>
              </select>
            </td>
          </tr>
          <tr>
            <th>상세설명</th>
            <td><textarea cols="30" rows="5" type="text" name="product_desc" readonly>${product.product_desc}</textarea>
            </td>
          </tr>
          <tr>
            <td align="center" colspan="2">
              <input type=button onClick="location.href='getProductList.do'" value="목록으로" />
              <input type="submit" value="장바구니에 추가">
            </td>
          </tr>
        </table>
      </form>
    </div>
    <br>
  </section>

  <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />