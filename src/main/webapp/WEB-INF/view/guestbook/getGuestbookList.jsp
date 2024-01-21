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
        <th colspan="7">
          <div style="text-align: left; float: left;">
              &emsp;<a class="button" href="guestbookAdd.do"> 방명록 추가 </a>
          </div>
          <div style="text-align: right; float: right;">
              <a class="button" href="guestbookForm.do"> 글쓰기 </a>&emsp;
          </div>
      </th>
      </tr>
      <tr>
        <th>rownum</th>
				<th>rnum</th>
        <th>번호</th>
        <th>이름</th>
        <th width="150">메모</th>
        <th>날짜</th>
        <th>삭제</th>
      </tr>
      <c:forEach items="${li}" var="record">
        <tr>
          <td>${record.rownum}</td>
          <td>${record.rnum}</td>
          <td>${record.guestbook_idx}</td>
          <td><a class="button" href="getGuestbook.do?guestbook_idx=${record.guestbook_idx}&start=${start}&ch1=${ch1}&ch2=${ch2}">${record.guestbook_name}</a></td>
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
          <td><a href="#" onclick="confirmDelete('${record.guestbook_idx}'); return false;">삭제</a></td>
      </tr>
      </c:forEach>
    </table>

    <div style="margin-top: 8px;">
      <a class="button" href="getGuestbookList.do?start=1&ch1=${ch1}&ch2=${ch2}">처음으로</a>
      <c:if test="${ start != 1 }">
        <a class="button" href="getGuestbookList.do?start=${ start - pageSize }&ch1=${ch1}&ch2=${ch2}">이전</a>
      </c:if>
      <c:if test="${ start == 1 }">
        이전
      </c:if>
      
      <c:forEach var="i" begin="${listStartPage}"  end="${listEndPage}"  >
        <c:set var="startVar"  value="${(i-1) * pageSize + 1}" />
        <c:if test="${i <= totalPage}">
          <a class="button" href="getGuestbookList.do?start=${startVar}&ch1=${ch1}&ch2=${ch2}">[${i}]</a>&nbsp;
        </c:if>
      </c:forEach>
      
      <c:if test="${ currentPage != totalPage }">
        <a class="button" href="getGuestbookList.do?start=${ start + pageSize }&ch1=${ch1}&ch2=${ch2}">다음</a>
      </c:if>
      <c:if test="${ currentPage == totalPage }">
        다음
      </c:if>
      
      <a class="button" href="getGuestbookList.do?start=${ lastPage }&ch1=${ch1}&ch2=${ch2}">마지막으로</a>
    </div>
    <form action="getGuestbookList.do">
      <select name="ch1">
        <option value="guestbook_name">이름</option>
        <option value="guestbook_memo">메모</option>
        <option value="guestbook_today">날짜</option>
      </select>
      <input type="text" name="ch2">
      <input type="submit" value="검색">
    </form>
  </div>
  <br>
</section>

<script>
  function confirmDelete(guestbook_idx) {
    var result = confirm("정말로 삭제하시겠습니까?");
    if (result) {
      location.href = 'guestbookDelete.do?guestbook_idx=' + guestbook_idx + '&start=${start}&ch1=${ch1}&ch2=${ch2}';
    }
    return result;
  }
</script>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />

