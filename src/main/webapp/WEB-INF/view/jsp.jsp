<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
  <div class="start-container" align=center>
    <!-- <div>
      <a href="#" class="logo" onmouseover="changeText()" onmouseout="resetText()">
        포트폴리오
      </a>
    </div> -->
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

<!-- <script>
  function changeText() {
    document.querySelector('.logo').textContent = '반갑습니다';
  }

  function resetText() {
    document.querySelector('.logo').textContent = '포트폴리오';
  }
</script> -->
<script src="./js/timer.js"></script>

<c:import url="/WEB-INF/view/include/bottom.jsp" />