package com.springboot.springboot.controller;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.springboot.springboot.project.restaurant.RestaurantVO;

// import com.springboot.springboot.project.restaurant.RestaurantService;

@Controller
public class RestaurantController {

  // @Autowired
  // private RestaurantService service;

  @GetMapping("/getRestaurant.do")
  String Restaurant(Model model) throws Exception {

    StringBuilder urlBuilder = new StringBuilder("http://api.kcisa.kr/openapi/API_CNV_055/request"); /* URL */
    urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=4ea8a43b-42d2-4153-a938-c2e62138ecaf");

    urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("20", "UTF-8"));

    urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /* 페이지수 */
    urlBuilder.append("&" + URLEncoder.encode("areaNm", "UTF-8") + "=" + URLEncoder.encode("마포", "UTF-8"));

    URL url = new URL(urlBuilder.toString());
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

    conn.setRequestMethod("GET");
    conn.setRequestProperty("Content-type", "application/json");
    System.out.println("Response code: " + conn.getResponseCode());

    BufferedReader rd;
    if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {

      rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));

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

    System.out.println(sb.toString());

    String xmlString = sb.toString(); // 주어진 XML 문자열

    try {
      // XML 파서 설정
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = factory.newDocumentBuilder();

      // 주어진 XML 문자열을 InputStream으로 변환
      ByteArrayInputStream input = new ByteArrayInputStream(xmlString.getBytes("UTF-8"));

      // XML 파싱
      Document document = builder.parse(input);

      // <item> 엘리먼트의 NodeList 가져오기
      NodeList itemList = document.getElementsByTagName("item");

      List<RestaurantVO> restaurantList = new ArrayList<>();

      // <item> 엘리먼트들을 순회하며 내용 출력
      for (int i = 0; i < itemList.getLength(); i++) {
        Element itemElement = (Element) itemList.item(i);

        String title = itemElement.getElementsByTagName("title").item(0).getTextContent();
        String rstrNm = itemElement.getElementsByTagName("rstrNm").item(0).getTextContent();
        String rights = itemElement.getElementsByTagName("rights").item(0).getTextContent();
        String rstrMenuPri = itemElement.getElementsByTagName("rstrMenuPri").item(0).getTextContent();

        RestaurantVO restaurantVO = new RestaurantVO();
        restaurantVO.setTitle(title);
        restaurantVO.setRstrNm(rstrNm);
        restaurantVO.setRights(rights);
        restaurantVO.setRstrMenuPri(rstrMenuPri);

        restaurantList.add(restaurantVO);

        // 가져온 내용 출력
        System.out.println("Title: " + title);
        System.out.println("rstrNm: " + rstrNm);
        System.out.println("rstrNm: " + rights);
        System.out.println("rstrNm: " + rstrMenuPri);
        System.out.println("--------------");

        model.addAttribute("restaurantList", restaurantList);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return "/restaurant/getRestaurantList";
  }

}
