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
                <a
                  href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${rest_api_key}&redirect_uri=${redirect_uri}">
                  <img src="/img/kakao_login_small.png" alt="kakao">
                </a>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </section>

    <script>
      // error 시 아이티 비밀번호 확인 alert 창 띄우기
      // location.search 파라미터 값 추출 시 [key, value] 형식이기 때문에
      // http://localhost:8081/login.do?error 의 error를 get으로는 가져올 수 없음
      // 모든 값 가져오기를 하면 배열의 형태를 띄기 때문에 alert 창을 띄울 수는 있음
      document.addEventListener("DOMContentLoaded", function () {
        const searchParams = new URLSearchParams(location.search);
        for (const error of searchParams) {
          console.log("error value: ", error);
          alert('아이디와 비밀번호를 확인해주세요.');
        }
        // const urlParams = new URL(location.href).searchParams;
        // const error = urlParams.get('error');
        // console.log("errorParam value: ", error); // X
      });
    </script>


    <c:import url="/WEB-INF/view/include/bottom.jsp" />