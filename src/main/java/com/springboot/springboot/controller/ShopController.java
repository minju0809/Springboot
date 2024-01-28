package com.springboot.springboot.controller;

import java.io.File;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.springboot.project.shop.CartVO;
import com.springboot.springboot.project.shop.ProductVO;
import com.springboot.springboot.project.shop.ShopService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ShopController {

  @Autowired
  private ShopService service;

  @Autowired
  private HttpServletRequest request;

  @GetMapping("/getProductList.do")
  String getProductList(Model model, ProductVO vo) {

    model.addAttribute("li", service.getProductList(vo));

    return "/shop/getProductList";
  }

  @GetMapping("/getProduct.do")
  String getProduct(Model model, ProductVO vo) {

    model.addAttribute("product", service.getProduct(vo));

    return "/shop/getProduct";
  }

  @GetMapping("/productForm.do")
  String productForm(Model model) {

    return "/shop/productForm";
  }

  @PostMapping("/productInsert.do")
  String productInsert(ProductVO vo) throws Exception {
    String path = request.getSession().getServletContext().getRealPath("/img/shop/");
    System.out.println("path: " + path);
    // path: /Users/minju/Springboot/src/main/webapp/img/shop/

    long time = System.currentTimeMillis();
    SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
    String timeStr = sdf.format(time);

    MultipartFile file = vo.getProduct_img();
    String fileName = file.getOriginalFilename();
    File f = new File(path + fileName);

    if(!file.isEmpty()) {
      if(f.exists()) {
        String onlyFileName = fileName.substring(0, fileName.lastIndexOf("."));
        String ext = fileName.substring(fileName.lastIndexOf("."));
        fileName = onlyFileName + "_" + timeStr + ext;
      }
      file.transferTo(new File(path + fileName));
    } else {
      fileName = "space.png";
    }

    vo.setProduct_imgStr(fileName);
    System.out.println("vo: " + vo);
    service.productInsert(vo);

    return "redirect:/getProductList.do";
  }

  @GetMapping("/getCartList.do")
  String getCartList(Model model, CartVO vo) {

    // model.addAttribute("li", service.getCartList(vo));

    return "/shop/getCartList";
  }

  
}
