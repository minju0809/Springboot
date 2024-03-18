<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script>
  function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
</script>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />
<section>
  <br>
  <h2>&emsp;관리자 보드</h2>
  <br>
  <div align="center">
    <h2>맴버 목록</h2>
    <br>
    <form action="/a/admin.do" align="left">
      &emsp;&emsp;&emsp;&emsp;
      <select name="ch1">
        <option value="username">아이디</option>
        <option value="name">이름</option>
        <option value="address">지역</option>
        <option value="regdate">날짜</option>
      </select>
      <input type="text" name="ch2">
      <input type="submit" value="검색">
    </form>
    <br>
    <table class="basic-table">
      <tr>
        <th>번호</th>
        <th>아이디</th>
        <th>비밀번호</th>
        <th>등급</th>
        <th>이름</th>
        <th>번호</th>
        <th>지역</th>
        <th>날짜</th>
        <th>기타</th>
      </tr>
      <c:forEach items="${memberList}" var="record">
        <tr>
          <td>${record.member_idx}</td>
          <td>
            <a href="/getMember.do?member_idx=${record.member_idx}">
              <c:if test="${not empty record.uuid}">
                <span class="warning">(카)</span>
              </c:if>
              ${record.username}
            </a>
          </td>
          <td>${record.password.substring(0,10)}...</td>
          <td>${record.role}</td>
          <td>${record.name}</td>
          <td>${record.phone}</td>
          <td>${record.address.substring(0,2)}</td>
          <td>${record.regdate.substring(0,10)}</td>
          <td>${record.etc}</td>
        </tr>
      </c:forEach>
    </table>
    <br>
    <br>
    <h2>전체 장바구니 목록</h2>
    <br>
    <form name="f1" method="post" enctype="multipart/form-data">
      <table class="basic-table">
        <tr>
          <td>cart_id</td>
          <td>img</td>
          <td>memberId</td>
          <td>product_id</td>
          <td>product_name</td>
          <td>amount</td>
          <td>price</td>
        </tr>
        <c:forEach items="${ cartList }" var="m" varStatus="status">
          <c:set var="order_price" value="${order_price + m.product_price}"></c:set>
          <input type="hidden" name="order_idx" value="${ order_idx }" />
          <input type="hidden" name="member_idx" value="${ m.member_idx }" />
          <input type="hidden" name="cart_idx" value="${ m.cart_idx }" />
          <input type="hidden" name="product_idx" value="${ m.product_idx }" />
          <input type="hidden" name="product_name" value="${ m.product_name }" />
          <input type="hidden" name="product_imgStr" value="${ m.product_imgStr }">
          <input type="hidden" name="order_price" value="${ order_price }">
          <tr>
            <td>${ m.cart_idx }</td>
            <td><img src="${ path }/img/shop/${ m.product_imgStr }" width=50 height=50 /></td>
            <td>${ m.member_idx }</td>
            <td>${ m.product_idx }</td>
            <td>${ m.product_name }</td>
            <td>${m.product_amount}</td>
            <td>${ m.product_price }</td>
          </tr>
        </c:forEach>
        <c:if test="${empty cartList}">
          <tr>
            <td colspan="8" align="center">장바구니가 비어있습니다.</td>
          </tr>
        </c:if>
        <tr>
          <td colspan="8" align="right">전체 구매 금액:
            <span id="formattedTotal">${order_price}</span>원
          </td>
        </tr>
      </table>
      <br>
    </form>
    <br>
    <h2>전체 주문 목록</h2>
    <br>
    <form name="f1">
      <table class="basic-table">
        <tr>
          <td>order_id</td>
          <td>memberId</td>
          <td>username</td>
          <td>price</td>
          <td>order_today</td>
        </tr>
        <c:forEach items="${ orderList }" var="m" varStatus="status">
          <c:set var="total_order_price" value="${total_order_price + m.product_price}"></c:set>
          <tr>
            <td><a href="/getDetailOrderList.do?order_idx=${m.order_idx}">${ m.order_idx }</a></td>
            <td>${ m.member_idx }</td>
            <td>${ m.username }</td>
            <td>
              <span id="${m.product_idx}_price">
                <fmt:formatNumber value="${m.product_price}" pattern="#,##0" />
              </span>원
            </td>
            <td>${ m.order_today }</td>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty orderList}">
          <tr>
            <td colspan="9" align="center">주문 목록이 비어있습니다.</td>
          </tr>
        </c:if>
        <tr>
          <td colspan="9" align="right">전체 구매 금액:
            <fmt:formatNumber value="${total_order_price}" pattern="#,##0" />원
          </td>
        </tr>
      </table>
      <br>
    </form>
  </div>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />