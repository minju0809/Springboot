<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<style>
  .dot {
    overflow: hidden;
    float: left;
    width: 12px;
    height: 12px;
    background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');
  }

  .dotOverlay {
    position: relative;
    bottom: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    border-bottom: 2px solid #ddd;
    float: left;
    font-size: 12px;
    padding: 5px;
    background: #fff;
  }

  .dotOverlay:nth-of-type(n) {
    border: 0;
    box-shadow: 0px 1px 2px #888;
  }

  .number {
    font-weight: bold;
    color: #ee6152;
  }

  .dotOverlay:after {
    content: '';
    position: absolute;
    margin-left: -6px;
    left: 50%;
    bottom: -8px;
    width: 11px;
    height: 8px;
    background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')
  }

  .distanceInfo {
    position: relative;
    top: 5px;
    left: 5px;
    list-style: none;
    margin: 0;
  }

  .distanceInfo .label {
    display: inline-block;
    width: 50px;
  }

  .distanceInfo:after {
    content: none;
  }
</style>

<section>
  <div align=center>
    <br><br>
    <h2>게시판 상세보기</h2>
    <br>
    <c:set var="updateUrl" value="${empty session.uuid ? '/m/boardUpdate.do' : '/kakaoBoardUpdate.do' }" />

      <form method="post" action="${updateUrl}" enctype="multipart/form-data">
        <input type="hidden" name="board_idx" value="${board.board_idx}">
        <input type="hidden" name="board_imgStr" value="${board.board_imgStr}">
        <table class="another-table">
          <tr>
            <td colspan="3">
              <div id="map" style="width:700px;height:400px;position:relative;overflow:hidden;"></div>
            </td>
          </tr>
          <tr>
            <th>번호</th>
            <td class="position">
              ${board.board_idx}
              <c:if test="${not empty session.username}">
                <button class="bookmark-button"
                  onclick="toggleBookmark(event, ${session.member_idx}, ${board.board_idx}, this)">
                  <svg class="heart-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                    stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path class="heart-path"
                      d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 6.5 3.5 5 5.5 5c1.54 0 3.04.99 4 2.36C10.46 5.99 11.96 5 13.5 5c2 0 3.5 1.5 3.5 3.5 0 3.78-3.4 6.86-8.55 11.54L12 21.35z">
                    </path>
                  </svg>
                </button>
              </c:if>
            </td>
            <td rowspan="7">
              <img src="/img/board/${board.board_imgStr}" alt="image" width="300" height="300">
            </td>
          </tr>
          <tr>
            <th>이름</th>
            <td>${board.member_name}</td>
          </tr>
          <tr>
            <th>제목</th>
            <td><input type="text" name="board_title" value="${board.board_title}" /></td>
          </tr>
          <tr>
            <th>내용</th>
            <td>
              <textarea rows="5" cols="30" name="board_content">${board.board_content}</textarea>
            </td>
          </tr>
          <tr>
            <th>사진수정</th>
            <td>
              <input type="file" name="board_img">
            </td>
          </tr>
          <tr>
            <th>총 이동거리</th>
            <td>${board.board_map}</td>
          </tr>
          <tr>
            <th>날짜</th>
            <td>${board.board_today}</td>
          </tr>
          <c:if test="${board.member_name eq session.name}">
            <tr>
              <td colspan="3" align="center">
                <input type="submit" value="수정">
                <input type="button" value="삭제" onclick="boardDelete()">
              </td>
            </tr>
          </c:if>
        </table>
      </form>
      <form action="/commentBoardInsert.do">
        <input type="hidden" name="member_idx" value="${session.member_idx}">
        <input type="hidden" name="board_idx" value="${board.board_idx}">
        <table class="basic-table">
          <c:if test="${not empty session.username}">
            <tr>
              <td>
                <p>${session.username}</p>
              </td>
              <td><input type="text" size="85%" name="comment_content"></td>
              <td><input type="submit" value="등록"></td>
            </tr>
          </c:if>
          <tr>
            <th>작성자</th>
            <th>댓글</th>
            <th>작성일자</th>
          </tr>
          <c:choose>
            <c:when test="${not empty comment}">
              <c:forEach items="${comment}" var="record">
                <tr>
                  <td>${record.username}</td>
                  <td>${record.comment_content}</td>
                  <td>${record.comment_date}</td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="3">댓글이 없습니다.</td>
              </tr>
            </c:otherwise>
          </c:choose>
        </table>
      </form>
    </div>
    <br>
  </section>

