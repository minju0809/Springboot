<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
	<br>
	<div align=center>
		<h3>주문 목록</h3>
		<br>
		<form name="f1">
			<table border=1>
				<tr>
					<td>order_id</td>
					<td>cart_id</td>
					<td>img</td>
					<td>memberId</td>
					<td>product_id</td>
					<td>product_name</td>
					<td>amount</td>
					<td>price</td>
					<!-- <td>삭제</td> -->
				</tr>
				<c:forEach items="${ li }" var="m" varStatus="status">
					<input type=hidden name="member_idx" value="${ m.member_idx }" />
					<input type=hidden name="cart_idx" value="${ m.cart_idx }" />
					<input type=hidden name="product_idx" value="${ m.product_idx }" />
					<input type=hidden name="product_name" value="${ m.product_name }" />
					
					<c:set var="total" value="${total + m.product_price}"></c:set>
					<tr>
						<td>${ m.order_idx }</td>
						<td>${ m.cart_idx }</td>
						<td><img src="${ path }/img/shop/${ m.product_imgStr }" width=50 height=50 /></td>
						<td>${ m.member_idx }</td>
						<td>${ m.product_idx }</td>
						<td>${ m.product_name }</td>
						<td>${ m.product_amount }</td>
						<td><input id=${m.product_idx}_price type="text" name="product_price" value="${ m.product_price }"
								readonly></td>
						<!-- <td><input type="button" onclick="location.href='/cartDelete.do?cart_idx=${m.cart_idx}'" value="삭제"> -->
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
						<span id="formattedTotal">${total}</span>원
					</td>
				</tr>
			</table>
			<br>

		</form>
	</div>
	<br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />