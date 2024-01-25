<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <c:import url="/WEB-INF/view/include/top.jsp" />

    <section>
      <div class="start-container" align=center>
        <h2>시작페이지</h2>
        <br>
        <div>
          <a href="#" class="logo" onmouseover="changeText()" onmouseout="resetText()">
            포트폴리오
          </a>
        </div>
        <br>
        <span>서버 </span>:
        <%=application.getServerInfo()%><br>
        <span>서블릿 </span>:
        <%=application.getMajorVersion()%>.<%=application.getMinorVersion()%><br>
        <span>JSP </span>:
        <%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion()%><br>
      </div>
    </section>

    <script>
      function changeText() {
        document.querySelector('.logo').textContent = '반갑습니다';
      }
    
      function resetText() {
        document.querySelector('.logo').textContent = '포트폴리오';
      }
    </script>

    <c:import url="/WEB-INF/view/include/bottom.jsp" />