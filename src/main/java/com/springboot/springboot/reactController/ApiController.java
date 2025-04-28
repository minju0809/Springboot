package com.springboot.springboot.reactController;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/api")
public class ApiController {

  @Autowired
  private RestTemplate restTemplate;
  
  private Map<String, String> dataStore = new HashMap<>();

  @GetMapping("/hello")
  public String sayHello() {
    return "Hello, World";
  }

  @GetMapping("/data/{key}")
  public String getData(@PathVariable String key) {
    return dataStore.getOrDefault(key, key + "를 찾을 수 없습니다");
  }

  @GetMapping("/fetchGuest")
  public String fetchGuest() {
    String url = "http://localhost:3000/guestbookListPage";
    ResponseEntity<String> res = restTemplate.getForEntity(url, String.class);
    System.out.println("res: " + res);
    return res.getBody();
  }
}
