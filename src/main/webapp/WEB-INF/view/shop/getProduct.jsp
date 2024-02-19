<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

  <c:import url="${path}/WEB-INF/view/include/top.jsp" />

  <section>
    <br><br>
    <div align=center>
      <h2>상품 상세보기</h2>
      <br>
      <form id="addToCartForm" action="cartAdd.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="product_imgStr" value="${product.product_imgStr}">
        <input type="hidden" id="loginCheck" value="${empty session.username}">
        <table class="another-table">
          <tr>
            <td colspan="2"><img src="/img/shop/${product.product_imgStr}" alt="image" width="300"></td>
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
              <input type="button" onclick="addToCart()" value="장바구니에 추가">
            </td>
          </tr>
        </table>
      </form>
    </div>
    <br>
  </section>

  <script>
    function addToCart() {
        var loginCheck = document.getElementById("loginCheck").value;

        if (loginCheck === "true") {
            if (confirm("로그인이 되어 있지 않습니다. 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
                window.location.href = '/login.do'; 
            }
        } else {
            document.getElementById("addToCartForm").submit();
        }
    }
</script>

  <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />