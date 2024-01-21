<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br>
  <div align="left">
    &emsp;0. 전체 레코드 수: ${totalCount}<br>  
    &emsp;1. 페이지 사이즈 : ${pageSize}<br>
    &emsp;2. 페이지 List사이즈(아래숫자갯수) : ${pageListSize}<br>
    &emsp;3. 전체레코두 수 : ${totalCount}<br>
    &emsp;4. 총페이지수 : ${totalPage}<br>
    &emsp;5. 현재레코드 : ${start}<br>
    &emsp;6. 현재페이지 : ${currentPage}<br>
    &emsp;7. 가로하단 시작 :${listStartPage}<br>
    &emsp;8. 가로 하단 마지막 : ${listEndPage}<br>
  </div>
  <div align=center>
    <h2>방명록 목록</h2>
    <table border="1">
      <tr>
        <th colspan="6">
          <div style="text-align: left; float: left;">
              &emsp;<button onclick="location.href='guestbookAdd.do'"> 방명록 추가 </button>
          </div>
          <div style="text-align: right; float: right;">
              <button onclick="location.href='guestbookForm.do'"> 글쓰기 </button>&emsp;
          </div>
      </th>
      </tr>
      <tr>
        <td>rownum</td>
				<td>rnum</td>
        <th>번호</th>
        <th>이름</th>
        <th width="150">메모</th>
        <th>날짜</th>
      </tr>
      <c:forEach items="${li}" var="record">
        <tr>
          <td>${record.rownum}</td>
          <td>${record.rnum}</td>
          <td>${record.guestbook_idx}</td>
          <td><a href="getGuestbook.do?guestbook_idx=${record.guestbook_idx}">${record.guestbook_name}</a></td>
          <td>
            <c:choose>
              <c:when test="${fn:length(record.guestbook_memo) > 10}">
                ${fn:substring(record.guestbook_memo, 0, 10)}...
              </c:when>
              <c:otherwise>
                ${record.guestbook_memo}
              </c:otherwise>
            </c:choose>
          </td>
          <td>${record.guestbook_today.substring(0, 10)}</td>
      </tr>
      </c:forEach>
    </table>

    <a href="getGuestbookList.do?start=1">처음으로</a>
		<c:if test="${ start != 1 }">
			<a href="getGuestbookList.do?start=${ start - pageSize }">이전</a>
		</c:if>
		<c:if test="${ start == 1 }">
			이전
		</c:if>

    <c:forEach var="i" begin="${listStartPage}"  end="${listEndPage}"  >
			<c:set var="startVar"  value="${(i-1) * pageSize + 1}" />
			<c:if test="${i <= totalPage}">
				<a href="getGuestbookList.do?start=${startVar}">[${i}]</a>&nbsp;
			</c:if>
		</c:forEach>

		<c:if test="${ currentPage != totalPage }">
			<a href="getGuestbookList.do?start=${ start + pageSize }">다음</a>
		</c:if>
		<c:if test="${ currentPage == totalPage }">
			다음
		</c:if>

		<a href="getGuestbookList.do?start=${ lastPage }">마지막으로</a>
  </div>
  <br>
</section>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />

