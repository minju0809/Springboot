<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jstl/core_rt"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <h2>결제 성공</h2>
  <div class="payment-info">
    <h3>결제 정보</h3>
    <p id="paymentKey"></p>
    <p id="orderId"></p>
    <p id="amount"></p>
    <p id="orderName"></p>
  </div>
  
  <div class="customer-info">
    <h3>고객 정보</h3>
    <p>이름: ${sessionScope.session.name}</p>
    <p>이메일: ${sessionScope.session.email}</p>
    <p>전화번호: ${sessionScope.session.phone}</p>
  </div>
</section>

<script>
  // 쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
  // 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
  const urlParams = new URLSearchParams(window.location.search);
  const paymentKey = urlParams.get("paymentKey");
  const orderId = urlParams.get("orderId");
  const amount = urlParams.get("amount");
  const orderName = urlParams.get("orderName");

  async function confirm() {
    const requestData = {
      paymentKey: paymentKey,
      orderId: orderId,
      amount: amount,
    };

    const response = await fetch("/confirm", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(requestData),
    });

    const json = await response.json();

    if (!response.ok) {
      // 결제 실패 비즈니스 로직을 구현하세요.
      console.log(json);
      window.location.href = `/fail?message=${json.message}&code=${json.code}`;
      return;
    }

    // 결제 성공 시 주문 처리
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/orderAll.do';
    
    // 주문 정보 추가
    const orderIdxArray = '${order_idx}'.split(',');
    orderIdxArray.forEach((value, index) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'order_idx';
      input.value = value;
      form.appendChild(input);
    });
    
    const memberIdxInput = document.createElement('input');
    memberIdxInput.type = 'hidden';
    memberIdxInput.name = 'member_idx';
    memberIdxInput.value = '${member_idx}';
    form.appendChild(memberIdxInput);
    
    // 배열 형태의 데이터 추가
    const cartIdxArray = '${cart_idx}'.split(',');
    cartIdxArray.forEach((value, index) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'cart_idx';
      input.value = value;
      form.appendChild(input);
    });
    
    const productIdxArray = '${product_idx}'.split(',');
    productIdxArray.forEach((value, index) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'product_idx';
      input.value = value;
      form.appendChild(input);
    });
    
    const productNameArray = '${product_name}'.split(',');
    productNameArray.forEach((value, index) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'product_name';
      input.value = value;
      form.appendChild(input);
    });
    
    const productAmountArray = '${product_amount}'.split(',');
    productAmountArray.forEach((value, index) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'product_amount';
      input.value = value;
      form.appendChild(input);
    });
    
    const productPriceArray = '${product_price}'.split(',');
    productPriceArray.forEach((value, index) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'product_price';
      input.value = value;
      form.appendChild(input);
    });
    
    const orderPriceArray = '${order_price}'.split(',');
    orderPriceArray.forEach((value, index) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'order_price';
      input.value = value;
      form.appendChild(input);
    });
    
    const productImgStrArray = '${product_imgStr}'.split(',');
    productImgStrArray.forEach((value, index) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'product_imgStr';
      input.value = value;
      form.appendChild(input);
    });
    
    // 결제 정보 추가
    const paymentKeyInput = document.createElement('input');
    paymentKeyInput.type = 'hidden';
    paymentKeyInput.name = 'paymentKey';
    paymentKeyInput.value = paymentKey;
    form.appendChild(paymentKeyInput);
    
    const orderIdInput = document.createElement('input');
    orderIdInput.type = 'hidden';
    orderIdInput.name = 'orderId';
    orderIdInput.value = orderId;
    form.appendChild(orderIdInput);
    
    const amountInput = document.createElement('input');
    amountInput.type = 'hidden';
    amountInput.name = 'amount';
    amountInput.value = amount;
    form.appendChild(amountInput);
    
    // 폼 제출
    document.body.appendChild(form);
    form.submit();
  }
  confirm();

  const paymentKeyElement = document.getElementById("paymentKey");
  const orderIdElement = document.getElementById("orderId");
  const amountElement = document.getElementById("amount");
  const orderNameElement = document.getElementById("orderName");

  orderIdElement.textContent = "주문번호: " + orderId;
  amountElement.textContent = "결제 금액: " + new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(amount);
  paymentKeyElement.textContent = "paymentKey: " + paymentKey;
  orderNameElement.textContent = "주문상품: " + orderName;
</script>

<style>
  .payment-info, .customer-info {
    margin: 20px 0;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
  }
  
  h3 {
    margin-bottom: 15px;
    color: #333;
  }
  
  p {
    margin: 10px 0;
    line-height: 1.5;
  }
</style>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />
