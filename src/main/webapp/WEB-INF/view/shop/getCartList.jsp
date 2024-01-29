<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<script>
	function updateAll() {
		alert("전체수정");
		f1.action = "cartTotalUpdate.do"
	}

	function orderAll() {
		alert("전체주문");
		f1.action = "cartOrderAll.do"
	}
</script>

<section>
	<br>
	<div align=center>
		<h3>장바구니 목록</h3>
		<form name=f1>
			<table border=1>
				<tr>
					<td>cart_id</td>
					<td>img</td>
					<td>memberId</td>
					<td>product_id</td>
					<td>product_name</td>
					<td>amount</td>
					<td>price</td>
				</tr>
				<c:forEach items="${ li }" var="m" varStatus="status">
					<input type=hidden name="member_idx" value="${ m.member_idx }" />
					<input type=hidden name="cart_idx" value="${ m.cart_idx }" />
					<input type=hidden name="product_idx" value="${ m.product_idx }" />
					<input type=hidden name="product_name" value="${ m.product_name }" />
					<tr>
						<td>${ m.cart_idx }</td>
						<td><img src="${ path }/img/shop/${ m.product_imgStr }" width=50 height=50 /></td>
						<td>${ m.member_idx }</td>
						<td>${ m.product_idx }</td>
						<td>${ m.product_name }</td>
						<td>${ m.product_amount }</td>
						<td>${ m.product_price }</td>
					</tr>
				</c:forEach>
			</table>
			<br>

		</form>
	</div>
	<br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />