<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

      <c:import url="${path}/WEB-INF/view/include/top.jsp" />

      <section>
        <br>
        <div align=center>
          <h2>맛집 목록</h2>
          <br>
          <form action="getRestaurantList.do" method="get">
            <select name="ch1">
              <option value="rstrRoadAddr">지역</option>
              <option value="rstrNm">식당명</option>
              <option value="rstrMenuNm">메뉴이름</option>
            </select>
            <input type="text" name="ch2">
            <input type="submit" value="검색">
          </form>
          <br>
          <table class="basic-table">
            <tr>
              <th>번호</th>
              <th>식당명</th>
              <th>식당주소</th>
              <th>메뉴이름</th>
              <th>메뉴가격</th>
            </tr>
            <c:forEach var="restaurant" items="${li}">
              <tr>
                <td>${restaurant.idx}</td>
                <td>
                  <a href="/getRestaurant.do?idx=${restaurant.idx}">
                    ${restaurant.rstrNm}
                  </a>
                </td>
                <td>${restaurant.rstrRoadAddr}</td>
                <td>
                  <c:choose>
                    <c:when test="${fn:length(restaurant.rstrMenuNm) > 10}">
                      ${fn:substring(restaurant.rstrMenuNm, 0, 10)}...
                    </c:when>
                    <c:otherwise>
                      ${restaurant.rstrMenuNm}
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>${restaurant.rstrMenuPri}</td>
              </tr>
            </c:forEach>
          </table>
        </div>
        <br>
      </section>

      <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />