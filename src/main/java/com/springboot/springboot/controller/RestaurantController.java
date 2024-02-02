package com.springboot.springboot.controller;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.springboot.springboot.project.restaurant.RestaurantVO;

@Controller
public class RestaurantController {

  private List<RestaurantVO> processApiData() throws Exception {
    StringBuilder urlBuilder = new StringBuilder("http://api.kcisa.kr/openapi/API_CNV_055/request"); /* URL */
    urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=4ea8a43b-42d2-4153-a938-c2e62138ecaf");
    urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));
    urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /* 페이지수 */
    // urlBuilder.append("&" + URLEncoder.encode("areaNm", "UTF-8") + "=" +
    // URLEncoder.encode(areaName, "UTF-8"));

    URL url = new URL(urlBuilder.toString());
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

    conn.setRequestMethod("GET");
    conn.setRequestProperty("Content-type", "application/json");
    System.out.println("Response code: " + conn.getResponseCode());

    BufferedReader rd;
    if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
      rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    } else {
      rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
    }

    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = rd.readLine()) != null) {
      sb.append(line);
    }
    rd.close();
    conn.disconnect();

    // System.out.println(sb.toString());

    String xmlString = sb.toString(); // 주어진 XML 문자열

    // XML 파싱
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();

    // 주어진 XML 문자열을 InputStream으로 변환
    ByteArrayInputStream input = new ByteArrayInputStream(xmlString.getBytes("UTF-8"));

    // XML 파싱
    Document document = builder.parse(input);

    // <item> 엘리먼트의 NodeList 가져오기
    NodeList itemList = document.getElementsByTagName("item");

    Set<String> processedAddresses = new HashSet<>();
    List<RestaurantVO> restaurantList = new ArrayList<>();

    // <item> 엘리먼트들을 순회하며 내용 출력
    for (int i = 0; i < itemList.getLength(); i++) {
      Element itemElement = (Element) itemList.item(i);

      String rstrRoadAddr = itemElement.getElementsByTagName("rstrRoadAddr").item(0).getTextContent();

      // 중복된 주소가 아닌 경우에만 처리
      if (!processedAddresses.contains(rstrRoadAddr)) {
        processedAddresses.add(rstrRoadAddr);

        String title = itemElement.getElementsByTagName("title").item(0).getTextContent();
        String rstrNm = itemElement.getElementsByTagName("rstrNm").item(0).getTextContent();
        String rights = itemElement.getElementsByTagName("rights").item(0).getTextContent();
        String rstrMenuNm = itemElement.getElementsByTagName("rstrMenuNm").item(0).getTextContent();
        String rstrMenuPri = itemElement.getElementsByTagName("rstrMenuPri").item(0).getTextContent();
        String description = itemElement.getElementsByTagName("description").item(0).getTextContent();

        RestaurantVO restaurantVO = new RestaurantVO();
        restaurantVO.setTitle(title);
        restaurantVO.setRstrNm(rstrNm);
        restaurantVO.setRights(rights); 
        restaurantVO.setRstrMenuNm(rstrMenuNm);
        restaurantVO.setRstrMenuPri(rstrMenuPri);
        restaurantVO.setRstrRoadAddr(rstrRoadAddr);
        restaurantVO.setDescription(description);

        restaurantList.add(restaurantVO);
      }
    }
    return restaurantList;
  }

  private List<RestaurantVO> filterRestaurantList(List<RestaurantVO> restaurantList, String ch1, String ch2) {
    if (ch1 != null && ch2 != null && !ch1.isEmpty() && !ch2.isEmpty()) {
      return restaurantList.stream()
          .filter(restaurant -> {
            switch (ch1) {
              case "rstrRoadAddr":
                return restaurant.getRstrRoadAddr().contains(ch2);
              case "rstrNm":
                return restaurant.getRstrNm().contains(ch2);
              case "rstrMenuNm":
                return restaurant.getRstrMenuNm().contains(ch2);
              default:
                return false;
            }
          })
          .collect(Collectors.toList());
    }
    return restaurantList;
  }

  @GetMapping("/getRestaurantList.do")
  String Restaurant(Model model, @RequestParam(name = "ch1", required = false) String ch1,
      @RequestParam(name = "ch2", required = false) String ch2) throws Exception {

    List<RestaurantVO> restaurantList = processApiData();
    restaurantList = filterRestaurantList(restaurantList, ch1, ch2);

    // System.out.println("@" + ch1 + "::" + ch2 + "@");
    model.addAttribute("keyValue", "5fd42cdd845577dc157f2510c3e96a73");
    model.addAttribute("ch1", ch1);
    model.addAttribute("ch2", ch2);
    model.addAttribute("li", restaurantList);

    return "/restaurant/getRestaurantList";
  }

  @GetMapping("/getRestaurantMap.do")
  String getRestaurantMap(Model model, @RequestParam(name = "ch1", required = false) String ch1,
      @RequestParam(name = "ch2", required = false) String ch2) throws Exception {

    List<RestaurantVO> restaurantList = processApiData();
    restaurantList = filterRestaurantList(restaurantList, ch1, ch2);

    // System.out.println("@" + ch1 + "::" + ch2 + "@");
    model.addAttribute("keyValue", "5fd42cdd845577dc157f2510c3e96a73");
    model.addAttribute("ch1", ch1);
    model.addAttribute("ch2", ch2);
    model.addAttribute("li", restaurantList);

    return "/restaurant/getRestaurantMap";
  }
}
