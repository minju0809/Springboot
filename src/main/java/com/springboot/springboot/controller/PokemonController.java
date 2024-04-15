package com.springboot.springboot.controller;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import com.springboot.springboot.project.pokemon.PokemonService;
import com.springboot.springboot.project.pokemon.PokemonVO;

import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PokemonController {

  @Autowired
  private PokemonService service;

  // @GetMapping("/pokemonInsert.do")
  // public String pokemonInsert(Model model) {
  //   service.pokemonDelete();
  //   // List<PokemonVO> li = new ArrayList<>();

  //   // Chrome WebDriver 경로 설정
  //   System.setProperty("webdriver.chrome.driver", "/Users/minju/coding/chromedriver");

  //   try {
  //     WebDriver driver = new ChromeDriver();
  //     String url = "https://pokemonkorea.co.kr/pokedex";
  //     driver.get(url);

  //     // 스크롤을 내림
  //     JavascriptExecutor js = (JavascriptExecutor) driver;
  //     long lastHeight = (long) js.executeScript("return document.body.scrollHeight");
  //     while (true) {
  //       js.executeScript("window.scrollTo(0, document.body.scrollHeight)");
  //       Thread.sleep(1000); // 스크롤 후 일정 시간 대기
  //       long newHeight = (long) js.executeScript("return document.body.scrollHeight");
  //       if (newHeight == lastHeight) {
  //         break; // 스크롤이 더 이상 되지 않으면 페이지의 끝에 도달한 것으로 판단하고 반복문 종료
  //       }
  //       lastHeight = newHeight;
  //     }

  //     // id가 "pokedexlist"인 ul 태그의 자식 li 요소들을 선택
  //     List<WebElement> pokemonElements = driver.findElements(By.cssSelector("#pokedexlist > li"));

  //     for (WebElement pokemonElement : pokemonElements) {
  //       // 각 li 요소의 id 속성값을 확인하여 "#pokedex_"로 시작하는 요소만 처리
  //       String id = pokemonElement.getAttribute("id");
  //       if (id.startsWith("#pokedex_")) {
  //         WebElement anchor = pokemonElement.findElement(By.tagName("a"));
  //         String image = anchor.findElement(By.tagName("img")).getAttribute("src");
  //         String num = anchor.findElement(By.cssSelector("h3 p")).getText().replace("No.", "");
  //         String name = anchor.findElement(By.tagName("h3")).getText().replaceAll("[^가-힣]", "");
  //         WebElement firstSpan = anchor.findElements(By.tagName("span")).get(0);
  //         String type1 = firstSpan.getText();
  //         List<WebElement> spanElements = anchor.findElements(By.tagName("span"));
  //         String type2 = "";
  //         if (spanElements.size() > 1) {
  //           WebElement secondSpan = spanElements.get(1);
  //           type2 = secondSpan.getText();
  //         }

  //         PokemonVO vo = new PokemonVO();
  //         vo.setNum(num);
  //         vo.setName(name);
  //         vo.setImage(image);
  //         vo.setType1(type1);
  //         vo.setType2(type2);
  //         service.pokemonInsert(vo);
  //         // li.add(vo);
  //       }
  //     }
  //     // model.addAttribute("li", li);
  //     // WebDriver 종료
  //     driver.quit();

  //     return "redirect:/getPokemonList.do";
  //   } catch (Exception e) {
  //     e.printStackTrace();
  //     System.out.println("@@@@@@@@@@@@22222!!!!!!!1실패!");
  //     return "redirect:/getPokemonList.do";
  //   }
  // }

  @GetMapping("/getPokemonList.do")
  public String getMethodName(PokemonVO vo, Model model) {
    int start = 0;
    int pageSize = 12;
    int pageListSize = 10;
    int totalCount = service.getTotalCount(vo);

    if (vo.getStart() == 0) {
      start = 1;
    } else {
      start = vo.getStart();
    }

    int end = start + pageSize - 1;

    int totalPage = (totalCount / pageSize) + 1;
    int currentPage = (start / pageSize) + 1;
    int lastPage = (totalPage - 1) * pageSize + 1;
    int listStartPage = (currentPage - 1) / pageListSize * pageListSize + 1;
    int listEndPage = listStartPage + pageListSize - 1;

    vo.setStart(start);
    vo.setPageSize(pageSize);
    vo.setEnd(end);

    model.addAttribute("totalCount", totalCount);
    model.addAttribute("start", start);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("end", end);
    model.addAttribute("totalPage", totalPage);
    model.addAttribute("currentPage", currentPage);
    model.addAttribute("lastPage", lastPage);

    model.addAttribute("pageListSize", pageListSize);
    model.addAttribute("listStartPage", listStartPage);
    model.addAttribute("listEndPage", listEndPage);

    model.addAttribute("ch1", vo.getCh1());
    model.addAttribute("ch2", vo.getCh2());

    model.addAttribute("li", service.getPokemonList(vo));
    return "/pokemon/getPokemonList";
  }

}
