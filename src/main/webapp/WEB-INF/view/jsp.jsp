<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section class="background">
  <div class="start-container" align=center>
    <!-- 시계 -->
    <div class="timer">
      <div id="time">
        <div class="circle" style="--clr: #00e5ff">
          <div class="dots hr_dot"></div>
          <svg>
            <circle cx="70" cy="70" r="70"></circle>
            <circle cx="70" cy="70" r="70" id="hh"></circle>
          </svg>
          <div id="hours" class="timerFont">00</div>
        </div>
        <div class="circle" style="--clr: #64ffda">
          <div class="dots min_dot"></div>
          <svg>
            <circle cx="70" cy="70" r="70"></circle>
            <circle cx="70" cy="70" r="70" id="mm"></circle>
          </svg>
          <div id="minutes" class="timerFont">00</div>
        </div>
        <div class="circle" style="--clr: #00e676">
          <div class="dots sec_dot"></div>
          <svg>
            <circle cx="70" cy="70" r="70"></circle>
            <circle cx="70" cy="70" r="70" id="ss"></circle>
          </svg>
          <div id="seconds" class="timerFont">00</div>
        </div>
        <div class="ap">
          <div id="ampm" class="timerFont">AM</div>
        </div>
      </div>
    </div>
    <br>
  </div>
</section>

<section>
  <div align="center" style="margin: 20px 0;">
    <form action="jsp.do" method="get">
      <select name="ch1">
        <option value="product_name">이름</option>
        <option value="product_desc">상세설명</option>
      </select>
      <input type="text" name="ch2">
      <input type="submit" value="검색">
    </form>
  </div>

  <div class="shop-container">
    <c:forEach items="${li}" var="record">
      <a href="/getProduct.do?product_idx=${record.product_idx}" class="product-card" style="text-decoration: none;">
        <img src="${record.product_imgStr}" alt="${record.product_name}" class="product-image">
        <div class="product-info">
          <h3 class="product-name">${record.product_name}</h3>
          <div class="product-price">
            <fmt:formatNumber value="${record.product_price}" pattern="#,###"/>원
          </div>
          <p class="product-desc">${record.product_desc}</p>
        </div>
      </a>
    </c:forEach>
  </div>

  <div class="pagination">
    <c:if test="${start > 1}">
      <a href="/jsp.do?start=${start-1}${ch1 != null ? '&ch1='.concat(ch1).concat('&ch2=').concat(ch2) : ''}">이전</a>
    </c:if>
    
    <c:forEach begin="1" end="${totalPages}" var="i">
      <a href="/jsp.do?start=${i}${ch1 != null ? '&ch1='.concat(ch1).concat('&ch2=').concat(ch2) : ''}" class="${start == i ? 'active' : ''}">${i}</a>
    </c:forEach>
    
    <c:if test="${start < totalPages}">
      <a href="/jsp.do?start=${start+1}${ch1 != null ? '&ch1='.concat(ch1).concat('&ch2=').concat(ch2) : ''}">다음</a>
    </c:if>
  </div>
</section>

<script src="./js/timer.js"></script>

<c:import url="/WEB-INF/view/include/bottom.jsp" />