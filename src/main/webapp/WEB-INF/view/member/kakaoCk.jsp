<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <c:import url="/WEB-INF/view/include/top.jsp" />

    <section>
      <div align="center">
        <br><br>
        <h2>아이디 확인 중...</h2>
        <br>
      </div>
    </section>

    <script>
      let id = localStorage.getItem("uuid")
      console.log("hello: " + id);
      console.log(!id);
      setTimeout(() => {

        if (!id) {
          id = self.crypto.randomUUID();
          localStorage.setItem("uuid", id);
          window.open("http://localhost:8080/member/memberForm.jsp" + "?uuid=" + id, "_self");
        } else {
          window.open("http://localhost:8080/kakaoCk.do" + "?uuid=" + id, "_self");
        }
      }, 1000);
    </script>

    <c:import url="/WEB-INF/view/include/bottom.jsp" />