<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
  $(document).ready(function() {
    var member_idx = '${session.member_idx}';
    var board_idx = '${board.board_idx}';
    // 페이지가 로드될 때 
    getBookmarkStatus(member_idx, board_idx);
  });

  function getBookmarkStatus(member_idx, board_idx) {
    $.ajax({
      url: "getBookmarkStatus.do",
      type: "GET",
      data: {
        member_idx: member_idx,
        board_idx: board_idx
      },
      success: function(response) {
        console.log("북마크 상태 가져오기 성공: + response");
        if (response === "bookmarked") {
          $('.bookmark-button').addClass('bookmarked');
          $('.heart-path').css('fill', 'red');
        }
      },
      error: function (xhr, status, error) {
        console.log("북마크 상태 가져오기 실패: ", error);
      }
    });
  }

  function toggleBookmark(event, member_idx, board_idx, button) {
    event.preventDefault();
    const heartPath = button.querySelector('.heart-path');
    const isBookmarked = button.classList.toggle('bookmarked');

    $.ajax({
      url: "toggleBookmark.do",
      type: "GET",
      data: {
        member_idx: member_idx,
        board_idx: board_idx
      },
      success: function(response) {
        console.log("북마크 상태 변경");
        if(response === "added") {
          alert("북마크에 추가되었습니다.")
          heartPath.style.fill = "red";
        } else if (response === "deleted") {
          alert("북마크가 해제되었습니다.")
          heartPath.style.fill = "none";
        }
      },
      error: function(xhr, status, error) {
        console.log("에러 발생: ", error);
      }
    });
    // alert('로그인 번호 ' + member_idx + '게시물 번호 ' + board_idx + ' 의 즐겨찾기 상태: ' + isBookmarked);
  }

  function boardDelete() {
    var result = confirm("정말로 삭제하시겠습니까?");
      if (result) {
        <c:choose>
          <c:when test="${empty session.uuid}">
            location.href = '/m/boardDelete.do?board_idx=${board.board_idx}';
          </c:when>
          <c:otherwise>
            location.href = '/kakaoBoardDelete.do?board_idx=${board.board_idx}';
          </c:otherwise>
        </c:choose>
      }
      return result;
  }
</script>
<script type="text/javascript"
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${keyValue}&libraries=services"></script>
<script>
  var parsedDots = JSON.parse('${board.map_dot}');
  var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다

  var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = {
      center: new kakao.maps.LatLng(37.5642135, 127.0016985), // 지도의 중심좌표
      level: 3 // 지도의 확대 레벨
    };

  var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

  var bounds = new kakao.maps.LatLngBounds();

  parsedDots.forEach((dot, index) => {
    var clickPosition = new kakao.maps.LatLng(dot.position.Ma, dot.position.La);

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
    // LatLngBounds 객체에 좌표를 추가합니다
    bounds.extend(clickPosition);

    if (index == 0) {

      // 처음 누른 점
      clickLine = new kakao.maps.Polyline({
        map: map, // 선을 표시할 지도입니다 
        path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
        strokeWeight: 3, // 선의 두께입니다 
        strokeColor: '#db4040', // 선의 색깔입니다
        strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
        strokeStyle: 'solid' // 선의 스타일입니다
      });

      displayCircleDot(clickPosition, 0);
    } else {
      // 나머지 점
      var path = clickLine.getPath();

      // 좌표 배열에 클릭한 위치를 추가합니다
      path.push(clickPosition);

      // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
      clickLine.setPath(path);

      var distance = Math.round(clickLine.getLength());
      displayCircleDot(clickPosition, distance);
    }


  })

  function displayCircleDot(position, distance) {

    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
    var circleOverlay = new kakao.maps.CustomOverlay({
      content: '<span class="dot"></span>',
      position: position,
      zIndex: 1
    });

    // 지도에 표시합니다
    circleOverlay.setMap(map);

    if (distance > 0) {
      // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
      var distanceOverlay = new kakao.maps.CustomOverlay({
        content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
        position: position,
        yAnchor: 1,
        zIndex: 2
      });

      // 지도에 표시합니다
      distanceOverlay.setMap(map);
    }
  }

  // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
  map.setBounds(bounds);

</script>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />