<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<script>
	function updateAll() {
		alert("전체수정");
		f1.action = "/cartUpdateAll.do"
	}

	function orderAll() {
		alert("전체주문");
		f1.action = "/orderAll.do"
	}

	function onAmountChange(ev, idx, price, amount) {
		const p = document.getElementById(idx + "_price");
		console.log("price element: ", p);
		console.log(idx, price, amount);

		p.value = price / amount * ev.value;

		updateTotal();
	}

	function updateTotal() {

		const priceElements = document.getElementsByName("product_price");
		console.log("!!!!!",priceElements);
		let total = 0;

		for (const element of priceElements) {
			total += parseFloat(element.value);
		}
		console.log(total);

		const formattedTotal = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(total);
		document.getElementById("formattedTotal").innerText = formattedTotal;

	}

	window.onload = function () {
			updateTotal();
	};

</script>

<section>
	<br>
	<div align=center>
		<h3>장바구니 목록</h3>
		<br>
		<form name="f1" method="post" enctype="multipart/form-data">
			<table border=1>
				<tr>
					<td>cart_id</td>
					<td>img</td>
					<td>memberId</td>
					<td>product_id</td>
					<td>product_name</td>
					<td>amount</td>
					<td>price</td>
					<td>삭제</td>
				</tr>
				<c:forEach items="${ li }" var="m" varStatus="status">
					<c:set var="order_price" value="${order_price + m.product_price}"></c:set>
					<input type="hidden" name="order_idx" value="${ order_idx }" />
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
						<td>
							<select name="product_amount"
								onchange="onAmountChange(this, `${m.product_idx}`,`${m.product_price}`,`${m.product_amount}`)">
								<option value="1" ${m.product_amount==1 ? 'selected' : '' }>1</option>
								<option value="2" ${m.product_amount==2 ? 'selected' : '' }>2</option>
								<option value="3" ${m.product_amount==3 ? 'selected' : '' }>3</option>
								<option value="4" ${m.product_amount==4 ? 'selected' : '' }>4</option>
								<option value="5" ${m.product_amount==5 ? 'selected' : '' }>5</option>
							</select>
						</td>
						<td><input id=${m.product_idx}_price type="text" name="product_price" value="${ m.product_price }"
								readonly></td>
						<td><input type="button" onclick="location.href='/cartDelete.do?cart_idx=${m.cart_idx}'" value="삭제">
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty li}">
					<tr>
						<td colspan="8" align="center">장바구니가 비어있습니다.</td>
					</tr>
				</c:if>
				<tr>
					<td colspan="8" align="right">전체 구매 금액:
						<span id="formattedTotal">${order_price}</span>원
					</td>
				</tr>

				<tr>
					<td colspan="8" align="center">
						<input type=submit value="전체수정" onclick="updateAll()" />
						<input type=submit value="전체주문" onclick="orderAll()" />
					</td>
				</tr>
			</table>
			<br>

		</form>
	</div>
	<br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />