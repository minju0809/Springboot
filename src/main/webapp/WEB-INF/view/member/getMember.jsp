<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

      <c:import url="${path}/WEB-INF/view/include/top.jsp" />

      <section>
        <br>
        <div align=center>
          <h2>마이페이지</h2>
          <br>
          <table border="1">
            <tr>
              <th>번호</th>
              <td>${member.member_idx}</td>
            </tr>
            <tr>
              <th>아이디</th>
              <td>${member.username}</td>
            </tr>
            <tr>
              <th>비밀번호</th>
              <td>${member.password}</td>
            </tr>
            <tr>
              <th>등급</th>
              <td>${member.role}</td>
            </tr>
            <tr>
              <th>이름</th>
              <td>${member.name}</td>
            </tr>
            <tr>
              <th>번호</th>
              <td>${member.phone}</td>
            </tr>
            <tr>
              <th>메일</th>
              <td>${member.email}</td>
            </tr>
            <tr>
              <th>우편번호</th>
              <td>${member.postcode}</td>
            </tr>
            <tr>
              <th>주소</th>
              <td>${member.address}</td>
            </tr>
            <tr>
              <th>상세주소</th>
              <td>${member.detailAddress}</td>
            </tr>
            <tr>
              <th>나머지</th>
              <td>${member.extraAddress}</td>
            </tr>
            <tr>
              <th>날짜</th>
              <td>${member.regdate}</td>
            </tr>
            <tr>
              <th>기타</th>
              <td>${member.etc}</td>
            </tr>
          </table>
        </div>
        <br>
      </section>

      <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />