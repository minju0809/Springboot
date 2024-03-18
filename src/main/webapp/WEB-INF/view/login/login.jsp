<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <c:import url="/WEB-INF/view/include/top.jsp" />

    <section>
      <div align="center">
        <br><br>
        <h2>로그인 화면</h2>
        <br>
        <form method="post">
          <table class="another-table">
            <tr>
              <th>아이디</th>
              <th><input type="text" name="username" value="lina"></th>
            </tr>
            <tr>
              <th>암호</th>
              <th><input type="text" name="password" value="1234"></th>
            </tr>
            <tr>
              <td colspan="2" align="center">
                <input type="submit" value="로그인">
                <a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${rest_api_key}&redirect_uri=${redirect_uri}">
                  <img src="/img/kakao_login_small.png" alt="kakao">
                </a>
              </td>
            </tr>
          </table>      
        </form>
      </div>
    </section>

    <c:import url="/WEB-INF/view/include/bottom.jsp" />