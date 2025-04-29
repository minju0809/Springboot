<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jstl/core_rt"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <h2> 결제 실패 </h2>
  <p id="code"></p>
  <p id="message"></p>
</section>

<script>
  const urlParams = new URLSearchParams(window.location.search);

  const codeElement = document.getElementById("code");
  const messageElement = document.getElementById("message");

  codeElement.textContent = "에러코드: " + urlParams.get("code");
  messageElement.textContent = "실패 사유: " + urlParams.get("message");
</script>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />
