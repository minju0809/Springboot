<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<!-- 토스페이먼츠 Standard SDK 추가 -->
<script src="https://js.tosspayments.com/v2/standard"></script>

<script>
	function updateAll() {
		alert("전체수정");
		f1.action = "/cartUpdateAll.do"
	}

	// 전화번호에서 하이픈 제거
	const phoneNumber = "${sessionScope.session.phone}".replace(/-/g, "");

	async function orderAll() {
		// 세션 정보 확인
		const memberPhone = "${sessionScope.session.phone}";
		const memberAddress = "${sessionScope.session.address}";
		
		if (!memberPhone || !memberAddress) {
			if (confirm("연락처와 주소가 입력되지 않았습니다. 회원 정보 수정 페이지로 이동하시겠습니까?")) {
				window.location.href = "/getMember.do?member_idx=${sessionScope.session.member_idx}";
				return;
			} else {
				return;
			}
		}
		
		const button = document.getElementById("payment-button");
		
		// 주문 ID 생성 (타임스탬프 + 랜덤 문자열)
		const orderId = 'order_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
		
		// ------  결제위젯 초기화 ------
		const clientKey = "${tossClientKey}";
		const tossPayments = TossPayments(clientKey);
		
		// 회원 결제
		const customerKey = "${tossCustomerKey}";
		const widgets = tossPayments.widgets({
			customerKey,
		});
		// 비회원 결제
		// const widgets = tossPayments.widgets({ customerKey: TossPayments.ANONYMOUS });

		// ------ 주문의 결제 금액 설정 ------
		const totalAmount = parseFloat(document.getElementById("formattedTotal").textContent.replace(/[^0-9]/g, ""));
		await widgets.setAmount({
			currency: "KRW",
			value: totalAmount,
		});

		await Promise.all([
			// ------  결제 UI 렌더링 ------
			widgets.renderPaymentMethods({
				selector: "#payment-method",
				variantKey: "DEFAULT",
			}),
			// ------  이용약관 UI 렌더링 ------
			widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
		]);

		// ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
		button.addEventListener("click", async function () {
			// 상품 개수 확인
			const productNames = document.getElementsByName("product_name");
			let orderName = "";
			
			if (productNames.length === 1) {
				orderName = productNames[0].value;
				console.log("orderName: ", orderName);
			} else {
				orderName = productNames[0].value + " 외 " + (productNames.length - 1) + "건";
				console.log("orderName: ", orderName);
			}
			
			await widgets.requestPayment({
				orderId: orderId,
				orderName: orderName,
				successUrl: window.location.origin + "/paymentSuccess.do?" + 
					"order_idx=" + document.getElementsByName("order_idx")[0].value + "&" +
					"member_idx=" + document.getElementsByName("member_idx")[0].value + "&" +
					"cart_idx=" + Array.from(document.getElementsByName("cart_idx")).map(input => input.value).join(",") + "&" +
					"product_idx=" + Array.from(document.getElementsByName("product_idx")).map(input => input.value).join(",") + "&" +
					"product_name=" + Array.from(document.getElementsByName("product_name")).map(input => input.value).join(",") + "&" +
					"product_amount=" + Array.from(document.getElementsByName("product_amount")).map(input => input.value).join(",") + "&" +
					"product_price=" + Array.from(document.getElementsByName("product_price")).map(input => input.value).join(",") + "&" +
					"order_price=" + document.getElementsByName("order_price")[0].value + "&" +
					"product_imgStr=" + Array.from(document.getElementsByName("product_imgStr")).map(input => input.value).join(",") + "&" +
					"orderName=" + orderName,
				failUrl: window.location.origin + "/fail.jsp",
				customerEmail: "${sessionScope.session.email}",
				customerName: "${sessionScope.session.name}",
				customerMobilePhone: phoneNumber,
			});
		});
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
			<!-- 결제 정보를 위한 hidden 필드 추가 -->
			<input type="hidden" id="paymentKey" name="paymentKey" value="">
			<input type="hidden" id="orderId" name="orderId" value="">
			<input type="hidden" id="amount" name="amount" value="">
			
			<table class="basic-table">
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
						<!-- 결제 UI -->
						<div id="payment-method"></div>
						<!-- 이용약관 UI -->
						<div id="agreement"></div>
						<!-- 결제하기 버튼 -->
						<input type=button value="전체주문" id="payment-button" onclick="orderAll()" />
					</td>
				</tr>
			</table>
			<br>

		</form>
	</div>
	<br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />