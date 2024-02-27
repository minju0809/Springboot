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
    <form method="post" action="/m/boardUpdate.do" enctype="multipart/form-data">
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
          <td>${board.board_idx}</td>
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
  </div>
  <br>
</section>

<script>
  function boardDelete() {
    var result = confirm("정말로 삭제하시겠습니까?");
      if (result) {
        location.href = '/m/boardDelete.do?board_idx=${board.board_idx}';
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