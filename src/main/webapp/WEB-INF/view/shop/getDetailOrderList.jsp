<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<script>
	function numberWithCommas(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>

<section>
	<br>
	<div align=center>
		<h3>주문서</h3>
		<br>
		<form name="f1">
			<table class="basic-table">
			  <c:forEach items="${li}" var="m" varStatus="status" begin="0" end="0">
					<tr>
						<td colspan="9">
							<p>주문자: ${m.username} (이름: ${m.name}) &emsp;&emsp; 연락처: ${m.phone}</p>
							<p>주소: (${m.postcode}) ${m.address}, ${m.detailAddress}</p>
							<p>주문일: ${m.order_today}</p>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td>order_id</td>
					<td>cart_id</td>
					<td>member_id</td>
					<td>product_id</td>
					<td>img</td>
					<td>product_name</td>
					<td>amount</td>
					<td>order_price</td>
				</tr>
				<c:forEach items="${ li }" var="m" varStatus="status">
					<c:set var="order_price" value="${order_price + m.product_price}"></c:set>
					<tr>
						<td>${ m.order_idx }</td>
						<td>${ m.cart_idx }</td>
						<td>${ m.member_idx }</td>
						<td>${ m.product_idx }</td>
						<td><img src="${m.product_imgStr}" alt="image" width="50" height="50"></td>
						<td>${ m.product_name }</td>
						<td>${ m.product_amount }</td>
						<td>
							<span id="${m.product_idx}_price">
								<fmt:formatNumber value="${m.product_price}" pattern="#,##0"/>
							</span>원
					  </td>
					</tr>
				</c:forEach>
				<c:if test="${empty li}">
					<tr>
						<td colspan="9" align="center">주문 목록이 비어있습니다.</td>
					</tr>
				</c:if>
				<tr>
					<td colspan="9" align="right">전체 구매 금액:
						<span id="formattedTotal">
								<fmt:formatNumber value="${order_price}" pattern="#,##0"/>
						</span>원
				</td>
				</tr>
			</table>
			<br>

		</form>
	</div>
	<br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />