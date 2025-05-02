<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <c:import url="${path}/WEB-INF/view/include/top.jsp" />

    <section>
      <br>
      <div align=center>
        <h2>맛집 지도</h2>
        <br>
        <form action="getRestaurantMap.do" method="get">
          <select name="ch1">
            <option value="rstrRoadAddr">지역</option>
            <option value="rstrNm">식당명</option>
            <option value="rstrMenuNm">메뉴이름</option>
          </select>
          <input type="text" name="ch2">
          <input type="submit" value="검색">
        </form>
        <br>
        <div id="map" style="width:90%;height:400px;"></div>
      </div>
      <br>
    </section>

    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=${keyValue}&libraries=services"></script>
    <script>
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
          center: new kakao.maps.LatLng(37.566601, 126.977467), // 지도의 중심좌표
          level: 6 // 지도의 확대 레벨
        };

      // 지도를 생성합니다    
      var map = new kakao.maps.Map(mapContainer, mapOption);

      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new kakao.maps.services.Geocoder();

      var locations = [
        <c:forEach items="${li}" var="m" varStatus="status">
          {idx: '${m.idx}', 
          rstrRoadAddr: '${m.rstrRoadAddr}',
          rstrNm: '${m.rstrNm}',
          rstrMenuNm: '${m.rstrMenuNm}'}
          <c:if test="${!status.last}">,</c:if>
        </c:forEach>
      ];

      for (var i = 0; i < locations.length; i++) {
        searchAddress(locations[i]);
      }
      function searchAddress(location) {
        // 주소로 좌표를 검색합니다
        geocoder.addressSearch(location.rstrRoadAddr, function (result, status) {

          // 정상적으로 검색이 완료됐으면 
          if (status === kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
              map: map,
              position: coords
            });

            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
              content: '<div style="width:150px;text-align:center;padding:6px 0;color: #000;">' +
                '<a href="/getRestaurant.do?idx=' + location.idx + '">' +
                location.rstrNm + "_" + location.rstrMenuNm +
                '</a></div>'
            });

            // 마커를 클릭했을 때의 이벤트 리스너를 등록합니다
            kakao.maps.event.addListener(marker, 'mouseover', function () {
              // 인포윈도우를 지도 위에 표시합니다
              infowindow.open(map, marker);

              // 1초 후에 인포윈도우를 닫습니다
              setTimeout(function () {
                infowindow.close();
              }, 1000);
            });

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
          }
        });
      }   
    </script>

    <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />