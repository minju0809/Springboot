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
	<br><br>
	<div align=center>
		<h3>주문 목록</h3>
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
				<c:forEach items="${ li }" var="m" varStatus="status">
					<c:set var="order_price" value="${order_price + m.product_price}"></c:set>
					<tr>
						<td><a href="/getDetailOrderList.do?order_idx=${m.order_idx}">${ m.order_idx }</a></td>
						<td>${ m.member_idx }</td>
						<td>${ m.username }</td>
						<td>
							<span id="${m.product_idx}_price">
								<fmt:formatNumber value="${m.product_price}" pattern="#,##0"/>
							</span>원
						</td>
						<td>${ m.order_today }</td>
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
