<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <c:import url="${path}/WEB-INF/view/include/top.jsp" />

    <section>
      <br>
      <div align=center>
        <h2>맛집 목록</h2>
        <table border="1">
          <tr>
            <th>위치</th>
            <th>메뉴</th>
            <th>가격</th>
          </tr>
          <c:forEach var="restaurant" items="${restaurantList}">
            <tr>
              <td>${restaurant.rights}</td>
              <td>${restaurant.rstrNm}</td>
              <td>${restaurant.rstrMenuPri}</td>
            </tr>
          </c:forEach>
        </table>
      </div>
      <br>
    </section>

    <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />