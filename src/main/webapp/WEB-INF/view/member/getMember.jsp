<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

      <c:import url="${path}/WEB-INF/view/include/top.jsp" />

      <style>
        table {
          width: 900px;
        }

        input[type="text"] {
          width: 90%;
          border: 1px solid #ccc;
          border-radius: 5px;
          box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
          padding: 8px 12px;
          font-size: 16px;
        }

        input[type="submit"] {
          background-color: #4CAF50;
          color: white;
          padding: 10px 20px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
        }
      </style>

      <section>
        <br><br>
        <div align=center>
          <h2>마이페이지
            <c:if test="${not empty member.uuid}">
              <span class="warning">(카카오 로그인)</span>
            </c:if>
          </h2>
            
          <br>
          <form action="/memberUpdate.do">
            <table class="another-table">
              <tr>
                <td colspan="2">
                  <span class="warning">
                    <c:choose>
                      <c:when test="${not empty member.uuid}">
                        &emsp; 카카오톡에서 변경된 닉네임은 다시 로그인 해야 적용 됩니다!
                      </c:when>
                      <c:otherwise>
                        &emsp; 수정된 이름은 다시 로그인 해야 적용 됩니다!
                      </c:otherwise>
                    </c:choose>
                  </span>
                </td>
              </tr>
              <tr>
                <th>번호</th>
                <td><input type="text" name="member_idx" value="${member.member_idx}" readonly></td>
              </tr>
              <tr>
                <th>아이디</th>
                <td><input type="text" name="username" value="${member.username}" readonly></td>
              </tr>
              <tr>
                <th>비밀번호</th>
                <td><input type="text" name="password" value="${member.password}" readonly></td>
              </tr>
              <tr>
                <th>등급</th>
                <td><input type="text" name="role" value="${member.role}" readonly></td>
              </tr>
              <tr>
                <th>이름</th>
                <td><input type="text" name="name" value="${member.name}"></td>
              </tr>
              <tr>
                <th>번호</th>
                <td><input type="text" name="phone" value="${member.phone}"></td>
              </tr>
              <tr>
                <th>메일</th>
                <td><input type="text" name="email" value="${member.email}"></td>
              </tr>
              <tr>
                <th>주소</th>
                <td>
                  <input type="text" name="postcode" id="sample6_postcode" value="${member.postcode}"
                    style="width:50px">
                  <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                  <input type="text" name="address" id="sample6_address" value="${member.address}" size=50><br>
                  <input type="text" name="detailAddress" id="sample6_detailAddress" value="${member.detailAddress}">
                  <input type="text" name="extraAddress" id="sample6_extraAddress" value="${member.extraAddress}">
                </td>
              </tr>
              <tr>
                <th>날짜</th>
                <td><input type="text" name="regdate" value="${member.regdate}" readonly></td>
              </tr>
              <tr>
                <th>기타</th>
                <td><input type="text" name="etc" value="${member.etc}"></td>
              </tr>
              <tr>
                <td colspan="2" align="center">
                  <input type="submit" value="수정">
                </td>
              </tr>
            </table>
          </form>
        </div>
        <br>
      </section>

      <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
      <script>
        function sample6_execDaumPostcode() {
          new daum.Postcode({
            oncomplete: function (data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

              // 각 주소의 노출 규칙에 따라 주소를 조합한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var addr = ''; // 주소 변수
              var extraAddr = ''; // 참고항목 변수

              //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
              if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
              } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
              }

              // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
              if (data.userSelectedType === 'R') {
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                  extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                  extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraAddr !== '') {
                  extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;

              } else {
                document.getElementById("sample6_extraAddress").value = '';
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('sample6_postcode').value = data.zonecode;
              document.getElementById("sample6_address").value = addr;
              // 커서를 상세주소 필드로 이동한다.
              document.getElementById("sample6_detailAddress").focus();
            }
          }).open();
        }
      </script>

      <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />