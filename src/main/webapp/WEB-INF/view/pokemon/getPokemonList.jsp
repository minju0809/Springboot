<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br>
  <div align=center>
    <div class="record-info">
      <div>1. 페이지 사이즈 : ${pageSize}</div>
      <div>2. 페이지 List사이즈 : ${pageListSize}</div>
      <div>3. 전체 레코드 수 : ${totalCount}</div>
      <div>4. 총 페이지 수 : ${totalPage}</div>
    </div>
    <div class="record-info">
      <div>5. 현재 레코드 : ${start}</div>
      <div>6. 현재 페이지 : ${currentPage}</div>
      <div>7. 가로 하단 시작 :${listStartPage}</div>
      <div>8. 가로 하단 마지막 : ${listEndPage}</div>
    </div>
    <h2>포켓몬 도감</h2>
    <br>
    <form action="getPokemonList.do" method="get">
      <select name="ch1">
        <option value="num">번호</option>
        <option value="name">이름</option>
      </select>
      <input type="text" name="ch2">
      <input type="submit" value="검색">
    </form>
    <br>
    <div style="text-align:center; display: grid; gap:4px; grid-template-columns: repeat(auto-fill, minmax(200px, auto));">
      <c:forEach items="${li}" var="pokemon">
        <div>
          <img src="${pokemon.image}" alt="${pokemon.name} 이미지" width="100px">
          <p>도감 번호: ${pokemon.num}</p>
          <h3>포켓몬 이름: ${pokemon.name}</h3>
          <p>타입: ${pokemon.type1} ${pokemon.type2}</p>
        </div>
      </c:forEach>
    </div>
  <br>
  <div style="margin: 8px 0;">
    <a class="button" href="getPokemonList.do?start=1&ch1=${ch1}&ch2=${ch2}">처음으로</a>
    <c:if test="${ start != 1 }">
      <a class="button" href="getPokemonList.do?start=${ start - pageSize }&ch1=${ch1}&ch2=${ch2}">이전</a>
    </c:if>
    <c:if test="${ start == 1 }">
      이전
    </c:if>
    
    <c:forEach var="i" begin="${listStartPage}"  end="${listEndPage}"  >
      <c:set var="startVar"  value="${(i-1) * pageSize + 1}" />
      <c:if test="${i <= totalPage}">
        <a class="button" href="getPokemonList.do?start=${startVar}&ch1=${ch1}&ch2=${ch2}">${i}</a>&nbsp;
      </c:if>
    </c:forEach>
    
    <c:if test="${ currentPage != totalPage }">
      <a class="button" href="getPokemonList.do?start=${ start + pageSize }&ch1=${ch1}&ch2=${ch2}">다음</a>
    </c:if>
    <c:if test="${ currentPage == totalPage }">
      다음
    </c:if>
    
    <a class="button" href="getPokemonList.do?start=${ lastPage }&ch1=${ch1}&ch2=${ch2}">마지막으로</a>
  </div>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />