<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

      <c:import url="${path}/WEB-INF/view/include/top.jsp" />

      <section>
        <br>
        <div align=center>
          <h2>맛집 상세보기</h2>
          <br>
          <table border="1">
            <tr>
              <th>식당명</th>
              <td>${restaurant.rstrNm}</td>
            </tr>
            <tr>
              <th>식당주소</th>
              <td>${restaurant.rstrRoadAddr}</td>
            </tr>
            <tr>
              <th>메뉴이름</th>
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
            </tr>
            <tr>
              <th>메뉴가격</th>
              <td>${restaurant.rstrMenuPri}</td>
            </tr>
          </table>
        </div>
        <br>
      </section>

      <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />