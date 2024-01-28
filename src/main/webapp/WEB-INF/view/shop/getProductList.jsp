<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br>
  <div align=center>
    <h2>상품 목록</h2>
    <br>
    <table border="1">
      <tr>
        <th>번호</th>
        <th>이름</th>
        <th>가격</th>
        <th>상세설명</th>
        <th>이미지이름</th>
        <th>이미지</th>
      </tr>
      <c:forEach items="${li}" var="record">
        <tr>
          <td>${record.product_idx}</td>
          <td><a href="/getProduct.do?product_idx=${record.product_idx}">${record.product_name}</a></td>
          <td><fmt:formatNumber value="${record.product_price}" pattern="#,###"/></td>
          <td>${record.product_desc}</td>
          <td>${record.product_imgStr}</td>
          <td><img src="/img/shop/${record.product_imgStr}" alt="image" width="50" height="50">
          </td>
        </tr>
      </c:forEach>
    </table>

    <form action="getProductList.do">
      <select name="ch1">
        <option value="product_name">이름</option>
        <option value="product_desc">상세설명</option>
      </select>
      <input type="text" name="ch2">
      <input type="submit" value="검색">
    </form>
  </div>
  <br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />